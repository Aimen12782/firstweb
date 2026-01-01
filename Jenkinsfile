pipeline {
    agent any

    environment {
        SONAR_TOKEN = credentials('sonarqubetoken')
        IMAGE_NAME = "myapp"
        IMAGE_TAG = "${BUILD_NUMBER}"
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
                script {
                    def scannerHome = tool name: 'sonar-scanner', type: 'hudson.plugins.sonar.SonarRunnerInstallation'
                    withSonarQubeEnv('SonarQube') {
    sh """
    /var/lib/jenkins/tools/hudson.plugins.sonar.SonarRunnerInstallation/sonar-scanner/bin/sonar-scanner \
    -Dsonar.projectKey=myapp \
    -Dsonar.sources=. \
    -Dsonar.host.url=http://16.170.15.66>:9000 \
    -Dsonar.login=${SONAR_TOKEN}
    """
}
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
                sshagent(['ec2key']) {
                    sh """
                    ssh -o StrictHostKeyChecking=no ubuntu@16.171.56.29 "
                        sudo docker stop ${IMAGE_NAME} || true
                        sudo docker rm ${IMAGE_NAME} || true
                        sudo docker run -d -p 80:80 --name ${IMAGE_NAME} ${IMAGE_NAME}:${IMAGE_TAG}
                    "
                    """
                }
            }
        }
    }

    post {
        success {
            echo "Pipeline completed successfully!"
        }
        failure {
            echo "Pipeline failed. Check logs!"
        }
    }
}
