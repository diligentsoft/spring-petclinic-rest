pipeline {
    agent any
    stages {
        stage('Build') {
            agent {
                docker {
                    image 'maven:3-alpine'
                    args '-v /root/.m2:/root/.m2'
                }
            }
            steps {
                sh 'mvn -B -DskipTests clean package'
            }
        }
        stage('Publish') {
            steps {
                sh 'docker tag spring-petclinic:latest diligentsoft/spring-petclinic:latest'
                withCredentials([usernamePassword(credentialsId: 'docker-hub', usernameVariable: 'username', passwordVariable: 'password')]) {
                    sh 'docker login -u $username -p $password'
                }
                sh 'docker push diligentsoft/spring-petclinic:latest'
            }
        }
        stage('Deploy - Test') {
            steps {
                sh './deploy.sh 52.56.220.178 latest'
            }
        }
    }
}
