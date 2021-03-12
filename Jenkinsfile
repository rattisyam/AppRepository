node {
   
   stage('Git Checkout') {
     checkout scm
    
   }
   stage('Build') {
     nodejs(nodeJSInstallationName: 'nodejs') {
       sh 'npm install'
       
     }
   }
    stage('Test') {
     nodejs(nodeJSInstallationName: 'nodejs') {
      
       sh 'npm test'
     }
   }
   stage('docker build/push') {
        def dockerobject = docker.build "onboard.azurecr.io/gitopsNJS:latest"
        
        docker.withRegistry( "https://onboard.azurecr.io/gitopsNJS", "gitopsacr" ) {
        dockerobject.push())
     }
   }
}
