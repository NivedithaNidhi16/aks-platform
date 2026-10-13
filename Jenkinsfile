pipeline {
    agent {
        label 'agent'
    }

    stages {
        stage('Checkout') {
            steps {
                echo 'Checking out source code from GitHub'
                checkout scm
            }
        }

        stage('Test') {
            steps {
                echo 'Run the test cases'
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
                echo 'Build the application'
                dir('application') {
                    sh 'docker build -t aks-app:latest .'
                }
            }
        }

        stage('Push') {
            steps {
                echo 'Push Docker image to ACR'

                withCredentials([usernamePassword(
                    credentialsId: 'azure-sp-acr',
                    usernameVariable: 'AZURE_CLIENT_ID',
                    passwordVariable: 'AZURE_CLIENT_SECRET'
                )]) {
                    sh '''
                        set +x
                        set -e

                        echo "$AZURE_CLIENT_SECRET" | docker login nivacrseukr.azurecr.io \
                            --username "$AZURE_CLIENT_ID" \
                            --password-stdin

                        docker tag aks-app:latest \
                            nivacrseukr.azurecr.io/aks-app:${BUILD_NUMBER}

                        docker push nivacrseukr.azurecr.io/aks-app:${BUILD_NUMBER}

                        docker logout nivacrseukr.azurecr.io
                    '''
                }
            }
        }

        stage('Deploy to AKS') {
            steps {
                echo 'Deploying application to AKS'

                withCredentials([usernamePassword(
                    credentialsId: 'azure-sp-acr',
                    usernameVariable: 'AZURE_CLIENT_ID',
                    passwordVariable: 'AZURE_CLIENT_SECRET'
                )]) {
                    sh '''
                        set +x
                        set -e

                        az login \
                            --service-principal \
                            --username "$AZURE_CLIENT_ID" \
                            --password "$AZURE_CLIENT_SECRET" \
                            --tenant "e04e9f50-006e-4eaa-ab0b-e804b0c7b7d1" \
                            --output none

                        az account set \
                            --subscription "2848b0d1-a487-4669-b6ef-3dac9cf8117b"

                        az aks get-credentials \
                            --resource-group prod-niv-aks-niv-rg \
                            --name prod-niv-aks-niv-aks \
                            --overwrite-existing

                        kubelogin convert-kubeconfig -l azurecli

                        kubectl apply -f kubernetes/namespace.yaml
                        kubectl apply -f kubernetes/deployment.yaml
                        kubectl apply -f kubernetes/service.yaml

                        kubectl set image deployment/aks-app \
                            aks-app=nivacrseukr.azurecr.io/aks-app:${BUILD_NUMBER} \
                            -n aks-app

                        kubectl rollout status deployment/aks-app \
                            -n aks-app --timeout=180s

                        kubectl get pods -n aks-app
                        kubectl get service -n aks-app

                        az logout
                    '''
                }
            }
        }
    }
}