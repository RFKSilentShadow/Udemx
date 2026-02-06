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
        git credentialsId: 'github-key',
            url: 'git@github.com:RFKSilentShadow/Udemx.git'
      }
    }

    stage('Build') {
      steps {
        sh "docker build -t $REGISTRY/$IMAGE:$TAG -f docker/Dockerfile ."
      }
    }

    stage('Push') {
      steps {
        withCredentials([usernamePassword(
          credentialsId: 'registry-creds',
          usernameVariable: 'USER',
          passwordVariable: 'PASS'
        )]) {
          sh """
            echo \$PASS | docker login $REGISTRY -u \$USER --password-stdin
            docker push $REGISTRY/$IMAGE:$TAG
          """
        }
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
