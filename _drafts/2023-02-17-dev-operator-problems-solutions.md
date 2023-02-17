---
title: "Debugging Operators : Problems and Solutions"
linkTitle: "Debugging Operators : Problems and Solutions"
date: 2022-02-17
categories: documentation
weight: 4
description: >
  A compilation of issues and resolutions encountered during the creation and troubleshooting of operators.
---

* Issue
  
  Operator Controller-manager pod keeps crashlooping with OOMkilled

* Resolution

  Increase the memory for the controller-mananger pod by editing the operator CSV:

   ````
   resources:
      limits:
        cpu: 200m
        memory: 400Mi    <------ Increased to 400Mi
      requests:
         cpu: 200m
         memory: 400Mi   <------ Increased to 400Mi
   ````

* Issue

  Docker image run on Openshift with the following error:
  ````
  exec /srv/app/entrypoint.sh: exec format error
  ````
* Resolution
  
  Review the Docker image, as it may have been built on a device with an architecture that differs from that of Openshift.

  ````
  docker image inspect cloudtruth/kubetruth:1.2.2-redhat.test.2 | grep Architecture
        “Architecture”: “arm64", 
  ````  

  Verify if the architecture of the node matches that of the Docker image.
  ````
  oc get node ip-####.us-west-2.compute.internal -oyaml | grep architecture
    architecture: amd64
  ````

    