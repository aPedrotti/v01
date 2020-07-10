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
      steps {
        dockerImage = docker.build REGISTRYNAME + ":$BUILD_NUMBER"
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
        docker.withRegistry( '', registryCredential ) {
          dockerImage.push()
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