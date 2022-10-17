# MSR and Microgateway monitoring in a Kubernetes cluster

## Monitoring of metrics using Prometheus and Grafana

Both MSR and Microgateway expose a /metrics endpoints for Prometheus to scrape their metrics.

First we install and configure Prometheus and Grafana in the Kubernetes cluster.

Then we configure the microservice pods to make them known by Prometheus.

### Prometheus installation and configuration

We follow this excellent tutorial written by Bibin Wilson: https://devopscube.com/setup-prometheus-monitoring-on-kubernetes/

We get a fully working Prometheus that is already capable of discovering the pods that need to be scraped.

This is thanks to the configuration applied in the config-map.yaml file.

There's a job name kubernetes-pods which scraps Kubernetes objects with the pod role. 
We just need to activate the scraping using the prometheus.io/scrape: "true" annotation in the pod specification.

However since the MSR and the microgateway are deployed together in pods (side car deployment), we need to modify the Prometheus configuration to make it capable of scraping several containers in a pod.
The solution is provided in this github code snippet: https://gist.github.com/bakins/5bf7d4e719f36c1c555d81134d8887eb
