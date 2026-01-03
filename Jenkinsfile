pipeline {
    agent any

    environment {
        IMAGE_NAME = "myapp"
        IMAGE_TAG = "${BUILD_NUMBER}"
    }

    stages {
        stage('Checkout') {
            steps {
                withCredentials([usernamePassword(
                    credentialsId: 'githubtoken', 
                    usernameVariable: 'GITHUB_USER', 
                    passwordVariable: 'GITHUB_PASS'
                )]) {
                    sh '''
                    git clone https://${GITHUB_USER}:${GITHUB_PASS}@github.com/Aimen12782/firstweb.git
                    cd firstweb
                    git checkout master
                    '''
                }
            }
        }
    }
}
