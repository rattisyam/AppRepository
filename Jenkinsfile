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
        def dockerobject = docker.build "onboard.azurecr.io/gitopsnjs:1."+env.BUILD_NUMBER
        
        docker.withRegistry( "https://onboard.azurecr.io/gitopsnjs:latest", "gitopsacr" ) {
        //dockerobject.push()
     }
   }
}
