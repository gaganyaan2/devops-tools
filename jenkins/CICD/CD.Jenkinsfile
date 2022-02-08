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
        stage('static-analysis-k8deploy')
        {
            steps{
            sh '''
            #static analyisi of Deployment
            cd jenkins/CICD/simple-rust-webserver
            sed -i "s/unique_image_tag/${image_tag}/g" k8-deployment.yml
            docker run -t -v $(pwd):/output bridgecrew/checkov -f /output/k8-deployment.yml -o json > k8deploy_result | exit 0
            cat k8deploy_result
            '''
            }
        }
       stage('kube-bench')
        {
            steps{
            sh '''
            #kube bench for CIS scanning
            docker run --pid=host -v /etc:/etc:ro -v /var:/var:ro -t aquasec/kube-bench:latest --version 1.23 | grep '\[FAIL\]'
            
            #kube hunter - Hunt for security weaknesses in Kubernetes clusters
            #kube-hunter --remote 192.168.0.183 --active > kube_hunter
            #cat kube_hunter
            '''
            }
        }
        stage('kube-popeye')
        {
            steps{
            sh '''
            #kube-popeye Kubernetes Cluster Sanitizer
             docker run -t \
            -v /root/.kube:/root/.kube \
            -e POPEYE_REPORT_DIR=/tmp/popeye \
            -v /tmp:/tmp \
            quay.io/derailed/popeye -n default --save --output-file kube-popeye.txt | exit 0
            
            cat /tmp/popeye/kube-popeye.txt
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
        stage('smoke-test')
        {
            steps
            {
                sh '''
                sleep 5
                status_code=$(curl -sL -w "%{http_code}\\n" "http://<endpoint>" -o /dev/null)
                if [[ "$status_code" != "200" ]]
                then
                    echo "$endpoint status code is : $status_code"
                    exit 1
                fi
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