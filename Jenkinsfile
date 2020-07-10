pipeline {
  environment {
    PROJECT = "web-app-python"
    REGISTRYNAME = "andrehpedrotti"
    registryCredential = "dockerhub"
    registry="$REGISTRYNAME/$PROJECT"
    VERSIONBASE = "base"
    dockerImage = ''
  }
  agent any
  stages {
    stage('Git Clone') {
      steps {
        git 'https://github.com/apedrotti/v01.git'
      }
    }

    stage('Build Image') {
      steps {
        script {
          sh '[! -z $(docker images -q $REGISTRYNAME/$PROJECT:$VERSIONBASE) ] || docker build -t $REGISTRYNAME/$PROJECT:$VERSIONBASE -f ./docker/Dockerfile.base .'
        }
      }
    }
    stage('Build updated image'){
      steps {
        script {
          sh 'docker build -t $REGISTRYNAME/$PROJECT:${BUILD_NUMBER} \
                --build-arg REGISTRYNAME=$REGISTRYNAME \
                --build-arg PROJECT=$PROJECT \
                --build-arg VERSIONBASE=$VERSIONBASE \
                -f ./docker/Dockerfile.prod .'
          dockerImage = "$REGISTRYNAME/$PROJECT:${BUILD_NUMBER}"
        }
      }
    }

    stage ('Stop Existing container'){
      steps {
        sh '[ -z $(docker ps -q --filter "name=$PROJECT") ] || docker stop $PROJECT && docker container prune -f'
        /*sh 'docker container prune -f'*/
      }
    }
    
    stage ('Run Container'){
      steps {
        sh 'docker run -d --restart always -p 80:8000 --name $PROJECT $registry:$BUILD_NUMBER'
      }
    }
  
    stage('Push Image to Registry $registry') {
      steps {
        script {
          docker.withRegistry( '', registryCredential ) {
          /* Push the container to the custom Registry */
            dockerImage.push()
          }
        }
      }
    }

    stage('Remove unused images') {
      steps {
        //sh 'docker images rmi $registry:$BUILD_NUMBER'
        sh 'docker image prune -f -a'
      }
    }

  } /*End of stages*/
}