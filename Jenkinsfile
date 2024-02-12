def paramDefaults = [
        'cloud': 'anthos-ci',
        'image_name': 'vijayimage',
        'timeout': 2,
        'dockerfile': 'Dockerfile',
        'jenkins_client_image': 'dockerdaemon0901/jenkinworker:v1',
        'target_to_image_suffix': ['': ''],
        'kaniko_cache': 'true',
        'build_dir': '',
        'test': true,
        'enforce_test': true,
        'test_integration': false,
        'test_e2e': true,
        'test_schema': false,
        'enforce_lint': true,
        'enforce_format': false,
        'push_dockerhub': false,
        'e2e_branch': 'dev',
        'API_SERVICE_IMAGE': 'default',
        'CONTROLLER_IMAGE': 'default',
        'DEVICE_RESOLVER_IMAGE': 'default',
        'CALENDAR_RESOLVER_IMAGE': 'default',
        'INVENTORY_SERVICE_IMAGE': 'default',
        'LAB_WORKER_IMAGE': 'default',
        'LAB_CONTROLLER_IMAGE': 'default',
        'ACTIONS_SERVICE_IMAGE': 'default',
        'QUEUED_RESERVATION_IMAGE': 'default',
        'TESTBED_MANAGER_IMAGE': 'default',
        'VIRTUAL_DEVICE_CREATOR_IMAGE': 'default',
        'RESERVATION_SERVICE_IMAGE': 'default',
        'E2E_UTILS_IMAGE': 'default',
        'NOTIFY_SERVICE_IMAGE': 'default',
        'PERMISSION_SERVICE_IMAGE': 'default',
        'GROUPS_SYNC_SERVICE_IMAGE': 'default',
        'XPRESSO_AUTH_PROXY_IMAGE': 'default',
        'FAAS_HELPER_IMAGE': 'default',
        'USER_PREFERENCE_SERVICE_IMAGE': 'default',
        'WEBUI_IMAGE': 'default',
        'KEA_DHCP_WEBSVC_IMAGE': 'default',
        'KEA_BASE_IMAGE': 'default',
        'DBSYNC_CORE_SERVICE_IMAGE': 'default',
        'DBSYNC_LAB_SERVICE_IMAGE': 'default',
        'LAASV2_DOCS_IMAGE': 'default',
        'NSO_IMAGE': 'default',
        'PLUGIN_BASE_IMAGE': 'default',
        'PYATS_PLUGIN_IMAGE': 'default',
        'PING_PLUGIN_IMAGE': 'default',
        'VCENTER_PLUGIN_IMAGE': 'default',
        'IPAM_KAFKA_IMAGE': 'default',
        'GRPC_SERVER_IMAGE': 'default',
        'HISTORY_COLLECTOR_SERVICE_IMAGE': 'default',
        'KEA_CONTROLLER_IMAGE': 'default',
        'KEA_INIT_IMAGE': 'default',
        'VMWARE_SERVICE_IMAGE': 'default',
        'VSPC_IMAGE': 'default',
        'SLEEP_AFTER_DEPLOY_TIME': '0',
        'LOOKUP_LATEST_GIT_TAG': 'true',
        'TEST_ITERS': '1',
        'ENABLE_DOCS': 'false',
        'FORCE_CLOSE_HTTP': 'true',
        'NUM_BUILD_IMAGES_RETRIES': 3,
        'RESERVATION_STATE_SYNC': 'default',
        'INVENTORY_GRPC_IMAGE': 'default',
        'DEVICE_LEARN_PLUGIN_IMAGE': 'default',
        'CYPRESS_UI_E2E': 'default',
        'INVENTORY_STATE_PUBLISHER': 'default',
        'SNMP_PLUGIN_IMAGE': 'default',
        'SEARCH_SERVICE_IMAGE':'default',
        'QINQ_VM_NETWORK_SETUP_SERVICE_IMAGE':'default',
        'ES_PROXY_SERVICE_IMAGE':'default',
        'CERT_POLLER_IMAGE':'default',
    ]
def pipelineParams = paramDefaults
pipeline {
    options {
            ansiColor('xterm')
            timeout(time: pipelineParams.timeout, unit: 'HOURS')
    }

    environment {
        DOCKERHUB_URL = 'hub.docker.com/dockerdaemon0901'
        NSO_VERSION = '5.7.2'
        CHECKOUT_BRANCH = "${env.CHANGE_BRANCH == null ? env.GIT_BRANCH : env.CHANGE_BRANCH}"
        BRANCH_TAG = CHECKOUT_BRANCH.replaceAll("[^a-zA-Z0-9-._]+", "_")
        TEST_TAG = "${env.GIT_COMMIT}"
        IMAGE_NAME = "${pipelineParams.image_name}"
        REGISTRY = 'docker.io/'
    }

    agent any

    stages {

        stage('Return early branch indexing') {
                when {
                    allOf {
                        triggeredBy cause: 'BranchIndexingCause'
                        not {
                            changeRequest()
                        }
                    }
                }
                steps {
                    script {
                        echo "Branch indexing triggered, returning early"
                        currentBuild.result = 'SUCCESS'
                        error "Branch indexing triggered, returning early"
                    }
                }
        }

        stage('check version'){
            agent {
                docker { image 'dockerdaemon0901/jenkinworker:v1' }
                }
            steps {
                script {
                    // Print some information about the Docker image
                    // sh 'docker info'

                    // Check Python version
                    sh 'python3 --version'
                }
            }
        }

        stage('Run Command in Kaniko Container') {
            agent {
                docker {
                    image 'gcr.io/kaniko-project/executor:v1.18.0-debug'
                }
            }
            steps {
                sh 'echo "Hello Jenkins"'
            }
        }

        
        stage('Build image Kaniko') {
            agent {
                docker {
                    image 'gcr.io/kaniko-project/executor:v1.18.0-debug'
                    // args '-v /kaniko/.docker/:/kaniko/.docker/ -v /kaniko/gittoken:/kaniko/gittoken'
                }
            }
            steps {
                script{
                    sh "echo Heyyy"
                }
                // script {
                //     // Assuming 'pipelineParams' and the necessary environment variables are available
                //     def extraArgs = ""
                //     if (pipelineParams.push_dockerhub) {
                //         extraArgs += " --destination=$DOCKERHUB_URL/$IMAGE_NAME:$BRANCH_TAG"
                //         extraArgs += " --destination $DOCKERHUB_URL/$IMAGE_NAME:$TEST_TAG"
                //     }
                //     sh """
                //     echo "################################################################################"
                //     echo "#                         Build Image - Kaniko                                 #"
                //     echo "################################################################################"
                //     /kaniko/executor \
                //         --context `pwd`${pipelineParams.build_dir} \
                //         --dockerfile ${pipelineParams.dockerfile} \
                //         --destination=$REGISTRY/$IMAGE_NAME:$BRANCH_TAG${suffix} \
                //         --destination $REGISTRY/$IMAGE_NAME:$TEST_TAG${suffix} \
                //         --cache=${pipelineParams.kaniko_cache} \
                //         --cache-ttl=4h \
                //         --ignore-path=/busybox \
                //         --snapshot-mode=full \
                //         --log-format=color \
                //         --push-retry=3 \
                //         --cleanup ${extra_args}
                //     """
                // }
            }
        }
    }
    post {
        always {
            // Cleanup steps that should always run regardless of the build outcome
            script {
                echo "Performing cache cleanup..."
                // Insert your cache cleanup commands here
                // For example, if you're using a workspace on the Jenkins agent, you can clean it up:
                cleanWs()
            }
        }
    }
}