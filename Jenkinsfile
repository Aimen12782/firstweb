pipeline {
    agent any

    // This tells Jenkins to pull the 'sonar-scanner' tool you just configured
    tools {
        sonarScanner 'sonar-scanner' 
    }

    environment {
        IMAGE_NAME = "myapp"
        IMAGE_TAG = "${BUILD_NUMBER}"
        SONAR_TOKEN = credentials('sonarqubetoken')
    }

    stages {
        // ... (Checkout stage)

        stage('SonarQube Analysis') {
            steps {
                echo "Running SonarQube code analysis..."
                withSonarQubeEnv('SonarQube') {
                    // Because of the 'tools' block, Jenkins now knows what 'sonar-scanner' is
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
        // ... (Remaining stages)
    }
}
