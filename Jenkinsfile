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
                withCredentials([string(credentialsId: 'swarm-master-test', variable: 'swarm_master')]) {
                    sh './deploy.sh $swarm_master latest'
                }
            }
        }
        stage('Sanity check') {
            steps {
                input "Does the staging environment look ok? Deploy to prod?"
            }
        }
        stage('Deploy - Prod') {
            steps {
                withCredentials([string(credentialsId: 'swarm-master-prod', variable: 'swarm_master')]) {
                    sh './deploy.sh $swarm_master latest'
                }
            }
        }
    }
}
