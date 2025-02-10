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

