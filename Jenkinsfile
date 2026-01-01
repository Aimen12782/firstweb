pipeline {
    agent any

    tools {
        // Updated keyword to match your Jenkins configuration
        "sonar-scanner" 'sonar-scanner' 
    }

    environment {
        IMAGE_NAME = "myapp"
        IMAGE_TAG = "${BUILD_NUMBER}"
        SONAR_TOKEN = credentials('sonarqubetoken')
    }

    stages {
        stage('Checkout') {
            steps {
                echo "Cloning GitHub repository..."
                git branch: 'master',
                    url: 'https://github.com/Aimen12782/firstweb.git',
                    credentialsId: 'githubtoken'
            }
        }

        stage('SonarQube Analysis') {
            steps {
                echo "Running SonarQube code analysis..."
                withSonarQubeEnv('SonarQube') {
                    sh """
                    sonar-scanner \
                        -Dsonar.projectKey=myapp \
                        -Dsonar.sources=. \
                        -Dsonar.host.url=http://16.170.15.66:9000 \
                        -Dsonar.login=${SONAR_TOKEN}
                    """
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                echo "Building Docker image..."
                // Build the image locally on the Jenkins agent
                sh "docker build -t ${IMAGE_NAME}:${IMAGE_TAG} ."
            }
        }

        stage('Deploy to EC2') {
            steps {
                echo "Deploying Docker container to EC2..."
                sshagent(['ec2key']) {
                    sh """
                    ssh -o StrictHostKeyChecking=no ubuntu@16.171.56.29 "
                        sudo docker stop myapp || true
                        sudo docker rm myapp || true
                        # Note: If image is not on a registry, you may need 'docker save/load' 
                        # but usually for local build/deploy, we run it here:
                        sudo docker run -d -p 80:80 --name myapp ${IMAGE_NAME}:${IMAGE_TAG}
                    "
                    """
                }
            }
        }
    }

    post {
        success {
            echo "Pipeline completed successfully! App: http://16.171.56.29"
        }
        failure {
            echo "Pipeline failed. Check the logs for details."
        }
    }
}
