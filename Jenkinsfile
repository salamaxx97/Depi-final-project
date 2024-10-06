pipeline {
  agent any
  
  environment {
    DOCKER_BFLASK_IMAGE = 'salamaxx97/my-flask-app:latest'
    DOCKER_REGISTRY_CREDS = 'Docker-hub'
  }
   parameters {
        string(name: 'BRANCH_NAME', defaultValue: 'salama-app', description: 'Branch to build')
    }


  stages {
   stage('Checkout') {
            steps {
                git branch: params.BRANCH_NAME, url: 'https://github.com/ahmedabdelharse/DEPI-Grad-Project.git'
            }
        }
    stage('Build') {
      steps {
        sh 'docker build -t my-flask-app .'
        sh 'docker tag my-flask-app $DOCKER_BFLASK_IMAGE'
      }
    }
    stage('Test') {
      steps {
        sh 'docker run my-flask-app python -m pytest app/tests/'
      }
    }
    stage('Deploy') {
      steps {
        withCredentials([usernamePassword(credentialsId: "${DOCKER_REGISTRY_CREDS}", passwordVariable: 'DOCKER_PASSWORD', usernameVariable: 'DOCKER_USERNAME')]) {
          sh "echo \$DOCKER_PASSWORD | docker login -u \$DOCKER_USERNAME --password-stdin docker.io"
          sh 'docker push $DOCKER_BFLASK_IMAGE'
        }
      }
    }
  }
  post {
    success {
      echo 'Build and deployment succeeded!'
    }
    failure {
      echo 'Build or deployment failed!'
    }
    always {
      sh 'docker logout'
    }
    cleanup {
      sh 'docker system prune -f'
    }
  }
}
