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
            }
        }
    }
}