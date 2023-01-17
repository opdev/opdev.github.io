---
title: "OLM from 10,000-ft"
linkTitle: "OLM from 10,000-ft"
date: 2022-02-01
weight: 4
description: >
  A 10,000-ft view of the Operator Lifecycle Manager (OLM).
---

OLM provides a way to install, manage and upgrade Operators on a cluster.

What are some of the Operators available on the cluster to install.

This command shows all the Operators available on the cluster. 

```
oc get packagemanifests
```
On the left is the name of the Operator, and on the right is the CatalogSource it belongs to.

OLM use the concept of CatalogSource to reference a catalog of Operators

For a list of available CatalogSource on the cluster, run:

```
oc get catalogsource --all-namespaces
```

Let's say you're intestested in installing the l5-operator

First, we need to find out which CatalogSource reference l5-operator.

```
oc get packagemanifests | grep 'l5-operator'
```
returns 'Community Operators Catalog'

so the l5-operator is referenced in the community-operators CatalogSource.

Where is the community-operator-index catalog stored ?


```
oc get catalogsource community-operators -n openshift-marketplace -o json | jq -r '.spec.image'
```

returns

registry.redhat.io/redhat/community-operator-index:v4.11.

and so the l5-operator and many other operators are packaged in the catalog, community-operator-index:v4.11

Now, you might wonder why is the catalog in the container image format ?

The short answer is, this is how OLM stores one or more operator. For more information on this subject, click here.

So now that you know where is your operator stored and what is the catalog name that contains your operator you are ready to install Operator using OLM.

OLM comes with 2 Operators. 

* $\color{orange}\textsf{OLM \ Operator}$

* $\color{green}\textsf{Catalog \ Operator}$

They work together to install Operator. For clarity, I will tag $\color{orange}\textsf{OLM}$ for things the OLM Operator manages</span>, and tag $\color{green}\textsf{Catalog}$ for things the Catalog Operator manages</span>. 

1. Create a namespacefor the operator to be installed in.

2. $\color{green}\textsf{Catalog}$ Create a <i>CatalogSource</i> that points to the location of the Operator's package. Since we are using the community-operators for our catalogsource, we can ignore this step. [Example create CatalogSource](https://olm.operatorframework.io/docs/tasks/make-catalog-available-on-cluster/).

3. $\color{orange}\textsf{OLM}$ Create an <i>OperatorGroup</i>  that defines a set of target namespaces where operators should be installed and managed. It allows you to specify which operators should be installed in which namspaces, and it also provides a way to configure the overall behavior of the operators in those namespaces

4. $\color{green}\textsf{Catalog}$ Create a <i>Subscription</i>.
The <i>Subscription</i> resource links the Operator to the <i>CatalogSource</i> and the namespace.

5. $\color{green}\textsf{Catalog}$ The Catalog Operator pulls the <i>ClusterServiceVersion</i> (CSV) from the <i>CatalogSource</i> and creates <i>InstallPlan</i> containing objects based on the CSV.

6.  $\color{green}\textsf{Catalog}$ <i>InstallPlan</i> create objects such as CRDs, CSV and other dependent objects.  

7.  $\color{green}\textsf{Catalog}$ An Operator may have a dependecy on another Operator being present in the cluster. The Catalog Operator is responsible for resolving all dependencies by ensuring all specified versions of Operators and CRDs are installed on the cluster.

8.  $\color{orange}\textsf{OLM}$ The OLM Operator checks if the dependent resources defined in CSV are deployed.

9.  $\color{orange}\textsf{OLM}$ Once all the depenencies are resolved and installed, OLM Operator starts installing deployment resource defined in CSV

10. $\color{orange}\textsf{OLM}$  After the operator is installed, it will be registered in a OperatorGroup.

 
 
