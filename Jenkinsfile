pipeline {
  environment {
    REGISTRYNAME = "andrehpedrotti"
    registryCredential = "dockerhub"
    PROJECT = "web-app-python"
    VERSIONBASE = "1.0"
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
        script{
          sh '[! -z $(docker images -q $REGISTRYNAME/$PROJECT:$VERSIONBASE) ] || \
                      docker build -t $REGISTRYNAME/$PROJECT:$VERSIONBASE -f ./docker/Dockerfile.base .'
          sh 'docker build -t $REGISTRYNAME/$PROJECT:${BUILD_NUMBER} \
              --build-arg REGISTRYNAME=$REGISTRYNAME \
              --build-arg PROJECT=$PROJECT \
              --build-arg VERSIONBASE=$VERSIONBASE \
              -f ./docker/Dockerfile.prod .'
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
        sh 'docker run -d --restart always -p 80:8000 --name $PROJECT $REGISTRYNAME:$BUILD_NUMBER'
      }
    }
  
    stage('Deploy Image') {
      steps {
        script {
          sh 'docker push $REGISTRYNAME/$PROJECT:${BUILD_NUMBER}'
          }
        }
      }
    
    stage('Remove unused images') {
      steps{
        //sh 'docker images rmi $registry:$BUILD_NUMBER'
        sh 'docker image prune -f -a'
      }
    }

  } /*End of stages*/
}