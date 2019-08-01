pipeline {
  agent any
  
  
  stages {
    stage('build') {
      steps {
        echo 'build'
        sh   'build.sh'
      }
    }
    stage('deploy') {
      steps {
        echo 'deploy'
      }
    }
  }
}
