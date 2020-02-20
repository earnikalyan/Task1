pipeline {
    agent any
     tools { 
        maven 'maven' 
        jdk 'java' 
    }
    stages{
    
    stage ('git clone') {
            steps {
        echo "code is building"
         git 'http://13.230.194.203/root/my_first_project1.git'
            }
        }

        stage ('build') {
            steps {
        echo "code is building"
         sh 'mvn clean'
         sh 'mvn install'                
            }
        }
        
  stage('Deploy Artifacts') 
        { 
             steps 
             {
                script 
                {			 
                     def server = Artifactory.server 'artifactory' 
                     def uploadSpec = """{
                       "files": [
                            {
                              "pattern": "/var/lib/jenkins/.m2/repository/com/dev3l/hello_world/mvn-hello-world/1.4-SNAPSHOT/mvn-hello-world-1.4-SNAPSHOT.war",
                              "target": "My_task/"
                            }
                                ]
                    }"""
	                server.upload(uploadSpec)
	            }
	          }
	        }

        stage ('Bulding docker docker image') {
            steps { 
                echo "build docker image"
                sh 'docker build -t firstclass .'
            }
        }
        stage ('Uploading to Ecr') {
            steps {
                echo "uploading to ECR "
                sh 'aws ecr get-login --no-include-email'
                sh 'docker tag firstclass:latest 389670566897.dkr.ecr.ap-northeast-1.amazonaws.com/firstclass:latest'
		sh 'docker push 389670566897.dkr.ecr.ap-northeast-1.amazonaws.com/firstclass:latest'
            }
        }

        stage ('deploying to EKS') {
           steps { 
                echo "deploying imges to EKS"
                sh 'rm -rf /var/lib/jenkins/.kube && aws eks update-kubeconfig --name Task'
                sh 'kubectl apply -f Dp.yaml'
                sh 'kubectl apply -f SVC.yaml'
           }
    }  
        
}

}
