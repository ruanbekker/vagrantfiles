## Kubernetes Secrets

Create the secret in text files:

```
$ echo -n 'admin' > ./username.txt
$ echo -n 'mypassword' > ./password.txt
```

Create the kubernetes secrets from the files:

```
$ kubectl create secret generic db-user-pass --from-file=./username.txt --from-file=./password.txt
secret/db-user-pass created
```

View the secrets:

```
$ kubectl get secrets/db-user-pass
NAME           TYPE     DATA   AGE
db-user-pass   Opaque   2      4m9s
```

View the encoded values of the secrets:

```
$ kubectl get secrets/db-user-pass -o yaml
apiVersion: v1
data:
  password.txt: bXlwYXNzd29yZA==
  username.txt: YWRtaW4=
kind: Secret
```

Decode the values:

```
$ echo "bXlwYXNzd29yZA==" | base64 --decode
mypassword

$ echo "YWRtaW4=" | base64 --decode
admin
```

More info:
- https://kubernetes.io/docs/concepts/configuration/secret/
