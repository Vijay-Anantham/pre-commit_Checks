def paramDefaults = [
        'cloud': 'anthos-devx-ci',
        'timeout': 2,
        'dockerfile': 'Dockerfile',
        'target_to_image_suffix': ['': ''],
        'kaniko_cache': 'true',
        'build_dir': '',
        'test': false,
        'enforce_test': false,
        'test_integration': false,
        'test_e2e': false,
        'test_schema': false,
        'enforce_lint': false,
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
def pipelineParams = paramDefaults + specifiedParams

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
            TEST_TAG = "${env.GIT_COMMIT}"
            DEV_TAG = 'dev-latest'
            MASTER_TAG = 'latest'
            HTTP_PROXY = "${pipelineParams.http_proxy_url}"
            HTTPS_PROXY = "${pipelineParams.https_proxy_url}"


            //variables used in Makefile
            CI = 'true'
            IMAGE_NAME = "${pipelineParams.image_name}"
            PROJECT_NAME = "${UUID.randomUUID().toString()[0..7]}"
            IMAGE_TAG = "${TEST_TAG}"
            NSO_VERSION = '5.7.2'
        }

    agent {
        docker { image 'python' }
    }
    // agent any
    stages {
        stage('Check version') {
            steps {
                sh 'python3 --version'
            }
        }
    }

}