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
   stage('Clone GitOps repo'){
      git branch: 'master',  credentialsId:"af539a9b-b67e-41d7-9179-5519fee65c6d" , url: "https://github.com/rattisyam/GitOpsRepo.git"
   }
   stage('Update Image tag'){
      sh "yq write -i ./nodejs/values.yaml image.tag 1.${env.BUILD_NUMBER} && git commit -am 'updated tag' && git push origin master"
   }
}
