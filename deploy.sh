docker build -t maa5iv/multi-client:latest -t maa5iv/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t maa5iv/multi-server:latest -t maa5iv/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t maa5iv/multi-worker:latest -t maa5iv/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push maa5iv/multi-client:latest
docker push maa5iv/multi-server:latest
docker push maa5iv/multi-worker:latest

docker push maa5iv/multi-client:$SHA
docker push maa5iv/multi-server:$SHA
docker push maa5iv/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=maa5iv/multi-server:$SHA
kubectl set image deployments/client-deployment client=maa5iv/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=maa5iv/multi-worker:$SHA