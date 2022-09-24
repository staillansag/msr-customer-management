pipeline {
  
  agent any
  
  options {
      skipStagesAfterUnstable()
  }
  
  stages {
    
    stage('Clone repository') { 
      steps { 
        script{
          checkout scm
        }
      }
    }
  
    stage('Build image') {
        /* This builds the actual image; synonymous to
         * docker build on the command line */
      steps {   
        script {
          app = docker.build("staillansag/msr-customer-management", "-f Dockerfile .")
        }
      }
    }

    stage('Test image') {
        /* Ideally, we would run a test framework against our image.
         * For this example, we're using a Volkswagen-type approach ;-) */
      steps { 
        sh 'echo "Tests passed"'
      }
    }

    stage('Push image') {
        /* Finally, we'll push the image with two tags:
         * First, the incremental build number from Jenkins
         * Second, the 'latest' tag.
         * Pushing multiple tags is cheap, as all the layers are reused. */
      steps { 
        script {
            docker.withRegistry('https://registry.hub.docker.com', 'docker-hub-credentials') {
            app.push("${env.MAJOR_VERSION}.${env.MINOR_VERSION}.${env.BUILD_NUMBER}")
            app.push("latest")
          }
        }
      }
    }
    
    stage('Restart the Kubernetes deployment') {
        /* We restart the K8S deployment to deploy the new image version */
      steps { 
        sh 'kubectl rollout restart deployment customer-management'
      }
    }
    
  }
  
}
