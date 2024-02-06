pipeline {
    agent any 

    stages {
        stage('Hello') {
            steps {
                echo 'Hello, World!'
            }
        }

        stage('Version check'){
            sh 'python --version'
        }
    }
}