pipeline {
    agent any

    environment {
        DOCKER_IMAGE = "myapp:latest"
        APP_SERVER_IP = "16.170.209.221"            // Replace with your App EC2 public IP
        SSH_KEY = "/var/lib/jenkins/keys/deploykey2.pem"
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'master',
                    url: 'https://github.com/Aimen12782/firstweb.git',
                    credentialsId: 'githubtoken'
            }
        }

        stage('SonarQube Analysis') {
            steps {
                withSonarQubeEnv('SonarQube') {
                    sh """
                        ${tool 'SonarScanner'}/bin/sonar-scanner \
                        -Dsonar.projectKey=my-first-project \
                        -Dsonar.sources=.
                    """
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                sh "docker build -t $DOCKER_IMAGE ."
            }
        }

        stage('Deploy to App EC2') {
            steps {
                // Push & run container on remote server
                sh """
                    # Save Docker image, send via SSH, and load
                    docker save $DOCKER_IMAGE | ssh -o StrictHostKeyChecking=no -i $SSH_KEY ubuntu@$APP_SERVER_IP 'sudo docker load'

                    # Stop old container, remove it, and run new container
                    ssh -o StrictHostKeyChecking=no -i $SSH_KEY ubuntu@$APP_SERVER_IP '
                        sudo docker stop myapp || true
                        sudo docker rm myapp || true
                        sudo docker run -d -p 80:80 --name myapp $DOCKER_IMAGE
                    '
                """
            }
        }
    }
}
