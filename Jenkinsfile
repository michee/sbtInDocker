pipeline {
  agent any
  environment {
    CONTAINER = 'michee/arm64v8-sbt:1.2.8'
  }
 
  stages {
    stage('build') {
      steps {
        echo 'build'
        sh   'docker build --rm -t $CONTAINER .'
      }
    }
    stage('deploy') {
      environment {
        DOCKERHUB = credentials('dockerhub')
      }
      steps {
        echo 'deploy'
        sh   "docker login --username $dockerhub_USR --password $dockerhub_PSW" 
        sh   'docker push $CONTAINER'
      }
    }
    stage('clean') {
      steps {
        echo 'cleanup hosts docker from lefover containers'
        sh   'docker system prune --all -y'
    }
  }
}
