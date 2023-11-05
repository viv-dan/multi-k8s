docker build -t vivdan/multi-client-k8s:latest -t vivdan/multi-client-k8s:$SHA -f ./client/Dockerfile ./client
docker build -t vivdan/multi-server-k8s:latest -t vivdan/multi-server-k8s:$SHA -f ./server/Dockerfile ./server
docker build -t vivdan/multi-worker-k8s:latest -t vivdan/multi-worker-k8s:$SHA -f ./worker/Dockerfile ./worker

docker push vivdan/multi-client-k8s:latest
docker push vivdan/multi-server-k8s:latest
docker push vivdan/multi-worker-k8s:latest

docker push vivdan/multi-client-k8s:$SHA
docker push vivdan/multi-server-k8s:$SHA
docker push vivdan/multi-worker-k8s:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=vivdan/multi-server-k8s:$SHA
kubectl set image deployments/client-deployment client=vivdan/multi-client-k8s:$SHA
kubectl set image deployments/worker-deployment worker=vivdan/multi-worker-k8s:$SHA