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
                sh 'sudo docker build -t image1 .'
            }
        }
        
        stage('Run Container') {
            steps {
                sh 'sudo docker run -itd --name java image1'
            }
        }

        stage('Verify Webhook') {
            steps {
                script {
                    try {
                        echo "Checking webhook connectivity..."
                        sh '''
                            set -e  # Exit on error
                            RESPONSE=$(curl -sSf https://api.github.com/meta | jq .hooks)
                            if [ -z "$RESPONSE" ]; then
                                echo "Error: Webhook response is empty!"
                                exit 1
                            fi
                            echo "$RESPONSE" > github_hooks.txt
                            echo "GitHub webhook IP ranges verified"
                        '''
                    } catch (Exception e) {
                        echo "Webhook verification failed: ${e.message}"
                        error("Stopping build due to webhook verification failure!")
                    }
                }
            }
        }
    }

    post {  // This should be outside the 'stages' block
        success {
            slackSend color: "good", message: "Build Successful: ${env.JOB_NAME} #${env.BUILD_NUMBER}"
        }
        failure {
            slackSend color: "danger", message: " Build Failed: ${env.JOB_NAME} #${env.BUILD_NUMBER}"
        }
    }
}
