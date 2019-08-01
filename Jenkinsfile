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
      steps {
        echo 'deploy'
      }
    }
  }
}
