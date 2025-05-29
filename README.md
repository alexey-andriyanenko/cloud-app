# Getting Started

### Running the Application

```
./gradlew bootRun
```

Open [http://localhost:8080](http://localhost:8080) in your browser.

### Building the Application

```
./gradlew bootJar
```

### Running the Application as a Docker Container

```
...
java -jar ./build/libs/tech-challenge-0.0.1-SNAPSHOT.jar
```

### Requirements

1. This project should be made to run as a Docker image.
2. Docker image should be published to a Docker registry.
3. Docker image should be deployed to a Kubernetes cluster.
4. Kubernetes cluster should be running on a cloud provider.
5. Kubernetes cluster should be accessible from the internet.
6. Kubernetes cluster should be able to scale the application.
7. Kubernetes cluster should be able to update the application without downtime.
8. Kubernetes cluster should be able to rollback the application to a previous version.
9. Kubernetes cluster should be able to monitor the application.
10. Kubernetes cluster should be able to autoscale the application based on the load.

### Additional
1. Application logs should be stored in a centralised logging system (Loki, Kibana, etc.)
2. Application should be able to send metrics to a monitoring system.
3. Database should be running on a separate container.
4. Storage should be mounted to the database container.


#### Implementation
1. This project should be made to run as a Docker image.

```bash
docker build -t cloud-app .
```
```bash
docker run --rm -p 8080:8080 tech-challenge-app
```
2. Docker image should be published to a Docker registry.
```bash
docker tag tech-challenge-app {myusername}/tech-challenge-app:latest
```
```bash
docker push {myusername}/tech-challenge-app:latest
```
3. Docker image should be deployed to a Kubernetes cluster.
Create deployment.yaml file with kubernetes configuration
```bash
kubectl apply -f deployment.yaml
```
4. Kubernetes cluster should be running on a cloud provider.
Using ngrok as sort of "cloud provider"

5. Kubernetes cluster should be accessible from the internet.
```bash
ngrok http 30080
```
6. Kubernetes cluster should be able to scale the application.
Manual Scaling (Horizontal Pod Autoscaling)
```bash
kubectl scale deployment tech-challenge-deployment --replicas=3
```
Automatic Scaling (HPA - Horizontal Pod Autoscaler)
```bash
kubectl autoscale deployment tech-challenge-deployment --cpu-percent=50 --min=1 --max=5
```

Adjust configuration with:
resources:
  requests:
    cpu: "250m"
  limits:
    cpu: "500m"

Test scaling:
Get into the pod
```bash
kubectl exec -it <pod-name> -- sh
```
Inside of pod
```bash
apt update && apt install -y stress
```
Burn 1 cpu for 60 seconds
```bash
stress --cpu 1 --timeout 60
```

Check HPA:
```bash
kubectl get hpa
```

7. Kubernetes cluster should be able to update the application without downtime.
Prevent traffic to pod while it's not fully ready
readinessProbe:
  httpGet:
    path: /actuator/health
    port: 8080
  initialDelaySeconds: 10
  periodSeconds: 5

### Utility commands

Build container
```bash
docker build -t cloud-app .
```
Run container
```bash
docker run --rm cloud-app
```
Run container and forward ports
```bash
docker run --rm -p 8080:8080 tech-challenge-app
```
Tag container
```bash
docker tag tech-challenge-app {myusername}/tech-challenge-app:latest
```
Push container to docker hub
```bash
docker push {myusername}/tech-challenge-app:latest
```
Pull container from another machine
```bash
docker pull {myusername}/tech-challenge-app:latest
```

Kubernetes

Apply config
```bash
kubectl apply -f deployment.yaml
```
Restart pod
```bash
kubectl rollout restart deployment tech-challenge-deployment
```
Get service details
```bash
kubectl get svc tech-challenge-service
```
Port forward
```bash
kubectl port-forward svc/tech-challenge-service 8080:8080
```
Describe pod
```bash
kubectl describe pod <pod-name>
```
Get deployments
```bash
kubectl get deployments
```
Pod logs
```bash
kubectl logs <pod-name>
```

Autoscale pod scaling
```bash
kubectl scale deployment tech-challenge-deployment --replicas=3
```
Horizontal pod autoscaler
```bash
kubectl autoscale deployment tech-challenge-deployment --cpu-percent=50 --min=1 --max=5
```
Monitor autoscaling
```bash
kubectl get pods -l app=tech-challenge
```
HPA status
```bash
kubectl get hpa
```


Stressing pod
```bash
kubectl exec -it <pod-name> -- sh
```
```bash
apt update && apt install -y stress
```
Burn 1 cpu core for 1 minute
```bash
stress --cpu 1 --timeout 60
```

Rollback
```bash
kubectl rollout undo deployment tech-challenge-deployment
```

Check deployment history
```bash
kubectl rollout history deployment tech-challenge-deployment
```

Ngrok
```bash
ngrok config add-authtoken <your-ngrok-auth-token>
```

kubectl set image deployment/tech-challenge-deployment tech-challenge=alexeiandriianenko/tech-challenge-app:<version>