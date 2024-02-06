// Local docker password : 3ba212a4ad7d4213bd673f883e80fc13
def specifiedParams = []
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
def pipelineParams = paramDefaults + specifiedParams

pipeline {
        options {
            ansiColor('xterm')
            timeout(time: pipelineParams.timeout, unit: 'HOURS')
            throttleJobProperty(categories: ['service'], throttleEnabled: true, throttleOption: 'category')
        }

        // environment {
        //     //variables used in Jenkinsfile
        //     CHECKOUT_BRANCH = "${env.CHANGE_BRANCH == null ? env.GIT_BRANCH : env.CHANGE_BRANCH}"
        //     BRANCH_TAG = CHECKOUT_BRANCH.replaceAll("[^a-zA-Z0-9-._]+", "_")
        //     // DOCKERHUB_URL = 'dockerhub-master.cisco.com/pyats-docker'
        //     // DOCKERHUB_PULL_URL = 'dockerhub.cisco.com/pyats-docker'
        //     TEST_TAG = "${env.GIT_COMMIT}"
        //     DEV_TAG = 'dev-latest'
        //     MASTER_TAG = 'latest'
        //     // HTTP_PROXY = "${pipelineParams.http_proxy_url}"
        //     // HTTPS_PROXY = "${pipelineParams.https_proxy_url}"
        //     NO_PROXY = ".cisco.com"

        //     // E2E_PIPELINE = "team-laas/devx/laasv2_e2e/${pipelineParams.e2e_branch}"

        //     //variables used in Makefile
        //     CI = 'true'
        //     IMAGE_NAME = "${pipelineParams.image_name}"
        //     PROJECT_NAME = "${UUID.randomUUID().toString()[0..7]}"
        //     REGISTRY = 'containers.cisco.com/laasv2'
        //     MIRROR_URL = 'dockerhub.cisco.com/docker.io/'
        //     IMAGE_TAG = "${TEST_TAG}"
        //     NSO_VERSION = '5.7.2'
        // }
        // Execute the Pipeline, or stage, inside a pod deployed on a Kubernetes cluster. In order to use this option, the Jenkinsfile must be loaded from either a Multibranch Pipeline or a Pipeline from SCM.
//         agent {
//             kubernetes {
//                 cloud "${pipelineParams.cloud}"
//                 defaultContainer 'jnlp'
//                 yaml """
// apiVersion: v1
// kind: Pod
// spec:
//   serviceAccountName: laasv2-e2e
//   containers:
//     - name: jnlp
//       image: ${pipelineParams.jenkins_client_image}
//       imagePullPolicy: IfNotPresent
//       stdin: true
//       tty: true
//       env:
//         - name: JENKINS_AGENT_WORKDIR
//           value: /home/jenkins/agent
//         - name: http_proxy
//           value: ${pipelineParams.http_proxy_url}
//         - name: HTTP_PROXY
//           value: ${pipelineParams.http_proxy_url}
//         - name: https_proxy
//           value: ${pipelineParams.https_proxy_url}
//         - name: HTTPS_PROXY
//           value: ${pipelineParams.https_proxy_url}
//         - name: no_proxy
//           value: .cisco.com,localhost
//         - name: DOCKER_CERT_PATH
//           value: /certs/client
//         - name: DOCKER_TLS_VERIFY
//           value: 1
//         - name: DOCKER_HOST
//           value: tcp://localhost:2376
//         - name: GEN_USER
//           valueFrom:
//             secretKeyRef:
//               name: dockerhub
//               key: username
//         - name: GEN_PASS
//           valueFrom:
//             secretKeyRef:
//               name: dockerhub
//               key: password
//       volumeMounts:
//         - name: dind-certs
//           mountPath: /certs/client
//         - name: workspace
//           mountPath: /home/jenkins/agent
//         - name: logs
//           mountPath: /home/jenkins/logs
//     - name: dind
//       image: dockerhub.cisco.com/docker.io/docker:24.0.6-dind
//       imagePullPolicy: IfNotPresent
//       securityContext:
//         privileged: true
//       resources:
//         requests:
//           ephemeral-storage: "4Gi"
//       env:
//         - name: http_proxy
//           value: ${pipelineParams.http_proxy_url}
//         - name: HTTP_PROXY
//           value: ${pipelineParams.http_proxy_url}
//         - name: https_proxy
//           value: ${pipelineParams.https_proxy_url}
//         - name: HTTPS_PROXY
//           value: ${pipelineParams.https_proxy_url}
//         - name: no_proxy
//           value: .cisco.com
//         - name: DOCKER_TLS_CERTDIR
//           value: /certs
//       volumeMounts:
//         - name: dind-storage
//           mountPath: /var/lib/docker
//         - name: dind-certs
//           mountPath: /certs/client
//   volumes:
//     - name: dind-storage
//       emptyDir: {}
//     - name: dind-certs
//       emptyDir: {}
//     - name: logs
//       emptyDir: {}
//     - name: workspace
//       emptyDir: {}
//     - name: gittoken
//       secret:
//         secretName: gittoken
//         defaultMode: 384
//     - name: kaniko-secret
//       secret:
//         secretName: kanikoharbor
//         defaultMode: 384
// """
//             }
//         }
        // Defines the stages of pipeline check
        stages {
            // A sample hello world stage
            stage('Example') {
                agent any
                options {
                    // Timeout counter starts BEFORE agent is allocated
                    timeout(time: 1, unit: 'SECONDS')
                }
                steps {
                    echo 'Hello World'
                }
            }

            // A sample version check
            stage('Version-check') {
                agent any
                options {
                    // Timeout counter starts BEFORE agent is allocated
                    timeout(time: 1, unit: 'SECONDS')
                }
                steps {
                  echo 'Version check running'
                  sh 'python --version'
                }
            }
    }
}