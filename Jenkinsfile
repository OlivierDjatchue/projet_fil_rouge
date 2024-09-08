pipeline{
    environment {
        INAGE_NAME ="website_img"
        INAGE_TAG ="latest"
        STAGING = "$USER-website-staging"
        PRODUCTION = "$USER-website-prod"
        ENDPOINT="http://10.0.4.5"
        DOCKERHUB_CREDENTIALS = credentials('dockerhub_passowrd')
        USER = 'olivierdja'
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
                    docker run --name=$INAGE_NAME -dp 83:80 -e PORT=80 $USER/$INAGE_NAME:$INAGE_TAG
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
                    curl $ENDPOINT:83 | grep "Dimension"
                    
                    '''
                }
            }
        }
       

        stage('Upload Image to DockerHub'){
            agent any
            steps{
                script {
                    sh '''
                    echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin
                    docker push  $USER/$INAGE_NAME:latest
            
                    '''
                }
            }
        }
        stage('Deploy to Heroku Staging'){
            when{
                expression { GIT_BRANCH == 'origin/master'}
            }
            agent any
            environment{
                HEROKU_API_KEY = credentials('heroku_api_key')
            }
            steps{
                script {
                    sh '''
                    npm i -g heroku@7.68.0
                    heroku container:login
                    heroku create $STAGING || echo "project already exist"
                    heroku container:push -a $STAGING web
                    heroku container:release -a $STAGING web
                    
                    '''
                }
            }
        }
        stage('Deploy to Heroku Production'){
            when{
                expression { GIT_BRANCH == 'origin/master'}
            }
            agent any
            environment{
                HEROKU_API_KEY = credentials('heroku_api_key')
            }
            steps{
                script {
                    sh '''
                  npm i -g heroku@7.68.0
                  heroku container:login
                  heroku create $PRODUCTION || echo "project already exist"
                  heroku container:push -a $PRODUCTION web
                  heroku container:release -a $PRODUCTION web
                    
                    '''
                }
            }
        }
    }
}
