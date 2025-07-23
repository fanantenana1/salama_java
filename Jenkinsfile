pipeline {
    agent any

    environment {
        SONARQUBE_ENV = 'sonar'  // nom du serveur Sonar dans Jenkins
        SONAR_TOKEN = credentials('sonar-token')
        MAVEN_HOME = tool 'maven' // doit être configuré dans Jenkins (Manage Jenkins > Global Tool Configuration)
    }

    stages {
        stage('Cloner le code') {
            steps {
                git branch: 'main', url: 'https://github.com/fanantenana1/salama_java.git'
            }
        }

        stage('Analyse SonarQube') {
            steps {
                withSonarQubeEnv(SONARQUBE_ENV) {
                    sh "${MAVEN_HOME}/bin/mvn sonar:sonar -Dsonar.projectKey=salama_java -Dsonar.login=${SONAR_TOKEN}"
                }
            }
        }

        stage('Construire l’image Docker') {
            steps {
                sh 'docker build -t monimagejava .'
            }
        }

        stage('Pousser sur DockerHub') {
            steps {
                withDockerRegistry([credentialsId: 'docker-hub-creds', url: '']) {
                    sh 'docker tag monimagejava haaa012/monimagejava'
                    sh 'docker push haaa012/monimagejava'
                }
            }
        }

        stage('Déployer vers Nexus') {
            steps {
                sh "${MAVEN_HOME}/bin/mvn deploy -DaltDeploymentRepository=nexus::default::http://localhost:8081/repository/maven-releases/"
            }
        }
    }
}
