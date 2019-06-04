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
resource "kubernetes_namespace" "tiller" {
  metadata {
    name = "tiller"
  }
}

module "tiller" {
  source = "git::https://github.com/lsst-sqre/terraform-tinfoil-tiller.git?ref=0.9.x"

  namespace = "${kubernetes_namespace.tiller.metadata.0.name}"
}

provider "helm" {
  version = "~> 0.9.1"

  service_account = "${module.tiller.service_account}"
  namespace       = "${module.tiller.namespace}"
  install_tiller  = false

  kubernetes {
    ...
  }
}
```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| namespace | kubernetes namespace to deploy into | string | `"kube-system"` | no |
| service\_account | kubernetes service account name | string | `"tiller"` | no |
| tiller\_image | tiller docker image. | string | `"gcr.io/kubernetes-helm/tiller:v2.11.0"` | no |

## Outputs

| Name | Description |
|------|-------------|
| namespace | kubernetes namespace in which tiller is installed |
| service\_account | name of kubernetes service account for tiller |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

`pre-commit` hooks
---

```bash
go get github.com/segmentio/terraform-docs
pip install --user pre-commit
pre-commit install

# manual run
pre-commit run -a
```

See Also
---

* [`helm`](https://docs.helm.sh/)
* [`pre-commit`](https://github.com/pre-commit/pre-commit)
* [`pre-commit-terraform`](https://github.com/antonbabenko/pre-commit-terraform)
* [`terraform-docs`](https://github.com/segmentio/terraform-docs)
* [`terraform`](https://www.terraform.io/)
