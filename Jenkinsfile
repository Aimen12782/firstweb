pipeline {
    agent any

    environment {
        IMAGE_NAME = "myapp"
        IMAGE_TAG = "${BUILD_NUMBER}"
        SONAR_TOKEN = credentials('sonarqubetoken')  // SonarQube token ID
    }

    stages {

        stage('Checkout') {
            steps {
                echo "Cloning GitHub repository..."
                git branch: 'main',
                    url: 'https://github.com/Aimen12782/firstweb.git',
                    credentialsId: 'githubtoken'  // GitHub token ID
            }
        }

        stage('SonarQube Analysis') {
            steps {
                echo "Running SonarQube code analysis..."
                withSonarQubeEnv('SonarQube') {  // Must match SonarQube server name in Jenkins
                    sh '''
                    sonar-scanner \
                        -Dsonar.projectKey=myapp \
                        -Dsonar.sources=
