---
title: "OLM from 10,000-ft"
linkTitle: "OLM from 10,000-ft"
date: 2022-02-01
categories: documentation
weight: 4
description: >
  A 10,000-ft view of the Operator Lifecycle Manager (OLM).
---

OLM provides a way to install, manage and upgrade operators on a cluster.

This command shows all the operators available on the cluster for installation.

```bash
oc get packagemanifests
```
On the left is the name of the operator, and on the right is the CatalogSource it belongs to.

A CatalogSource is a store of metadata that OLM can query to discover and install operators onto a cluster. In other words, CatalogSources serve as catalogs of available operators.

For a list of available CatalogSources on the cluster run:

```bash
oc get catalogsource --all-namespaces
```

Let's say you're intestested in installing the l5-operator. First, we need to find out which CatalogSource references the l5-operator.

```bash
oc get packagemanifests | grep 'l5-operator'
```

In the output of this command, we see that the l5-operator is listed in the community-operators CatalogSource.

Where is the community-operator-index catalog stored?

```bash
oc get catalogsource community-operators -n openshift-marketplace -o json | jq -r '.spec.image'
```

This returns `registry.redhat.io/redhat/community-operator-index:v4.11`, so we know the l5-operator and many other operators are packaged in the community-operator-index:v4.11 catalog.

You might note that the name of the catalog is formatted in the container image format. This is due to how OLM stores one or more operators. For more information on this subject, [click here.](https://example.com)

So now we know where the l5-operator is stored and the name of its catalog. Now we are ready to install it using OLM.

OLM itself functions via 2 operators.

* $\color{orange}\textsf{OLM \ Operator}$

* $\color{green}\textsf{Catalog \ Operator}$

They work together to install operators. For clarity, I will tag $\color{orange}\textsf{OLM}$ for things the OLM Operator manages</span>, and tag $\color{green}\textsf{Catalog}$ for things the Catalog Operator manages</span>.

1. Create a namespace within which we will install the operator.

2. $\color{green}\textsf{Catalog}$ Create a <i>CatalogSource</i> that points to the location of the operator's package. Since we are using the community-operators for our catalogsource, we can ignore this step. [Example create CatalogSource](https://olm.operatorframework.io/docs/tasks/make-catalog-available-on-cluster/).

3. $\color{orange}\textsf{OLM}$ Create an <i>OperatorGroup</i> that defines a set of target namespaces where operators should be installed and managed. It allows you to specify which operators should be installed in which namspaces, and it also provides a way to configure the overall behavior of the operators in those namespaces

4. $\color{green}\textsf{Catalog}$ Create a <i>Subscription</i>. The <i>Subscription</i> resource links the Operator to the <i>CatalogSource</i> and the namespace.

5. $\color{green}\textsf{Catalog}$ The Catalog Operator pulls the <i>ClusterServiceVersion</i> (CSV) from the <i>CatalogSource</i> and creates an <i>InstallPlan</i> containing objects based on the CSV.

6.  $\color{green}\textsf{Catalog}$ The <i>InstallPlan</i> creates objects such as CRDs, CSV and other dependent objects.

7.  $\color{green}\textsf{Catalog}$ An operator may have a dependency on another operator being present in the cluster. The Catalog Operator is responsible for resolving all dependencies by ensuring all specified versions of operators and CRDs are installed on the cluster.

8.  $\color{orange}\textsf{OLM}$ The OLM Operator checks if the dependent resources defined in the CSV are deployed.

9.  $\color{orange}\textsf{OLM}$ Once all the depenencies are resolved and installed, the OLM Operator starts installing deployment resources defined in CSV

10. $\color{orange}\textsf{OLM}$  After the operator is installed, it will be registered in a OperatorGroup.
