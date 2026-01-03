pipeline {
    agent any

    environment {
        IMAGE_NAME = "myapp"
        IMAGE_TAG = "${BUILD_NUMBER}"
    }

    stages {
        stage('Checkout') {
            steps {
                withCredentials([string(credentialsId: 'githubtoken', variable: 'GITHUB_TOKEN')]) {
                    sh '''
                    git clone https://Aimen12782:${GITHUB_TOKEN}@github.com/Aimen12782/firstweb.git
                    cd firstweb
                    git checkout master
                    '''
                }
            }
        }
    }
}
