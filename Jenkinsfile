pipeline {
    agent any

    environment {
        IMAGE_NAME = "myapp"
        IMAGE_TAG = "${BUILD_NUMBER}"
        APP_SERVER = "ubuntu@<APP_EC2_IP>"
    }

    stages {

        stage('Checkout') {
            steps {
                git branch: 'main',
                    url: 'https://github.com/yourusername/yourrepo.git'
            }
        }

        stage('SonarQube Analysis') {
            steps {
                withSonarQubeEnv('SonarQube') {
                    sh '''
                    sonar-scanner \
                    -Dsonar.projectKey=myapp \
                    -Dsonar.sources=. \
                    -Dsonar.host.url=http://<SONAR_EC2_IP>:9000
                    '''
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                sh "docker build -t ${IMAGE_NAME}:${IMAGE_TAG} ."
            }
        }

        stage('Deploy to EC2') {
            steps {
                sshagent(['ec2-key']) {
                    sh '''
                    ssh -o StrictHostKeyChecking=no ubuntu@<APP_EC2_IP> "
                    docker stop myapp || true
                    docker rm myapp || true
                    docker run -d -p 80:80 --name myapp ${IMAGE_NAME}:${IMAGE_TAG}
                    "
                    '''
                }
            }
        }
    }
}
