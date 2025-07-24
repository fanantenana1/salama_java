pipeline {
    agent any

    environment {
        SONARQUBE_ENV = 'sonar'  // Le nom du serveur Sonar configuré dans Jenkins (Manage Jenkins > SonarQube)
        SONAR_TOKEN = credentials('sonar-token')  // Le token stocké dans Jenkins > Credentials
        MAVEN_HOME = tool name: 'maven', type: 'maven'  // Nom de Maven dans Jenkins > Global Tool Configuration
    }

    stages {

        stage('Cloner le dépôt') {
            steps {
                git branch: 'main', url: 'https://github.com/fanantenana1/salama_java.git'
            }
        }
    stage('Tester le serveur Flask') {
        steps {
            sh '''
                docker run -d -p 5000:5000 --name flask_test haaa012/monimagejava
                sleep 5
                curl http://localhost:5000/status
                docker stop flask_test
                docker rm flask_test
            '''
        }
     }

        stage('Analyse SonarQube') {
            steps {
                withSonarQubeEnv(SONARQUBE_ENV) {
                    sh "${MAVEN_HOME}/bin/mvn sonar:sonar -Dsonar.projectKey=salama_java -Dsonar.login=${SONAR_TOKEN}"
                }
            }
        }

        stage('Build Maven') {
            steps {
                sh "${MAVEN_HOME}/bin/mvn clean package"
            }
        }

        stage('Construire l’image Docker') {
            steps {
                sh 'docker build -t haaa012/monimagejava .'
            }
        }

        stage('Pousser vers Docker Hub') {
            steps {
                withDockerRegistry(credentialsId: 'docker-hub-creds', url: '') {
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
