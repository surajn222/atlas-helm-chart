# atlas-helm-chart
Kubernetes Helm Chart to deploy Apache Atlas

1. git clone https://github.com/surajn222/atlas-helm-chart

2. make rebuild
It should spin up the setup in 5 minutes.

3. Then connect to local cluster:
kubectl -n apache-atlas port-forward services/atlasapache-atlas 21000:21000

4. Access in browser on localhost:21000
