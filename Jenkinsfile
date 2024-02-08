pipeline {
    agent none
    stages {
        stage('Build') {
            agent {
                docker {
                    image 'python:3-alpine'
                }
            }
            steps {
                sh 'virtualenv venv --distribute'
                sh 'source venv/bin/activate '
                sh 'pip install --user -r requirements.txt'
                sh 'python3 ./service/dummy.py'
            }
        }
    }
}