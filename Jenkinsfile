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
   stage('Update GitOps Dev'){
      withCredentials([usernamePassword(credentialsId: 'af539a9b-b67e-41d7-9179-5519fee65c6d', usernameVariable: 'USER', passwordVariable: 'PASS')]) {
                    script {
                        env.encodedPass=URLEncoder.encode(PASS, "UTF-8")
                    }
                    sh 'rm -rf master && git clone https://${USER}:${encodedPass}@github.com/rattisyam/GitOpsRepo.git master'
                    sh "yq e '.image.tag = 1.${env.BUILD_NUMBER}' -i ${WORKSPACE}/master/nodejs/values.yaml"
                    sh "git add ."
                    sh 'git commit -m "updated tag" '
                    sh 'git push origin master'
                } 
      //git branch: 'master',  credentialsId:"af539a9b-b67e-41d7-9179-5519fee65c6d" , url: "https://github.com/rattisyam/GitOpsRepo.git"
   }
  // stage('Update Image tag'){
  //    sh "yq e '.image.tag = 1.${env.BUILD_NUMBER}' -i ${WORKSPACE}/nodejs/values.yaml  && git commit -am 'updated tag' && git push origin master"
  // }
}
