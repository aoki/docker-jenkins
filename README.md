# Alpine Jenkins Dokcer Container

- Alpine Linux based.
- Jenkins with BlueOcean plugin.
- Installed `dokcer` command.

## Run

```bash
docker run --rm \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -v /var/lib/jenkins:/var/jenkins_home \
  -p 8080:8080 -p 50000:50000 \
  --name jenkins -d -u root aoki/jenkins
```

## Build
```bash
docker build -t aoki/jenkins .
```
