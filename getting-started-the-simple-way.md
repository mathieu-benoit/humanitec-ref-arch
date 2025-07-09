If you have any res def already in your Orgs, go through all of them and remove all the matching criterias.

```bash
humctl login
```

```bash
humctl create app demo
```

```yaml
apiVersion: score.dev/v1b1
metadata:
  name: demo
containers:
  demo:
    image: .
service:
  ports:
    tcp:
      port: 8080
      targetPort: 8080
```

```bash
humctl score deploy \
  -f score.yaml \
  --image nginx:alpine-slim \
  --app demo \
  --env development
```

This should fail.

To fix this:
- `k8s-cluster`: https://github.com/mathieu-benoit/humanitec-ref-arch/blob/main/modules/htc-cluster/k8s-cluster.tf
  - + Agent + Operator
- `k8s-namespace`: https://github.com/mathieu-benoit/humanitec-ref-arch/blob/main/modules/htc-org/k8s-namespace.tf
- Anything else?

Redeploy, that should work.

Then, `dns`:
- `dns` --> `echo`
- `ingress` -->

```yaml
apiVersion: score.dev/v1b1
metadata:
  name: demo
containers:
  demo:
    image: .
service:
  ports:
    tcp:
      port: 8080
      targetPort: 8080
resources:
  dns:
    type: dns
    id: dns
  route:
    type: route
    params:
      host: ${resources.dns.host}
      path: /
      port: 8080
```

FIXME

Then, CI/CD. Start simple, just `humctl score deploy`.

FIXME

Then, support in-cluster `postgres`.

Let's pause a little bit here. Let's make sure you have:
- CI/CD for any Score file for any Developer for any Project --> GitLab Pipeline template (you will bonify it later, in this centralize place)
- CI/CD for any Res def or Humanitec object via Terraform (locally if one person, or already Atlantis?)

Next:
- Add TF Runner
- Add Cloud Account to provision AWS resources per App/Project
- `dns` as Terraform
- `s3` as Terraform
- `postgres` (RDS) as Terraform
