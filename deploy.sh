docker build -t ta-taiyo/multi-client:latest -t ta-taiyo/multi-client:$SHA -f ./client/Dcokerfile ./client
docker build -t ta-taiyo/multi-server:latest -t ta-taiyo/multi-server:$SHA -f ./server/Dcokerfile ./server
docker build -t ta-taiyo/multi-worker:latest -t ta-taiyo/multi-worker:$SHA -f ./worker/Dcokerfile ./worker

docker push ta-taiyo/multi-client:latest
docker push ta-taiyo/multi-server:latest
docker push ta-taiyo/multi-worker:latest

docker push ta-taiyo/multi-client:$SHA
docker push ta-taiyo/multi-server:$SHA
docker push ta-taiyo/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=ta-taiyo/multi-server:$SHA
kubectl set image deployments/client-deployment client=ta-taiyo/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=ta-taiyo/multi-worker:$SHA