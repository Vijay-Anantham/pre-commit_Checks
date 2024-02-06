// Local docker password : 3ba212a4ad7d4213bd673f883e80fc13
def specifiedParams = []
def paramDefaults = [
        'timeout': 2,
    ]
def pipelineParams = paramDefaults + specifiedParams

pipeline {
        options {
            ansiColor('xterm')
            timeout(time: pipelineParams.timeout, unit: 'HOURS')
            throttleJobProperty(categories: ['service'], throttleEnabled: true, throttleOption: 'category')
        }
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