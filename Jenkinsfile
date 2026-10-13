pipeline{
    agent {
        label 'agent'
    }
    stages{
        stage('Checkout'){
            steps{
                echo "Checking out to source code from github"
                checkout scm
            }
        }
        stage('Test'){
            steps{
                echo "Run the test cases"
                sh "python3 --version"

                dir('application'){
                //check pip version
                sh 'python3 -m pip  --version'
                //create virtual environment
                sh 'python3 -m venv venv'
                //install requirements.txt inside that virtual env
                sh 'venv/bin/python -m pip install -r requirements.txt'
                //Check python syntax
                sh 'venv/bin/python -m py_compile main.py'
            }
            }
        }
        stage('Build'){
            steps{
                echo "Build the application"
                dir('application'){
                    sh 'docker build -t aks-app:latest .'
                }
            }
        }
}