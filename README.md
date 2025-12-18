pipeline {
    agent any

    stages {
        stage('Checkout Code') {
            steps {
                // Pull latest code from your GitHub repo
                git branch: 'main', url: 'https://github.com/Aimen12782/firstweb.git'
            }
        }

        stage('Build') {
            steps {
                echo "Building project..."
                // Add any build commands here if needed
            }
        }

        stage('Deploy') {
            steps {
                echo "Deploying to server..."
                // Example: copy code to server and restart app
                sh '''
                cd /var/www/gitproject1
                git pull origin main
                sudo systemctl restart gitproject1
                '''
            }
        }
    }

    post {
        success {
            echo "Deployment completed successfully!"
        }
        failure {
            echo "Deployment failed!"
        }
    }
}
