def git_url = 'https://github.com/koolwithk/devops-tools.git'
def git_branch = 'main'
pipeline
{
    agent {
        label 'lp-worker-1'
    }
    options{
        timestamps()
        timeout(time: 30, unit: 'MINUTES')
        buildDiscarder(logRotator(numToKeepStr: '10'))
    }
    environment {
        scannerHome = tool 'sonarqube'
    }
    parameters {
        string( name: 'image_tag', defaultValue: '', description: 'image tag eg. v1', trim: true )
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
                #OR using grype
                cd jenkins/CICD/simple-rust-webserver
                docker run -v $(pwd):/output registry.gitlab.com/security-products/container-scanning/grype:4 grype dir:/output
                '''
            }
        }
        stage('static-analysis-docker')
        {
            steps{
            sh '''
            #static analysis of Dockerfile
            cd jenkins/CICD/simple-rust-webserver
            docker run -v $(pwd):/output bridgecrew/checkov -f /output/Dockerfile -o json > docker_result | exit 0
            
            if [ $(cat docker_result | jq '.summary.failed') -gt 0 ]
            then
                echo "docker static analysis has been failed"
                cat docker_result | grep check_name 
                exit 0
            fi
            '''                
            }
        } 
        stage('docker build')
        {
            steps{
            sh '''
            cd jenkins/CICD/simple-rust-webserver
            docker build -t koolwithk/simple-rust-webserver:${image_tag} .
            '''
            }
        }
        stage('docker scan')
        {
            steps{
            sh '''
            echo "docker scan"
            #grype imagename -o json
            #docker run registry.gitlab.com/security-products/container-scanning/grype:4 grype koolwithk/simple-rust-webserver:${image_tag}  > docker_grype_result
            grype koolwithk/simple-rust-webserver:${image_tag}  > docker_grype_result
            if [ $(cat docker_result | grep -i 'severity'| egrep 'Critical|High' | wc -l ) -gt 0 ]
            then
                echo "docker image scan has been failed"
                cat docker_grype_result | grep -A 1 '"id"'
                exit 1
            fi
            '''
            }
        }
        stage('docker push')
        {
            steps{
            sh '''
            docker push koolwithk/simple-rust-webserver:${image_tag}
            '''
            }
        }
    }
}