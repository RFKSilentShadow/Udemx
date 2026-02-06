pipeline {
  agent any

  environment {
    REGISTRY="localhost:5000"
    IMAGE="udemx/hello"
    TAG="latest"
    RELEASE="udemx"
    NAMESPACE="udemx"
  }

  stages {

    stage('Checkout') {
      steps {
        git url: 'https://github.com/RFKSilentShadow/Udemx.git',
            branch: 'main'
      }
    }

    stage('Build') {
      steps {
        sh "docker build -t $REGISTRY/$IMAGE:$TAG -f docker/Dockerfile ."
      }
    }

    stage('Push') {
      steps {
        sh """
          docker push $REGISTRY/$IMAGE:$TAG
        """
      }
    }

    stage('Deploy Helm') {
      steps {
        sh """
          helm upgrade --install $RELEASE helm/udemx \
            --namespace $NAMESPACE \
            --create-namespace
        """
      }
    }
  }
}
