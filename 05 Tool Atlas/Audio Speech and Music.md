---
title: Audio Speech and Music
aliases:
  - Audio, Speech, and Music
tags:
  - atlas/tools
  - ai/audio
  - ai/speech
  - ai/music
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
last_updated: 2026-10-13
---

# Audio Speech and Music

> [!info] October 13, 2026 update
> Check [[Model and Agent Lifecycle Management]] and its linked provider lifecycle tables before selecting audio endpoints; an older example may be retired or preview-only.

This category covers recording/editing, transcription (STT), synthesis (TTS), voice agents, dubbing, separation, and music generation. Test with the accents, noise, vocabulary, latency, and accessibility needs of the actual audience.

## Representative comparison

| Tool/service | Access posture | Best fit | Watch closely | Official |
|---|---|---|---|---|
| Audacity | GPL-3.0 open source | Free recording, cleanup, editing, and export | Manual workflow; plugin supply chain | [Audacity](https://www.audacityteam.org/) · [GitHub](https://github.com/audacity/audacity) |
| OpenAI Whisper | MIT-licensed open-source speech recognition model/code | Local transcription baseline | Hardware, diarization, language/domain errors | [GitHub](https://github.com/openai/whisper) |
| OpenAI Audio API | Paid usage | Application STT/TTS and realtime voice integration | Model/voice availability, latency, data controls | [audio guide](https://platform.openai.com/docs/guides/audio) · [pricing](https://openai.com/api/pricing/) |
| ElevenLabs | Free limited plan plus paid/enterprise/API | Expressive TTS, dubbing, voice and conversational agents | Voice consent, credit units, cloning safeguards | [pricing](https://elevenlabs.io/pricing) · [docs](https://elevenlabs.io/docs) |
| Deepgram | Evaluation credits as offered plus paid usage/enterprise | Realtime/batch speech APIs and voice agents | Feature/model-specific units and concurrency | [pricing](https://deepgram.com/pricing) · [docs](https://developers.deepgram.com/) |
| AssemblyAI | Evaluation credits as offered plus paid usage/enterprise | Transcription, diarization, speech intelligence | Language/model/feature charges | [pricing](https://www.assemblyai.com/pricing) · [docs](https://www.assemblyai.com/docs) |
| Google Cloud Speech / Azure Speech in Foundry Tools | Free allowance/tier where listed plus paid cloud usage | Enterprise speech inside existing cloud | Region, feature tiers, characters/minutes, related services | [Google pricing](https://cloud.google.com/speech-to-text/pricing) · [Azure pricing](https://azure.microsoft.com/en-us/pricing/details/speech/) |
| Descript | Free plan plus paid plans/enterprise | Transcript-based podcast/video editing and voice workflow | AI credits, transcription hours, voice consent | [pricing](https://www.descript.com/pricing) |
| Suno | Free limited plan plus paid plans | Song ideation and generation | Commercial rights differ by plan; training/input rights | [pricing](https://suno.com/pricing) · [terms](https://suno.com/terms) |
| Udio | Free/paid access as currently offered | Music generation and editing experimentation | Availability, credits, rights, evolving legal landscape | [pricing](https://www.udio.com/pricing) · [terms](https://www.udio.com/terms-of-service) |

> [!danger] Voice is biometric and identity-bearing
> Obtain explicit permission to clone or transform a person's voice. Disclose synthetic speech where appropriate, secure reference recordings, plan revocation, and never use voice cloning to bypass authentication.

## Selection criteria

- STT/TTS/music/editor/voice-agent task and batch vs realtime latency.
- Word error rate on domain terms, accents, code-switching, noise, and overlapping speakers.
- Diarization, timestamps, captions, pronunciation dictionaries, emotion/style, streaming, and API.
- Data retention/training, voice consent/verification, region, encryption, and deletion.
- Commercial rights, music publishing/licensing, performer rights, and disclosure.
- Billing by minute, character, token, generation, credit, concurrency, storage, or seat.

## Free-first path

1. Record and edit a rights-safe sample in Audacity.
2. Establish a local Whisper transcription baseline.
3. Test limited hosted STT/TTS with the same noisy/accented/domain-specific clips.
4. Human-review transcripts, captions, names, numbers, and synthetic voices.
5. Pay for latency, quality, languages, diarization, collaboration, API scale, or contractual controls.

~~~mermaid
flowchart TD
    A["Audio task"] --> B{"Transcribe or synthesize?"}
    B -->|"Transcribe"| C{"Offline required?"}
    C -->|"Yes"| D["Whisper local"]
    C -->|"No"| E["OpenAI, Deepgram, AssemblyAI, Google, or Azure"]
    B -->|"Synthesize/voice"| F["Consent-verified TTS provider"]
    B -->|"Music"| G["Suno/Udio or conventional licensed workflow"]
    B -->|"Edit"| H["Audacity or Descript"]
    D --> I["Human accuracy review"]
    E --> I
    F --> J["Identity, disclosure, and rights review"]
    G --> J
~~~

## Role connections

[[Conversation Designer|Conversational AI Designer]], [[AI Audio and Music Specialist|AI Audio Producer]], [[AI Audio and Music Specialist|Podcast Producer]], [[Speech AI Engineer|Speech ML Engineer]], [[AI Content Designer|Localization Specialist]], and [[AI Accessibility|Accessibility Specialist]].

## Official-source record

Verified **2026-08-12**. See [[Tool Source Registry#Audio speech and music]].
