# Создание пользователей

```
sudo chmod +x ./create_users.sh
./create_users.sh
```

Далее проверьте что пользователи создались 

```
kubectl get csr
```


# Создание ролей


```
kubectl apply -f roles.yaml
```

```
kubectl get clusterrole
kubectl get role
```


# Создание биндингов


```
kubectl apply -f bindings.yaml
```

```
kubectl get clusterrolebinding
kubectl get rolebinding
```
