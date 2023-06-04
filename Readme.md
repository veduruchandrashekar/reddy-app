Technologies used: Git, Maven, Jenkins, Docker, Sonarqube, K8s, AWS
# Installing jenkins
Create an ec2 instance and install jenkins on it.
sudo yum update
sudo wget -O /etc/yum.repos.d/jenkins.repo \
    https://pkg.jenkins.io/redhat-stable/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key
sudo yum upgrade -y
sudo amazon-linux-extras install java-openjdk11 -y
sudo yum install jenkins -y
sudo systemctl enable jenkins
sudo systemctl start jenkins
sudo chkconfig jenkins on (this auto starts jenkins when linux server restarts)
Then after using Ipaddress:8080 login into jenkins
#Installing git and maven 
And also install git and maven in jenkins server
sudo yum install git -y
sudo yum install maven -y
# Installing sonarqube
spin up one more ec2 instance and install sonarqube
apt install unzip
adduser sonarqube
wget https://binaries.sonarsource.com/Distribution/sonarqube/sonarqube-9.4.0.54424.zip
unzip *
chmod -R 755 /home/sonarqube/sonarqube-9.4.0.54424
chown -R sonarqube:sonarqube /home/sonarqube/sonarqube-9.4.0.54424
cd sonarqube-9.4.0.54424/bin/linux-x86-64/
./sonar.sh start
use http://http://<ip-address>:9000
# Configuring slave machine and installing plugins
After that configure slave machine to jenkins
Now install sonarqubescanner, dockerpipeline, Kubernetes continuous deploy, credentials binding plugins
#Provisioning eks cluster and installing kubectl on jenkins machine
Provision a kubernetes cluster using terraform and attaching roles
AmazonEKSClusterPolicy
AmazonEKSNodeRole
AmazonEC2ContainerRegistryReadOnly
AmazonEKS_CNI_Policy
install kubectl on jenkins machine
sudo curl -O https://s3.us-west-2.amazonaws.com/amazon-eks/1.26.4/2023-05-11/bin/linux/amd64/kubectl
sudo curl -O https://s3.us-west-2.amazonaws.com/amazon-eks/1.26.4/2023-05-11/bin/linux/amd64/kubectl.sha256
sha256sum -c kubectl.sha256
openssl sha1 -sha256 kubectl
sudo mkdir -p $HOME/bin && cp ./kubectl $HOME/bin/kubectl && export PATH=$HOME/bin:$PATH
echo 'export PATH=$HOME/bin:$PATH' >> ~/.bashrc
kubectl version --short --client
Now configure k8s cluster on jenkins machine using command aws eks update-kubeconfig --region <region name> --name <clustername>
# Writing docker files and yaml files
Write a docker file to containerize application and also yaml files for deployments and services to expose app to outside world
# Building ci/cd and deploying app.
Now construct ci/cd declarative pipeline
first checkout code--> maven build--> sonarqube scanning--> docker image build--> docker registry authentication and pushing it to docker registry--> Now deploying it to kubernetes cluster.
 Now install prometheus and grafana and starting monitoring already deployed application on kubernetes cluster using grafana dashboard.

