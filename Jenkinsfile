pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                git branch: 'master',
                    url: 'https://github.com/Aimen12782/firstweb',
                    credentialsId: 'githubtoken'
            }
        }

        stage('Verify') {
            steps {
                sh 'ls -la'
            }
        }
    }
}
