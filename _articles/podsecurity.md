---
title: Pod Security
author: Rose
---

The PodSecurityPolicy API is deprecated and will be removed from Kubernetes in version 1.25. This API is replaced by a new built-in admission controller (KEP-2579: Pod Security Admission Control) which allows cluster admins to enforce Pod Security Standards Labels.

* Operator SDK provides documentation to get around this issue for Golang, Ansible, and Helm based Operators.
* [Pod Security Standards](https://sdk.operatorframework.io/docs/best-practices/pod-security-standards/){:target="_blank"}

### Operator Development

## Q/A

## General
* [Pod Security Standard](./doc/operator/podsecuritystandards)
* [Operator Observability Best Practices](https://github.com/sradco/operator-sdk/blob/af8e6383b2d50d4cc2c2c98a1b067c16f85a1c83/website/content/en/docs/best-practices/observability-best-practices.md)

### Red Hat OpenShift Operator Certification

* [Deploying onto Openshift](https://redhat-connect.gitbook.io/certified-operator-guide/ocp-deployment/openshift-deployment)
