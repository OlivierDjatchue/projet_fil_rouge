pipeline {
    environment {
        IMAGE_NAME = "website_img"
        IMAGE_TAG = "1.2"
        ENDPOINT = "http://192.168.99.10"
        USER = 'olivierdja'
        VAULT = credentials('vault_key')
        PRIVATE_KEY = credentials('private_key')
        ANSIBLE_IMAGE_AGENT = "docker.io/olivierdja/ansible-prepped"
        
    }
    agent none
    stages {
        stage('Build Docker Image') {
            agent any
            steps {
                script {
                    sh 'docker build -t ${USER}/${IMAGE_NAME}:${IMAGE_TAG} ./APP/' 
                }
            }
        }
        stage('Clean Up Existing Containers') {
            agent any
            steps {
                script {
                    sh '''
                    docker rm -f ${IMAGE_NAME} || echo "Container does not exist"
                    '''
                }
            }
        }
        stage('Launch Docker Container') {
            agent any
            steps {
                script {
                    sh '''
                    docker run --name=${IMAGE_NAME} -dp 83:8080 ${USER}/${IMAGE_NAME}:${IMAGE_TAG}
                    sleep 5
                    '''
                }
            }
        }
        stage('Run Tests') {
            agent any
            steps {
                script {
                    sh '''
                    curl ${ENDPOINT}:83 | grep "IC GROUP"
                    '''
                }
            }
        }
        stage('Upload Image to DockerHub') {
            agent any
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub_password', usernameVariable: 'DOCKERHUB_CREDENTIALS_USR', passwordVariable: 'DOCKERHUB_CREDENTIALS_PSW')]) {
                script {
                    sh '''
                    echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin
                    docker push $USER/$IMAGE_NAME:$IMAGE_TAG
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
                    
                    echo $VAULT > vault.key
                 
                    '''
                }
            }
        }
        stage('Deploy application') {

            agent {
                docker { 
                       image "${ANSIBLE_IMAGE_AGENT}"
                        args '-u root'
                       }
            }
            stages{
                stage('Test connection') {
                    steps {
                        script {
                            sh '''
                            apt update -y
                            apt install sshpass -y
                            export ANSIBLE_CONFIG=$(pwd)/ansible_resources/ansible.cfg
                            ansible all -i ./ansible_resources/hosts.yml -m ping 
                            '''
                        }
                    }
                }
                
                stage('Insatallion of IC_Webapp') {
                    steps {
                        script {
                            sh '''
                            export ANSIBLE_CONFIG=/var/jenkins_home/workspace/projet-fil-rouge/ansible_resources/ansible.cfg
                            ansible-playbook -i ./ansible_resources/hosts.yml ./ansible_resources/playbooks/deploy-ic-webapp.yml -l ic_webapp_server
                            '''
                        }
                    }
                }
                 stage('Insatallion of odoo') {
                    steps {
                        script {
                            sh '''
                            export ANSIBLE_CONFIG=/var/jenkins_home/workspace/projet-fil-rouge/ansible_resources/ansible.cfg
                            ansible-playbook -i ./ansible_resources/hosts.yml ./ansible_resources/playbooks/deploy-odoo.yml -l odoo_server
                            '''
                        }
                    }
                }
                 stage('Insatallion of pgadmin') {
                    steps {
                        script {
                            sh '''
                            export ANSIBLE_CONFIG=/var/jenkins_home/workspace/projet-fil-rouge/ansible_resources/ansible.cfg
                            ansible-playbook -i ./ansible_resources/hosts.yml ./ansible_resources/playbooks/deploy.yml -l pg_admin_server
                            '''
                        }
                    }
                }
            }
           
        }
    }
}
