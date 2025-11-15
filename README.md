# micrometer-demo (Spring Boot + Micrometer Prometheus)

## Build & run locally
```bash
./mvnw spring-boot:run
# or
./mvnw -DskipTests package && java -jar target/micrometer-demo-0.1.0-SNAPSHOT.jar
```

Check metrics:
```
curl http://localhost:8080/actuator/prometheus
```

## Build container (buildpacks, no Dockerfile)
```bash
./mvnw -DskipTests spring-boot:build-image -Dspring-boot.build-image.imageName=micrometer-demo:0.1
```

## Kubernetes deploy
Use manifests in `k8s/` folder (edit image if needed).
