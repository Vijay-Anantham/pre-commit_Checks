pipeline {
    agent {
        docker { image 'python' }
    }
    // agent any
    stages {
        stage('Setup Environment') {
            steps {
                sh 'pip install -r requirements.txt'
            }
        }
        stage('Execute Script') {
            steps {
                sh 'python3 --version'
            }
        }
    }

}