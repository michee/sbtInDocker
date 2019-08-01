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
        DOCKERHUB = credentials('dockerhub')
      }
      steps {
        echo 'deploy'
        echo $DOCKERHUB_USR
      }
    }
  }
}
