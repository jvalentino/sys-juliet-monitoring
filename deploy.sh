#!/bin/sh
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm delete prometheus --wait || true

helm install -f config/helm/prometheus/values.yaml prometheus --wait prometheus-community/kube-prometheus-stack

sh -x ./verify.sh
