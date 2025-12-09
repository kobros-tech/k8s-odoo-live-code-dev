# k8s-live-code-dev

## kubernetes development without rebuilding images


Build k8s deployments and manage them and develop code in real time with skaffold.


## Install Minikube and kubectl and helm

```bash
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
sudo install minikube-linux-amd64 /usr/local/bin/minikube
sudo snap install kubectl --classic
curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash
```

## Start Minikube and start developing code just intime.

```bash
# To download repositories for odoo and modules
gitaggregate -c repos.yaml 
# with this update doo.conf addons path and requirements.txt packages

# To start minikube
minikube start --driver=docker --memory=10240 --cpus=4
kubectl get nodes
kubectl get pods -A


# To install skaffold:
curl -Lo skaffold https://storage.googleapis.com/skaffold/releases/latest/skaffold-linux-amd64
sudo install skaffold /usr/local/bin/skaffold
rm skaffold

# To initialize skaffold
skaffold init

# To start odoo
skaffold dev

# To access an odoo running inside minikube:
minikube ip
192.168.49.2

# odoo url is: 
# http://192.168.49.2:30069/

# To access the running odoo in my local machine
skaffold dev --port-forward --cleanup=false

# odoo url is:
# http://localhost:8069/

# To access odoo pod
kubectl get pods
kubectl exec -it odoo-foobarbaz -n k8s-odoo-live-code-dev -- bash

# To  cleanup after work
minikube ssh -- docker system prune -a

```
