def paramDefaults = [
        'cloud': 'anthos-ci',
        'timeout': 2,
        'dockerfile': 'Dockerfile',
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
    agent {
        // docker { image 'dockerdaemon0901/jenkinworker:v1' }
        kubernetes {
                cloud "${pipelineParams.cloud}"
                defaultContainer 'jnlp'
                yaml """
apiVersion: v1
kind: Pod
spec:
  containers:
    - name: jnlp
      image: dockerdaemon0901/jenkinworker:v12
      imagePullPolicy: IfNotPresent
      stdin: true
      tty: true
      env:
        - name: JENKINS_AGENT_WORKDIR
          value: /home/jenkins/agent
        - name: DOCKER_CERT_PATH
          value: /certs/client
        - name: DOCKER_TLS_VERIFY
          value: 1
        - name: DOCKER_HOST
          value: tcp://localhost:2376
        - name: GEN_USER
          valueFrom:
            secretKeyRef:
              name: dockerhub
              key: username
        - name: GEN_PASS
          valueFrom:
            secretKeyRef:
              name: dockerhub
              key: password
      volumeMounts:
        - name: dind-certs
          mountPath: /certs/client
        - name: workspace
          mountPath: /home/jenkins/agent
        - name: logs
          mountPath: /home/jenkins/logs
    - name: dind
      image: docker:dind
      imagePullPolicy: IfNotPresent
      securityContext:
        privileged: true
      resources:
        requests:
          ephemeral-storage: "4Gi"
      env:
        - name: DOCKER_TLS_CERTDIR
          value: /certs
      volumeMounts:
        - name: dind-storage
          mountPath: /var/lib/docker
        - name: dind-certs
          mountPath: /certs/client
  volumes:
    - name: dind-storage
      emptyDir: {}
    - name: dind-certs
      emptyDir: {}
    - name: logs
      emptyDir: {}
    - name: workspace
      emptyDir: {}
    - name: gittoken
      secret:
        secretName: gittoken
        defaultMode: 384
    - name: kaniko-secret
      secret:
        secretName: kanikoharbor
        defaultMode: 384
"""
            }
        }
    // Step to skip triggering of build if there arent any code changes
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
        // Setup for building environment
        stage('Setup') {
            steps {
                script {
                    sh 'pip install -r requirements.txt'  // Install required packages
                }
            }
        }
        // Second layer Lint checks enforcing before merge..
        stage('Lint') {
            steps {
                script {
                    try {
                        // Linting
                        sh 'flake8 ./service'
                    } catch (Exception e) {
                        // Handle linting failure (fail the build, send notifications, etc.)
                        currentBuild.result = 'FAILURE'
                        error("Linting failed: ${e.message}")
                    }
                }
            }
        }
        // Run tests across all dir and files
        stage('Run Tests') {
            steps {
                script {
                    // Run pytest command
                    sh 'pytest'
                }
            }
        }

        stage('Repo login') {
            steps {
                script {
                    if (pipelineParams.push_dockerhub) {
                        sh 'echo $GEN_PASS | docker login dockerhub.cisco.com --username $GEN_USER --password-stdin'
                        sh 'echo $GEN_PASS | docker login dockerhub-master.cisco.com --username $GEN_USER --password-stdin'
                    }
                }
            }
        }

        // Build and publish
        stage('Build image Kaniko') {
                agent {
                    kubernetes {
                        cloud "${pipelineParams.cloud}"
                        defaultContainer 'kaniko'
                        yaml """
apiVersion: v1
kind: Pod
spec:
  serviceAccountName: laasv2-e2e
  containers:
    - name: kaniko
      image: gcr.io/kaniko-project/executor:v1.18.0-debug
      imagePullPolicy: IfNotPresent
      command:
        - /busybox/sleep
        - infinity
      tty: true
      env:
      volumeMounts:
        - name: kaniko-secret
          mountPath: /kaniko/.docker/
        - name: gittoken
          mountPath: /kaniko/gittoken
  volumes:
    - name: gittoken
      secret:
        secretName: gittoken
        defaultMode: 384
    - name: kaniko-secret
      secret:
        secretName: kanikoharbor
        defaultMode: 256
"""
                    }
                }
                steps {
                    container(name: 'kaniko', shell: '/busybox/sh') {
                        echo 'Build image'
                        script {
                            pipelineParams.target_to_image_suffix.each{target, suffix ->
                                extra_args = ""
                                if (target != "") {
                                    extra_args = extra_args + " --target=${target}"
                                }
                                if (pipelineParams.push_dockerhub) {
                                    extra_args = extra_args + " --destination=$DOCKERHUB_URL/$IMAGE_NAME:$BRANCH_TAG" + suffix
                                    extra_args = extra_args + " --destination $DOCKERHUB_URL/$IMAGE_NAME:$TEST_TAG" + suffix
                                }

                                retry(pipelineParams.NUM_BUILD_IMAGES_RETRIES) {
                                    withEnv(['PATH+EXTRA=/busybox']) {
                                        sh """#!/busybox/sh
                                        echo "################################################################################"
                                        echo "#                         Build Image - Kaniko                                 #"
                                        echo "################################################################################"
                                        cp -v /kaniko/gittoken/token /kaniko/token
                                        chmod -v 777 /kaniko/token
                                        /kaniko/executor \
                                            --context `pwd`${pipelineParams.build_dir} \
                                            --dockerfile ${pipelineParams.dockerfile} \
                                            --build-arg http_proxy=$HTTP_PROXY \
                                            --build-arg https_proxy=$HTTPS_PROXY \
                                            --build-arg no_proxy=$NO_PROXY \
                                            --build-arg MIRROR_URL=$MIRROR_URL \
                                            --build-arg REGISTRY=$REGISTRY \
                                            --build-arg NSO_VERSION=$NSO_VERSION \
                                            --cache=${pipelineParams.kaniko_cache} \
                                            --cache-ttl=4000h \
                                            --ignore-path=/busybox \
                                            --snapshot-mode=full \
                                            --log-format=color \
                                            --push-retry=3 \
                                            --destination=$REGISTRY/$IMAGE_NAME:$BRANCH_TAG${suffix} \
                                            --destination $REGISTRY/$IMAGE_NAME:$TEST_TAG${suffix} \
                                            --cleanup ${extra_args} \
                                            && mkdir -p /workspace
                                        """
                                    }
                                }
                            }
                        }
                    }
                }
            }

    }
}