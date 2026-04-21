pipeline {
    agent any

    tools {
        maven 'mvn'
        jdk 'JDK11'
    }

    environment {
        IMAGE_NAME = 'athu1717/my-student-app'
        SONARQUBE_ENV = 'sonar'
        DOCKER_CREDENTIALS = 'docker-creds'
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Build & Unit Test') {
            steps {
                sh 'mvn clean install'
            }
        }

        stage('SonarQube Analysis') {
            steps {
                withSonarQubeEnv('sonar') {
                    withCredentials([string(credentialsId: 'sonar-token', variable: 'SONAR_TOKEN')]) {
                        sh '''
                        mvn clean verify sonar:sonar \
                        -Dsonar.projectKey=sonar-app \
                        -Dsonar.host.url=http://51.20.123.239:9000 \
                        -Dsonar.login=$SONAR_TOKEN
                        '''
                    }
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t $IMAGE_NAME:${BUILD_NUMBER} .'
            }
        }

        stage('Trivy Scan (Image)') {
            steps {
                sh '''
                trivy image --exit-code 1 --severity HIGH,CRITICAL $IMAGE_NAME:${BUILD_NUMBER}
                '''
            }
        }

        stage('Push to DockerHub') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'docker-creds', usernameVariable: 'USER', passwordVariable: 'PASS')]) {
                    sh '''
                    echo $PASS | docker login -u $USER --password-stdin
                    docker push $IMAGE_NAME:${BUILD_NUMBER}
                    '''
                }
            }
        }

        stage('Deploy to Staging') {
            steps {
                sh '''
                docker rm -f staging || true
                docker run -d -p 8081:8080 --name staging $IMAGE_NAME:${BUILD_NUMBER}
                '''
            }
        }

        stage('Manual Approval (Production)') {
            steps {
                input message: 'Deploy to PRODUCTION?', ok: 'Yes, Deploy'
            }
        }

        stage('Deploy to Production') {
    steps {
        sshagent(['prod-ec2-key']) {
            sh '''
            ssh -o StrictHostKeyChecking=no ubuntu@13.63.159.135 "
            docker pull ${IMAGE_NAME}:${BUILD_NUMBER} &&
            docker rm -f prod || true &&
            docker run -d -p 8082:8080 --name prod ${IMAGE_NAME}:${BUILD_NUMBER}
            "
            '''
        }
    }
}
    }
}
