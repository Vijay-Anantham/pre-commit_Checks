    def paramDefaults = [
        'cloud': 'anthos-devx-ci',
        'timeout': 2,
        'email_recipient': 'laasv2_jenkins_alerts@cisco.com',
        'http_proxy_url': 'http://proxy-wsa.esl.cisco.com:80',
        'https_proxy_url': 'http://proxy-wsa.esl.cisco.com:80',
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
        'jenkins_client_image': 'containers.cisco.com/laasv2/laas-inbound-agent:9f9165b65ea96c9230ae00ffbab7442443efab2c',
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
    
    // echo pipelineParams.inspect()

    def e2e_param_list = [
        'API_SERVICE_IMAGE', 'CONTROLLER_IMAGE', 'DEVICE_RESOLVER_IMAGE', 'CALENDAR_RESOLVER_IMAGE',
        'INVENTORY_SERVICE_IMAGE', 'LAB_WORKER_IMAGE', 'QUEUED_RESERVATION_IMAGE', 'TESTBED_MANAGER_IMAGE',
        'VIRTUAL_DEVICE_CREATOR_IMAGE', 'RESERVATION_SERVICE_IMAGE', 'E2E_UTILS_IMAGE','NOTIFY_SERVICE_IMAGE',
        'PERMISSION_SERVICE_IMAGE', 'WEBUI_IMAGE', 'KEA_DHCP_WEBSVC_IMAGE', 'SLEEP_AFTER_DEPLOY_TIME', 'USER_PREFERENCE_SERVICE_IMAGE',
        'DBSYNC_CORE_SERVICE_IMAGE','DBSYNC_LAB_SERVICE_IMAGE', 'NSO_IMAGE', 'PYTEST_WORKERS', 'TEST_ITERS',
        'PYATS_PLUGIN_IMAGE', 'LAASV2_DOCS_IMAGE', 'ENABLE_DOCS', 'FAAS_HELPER_IMAGE', 'ACTIONS_SERVICE_IMAGE', 'IPAM_KAFKA_IMAGE',
        'KEA_BASE_IMAGE', 'GRPC_SERVER_IMAGE', 'GROUPS_SYNC_SERVICE_IMAGE', 'HISTORY_COLLECTOR_SERVICE_IMAGE', 'KEA_CONTROLLER_IMAGE',
        'KEA_INIT_IMAGE', 'PING_PLUGIN_IMAGE', 'VCENTER_PLUGIN_IMAGE', 'VMWARE_SERVICE_IMAGE', 'VSPC_IMAGE','RESERVATION_STATE_SYNC',
        'INVENTORY_GRPC_IMAGE', 'LAB_CONTROLLER_IMAGE', 'DEVICE_LEARN_PLUGIN_IMAGE', 'CYPRESS_UI_E2E', 'INVENTORY_STATE_PUBLISHER',
        'SNMP_PLUGIN_IMAGE', 'PLUGIN_BASE_IMAGE','SEARCH_SERVICE_IMAGE','ES_PROXY_SERVICE_IMAGE','QINQ_VM_NETWORK_SETUP_SERVICE_IMAGE',
        'LOOKUP_LATEST_GIT_TAG', 'XPRESSO_AUTH_PROXY_IMAGE', 'CERT_POLLER_IMAGE'
    ]
    def e2e_params = pipelineParams.findAll { e2e_param_list.contains(it.key) }

    pipeline {
        options {
            ansiColor('xterm')
            timeout(time: pipelineParams.timeout, unit: 'HOURS')
            throttleJobProperty(categories: ['service'], throttleEnabled: true, throttleOption: 'category')
        }

        environment {
            //variables used in Jenkinsfile
            CHECKOUT_BRANCH = "${env.CHANGE_BRANCH == null ? env.GIT_BRANCH : env.CHANGE_BRANCH}"
            BRANCH_TAG = CHECKOUT_BRANCH.replaceAll("[^a-zA-Z0-9-._]+", "_")
            DOCKERHUB_URL = 'dockerhub-master.cisco.com/pyats-docker'
            DOCKERHUB_PULL_URL = 'dockerhub.cisco.com/pyats-docker'
            TEST_TAG = "${env.GIT_COMMIT}"
            DEV_TAG = 'dev-latest'
            MASTER_TAG = 'latest'
            HTTP_PROXY = "${pipelineParams.http_proxy_url}"
            HTTPS_PROXY = "${pipelineParams.https_proxy_url}"
            NO_PROXY = ".cisco.com"

            E2E_PIPELINE = "team-laas/devx/laasv2_e2e/${pipelineParams.e2e_branch}"

            //variables used in Makefile
            CI = 'true'
            IMAGE_NAME = "${pipelineParams.image_name}"
            PROJECT_NAME = "${UUID.randomUUID().toString()[0..7]}"
            REGISTRY = 'containers.cisco.com/laasv2'
            MIRROR_URL = 'dockerhub.cisco.com/docker.io/'
            IMAGE_TAG = "${TEST_TAG}"
            NSO_VERSION = '5.7.2'
        }

        agent {
            kubernetes {
                cloud "${pipelineParams.cloud}"
                defaultContainer 'jnlp'
                yaml """
apiVersion: v1
kind: Pod
spec:
  serviceAccountName: laasv2-e2e
  containers:
    - name: jnlp
      image: ${pipelineParams.jenkins_client_image}
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
      image: dockerhub.cisco.com/docker.io/docker:24.0.6-dind
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

            stage('Set E2E param and environment variables') {
                steps {
                    script {
                        if (pipelineParams.image_param != null) {
                            //needs to be done here since env.GIT_COMMIT (used in TEST_TAG)
                            //is only available inside the pipeline
                            if (pipelineParams.push_dockerhub) {
                                e2e_params[pipelineParams.image_param] = "${DOCKERHUB_PULL_URL}/${IMAGE_NAME}:${TEST_TAG}"
                            } else {
                                e2e_params[pipelineParams.image_param] = "${REGISTRY}/${IMAGE_NAME}:${TEST_TAG}"
                            }
                        }
                        // echo e2e_params.inspect()
                        //set E2E params as environment variables, so that they also define
                        //the images used in unit tests and integration tests, e.g. e2e_utils
                        //is used to initialize the db for some unit tests
                        for ( e in e2e_params ) {
                            if (e.value == "default") {
                                continue
                            }
                            env."${e.key}" = "${e.value}"
                        }
                        // echo env.getEnvironment().inspect()
                    }
                }
            }

            stage('Lint') {
                steps {
                    script {
                        if (pipelineParams.enforce_lint) {
                            sh 'make lint'
                        } else {
                            sh 'make lint || true'
                        }
                        if (pipelineParams.enforce_format) {
                            sh 'make format_check'
                        } else {
                            sh 'make format_check || true'
                        }
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
        - name: http_proxy
          value: ${pipelineParams.http_proxy_url}
        - name: HTTP_PROXY
          value: ${pipelineParams.http_proxy_url}
        - name: https_proxy
          value: ${pipelineParams.https_proxy_url}
        - name: HTTPS_PROXY
          value: ${pipelineParams.https_proxy_url}
        - name: no_proxy
          value: .cisco.com
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

            stage('Post push') {
                failFast false
                parallel {
                    stage('E2E run') {
                        when {
                            expression { pipelineParams.test_e2e }
                        }
                        steps {
                            script {
                                e2e_pipeline_params = e2e_params.collect { k, v -> string(name: k, value: v) }
                                build(job: env.E2E_PIPELINE, parameters: e2e_pipeline_params)
                            }
                        }
                    }

                    stage('Service tests') {
                        stages {
                            stage('Wait dind') {
                                steps {
                                    script {
                                        def is_retry = false
                                        retry(10) {
                                            if (is_retry) {
                                                sleep time: 10, unit: 'SECONDS'
                                            }
                                            is_retry = true
                                            sh "docker info"
                                        }
                                    }
                                }
                            }

                            stage('Cleanup yaml') {
                                steps {
                                    script {
                                        withEnv(["IMAGE_NAME=$REGISTRY/$IMAGE_NAME"]) {
                                            sh '''
                                            shopt -s nullglob;
                                            for f in *.yml; do
                                                yq 'del(.services.*.build)' $f | envsubst '$IMAGE_NAME' > $f.tmp;
                                            done
                                            for f in *.yaml; do
                                                yq 'del(.services.*.build)' $f | envsubst '$IMAGE_NAME' > $f.tmp;
                                            done
                                            '''
                                        }
                                        archiveArtifacts artifacts: '*.tmp', allowEmptyArchive: true, onlyIfSuccessful: false
                                        sh 'shopt -s nullglob; for f in *.yml.tmp; do mv $f ${f%.tmp}; done'
                                        sh 'shopt -s nullglob; for f in *.yaml.tmp; do mv $f ${f%.tmp}; done'
                                    }
                                }
                            }

                            stage('Pull image') {
                                steps {
                                    script {
                                        sh "docker pull $REGISTRY/$IMAGE_NAME:$TEST_TAG"
                                        sh "docker tag $REGISTRY/$IMAGE_NAME:$TEST_TAG $IMAGE_NAME:$BRANCH_TAG"
                                    }
                                }
                            }

                            stage('Integration tests: Start services') {
                                when {
                                    expression { pipelineParams.test_integration }
                                }
                                steps {
                                    script {
                                        retry(pipelineParams.NUM_BUILD_IMAGES_RETRIES) {
                                            sh 'make test_int_up'
                                        }
                                    }
                                }
                            }

                            stage('Integration tests: Execute test') {
                                when {
                                    expression { pipelineParams.test_integration }
                                }
                                steps {
                                    sh 'make test_int_run'
                                }
                            }

                            stage('Integration tests: Stop services') {
                                when {
                                    expression { pipelineParams.test_integration }
                                }
                                steps {
                                    sh 'make test_int_logs > test_int_logs.log || true'
                                    sh 'make test_int_down || true'
                                }
                            }

                            stage('Unit tests: Start services') {
                                when {
                                    expression { pipelineParams.test }
                                }
                                steps {
                                    script {
                                        retry(pipelineParams.NUM_BUILD_IMAGES_RETRIES) {
                                            sh 'make test_up'
                                        }
                                    }
                                }
                            }

                            stage('Unit tests: Execute test') {
                                when {
                                    expression { pipelineParams.test }
                                }
                                steps {
                                    script {
                                        if (pipelineParams.enforce_test) {
                                            sh 'make test_run'
                                        } else {
                                            sh 'make test_run || true'
                                        }
                                    }
                                }
                            }

                            stage('Unit tests: Stop services') {
                                when {
                                    expression { pipelineParams.test }
                                }
                                steps {
                                    sh 'make test_logs > test_logs.log || true'
                                    sh 'make test_copy_artifacts || true'
                                    sh 'make test_down || true'
                                }
                            }
                        }
                    }
                }
            }
        }

        post {
            always {
                script {
                    if (env.BRANCH_TAG == 'master' || env.BRANCH_TAG == 'dev') {
                        retry(10) {
                            mail(
                                to: "${pipelineParams.email_recipient}",
                                subject: "${BUILD_TAG} ${currentBuild.currentResult}",
                                body: "${BUILD_TAG} ${currentBuild.currentResult}: ${BUILD_URL}",
                            )
                            sleep time: 15, unit: 'SECONDS'
                        }
                    }

                    sh 'test -s test_logs.log || make test_copy_artifacts || true'
                    sh 'test -s test_logs.log || make test_logs > test_logs.log || true'
                    sh 'test -s test_int_logs.log || make test_int_logs > test_int_logs.log || true'

                    archiveArtifacts artifacts: '*.log', allowEmptyArchive: true, onlyIfSuccessful: false
                    archiveArtifacts artifacts: '*.yaml', allowEmptyArchive: true, onlyIfSuccessful: false
                    publishHTML(target: [
                        allowMissing: true,
                        alwaysLinkToLastBuild: false,
                        keepAll: true,
                        reportDir: '.',
                        reportFiles: 'pytest_report.html',
                        reportName: 'pytest report'
                    ])
                    publishHTML(target: [
                        allowMissing: true,
                        alwaysLinkToLastBuild: false,
                        keepAll: true,
                        reportDir: 'htmlcov',
                        reportFiles: 'index.html',
                        reportName: 'Coverage report'
                    ])
                    publishHTML(target: [
                        allowMissing: true,
                        alwaysLinkToLastBuild: false,
                        keepAll: true,
                        reportDir: 'coverage',
                        reportFiles: 'coverage.html',
                        reportName: 'go coverage report'
                    ])
                }
            }
            cleanup {
                script {
                    sh 'make test_down || true'
                    sh 'make test_int_down || true'
                }
            }
        }
    }