pipeline {
    agent any

    environment {
        IMAGE_NAME = "myapp"
        IMAGE_TAG = "${BUILD_NUMBER}"
        SONAR_TOKEN = credentials('sonarqubetoken')  // Use the exact ID
    }

    stages {

        stage('Checkout') {
            steps {
                git branch: 'main',
                    url: 'https://github.com/Aimen12782/firstweb.git',
                    credentialsId: 'githubtoken'  // GitHub token ID
            }
        }

        stage('SonarQube Analysis') {
            steps {
                withSonarQubeEnv('SonarQube') {
                    sh '''
                    sonar-scanner \
                        -Dsonar.projectKey=myapp \
                        -Dsonar.sources=. \
                        -Dsonar.host.url=http://16.170.15.66:9000 \
                        -Dsonar.login=${SONAR_TOKEN}
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
                sshagent(['ec2key']) {  // SSH key ID
                    sh '''
                    ssh -o StrictHostKeyChecking=no ubuntu@16.171.56.29 "
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
