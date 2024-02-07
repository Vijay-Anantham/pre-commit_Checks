pipeline {
    agent {
    docker { image 'python' }
    }
    stages {
        stage('Checkout') {
            steps {
                // Checkout code from version control
                git 'https://github.com/Vijay-Anantham/pre-commit_Checks.git'
            }
        }
        stage('Setup Environment') {
            steps {
                sh 'pip install -r requirements.txt'
            }
        }
        stage('Execute Script') {
            steps {
                sh 'python3 dummy.py'
            }
        }
    }
    
    post {
        failure {
            // Send notification if build fails
            mail to: 'vijayanantham143@gmail.com', subject: 'Build failed', body: 'Check Jenkins for details.'
        }
    }
}