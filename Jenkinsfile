pipeline {
    agent any
    environment {
        IMAGE_NAME = "myapp"
        IMAGE_TAG = "${BUILD_NUMBER}"
    }
    stages {
        stage('Checkout') {
            steps {
                git branch: 'master',
                    url: 'https://github.com/Aimen12782/firstweb.git',
                    credentialsId: 'githubtoken'
            }
        }
    }
}

