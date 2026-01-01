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
    -Dsonar.login=${SO
