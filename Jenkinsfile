pipeline {
    agent {
        label 'agent'
    }
    stages {
        stage('Checkout') {
            steps {
                echo "Checking out source code from GitHub"
                checkout scm
            }
        }
        stage('Test') {
            steps {
                echo "Run the test cases"
                sh 'python3 --version'
                dir('application') {
                    sh 'python3 -m pip --version'
                    sh 'python3 -m venv venv'
                    sh 'venv/bin/python -m pip install -r requirements.txt'
                    sh 'venv/bin/python -m py_compile main.py'
                }
            }
        }
        stage('Build') {
            steps {
                echo "Build the application"
                dir('application') {
                    sh 'docker build -t aks-app:latest .'
                }
            }
        }
        stage('Push'){
            steps{
                echo "Docker image to be pushed to ACR registry"
                withCredentials([usernamePassword(
                    credentialsId: 'azure-sp-acr',
                    usernameVariable: 'AZURE_CLIENT_ID',
                    passwordVariable: 'AZURE_CLIENT_SECRET'
                )]){
                    sh '''
                    set +x
                    echo "$AZURE_CLIENT_SECRET" | docker login  nivacrseukr.azurecr.io --username "$AZURE_CLIENT_ID" --password-stdin

                     docker tag aks-app:latest nivacrseukr.azurecr.io/aks-app:${BUILD_NUMBER}

                docker push nivacrseukr.azurecr.io/aks-app:${BUILD_NUMBER}

                docker logout nivacrseukr.azurecr.io
                '''
                }
            }
        }
    }
}