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
        //sh "docker login --username $dockerhub_USR --password $dockerhub_PSW" 
        sh 'echo $DOCKERHUB_USR'
      }
    }
  }
}
