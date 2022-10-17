# MSR and Microgateway monitoring in a Kubernetes cluster

## Monitoring of metrics using Prometheus and Grafana

Both MSR and Microgateway expose a /metrics endpoints for Prometheus to scrape their metrics.

First we install and configure Prometheus and Grafana in the Kubernetes cluster.

Then we configure the microservice pods to make them known by Prometheus.

### Prometheus installation and configuration

We follow this excellent tutorial written by Bibin Wilson: https://devopscube.com/setup-prometheus-monitoring-on-kubernetes/

We get a fully working Prometheus that is already capable of discovering the pods that need to be scraped.

When you check the config-map.yaml file, in the "kubernetes-pods" scraping job there's a relabel configuration that makes it possible to activate scraping using the prometheus.io/scrape: "true" annotation.

However since the MSR and the microgateway are deployed together a pod (side car deployment), we need to modify this Prometheus configuration to make it capable of scraping several containers in a pod.

The solution is provided in this github code snippet: https://gist.github.com/bakins/5bf7d4e719f36c1c555d81134d8887eb

The config-map.yaml file provided in this project already includes these changes. You just need to specify the metrics ports for each container using a port named "metrics". 

### Grafana installation and configuration

Here we follow another tutorial by Bill Wilson: https://devopscube.com/setup-grafana-kubernetes/

### Update of the Kubernetes deployment descriptors for our microservice

 ![Kubernetes Architecture](https://github.com/stephane-sttlab/sagdemo/blob/main/Sagdemo_KubernetesArchitecture.png)
