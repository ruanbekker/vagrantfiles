## ConfigMaps - Env from File

Create the file with the environment variables:

```
$ cat envs.txt
HOSTNAME=app.domain.com
PASSWORD=foobar
```

Create the config map:

```
$ kubectl create configmap my-envvars-1 --from-env-file=./envs.txt
configmap/my-envvars-1 created
```

Define the pod manifest:

```
$ cat my-pod.yml
apiVersion: v1
kind: Pod
metadata:
  name: envs-test-pod
spec:
  restartPolicy: Never
  containers:
    - name: envs-test-container
      image: alpine
      imagePullPolicy: IfNotPresent
      command: [ "/bin/sh", "-c", "env" ]
      envFrom:
        - configMapRef:
            name: my-envvars-1
```

Deploy the pod

```
$ kubectl apply -f my-pod.yml
pod/envs-test-pod created
```

See the environment in the log output:

```
$ kubectl logs -f envs-test-pod
HOSTNAME=app.domain.com
PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
PWD=/
PASSWORD=foobar
```
