all: build run

build:
	-echo "Building"
	-docker build -t apache-atlas-image atlas-helm-chart 
	-kubectl create namespace apache-atlas
	-helm install atlasapache atlas-helm-chart -n apache-atlas --debug
	-sleep 10
	-kubectl get all -n apache-atlas

run:
	echo "Running"

clean:
	-echo "Uninstalling"
	-helm list
	-helm uninstall atlasapache -n apache-atlas
	-helm list
	-sleep 10
	-kubectl get all -n apache-atlas

delete-pvc:
	-kubectl get pvc -n apache-atlas | tail -n +2 | awk '{print $$1}' | sed 's/.*/pvc\/&/' |xargs kubectl delete -n apache-atlas
	-kubectl get pvc -n apache-atlas | tail -n +2 | awk '{print $$1}' | sed 's/.*/pvc\/&/' | xargs kubectl patch  -p '{"metadata":{"finalizers": []}}' --type=merge -n apache-atlas
	-kubectl get pvc

delete-pv:
	-kubectl get pv -n apache-atlas | tail -n +2 | awk '{print $$1}' | sed 's/.*/pvc\/&/' |xargs kubectl delete -n apache-atlas
	-kubectl get pv -n apache-atlas | tail -n +2 | awk '{print $$1}' | sed 's/.*/pvc\/&/' | xargs kubectl patch  -p '{"metadata":{"finalizers": []}}' --type=merge -n apache-atlas	
	-kubetl get pv

clean-full: clean delete-pvc delete-pv

rebuild: clean-full build
	
