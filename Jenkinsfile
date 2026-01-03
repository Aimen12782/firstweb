pipeline {
    agent any

    environment {
        DOCKER_IMAGE = "myapp:latest"
        APP_SERVER_IP = "16.170.209.221"   // Your App EC2 public IP
        SSH_KEY = "devopskey.pem"          // Make sure this is in Jenkins home
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
                sh """
                docker build -t $DOCKER_IMAGE .
                """
            }
        }

        stage('Push & Deploy to App EC2') {
            steps {
                // Copy Docker image to App EC2 without creating tar manually
                sh """
                docker save $DOCKER_IMAGE | bzip2 | ssh -o StrictHostKeyChecking=no -i $SSH_KEY ubuntu@$APP_SERVER_IP 'bunzip2 | docker load'
                ssh -o StrictHostKeyChecking=no -i $SSH_KEY ubuntu@$APP_SERVER_IP '
                    docker stop myapp || true
                    docker rm myapp || true
                    docker run -d -p 80:80 --name myapp myapp:latest
                '
                """
            }
        }
    }
}
