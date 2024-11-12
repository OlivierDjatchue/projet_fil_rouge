// This is a sample Jenkinsfile that can be used to deploy a web application on a Kubernetes cluster.
pipeline {
    environment {
        IMAGE_NAME = "ic-webapp"
        APP_CONTAINER_PORT = "8080"
        USER = "olivierdja"
        DOCKERHUB_PASSWORD = credentials('dockerhub_password')
        ANSIBLE_IMAGE_AGENT = "registry.gitlab.com/robconnolly/docker-ansible:latest"
        PRIVATE_KEY = credentials('private_key')
        APP_EXPOSED_PORT = "83"
        HOST_IP = "52.201.244.209"
    }
    agent none
    stages {
        stage('Build image') {
            agent any
            steps {
                script {
                    sh 'docker build --no-cache -t $USER/$IMAGE_NAME:$IMAGE_TAG ./APP/'
                }
            }
        }

        stage('Run container based on built image') {
            agent any
            steps {
                script {
                    sh '''
                        echo "Cleaning existing container if exists"
                        docker ps -a | grep -i $IMAGE_NAME && docker rm -f ${IMAGE_NAME} || true
                        docker run --name ${IMAGE_NAME} -d -p $APP_EXPOSED_PORT:$APP_CONTAINER_PORT $USER/$IMAGE_NAME:$IMAGE_TAG
                        sleep 5
                    '''
                }
            }
        }

        stage('Test image') {
            agent any
            steps {
                script {
                    sh '''
                        curl -I http://${HOST_IP}:${APP_EXPOSED_PORT} | grep -i "200"
                    '''
                }
            }
        }

        stage('Clean container') {
            agent any
            steps {
                script {
                    sh '''
                        docker stop $IMAGE_NAME 
                        docker rm $IMAGE_NAME
                    '''
                }
            }
        }

        stage('Login and Push Image on Docker Hub') {
            agent any
            steps {
                script {
                    sh '''
                        echo $DOCKERHUB_PASSWORD | docker login -u $DOCKERHUB_ID --password-stdin
                        docker push $USER/$IMAGE_NAME:$IMAGE_TAG
                    '''
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

        stage('Deploy application') {
            agent {
                docker { image 'registry.gitlab.com/robconnolly/docker-ansible:latest' }
            }
            stages {
                stage('Ping targeted hosts') {
                    steps {
                        script {
                            sh '''
                                apt update -y
                                anstall sshpass -y 
                                export ANSIBLE_CONFIG=$(pwd)/ansible_ressources/ansible.cfg
                                ansible all -i ./ansible_resources/hosts.yml -m ping --private-key id_rsa 
                            '''
                        }
                    }
                }

                stage('Deploy the Application') {
                    when { expression { GIT_BRANCH == 'origin/master' } }
                    stages {
                        stage('Install Docker on all hosts') {
                            steps {
                                script {
                                    sh '''
                                        export ANSIBLE_CONFIG=$(pwd)/ansible_ressources/ansible.cfg
                                        ansible-playbook  -i ./ansible_resources/hosts.yml ./ansible-ressources/deploy.yml -i  --private-key id_rsa 
                                    '''
                                }
                            }
                        }

                    }
                }
            }
        }
    }
}


