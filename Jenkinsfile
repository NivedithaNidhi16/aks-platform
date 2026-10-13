pipeline{
    agent {
        label 'agent'
    }
    stages{
        stage('Checkout'){
            steps{
                echo "Checout to source code from github"
                checkout scm
            }
        }
    }
}