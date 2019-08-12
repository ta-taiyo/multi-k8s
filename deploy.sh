docker build -t taiyo/multi-client:latest -t taiyo/multi-client:$SHA -f ./client/Dcokerfile ./client
docker build -t taiyo/multi-server:latest -t taiyo/multi-server:$SHA -f ./server/Dcokerfile ./server
docker build -t taiyo/multi-worker:latest -t taiyo/multi-worker:$SHA -f ./worker/Dcokerfile ./worker

docker push taiyo/multi-client:latest
docker push taiyo/multi-server:latest
docker push taiyo/multi-worker:latest

docker push taiyo/multi-client:$SHA
docker push taiyo/multi-server:$SHA
docker push taiyo/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=taiyo/multi-server:$SHA
kubectl set image deployments/client-deployment client=taiyo/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=taiyo/multi-worker:$SHA
