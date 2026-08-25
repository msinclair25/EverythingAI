---
title: Cloud Compute and Hardware
tags:
  - atlas/tools
  - ai/infrastructure
  - ai/compute
status: published
type: tool-category
scope: United States
level:
  - beginner
  - intermediate
  - advanced
as_of: 2026-08-12
last_verified: 2026-08-12
review_by: 2026-11-12
cssclasses:
  - everything-ai
source_policy: official-only
---

# Cloud Compute and Hardware

AI compute choices range from a laptop to serverless inference, rented GPUs, managed training, and reserved clusters. Match the resource to memory, throughput, duration, data location, reliability, and team skill.

> [!tip] Edge/web AI overlay · 2026-08-24
> [[Cloudflare and Vercel AI]] compares Cloudflare Workers AI serverless inference and edge runtime with Vercel Functions/Fluid Compute, AI Gateway, Sandbox, and durable agent workflows. Benchmark successful-task cost, p95 time-to-first-token, data locality, concurrency, state recovery, and total platform operations.

## Representative comparison

| Option/provider | Access posture | Best fit | Watch closely | Official |
|---|---|---|---|---|
| Owned CPU/GPU/Apple silicon | Hardware purchase; open runtimes available | Learning, privacy, predictable local inference | Up-front cost, power, heat, memory, depreciation | [[Local and Open Model Runtimes]] |
| Colab / Kaggle | Free quota-bound hosted accelerators; Colab paid tiers | Learning and short experiments | Dynamic quotas, availability, session/idle limits | [Colab FAQ](https://research.google.com/colaboratory/faq.html) · [Kaggle notebooks](https://www.kaggle.com/docs/notebooks) |
| Hugging Face Spaces | Free static/basic CPU posture plus paid hardware | Demos and model apps | Sleep, storage, private-space, GPU hourly cost | [Spaces](https://huggingface.co/docs/hub/spaces-overview) · [pricing](https://huggingface.co/pricing) |
| Cloudflare Workers AI | Free daily allocation where documented plus paid usage | Serverless inference near users | Supported model catalog and token/neuron meters | [pricing](https://developers.cloudflare.com/workers-ai/platform/pricing/) · [docs](https://developers.cloudflare.com/workers-ai/) |
| Vercel Functions / Fluid Compute | Hobby free base resources plus paid usage and enterprise | Web-native I/O-bound AI routes, streaming, and concurrent requests | Duration, memory, region, provider wait time, and plan limits | [Functions](https://vercel.com/docs/functions) · [Fluid Compute](https://vercel.com/docs/fluid-compute) |
| Modal | Starter/evaluation credits where offered plus paid usage/enterprise | Serverless Python, burst GPU jobs, inference | Cold start, storage/network, per-resource meters | [pricing](https://modal.com/pricing) · [docs](https://modal.com/docs) |
| Runpod | Paid per-use Pods/serverless/clusters; enterprise | Flexible GPU experimentation and deployment | Host class, availability, storage, security, teardown | [pricing](https://www.runpod.io/pricing) · [docs](https://docs.runpod.io/) |
| Lambda GPU Cloud | Paid on-demand/reserved GPU cloud and enterprise | AI-focused GPU instances/clusters | Capacity/region availability and storage/network | [GPU Cloud](https://lambda.ai/service/gpu-cloud) · [docs](https://docs.lambda.ai/) |
| CoreWeave | Paid on-demand/spot/reserved/enterprise | Large-scale NVIDIA GPU training/inference and Kubernetes | Capacity commitments and platform operations | [pricing](https://www.coreweave.com/pricing) · [docs](https://docs.coreweave.com/) |
| AWS / Google Cloud / Azure | Paid usage, reservations/spot, enterprise contracts | Existing cloud governance, global services, managed ML | Complex SKUs, quotas, egress, idle resources | [AWS EC2](https://aws.amazon.com/ec2/pricing/) · [GCP GPUs](https://cloud.google.com/compute/gpus-pricing) · [Azure VMs](https://azure.microsoft.com/pricing/details/virtual-machines/) |
| NVIDIA enterprise stack | Software/catalog access varies; hardware/cloud/support paid | CUDA ecosystem, optimized containers, enterprise support | Licensing, hardware compatibility, vendor stack | [NGC catalog](https://catalog.ngc.nvidia.com/) · [AI Enterprise](https://www.nvidia.com/en-us/data-center/products/ai-enterprise/) |

> [!warning] GPU sticker price is not total cost
> Include CPU/RAM, local and network storage, snapshots, egress, public IP, idle time, failed jobs, orchestration, observability, support, reservations, engineering labor, and deletion lag.

## Selection criteria

- Workload: interactive notebook, batch training, fine-tune, realtime inference, or burst job.
- Required VRAM/model size, precision/quantization, interconnect, disk throughput, network, and CPU/RAM.
- Expected utilization, queue time, cold start, concurrency, latency SLO, and geographic users.
- Data sensitivity, U.S. region, private network, encryption, IAM, audit, and host isolation.
- Spot interruption tolerance, checkpointing, capacity guarantee, and disaster recovery.
- Container/runtime support, CUDA/driver compatibility, infrastructure as code, and portability.
- Carbon/energy reporting and physical capacity constraints where material.

## Free-first path

1. Profile on CPU/local hardware with the smallest model and dataset that answers the question.
2. Use Colab/Kaggle quota or a basic Space for learning and demos.
3. Run a short, tagged, auto-terminating rented-GPU experiment; save checkpoints externally.
4. Benchmark throughput, quality, utilization, and full cost on two hardware classes.
5. Reserve capacity or adopt a hyperscaler only for stable demand, reliability, integration, or governance needs.

~~~mermaid
flowchart TD
    A["Compute workload"] --> B{"Fits owned hardware?"}
    B -->|"Yes"| C["Run locally and profile"]
    B -->|"No"| D{"Learning / short experiment?"}
    D -->|"Yes"| E["Colab, Kaggle, Spaces, or short GPU rental"]
    D -->|"No"| F{"Burst/serverless?"}
    F -->|"Yes"| G["Modal, Workers AI, or serverless GPU"]
    F -->|"No"| H{"Existing cloud governance?"}
    H -->|"Yes"| I["AWS, GCP, or Azure"]
    H -->|"No / AI-specialized"| J["Runpod, Lambda, or CoreWeave"]
    C --> K["Measure utilization and total cost"]
    E --> K
    G --> K
    I --> K
    J --> K
~~~

## Shutdown checklist

- stop/terminate compute and autoscaling workers;
- remove unattached disks, snapshots, images, reserved IPs, endpoints, and caches;
- verify object storage and egress logs;
- rotate/revoke credentials and delete test data;
- confirm billing dashboard returns to expected baseline.

## Role connections

[[AI Platform Engineer|AI Infrastructure Engineer]], [[MLOps Engineer]], [[ML Engineer]], [[AI Solutions Architect|Cloud Architect]], [[AI Economics and FinOps|FinOps Analyst]], and [[AI Solutions Architect]].

## Official-source record

Verified **2026-08-12**. See [[Tool Source Registry#Cloud compute and hardware]].
