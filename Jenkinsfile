pipeline {
    agent any

    environment {
        DOCKER_HOST_IP = "16.170.209.221"
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
                docker build -t myapp:latest .
                """
            }
        }

        stage('Deploy Docker Container') {
            steps {
                sh """
                ssh -o StrictHostKeyChecking=no -i devopskey.pem ubuntu@${DOCKER_HOST_IP} '
                    docker stop myapp || true
                    docker rm myapp || true
                    docker run -d -p 80:80 --name myapp myapp:latest
                '
                """
            }
        }
    }
}
