pipeline {
    agent none // This tells Jenkins that the pipeline will dictate its own execution environment

    stages {
        stage('Deploy Pod') {
            agent {
                // Define the Kubernetes pod template
                kubernetes {
                    // This YAML defines the pod template and the containers inside the pod
                    yaml '''
apiVersion: v1
kind: Pod
metadata:
  labels:
    some-label: some-label-value
spec:
  containers:
  - name: demo-container
    image: dockerdaemon0901/jenkinworker:v1
    command:
    - cat
    tty: true
'''
                }
            }
            steps {
                // Execute your scripts/commands here inside the pod
                container('my-container') {
                    sh 'echo "Running script inside the pod"'
                    // Add more shell commands or script executions here
                }
            }
        }
    }

    post {
        always {
            // Clean up the pod after the pipeline execution is done
            deleteDir()
        }
    }
}