pipeline{
    environment {
        INAGE_NAME ="website_img"
        INAGE_TAG =1.2
        STAGING = "$USER-website-staging"
        PRODUCTION = "$USER-website-prod"
        ENDPOINT="http://52.201.244.209"
        USER = 'olivierdja'
        PRIVATE_KEY = credentials('private_key')
       
    }
    agent none
    stages{
        stage('Build Docker Image'){
            agent any
            steps{
                script {
                    sh 'docker build -t $USER/$INAGE_NAME:$INAGE_TAG ./APP/' 
                }
            }
        }
         stage('Clean Up Existing Containers'){
            agent any
            steps{
                script {
                    sh '''
                    docker rm -f $INAGE_NAME || echo "Container does not exist"
                    
                    '''
                }
            }
        }

        stage('Launch Docker Container'){
            agent any
            steps{
                script {
                    sh '''
                    docker run --name=$INAGE_NAME -dp 83:8080 $USER/$INAGE_NAME:$INAGE_TAG
                    sleep 5
                    
                    '''
                }
            }
        }

        stage('Run Tests'){
            agent any
            steps{
                script {
                    sh '''
                    curl $ENDPOINT:83 | grep "IC GROUP"
                    
                    '''
                }
            }
        }
       

stage('Upload Image to DockerHub') {
    agent any
    steps {
        withCredentials([usernamePassword(credentialsId: 'dockerhub_passowrd', usernameVariable: 'DOCKERHUB_CREDENTIALS_USR', passwordVariable: 'DOCKERHUB_CREDENTIALS_PSW')]) {
            script {
                sh '''
                echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin
                docker push $USER/$INAGE_NAME:$INAGE_TAG
                '''
            }
        }
    }
}
stage('Prepare Ansible environment') {
            agent any
            steps {
                script {
                    sh '''
                        echo $PRIVATE_KEY > id_rsa
                        chmod 600 id_rsa
                    '''
                }
            }
        }

    }
}



        
      
    }
}
