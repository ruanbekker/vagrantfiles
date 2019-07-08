
```
$ vagrant box add https://atlas.hashicorp.com/envimation/boxes/ubuntu-xenial
```

```
$ vagrant box list
envimation/ubuntu-xenial (virtualbox, 1.0.3-1516241473)
```

```
$ vagrant init envimation/ubuntu-xenial
$ vagrant up --provision
```
