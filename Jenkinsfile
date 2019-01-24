pipeline {
    agent none

    options {
        ansiColor('xterm')
    }

    stages {
        stage('Setup') {
            agent any

            steps {
              sh 'make setup'
            }
        }
        stage('Test') {
            agent any

            steps {
              sh 'make test'
            }
            post {
                always {
                    sh 'make destroy clean'
                }
            }
        }
    }
}
