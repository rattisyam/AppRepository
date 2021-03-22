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
        
        docker.withRegistry( "https://onboard.azurecr.io/gitopsnjs:1."+env.BUILD_NUMBER, "gitopsacr" ) {
        dockerobject.push()
     }
   }
   stage('Update GitOps Dev'){
      withCredentials([usernamePassword(credentialsId: 'af539a9b-b67e-41d7-9179-5519fee65c6d', usernameVariable: 'USER', passwordVariable: 'PASS')]) {
                    script {
                        env.encodedPass=URLEncoder.encode(PASS, "UTF-8")
                    }
                    sh 'rm -rf master && git clone https://${USER}:${encodedPass}@github.com/rattisyam/GitOpsRepo.git master'
                    sh "cd master && yq e '.image.tag = 1.${env.BUILD_NUMBER}' -i ${WORKSPACE}/master/nodejs/values.dev.yaml && git add . && git commit -m 'updated tag' && git push origin master"
                    //sh "git add ."
                    //sh 'git commit -m "updated tag" '
                    //sh 'cd master && git push origin master'
                } 
      //git branch: 'master',  credentialsId:"af539a9b-b67e-41d7-9179-5519fee65c6d" , url: "https://github.com/rattisyam/GitOpsRepo.git"
   }
  // stage('Update Image tag'){
  //    sh "yq e '.image.tag = 1.${env.BUILD_NUMBER}' -i ${WORKSPACE}/nodejs/values.yaml  && git commit -am 'updated tag' && git push origin master"
  // }
   
  stage('Create a PR'){
       
      withCredentials([usernamePassword(credentialsId: 'af539a9b-b67e-41d7-9179-5519fee65c6d', usernameVariable: 'USER', passwordVariable: 'PASS')]) {
                    script {
                        env.encodedPass=URLEncoder.encode(PASS, "UTF-8")
                    }
                    sh 'rm -rf AppRepository && git clone --branch dev https://${USER}:${encodedPass}@github.com/rattisyam/AppRepository.git AppRepository'
                   
      }
	 withCredentials([usernamePassword(credentialsId: 'gittoken', usernameVariable: 'USER', passwordVariable: 'PASS')]) {
                   
				    
                    sh "cd AppRepository && echo ${PASS} > token && gh auth login --with-token < token && gh pr create --base stage --head dev --fill"
			}
	  slackSend color: '#BADA55', message: 'Created New Pull Request For Stage ${ghprbPullId} ${env.BUILD_URL}'               
                    
    } 
	
post {
    success {
      slackSend (color: '#00FF00', message: "SUCCESSFUL: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]' (${env.BUILD_URL})")
    }
    failure {
      slackSend (color: '#FF0000', message: "FAILED: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]' (${env.BUILD_URL})")
    }
}
