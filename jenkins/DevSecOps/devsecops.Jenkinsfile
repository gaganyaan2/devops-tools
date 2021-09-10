def git_url = 'https://github.com/koolwithk/devops-tools.git'
def git_branch = 'main'

pipeline
{
    agent {
        label 'lp-worker-1'
    }
    environment {
    scannerHome = tool 'sonarqube'
    }
    stages
    {
        /*stage('Git-checkout')
        {
            steps
            {
                git credentialsId: 'github', url: git_url , branch: git_branch
            }
        }*/
        stage('detect-secret')
        {
            steps
            {
                sh '''
                echo "detect-check"
                #detect-secrets -C /path/to/directory scan
                '''
            }
        }
        stage('static-analysis-code')
        {
            steps
                {
                        script 
                        {
                            withSonarQubeEnv('sonarqube') 
                            {
                                def temp_job_name = JOB_NAME.replaceAll('/','-')
                                sh '${scannerHome}/bin/sonar-scanner --version'
                                sh "${scannerHome}/bin/sonar-scanner -Dsonar.sourceEncoding=UTF-8  -Dsonar.sources=${WORKSPACE} -Dsonar.projectKey=${temp_job_name}-${git_branch} -Dsonar.projectName=${temp_job_name}-${git_branch};"
                                
                                    withCredentials([usernamePassword(credentialsId: 'sonarqube-user', usernameVariable: 'uname' , passwordVariable: 'upass')]) 
                                    {
                                        sh """
                                        cd .scannerwork
                                        sonar_job_url=\$(cat report-task.txt | grep ceTaskUrl | awk -F 'ceTaskUrl=' '{print \$NF}')
                                        while(true)
                                        do
                                            sonar_job_status=\$(curl -s --user "\$uname:\$upass" \$sonar_job_url | awk -F '"status":' '{print \$NF}' | cut -d ',' -f1 | sed 's/"//g')
                                            sleep 10
                                            if [ "\$sonar_job_status" != 'IN_PROGRESS' ]
                                            then
                                            echo "sonar job completed"
                                            
                                            #get new bugs
                                            new_vulnerabilities=\$(curl -s --user "\$uname:\$upass" http://sonarqube.example.com/api/measures/search_history?component="${temp_job_name}-${git_branch}"'&'metrics=new_vulnerabilities | awk -F '"value":' '{print \$NF}' | awk -F '}' '{print \$1}' | sed 's/"//g')
                                            new_bugs=\$(curl -s --user "\$uname:\$upass" http://sonarqube.example.com/api/measures/search_history?component="${temp_job_name}-${git_branch}"'&'metrics=new_bugs | awk -F '"value":' '{print \$NF}' | awk -F '}' '{print \$1}' | sed 's/"//g')
                                            new_violations=\$(curl -s --user "\$uname:\$upass" http://sonarqube.example.com/api/measures/search_history?component="${temp_job_name}-${git_branch}"'&'metrics=new_violations | awk -F '"value":' '{print \$NF}' | awk -F '}' '{print \$1}' | sed 's/"//g')
                                            
                                            echo "new_vulnerabilities=\$new_vulnerabilities new_bugs=\$new_bugs new_violations=\$new_violations" > /tmp/\${JOB_BASE_NAME}-\${BUILD_ID}.txt
                                            
                                            cat "/tmp/\${JOB_BASE_NAME}-\${BUILD_ID}.txt"
                                            
                                            echo "new_vulnerabilities: \$new_vulnerabilities , new_bugs : \$new_bugs , new_violations : \$new_violations"
                                            exit
                                            fi

                                        done
                                        """
                                    }
                            }

                            def qualitygate = waitForQualityGate()
                            server_report = qualitygate.status
                        }
                    
                }
        }
        stage('dependency-check')
        {
            steps
            {
                sh '''
                echo "dependency-check"
                #/dependency-check.sh --out /tmp --scan /home/home/Downloads/jar_file
                #OR oss scan
                '''
            }
        }
        stage('static-analysis-docker')
        {
            steps{
            sh '''
            #static analyisi of Dockerfile
            docker run -t -v $(pwd):/output bridgecrew/checkov -f /output/Dockerfile -o json |  jq '.' > docker_result | exit 0
            cat docker_result
            '''                
            }
        } 
        stage('docker build')
        {
            steps{
            sh '''
                      
            docker build -t the_httpd .
            docker tag the_httpd docker.com/koolwithk/the_httpd
            docker push docker.com/koolwithk/the_httpd
            '''
            }
        }
        stage('docker scan')
        {
            steps{
            sh '''
            echo "docker scan"
            #grype imagename -o json
            '''
            }
        }
        stage('kube-bench')
        {
            steps{
            sh '''
            #kube bench
            docker run --pid=host -v /etc:/etc:ro -v /var:/var:ro -t aquasec/kube-bench:latest --version 1.21
            
            #kube hunter
            kube-hunter --remote 192.168.0.183 --active > kube_hunter
            cat kube_hunter
            '''
            }
        }
        stage('kube-popeye')
        {
            steps{
            sh '''
             docker run -t \
            -v /root/.kube:/root/.kube \
            -e POPEYE_REPORT_DIR=/tmp/popeye \
            -v /tmp:/tmp \
            quay.io/derailed/popeye -n default --save --output-file kube-popeye.txt | exit 0
            
            cat /tmp/popeye/kube-popeye.txt
            '''
            }
        }
        stage('static-analysis-k8deploy')
        {
            steps{
            sh '''
            #static analyisi of Deployment
            docker run -t -v $(pwd):/output bridgecrew/checkov -f /output/the_httpd_deploy.yml -o json |  jq '.' > k8deploy_result | exit 0
            cat k8deploy_result
            '''
            }
        }
        stage('deploy')
        {
            steps
            {
                sh '''
                kubectl delete -f the_httpd_deploy.yml && true
                kubectl apply -f the_httpd_deploy.yml
            '''
            }
        }
        
        stage('api-testing')
        {
            steps
            {
                sh '''
                echo "api-test"
            '''
            }
        }
        stage('DAST')
        {
            steps
            {
                sh '''
                echo "dast"
            '''
            }
        }
    }
}
