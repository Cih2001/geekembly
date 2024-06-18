---
title: Part 0 - How to make a weblog, the hard way!
date: 2024-06-16
toc: false
---

Hey there! 👋 A little while ago, I had this lightbulb moment: "Why not set up a homelab?"
I've always dreamed of having a mini server at home where I can host my applications,
run my own Kubernetes cluster, set up a CI/CD pipeline, and have all the cool stuff like Kafka, Postgres,
object storage, and etc – basically, my own private cloud!

After about two months of putting in the work (and dealing with some blood, sweat, and tears),
I'm ready to start writing a bunch of blog posts on how I did it.

I'm gearing up to craft a series of blog posts that will be super user-friendly for everyone to follow. Our mission map includes:

- Booting up [Proxmox](https://www.proxmox.com/en/proxmox-virtual-environment/overview) on my server machine (more details on the hardware later).
- Setting up a Kubernetes cluster with 2 control planes and 5 worker nodes, using [Terraform](https://www.terraform.io/) and [Kubespray](https://kubespray.io/),
- Crafting a VLAN on [pfSense](https://www.pfsense.org/) to isolate our network from Kubernetes apps (because security matters!).
- Setup the k8s cluster persistance on a network file system using [nfs subdir provisioner](https://github.com/kubernetes-sigs/nfs-subdir-external-provisioner)
- Configuring [Metallb](https://metallb.io/) and [Cert-Manager](https://cert-manager.io/).
- Embracing the entire Argo :octopus: ecosystem – [Argo Workflows](https://argoproj.github.io/workflows/), [Argo Events](https://argoproj.github.io/events/), and [Argo CD](https://argoproj.github.io/cd/).
- Setting up our private object storage with [Minio](https://min.io/) and using it to create our own container [registry](https://hub.docker.com/_/registry).
- Secrets? We can push them on Github if they are [Sealed](https://github.com/bitnami-labs/sealed-secrets)!
- Getting this very blog up and running on our server, powered by [Hugo](https://gohugo.io/)!
- Keeping an eye on the cluster using [Prometheus](https://prometheus.io/) and [Grafana](https://grafana.com/).

Stay tuned! 🚀
