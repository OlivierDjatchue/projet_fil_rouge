pipeline{
    environment {
        INAGE_NAME ="ic-webapp"
        INAGE_TAG ="1.0"
        STAGING = "olivierbana-staging"
        PRODUCTION = "olivierbana-prod"
        ENDPOINT ="http://18.206.168.91"
        CONTAINER_TEST_NAME="test-ic-webapp"
    }
    agent none
    stages{
        stage('Build image'){
            agent any
            steps{
                script {
                    sh 'docker build -t $INAGE_NAME:$INAGE_TAG .' 
                }
            }
        }
        stage('Delete container if exist'){
            agent any
            steps{
                script {
                    sh '''
                    docker rm -f $CONTAINER_TEST_NAME || echo "Container does not exist"
                    
                    '''
                }
            }
        }
        stage('Run container'){
            agent any
            steps{
                script {
                    sh '''
                    docker run --name=$CONTAINER_TEST_NAME -dp 85:8080 $INAGE_NAME:$INAGE_TAG
                    sleep 5
                    
                    '''
                }
            }
        }

        stage('Test image'){
            agent any
            steps{
                script {
                    sh '''
                    curl $ENDPOINT:85 | grep "Intranet  Applications"
                    sleep 5
                    
                    '''
                }
            }
        }
        stage('Clean container'){
            agent any
            steps{
                script {
                    sh '''
                    docker stop $CONTAINER_TEST_NAME
                    docker rm $CONTAINER_TEST_NAME
                    '''
                }
            }
        }
       
    
        
    }
}

