pipeline {
    agent any

    environment {
        IMAGE_NAME = "firstweb:latest"
        CONTAINER_NAME = "firstweb_container"
    }

    stages {
        stage('Checkout Code') {
            steps {
                git branch: 'master', url: 'https://github.com/Aimen12782/firstweb.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh "docker build -t $IMAGE_NAME ."
            }
        }

        stage('Stop Old Container') {
            steps {
                sh "docker rm -f $CONTAINER_NAME || true"
            }
        }

        stage('Run Docker Container') {
            steps {
                sh "docker run -d --name $CONTAINER_NAME -p 3000:3000 $IMAGE_NAME"
            }
        }
    }

    post {
        success {
            echo "Website deployed successfully!"
        }
        failure {
            echo "Deployment failed!"
        }
    }
}
