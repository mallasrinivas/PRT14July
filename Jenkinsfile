Jenkins pipeline
pipeline {
    agent any

    environment {
        DOCKER_HUB_CREDENTIALS = credentials('dockerhub') // Jenkins credentials ID for DockerHub
        KUBE_CONFIG = credentials('kubeconfig') // Jenkins credentials ID for Kubernetes config
    }

    stages {
        stage('Checkout') {
            steps {
                // Checkout code from GitHub repository
                git 'https://github.com/YourUsername/Website-PRT-ORG.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                // Build Docker image from Dockerfile
                script {
                    def dockerImage = docker.build('yourdockerhubusername/website-prt-org:${env.BUILD_NUMBER}')
                    dockerImage.push()
                }
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                // Use Kubernetes deployment manifest
                withCredentials([file(credentialsId: 'kubeconfig', variable: 'KUBECONFIG')]) {
                    sh 'kubectl --kubeconfig=$KUBECONFIG apply -f kubernetes/deployment.yaml'
                    sh 'kubectl --kubeconfig=$KUBECONFIG apply -f kubernetes/service.yaml'
                }
            }
        }

        stage('Verify Deployment') {
            steps {
                // Check deployment status
                withCredentials([file(credentialsId: 'kubeconfig', variable: 'KUBECONFIG')]) {
                    sh 'kubectl --kubeconfig=$KUBECONFIG get pods --namespace=default'
                    sh 'kubectl --kubeconfig=$KUBECONFIG get svc --namespace=default'
                }
            }
        }
    }

    post {
        success {
            echo 'Pipeline successfully completed!'
        }
        failure {
            echo 'Pipeline failed!'
        }
    }
}

