#!/bin/sh
mkdir build || true

kubectl port-forward --namespace default svc/prometheus-operated 9090:9090 > build/prometheus-server.log 2>&1 &
curl http://localhost:9090

while [ $? -ne 0 ]; do
    kubectl port-forward --namespace default svc/prometheus-operated 9090:9090 > build/prometheus-server.log 2>&1 &
    curl http://localhost:9090
    sleep 5
done

kubectl port-forward --namespace default svc/alertmanager-operated 9093:9093 > build/alertmanager.log 2>&1 &
curl http://localhost:9093

while [ $? -ne 0 ]; do
    kubectl port-forward --namespace default svc/alertmanager-operated 9093:9093 > build/alertmanager.log 2>&1 &
    curl http://localhost:9093
    sleep 5
done

