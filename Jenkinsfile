pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                git url: 'https://github.com/Sknt017/termometro.git'
            }
        }
        stage('Build') {
            steps {
                sh 'mvn clean'
                sh 'mvn compile'
            }
        }
        stage('Test') {
            steps {
                sh 'mvn org.jacoco:jacoco-maven-plugin:prepare-agent test jacoco:report'
            }
        }
        stage('Package') {
            steps {
                sh 'mvn package'
                
            }
            post{
                always{
                    junit 'target/surefire-reports/**/*.xml'
                }
                success{
                    archiveArtifacts artifacts: 'target/*.jar', followSymlinks: false
                }
            }
        }
        stage('Code Analisys') {
            steps {
                script {
                    def scannerHome = tool 'SonarqubeScanner'
                    withSonarQubeEnv('ServerSonarqube') {
                        sh "${scannerHome}/bin/sonar-scanner \
                            -Dsonar.projectKey=analisisTermometro \
                            -Dsonar.projectName=analisisTermometro \
                            -Dsonar.sources=src/main/java \
                            -Dsonar.java.binaries=target/classes \
                            -Dsonar.coverage.jacoco.xmlReportPaths=target/site/jacoco/jacoco.xml"
                    }
                }
            }
        }
    }
}
