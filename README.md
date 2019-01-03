terraform secure deployment of `helm`'s “a giant sudo server”
===

[![Build Status](https://travis-ci.org/lsst-sqre/terraform-tinfoil-tiller.png)](https://travis-ci.org/lsst-sqre/terraform-tinfoil-tiller)

This module provides for a simple installation of `helm`s `tiller` agent that
is only accessible by establishing a proxy via the k8s API per this article:
https://engineering.bitnami.com/articles/helm-security.html .

helm provider 0.6.2 vendors helm 2.9.0, which does not correctly deploy
`tiller` with rbac enabled.  The manual patching **is not required** with this
module.

```bash
kubectl patch deploy --namespace kube-system tiller-deploy -p '{"spec":{"template":{"spec":{"automountServiceAccountToken":true}}}}'
```

Usage
---

```terraform
module "tiller" {
  source = "git::https://github.com/lsst-sqre/terraform-tinfoil-tiller.git//?ref=master"

  namespace       = "kube-system"
  service_account = "tiller"
  tiller_image    = "gcr.io/kubernetes-helm/tiller:v2.11.0"
}

provider "helm" {
  version = "~> 0.7.0"

  debug           = true
  service_account = "${module.tiller.service_account}"
  namespace       = "${module.tiller.namespace}"
  install_tiller  = false

  kubernetes {
    ...
  }
}
```

See Also
---

* [`terraform`](https://www.terraform.io/)
* [`helm`](https://docs.helm.sh/)
