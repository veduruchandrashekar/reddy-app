pipeline{
    agent any
    environment {
      SONAR_URL = "http://IP Address:9000"
    }

    stages{
        stage('Git checkout'){
            steps{
                git branch: 'main', credentialsId: 'jenkins', url: 'https://github.com/veduruchandrashekar/reddy-app.git'
            }
        }
        
        stage('Maven Build'){
            steps{
                sh 'mvn clean package'
            }
        }
        
        stage('sonarqube analysis'){
            steps{
              withSonarQubeEnv('sonar9'){
                            sh "mvn sonar:sonar"
                           
                        }
                        waitForQualityGate abortPipeline: true, credentialsId: 'sonar-token'
  
            }
        }
        
        stage('Docker Build'){
            steps{
                sh 'docker build -t veduruchandrashekar/hr-api.war .'
            }
        }
        
        stage('Docker Push'){
            steps{
                withCredentials([usernamePassword(credentialsId: 'veduru94', passwordVariable: 'pwd', usernameVariable: 'usrname')]) {
                    sh 'docker login -u ${usrname} -p ${pwd}'
                }
                  
                  sh 'docker push veduruchandrashekar/hr-api.war'
            }
        }
        
        stage('Deploy to kubernetes'){
            steps{
                   
                   sh 'kubectl create -f deployment.yml'
                   sh  'kubectl create -f services.yml'
            }
        }
    }
}
