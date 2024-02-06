pipeline {
    agent any 

    stages {
        stage('Hello') {
            steps {
                echo 'Hello, World!'
            }
        }

        stage('Version check'){
            steps{
                sh 'python3 --version'
            }
        }
    }
}