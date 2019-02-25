
//SSH Agent Plugin
pipeline {
    agent { docker 'isam2016/node:latest' }
    // agent any
    environment {
        DB_ENGINE    = 'sqlite'
    }
    stages {
        stage('build') {
            steps {
                sh 'export'
                sh 'echo "START"'
                sh 'node --version'
                sh 'npm --version'
                sh '''
                    npm install --registry=https://registry.npm.taobao.org
                    npm run  build
                '''
                sh '''
                    who
                '''
            }
        }
        stage('Deploy') {
            steps{
                sshagent(credentials:['deploy_ssh_key']){
                    sh 'ls'
                    // 不能是root 目录
                    sh 'scp -r  -o  StrictHostKeyChecking=no ./dist  root@47.104.95.186:/home'
                }
            }
        }
    }
    post {
        always {
            echo 'This will always run'
        }
        success {
            echo 'This success'
        }
        failure {
            echo 'This will run only if failed'
        }
        unstable {
            echo 'This will run only if the run was marked as unstable'
        }
        changed {
            echo 'This will run only if the state of the Pipeline has changed'
            echo 'For example, if the Pipeline was previously failing but is now successful'
        }
    }
}



