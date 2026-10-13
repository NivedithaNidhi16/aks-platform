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
                //Install requirements
                sh 'python3 -m pip install -r requirements.txt'
                //Check python syntax
                sh 'python3 -m py_compile main.py'
            }
            }
        }
    }
}