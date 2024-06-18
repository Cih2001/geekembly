---
title: Part 1 - Introduction
date: 2024-06-17
---

## Why Run a Home Server/Home Lab?

You might wonder why someone would bother running a home server or home lab.
Here are my key reasons:

- **Learning and Exploration:** It's a great opportunity to learn and tinker with technology.
- **Fun:** The process itself is enjoyable!
- **Safety:** I can experiment without worries. If something goes wrong, I can simply wipe everything clean and start over. This is much safer than accruing unexpected costs in the cloud.
- **Cost-Effective:** Except for the initial investment in hardware, it's essentially free compared to ongoing cloud service fees.
- **Data Ownership:** I have complete control over my data; it's not shared with anyone else.

Your motivations might vary, but if your only goal is to host a simple blog like this one, you can probably achieve that with a single click using various online services.

## Prerequisites for Setting Up a Home Server

If you want to set up a home server similar to mine, here’s what you will need:

### Hardware

First, you'll need a spare computer that you don’t mind using as a dedicated server.
If you plan to keep it running constantly, then power consumption becomes a critical factor.

After some research, I chose the [MS-01 Minisforum](https://store.minisforum.com/products/minisforum-ms-01) with these specifications:

- Intel Core i9-13900H
- 32 GB DDR5 Memory
- 1 TB SSD

![PC](/homelab/pc.jpeg)

This is a robust machine with low power consumption. However, other hardware configurations will sure work.

### Domain

Next, you need a registered domain name. If not obvious!, I own `geekembly.com`, which I use to host my applications.

### ISP

Your Internet Service Provider (ISP) must allow you to forward traffic to your private network, typically done using `port-forwarding` on your modem.

However, if you are behind a Carrier-Grade NAT (CGNAT) like I am, simple IPv4 port-forwarding won't work since your IP is shared with others.
In my case, Vodafone allowed me to use `IPv6 host exposure` after I contacted them. It's not IPv4, but it works.

### VPS

Though the goal is to self-host, I needed a small VPS (Virtual Private Server) as well. Before you point out the contradiction, let me explain.

Due to my inability to forward IPv4 traffic, I had two choices: stick with IPv6 or rent a VPS to tunnel IPv4 traffic to my exposed IPv6 services. Sticking with IPv6 wasn't feasible for me because:

- After a week of attempts, I failed to configure a dual-stack Kubernetes cluster properly. This surely have been a skill issue!
- Even with a proper setup, GitHub (especially its Webhooks) only supports IPv4, as discussed [here](https://github.com/orgs/community/discussions/10539).

Thus, I opted for a more straightforward solution: renting a $3/month droplet from Digital Ocean. Traffic to `geekembly.com` passes through this VPS and is forwarded to my server.

## Design Overview

We are going to set up a Kubernetes cluster on a home server, isolate it from other local devices, and make it accessible to the public. Here’s the strategy we'll be using:

1. **Proxmox Installation:** We will install Proxmox on our server. Proxmox is a powerful open-source virtualization management solution.
2. **Network Bridging:** We’ll then bridge Proxmox to the Vodafone modem to ensure connectivity.
3. **Virtual Networks (VNETs):** Using pfSense, we will create VNETs to isolate the Kubernetes network from our other devices.

Below is a diagram that shows how our home server will be accessed through the Internet:

![Network](/homelab/network.svg)

Stay tuned for the next part: Proxmox! 🚀
