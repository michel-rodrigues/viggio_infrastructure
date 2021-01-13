#!/bin/sh
cd $(dirname $0)
kubectl apply -f redis/redis-data-persistentvolumeclaim.yaml
kubectl apply -f redis/redis-deployment.yaml
kubectl apply -f redis/redis-service.yaml
kubectl apply -f frontend/frontend-deployment.yaml
kubectl apply -f frontend/frontend-service.yaml
kubectl apply -f django/django-env-configmap.yaml
kubectl apply -f django/django-deployment.yaml
kubectl apply -f django/django-service.yaml
kubectl apply -f celery/celery-deployment.yaml

helm repo add stable https://kubernetes-charts.storage.googleapis.com/

OUTPUT=$(helm install nginx-ingress nginx/nginx-ingress --set rbac.create=true --set controller.publishService.enabled=true)

if [ -z "${OUTPUT##*DEPLOYED*}" ] ;then
    echo "helm installed nginx-ingress"
else
	echo "ERROR: nginx-ingress install status isn't DEPLOYED"
fi

kubectl apply -f ingress/ingress-resource.yaml
