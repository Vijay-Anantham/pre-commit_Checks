pipeline {
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