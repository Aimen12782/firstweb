pipeline {
    agent any

    environment {
        DOCKER_IMAGE = "myapp:latest"
        APP_SERVER_IP = "16.170.209.221"
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'master',
                    url: 'https://github.com/firstweb.git',
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
                sh """
                scp -o StrictHostKeyChecking=no -i devopskey.pem <YOUR_LOCAL_TAR> ubuntu@$APP_SERVER_IP:~/app.tar
                ssh -o StrictHostKeyChecking=no -i devopskey.pem ubuntu@$APP_SERVER_IP '
                    docker stop myapp || true
                    docker rm myapp || true
                    docker load -i ~/app.tar
                    docker run -d -p 80:80 --name myapp myapp:latest
                '
                """
            }
        }
    }
}
