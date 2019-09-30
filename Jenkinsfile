pipeline {
  agent any
  
  
  stages {
    stage('build') {
      steps {
        echo 'build'
        // sh 'ls -la'
        // sh './build.sh'
        sh 'docker build --rm -t michee/arm64v8-sbt:1.2.8 .'
      }
    }
    stage('deploy') {
      environment {
        DOCKERHUB = credentials('dockerhub')
      }
      steps {
        echo 'deploy'
        sh "docker login --username $dockerhub_USR --password $dockerhub_PSW" 
        sh 'docker push michee/arm64v8-sbt:1.2.8'
      }
    }
  }
}
