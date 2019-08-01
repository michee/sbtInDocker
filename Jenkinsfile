pipeline {
  agent any
  
  
  stages {
    stage('build') {
      steps {
        echo 'build'
        sh 'ls -la'
        sh   './build.sh'
      }
    }
    stage('deploy') {
      environment {
        DOCKERHUB_USR = credentials('dockerhub-usr')
        DOCKERHUB_PSW = credentials('dockerhub-psw')
      }
      steps {
        echo 'deploy'
        echo $DOCKERHUB_USR
      }
    }
  }
}
