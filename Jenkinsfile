node {
   
   stage('Git Checkout') {
     checkout scm
    
   }
   stage('Build') {
     
       sh 'npm install'
       
    }
    stage('Test') {
     
       sh 'npm test'
     
   }
   stage('Docker Image') {
        def dockerobject = docker.build "onboard.azurecr.io/gitopsnjs:latest"
        
        docker.withRegistry( "onboard.azurecr.io/gitopsnjs:latest", "gitopsacr" ) {
        dockerobject.push()
     }
   }
}
