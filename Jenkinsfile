pipeline {
  environment {
    REGISTRYNAME = "andrehpedrotti/app-python"
    registryCredential = "dockerhub"
    PROJECT = "app-py"
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
      steps{
        script {
          sh '[! -z $(docker images -q $REGISTRYNAME/$PROJECT:$VERSIONBASE) ] || \
                    docker build -t $REGISTRYNAME/$PROJECT:$VERSIONBASE -f ./docker/Dockerfile .'
        }
      }
    }
    
    stage ('Stop Existing container'){
      steps {
        sh '[ -z $(docker ps -q --filter "name=$container_name") ] || docker stop $container_name && docker container prune -f'
        /*sh 'docker container prune -f'*/
      }
    }
    
    stage ('Run Container'){
      steps {
          sh 'docker run -d -p 80:8000 --name $container_name $registry:$BUILD_NUMBER'
      }
    }
  
    stage('Deploy Image') {
      steps{
        script {
          docker.withRegistry( '', registryCredential ) {
            dockerImage.push()
          }
        }
      }
    }
    
    stage('Remove unused images') {
      steps{
        //sh 'docker images rmi $registry:$BUILD_NUMBER'
        sh 'docker image prune -f -a'
      }
    } 
  }
}