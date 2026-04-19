# Создание кластера
```
minikube start --cni=calico
```
# Создание сервисов
```
kubectl run front-end-app --image=nginx --labels role=front-end --expose --port 80
kubectl run back-end-api-app --image=nginx --labels role=back-end-api --expose --port 80
kubectl run admin-front-end-app --image=nginx --labels role=admin-front-end --expose --port 80
kubectl run admin-back-end-api-app --image=nginx --labels role=admin-back-end-api --expose --port 80
```
# Создание сетевых политик
```
kubectl apply -f default-deny-all.yaml
kubectl apply -f non-admin-network-policy.yaml
kubectl apply -f admin-network-policy.yaml
```
# Проверка
```
kubectl exec -it admin-front-end-app -- curl http://admin-back-end-api-app --connect-timeout 5 # успешно
kubectl exec -it admin-front-end-app -- curl http://back-end-api-app --connect-timeout 5 # провал

kubectl exec -it front-end-app -- curl http://back-end-api-app --connect-timeout 5 # успешно
kubectl exec -it front-end-app -- curl http://admin-back-end-api-app --connect-timeout 5 # провал
```
#
