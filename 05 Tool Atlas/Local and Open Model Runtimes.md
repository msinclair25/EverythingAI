---
title: Local and Open Model Runtimes
tags:
  - atlas/tools
  - ai/local
  - ai/open-models
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

# Local and Open Model Runtimes

Local runtimes execute downloadable models on a workstation or self-managed server. They can improve control and offline access, but they transfer patching, capacity, licensing, and security responsibility to you.

> [!danger] “Local” is not automatically private
> Model downloads, telemetry, browser extensions, remote APIs, exposed ports, logs, and plugins can still move data. Bind services to trusted interfaces, authenticate network access, patch promptly, and verify each model license.

## Representative comparison

| Tool | Access posture | Best fit | Main trade-off | Official |
|---|---|---|---|---|
| Ollama | Open-source runtime; local use; hosted offerings may differ | Easiest CLI/local API start | Less control than lower-level engines | [GitHub](https://github.com/ollama/ollama) · [docs](https://docs.ollama.com/) |
| llama.cpp | MIT-licensed open source | Efficient CPU/GPU inference and GGUF experimentation | More manual configuration | [GitHub](https://github.com/ggml-org/llama.cpp) |
| vLLM | Apache-2.0 open source | High-throughput server inference | Server/GPU operations knowledge | [docs](https://docs.vllm.ai/) · [GitHub](https://github.com/vllm-project/vllm) |
| LM Studio | Free desktop use under current terms; business/enterprise options | GUI model discovery and local chat/server | Proprietary desktop product; verify terms and telemetry | [pricing](https://lmstudio.ai/pricing) · [docs](https://lmstudio.ai/docs/) |
| SGLang | Apache-2.0 open source | High-performance server inference and structured/agent workloads | GPU operations and serving complexity | [docs](https://docs.sglang.ai/) · [GitHub](https://github.com/sgl-project/sglang) |
| MLX / MLX LM | MIT-licensed open source | Apple silicon experimentation and inference | Apple-specific ecosystem | [MLX](https://github.com/ml-explore/mlx) · [MLX LM](https://github.com/ml-explore/mlx-lm) |

> [!warning] TGI is legacy for new selection
> Hugging Face placed Text Generation Inference in maintenance mode on December 11, 2025 and archived its repository in March 2026. Its official migration guidance recommends vLLM or SGLang for new Inference Endpoints.

## Choose on these dimensions

- Hardware and backend: CPU, Apple silicon, NVIDIA CUDA, AMD/ROCm, memory/VRAM.
- Model format and quantization support.
- Single-user interactivity vs concurrent serving throughput.
- OpenAI-compatible API needs, batching, streaming, and structured output.
- Authentication, TLS, network isolation, logging, and patch process.
- Model license, provenance, safety behavior, and commercial-use rights.
- Reproducible pinning of model file, quantization, prompt template, and runtime version.

## Free-first path

1. Start with Ollama or LM Studio on public data and a model that fits memory.
2. Learn what model size, quantization, tokens-per-second, context, and quality mean.
3. Re-run the same evaluation with llama.cpp or MLX LM to understand the lower layer.
4. Move to vLLM or SGLang only when concurrent serving or production throughput is the actual need.
5. Compare electricity, hardware time, maintenance, and engineering labor with a hosted API.

~~~mermaid
flowchart TD
    A["Run a downloadable model"] --> B{"Laptop or server?"}
    B -->|"Laptop / beginner"| C{"Prefer GUI?"}
    C -->|"Yes"| D["LM Studio"]
    C -->|"No"| E["Ollama"]
    B -->|"Server"| F{"High concurrency?"}
    F -->|"Yes"| G["vLLM or SGLang"]
    F -->|"No"| H["llama.cpp server"]
    D --> I["Verify model license and privacy"]
    E --> I
    G --> I
    H --> I
~~~

## Role connections

[[AI Platform Engineer|AI Infrastructure Engineer]], [[ML Engineer]], [[AI Engineer]], [[AI Threat Modeling|AI Security Engineer]], and [[AI ML Research Scientist|AI Research Scientist]].

## Official-source record

Verified **2026-08-12**. See [[Tool Source Registry#Local and open model runtimes]].
