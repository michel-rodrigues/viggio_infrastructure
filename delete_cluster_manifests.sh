#!/bin/sh
cd $(dirname $0)
kubectl delete -f redis/redis-data-persistentvolumeclaim.yaml
kubectl delete -f redis/redis-deployment.yaml
kubectl delete -f redis/redis-service.yaml
kubectl delete -f frontend/frontend-deployment.yaml
kubectl delete -f frontend/frontend-service.yaml
kubectl delete -f django/django-env-configmap.yaml
kubectl delete -f django/django-deployment.yaml
kubectl delete -f django/django-service.yaml
kubectl delete -f celery/celery-deployment.yaml
kubectl delete -f ingress/ingress-resource.yaml
helm del --purge nginx-ingress
