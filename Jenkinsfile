pipeline {
    agent any

    environment {
        IMAGE_NAME = "myapp"
        IMAGE_TAG = "${BUILD_NUMBER}"
        SONAR_TOKEN = credentials('sonarqubetoken')  // SonarQube token
    }

    stages {

        stage('Checkout') {
            steps {
                echo "Cloning GitHub repository..."
                git branch: 'main',
                    url: 'https://github.com/Aimen12782/firstweb.git',
                    credentialsId: 'githubtoken'  // GitHub token
            }
        }

        stage('SonarQube Analysis') {
            steps {
                echo "Running SonarQube code analysis..."
                withSonarQubeEnv('SonarQube') {
                    sh '''#!/bin/bash
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
                echo "Building Docker image..."
                sh "docker build -t ${IMAGE_NAME}:${IMAGE_TAG} ."
            }
        }

        stage('Deploy to EC2') {
            steps {
                echo "Deploying Docker container to EC2..."
                sshagent(['ec2key']) {
                    sh '''#!/bin/bash
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

    post {
        success {
            echo "Pipeline completed successfully! Your app should be live on http://16.171.56.29"
        }
        failure {
            echo "Pipeline failed. Check the logs for details."
        }
    }
}
