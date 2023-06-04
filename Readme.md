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
first checkout code--> maven build--> sonarqube scanning--> docker image build--> docker registry authentication and pushing it to docker registry--> Now deploying it to kubernetes 
cluster.
#Install Kubernetes Metrics Server
#Apply Metrics Server manifests which are available on Metrics Server releases making them installable via url:
kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/download/v0.4.3/components.yaml

#Use the following command to verify that the metrics-server deployment is running the desired number of pods:
kubectl get deployment metrics-server -n kube-system
kubectl get pods -n kube-system

#Confirm Metrics server is active.
kubectl get apiservice v1beta1.metrics.k8s.io -o yaml

#Metrics API can also be accessed by using the kubectl top command.
#To display cluster nodes resource usage – CPU/Memory/Storage you’ll run the command:
kubectl top nodes

#Similar command can be used for pods.
kubectl top pods -A

#You can also access use kubectl get –raw to pull raw resource usage metrics for all nodes in the cluster.
kubectl get --raw "/apis/metrics.k8s.io/v1beta1/nodes"

#Install Helm 
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update
helm install prometheus prometheus-community/prometheus
helm version

# Deploying Prometheus on EKS Kubernetes Cluster
#Prometheus can be installed on Kubernetes cluster using Operator or with helm
#First create a monitoring namespace.
kubectl create namespace monitoring

#Prometheus needs a way to persist metrics data for historical reference. We’ll use EBS which is provisioned with gp2 storage class.
kubectl get sc

#Add chart repository:
helm repo add stable https://charts.helm.sh/stable

#Deploy Prometheus using Helm.

helm install prometheus stable/prometheus --namespace monitoring --set alertmanager.persistentVolume.storageClass="gp2",server.persistentVolume.storageClass="gp2"

#Confirm PV and PVC are created.

kubectl get pv -n monitoring

kubectl get pvc -n monitoring

#Access Prometheus on EKS Kubernetes Cluster 

#After installation query all resources in the monitoring namespace:
kubectl get all -n monitoring

#Get the Prometheus server URL by running these commands in the same shell:
$POD_NAME=$(kubectl get pods --namespace monitoring -l "app=prometheus,component=server" -o jsonpath="{.items[0].metadata.name}")

#Use Kubernetes port forwarding feature to access Prometheus Server.
kubectl --namespace monitoring port-forward $POD_NAME 9090
