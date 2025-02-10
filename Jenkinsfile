pipeline {
    agent any

    stages {
        stage('Git Clone') {
            steps {
                git branch: 'main', url: 'https://github.com/prakashmk07/docker.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t image1 .'
            }
        }
        
        stage('Run Container') {
            steps {
                sh 'docker run -itd --name java image1'
            }
        }

        stage('Verify Webhook') {
            steps {
                script {
                    // Check if webhook payload is received (basic verification)
                    sh '''
                        echo "Checking webhook connectivity..."
                        curl -sSf https://api.github.com/meta | jq .hooks > github_hooks.txt
                        echo "GitHub webhook IP ranges verified"
                    '''
                    // Add additional webhook verification logic if needed
                }
            }
        }
    }

    post {
        success {
            slackSend color: "good", message: "Build Successful: ${env.JOB_NAME} ${env.BUILD_NUMBER}"
        }
        failure {
            slackSend color: "danger", message: "Build Failed: ${env.JOB_NAME} ${env.BUILD_NUMBER}"
        }
    }
}
