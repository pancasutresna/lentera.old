docker build -t lentera/multi-client:latest -t lentera/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t lentera/multi-server:latest -t lentera/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t lentera/multi-worker:latest -t lentera/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push lentera/multi-client:latest
docker push lentera/multi-server:latest
docker push lentera/multi-worker:latest
docker push lentera/multi-client:$SHA
docker push lentera/multi-server:$SHA
docker push lentera/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/client-deployment client=lentera/multi-client:$SHA
kubectl set image deployments/server-deployment server=lentera/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=lentera/multi-worker:$SHA