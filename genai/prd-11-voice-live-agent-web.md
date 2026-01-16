# Product Requirements Document (PRD): Azure AI Voice Live Agent Web Application
\n\n1.1 Document Information
\n\n**Version:** 1.0\n\n**Author(s):** GitHub Copilot\n\n**Date:** January 16, 2026\n\n**Status:** Active\n\n**Related Lab:** Develop an Azure AI Voice Live voice agent
\n\n1.2 Executive Summary

This document defines the requirements for a Flask-based Python web application that enables real-time, bidirectional voice interactions with an Azure AI Voice Live agent. The application demonstrates best practices for integrating Azure's real-time voice AI capabilities with web technologies, providing a foundation for building conversational AI experiences. The solution leverages WebSocket connections, asynchronous event handling, and containerized deployment on Azure App Service.
\n\n1.3 Problem Statement

Organizations need a scalable, production-ready template for building voice-enabled conversational AI applications that can:
\n\nHandle real-time audio streaming with low latency\n\nSupport natural conversational interruption patterns\n\nManage complex session lifecycle and event handling\n\nDeploy seamlessly to cloud infrastructure\n\nSupport cross-platform SDK implementations
\n\n1.4 Goals and Objectives
\n\nProvide a complete, working Flask application for real-time voice interactions with Azure AI Voice Live\n\nDemonstrate proper implementation of WebSocket connection management and session handling\n\nEnable natural conversation flow with interruption support\n\nAutomate deployment to Azure Container Registry and App Service\n\nCreate a reusable template for multi-language SDK implementations
\n\n1.5 Scope
\n\n1.5.1 In Scope
\n\nFlask-based Python web application with real-time voice capabilities\n\nAzure VoiceLive SDK integration and session configuration\n\nWebSocket event handling for bidirectional communication\n\nVoice Activity Detection (VAD) configuration and management\n\nSession lifecycle management (initialization, interruption, shutdown)\n\nAudio streaming with base64 encoding for client delivery\n\nContainerized deployment using Azure Container Registry\n\nApp Service deployment and configuration\n\nAzure Cloud Shell-based setup and deployment automation\n\nBash scripting for deployment orchestration\n\nError handling and logging mechanisms
\n\n1.5.2 Out of Scope
\n\nMulti-language implementations (reference only; documentation for .NET SDK provided)\n\nAdvanced audio processing and filtering\n\nCustom machine learning model training\n\nIntegration with third-party voice providers beyond Azure\n\nMobile application development\n\nSpeech recognition only (ASR) implementations
\n\n1.6 User Stories / Use Cases

| User Story | Description                                                                                                                    |
| ---------- | ------------------------------------------------------------------------------------------------------------------------------ |
| US-1       | As a developer, I want to download pre-built base files and implement voice assistant functionality to accelerate development. |
| US-2       | As a developer, I want to implement proper session initialization and configuration to ensure reliable voice interactions.     |
| US-3       | As a developer, I want to handle user interruptions gracefully so conversations feel natural and responsive.                   |
| US-4       | As a developer, I want to stream assistant audio responses to web clients for real-time playback.                              |
| US-5       | As a developer, I want to deploy the application automatically to Azure with a single command.                                 |
| US-6       | As an end user, I want to start a voice session and interact naturally with the assistant.                                     |
| US-7       | As an end user, I want to interrupt the assistant and have my input processed immediately.                                     |
| US-8       | As an operations engineer, I want to monitor application health and manage resources efficiently.                              |
\n\n1.7 Functional Requirements

| Requirement ID | Description                                                                                                                 | Priority |
| -------------- | --------------------------------------------------------------------------------------------------------------------------- | -------- |
| FR-1           | The application shall download and unzip base project files from the Microsoft Learning repository.                         | HIGH     |
| FR-2           | The application shall initialize the VoiceLive assistant with endpoint, credentials, model, voice, and system instructions. | HIGH     |
| FR-3           | The application shall establish an asynchronous WebSocket connection to Azure VoiceLive service.                            | HIGH     |
| FR-4           | The application shall configure session with dual modalities (audio and text) for bi-directional communication.             | HIGH     |
| FR-5           | The application shall implement Server-side Voice Activity Detection (VAD) with configurable sensitivity thresholds.        | HIGH     |
| FR-6           | The application shall set input and output audio formats to PCM16 for compatibility.                                        | HIGH     |
| FR-7           | The application shall handle SESSION_UPDATED events to signal readiness for user input.                                     | HIGH     |
| FR-8           | The application shall handle INPUT_AUDIO_BUFFER_SPEECH_STARTED events to detect user speech initiation.                     | HIGH     |
| FR-9           | The application shall implement interruption logic when user speaks during assistant response.                              | HIGH     |
| FR-10          | The application shall handle INPUT_AUDIO_BUFFER_SPEECH_STOPPED events and transition to processing state.                   | HIGH     |
| FR-11          | The application shall handle RESPONSE_AUDIO_DELTA events and stream audio to connected WebSocket clients.                   | HIGH     |
| FR-12          | The application shall encode audio data as base64 for client-side WebSocket delivery.                                       | HIGH     |
| FR-13          | The application shall handle RESPONSE_AUDIO_DONE events and reset to ready state.                                           | HIGH     |
| FR-14          | The application shall handle ERROR events and communicate error messages to users.                                          | HIGH     |
| FR-15          | The application shall support graceful shutdown with \_stopping flag.                                                       | MEDIUM   |
| FR-16          | The deployment script shall deploy the AI model to Azure AI Services.                                                       | HIGH     |
| FR-17          | The deployment script shall build container image using Azure Container Registry tasks.                                     | HIGH     |
| FR-18          | The deployment script shall deploy the application to Azure App Service.                                                    | HIGH     |
| FR-19          | The application shall support manual session start/stop control from the web UI.                                            | HIGH     |
| FR-20          | The application shall require audio device access (microphone and speaker) from the client.                                 | HIGH     |
\n\n1.8 Non-Functional Requirements

| Category           | Requirement                                                                               |
| ------------------ | ----------------------------------------------------------------------------------------- |
| **Performance**    | Audio latency must be < 500ms for natural conversation flow                               |
| **Scalability**    | Application must support multiple concurrent WebSocket connections                        |
| **Reliability**    | Application must automatically reconnect on temporary network failures                    |
| **Availability**   | Application must maintain 99.9% uptime on Azure App Service                               |
| **Security**       | All audio data must be transmitted over HTTPS/WSS connections                             |
| **Security**       | Authentication credentials must be stored in Azure Key Vault or App Service configuration |
| **Usability**      | UI controls must clearly indicate session state (idle, listening, processing, speaking)   |
| **Supportability** | Application must log all events and errors for troubleshooting                            |
| **Portability**    | Application must run on Linux-based Azure App Service instances                           |
| **Extensibility**  | Code structure must allow easy integration of additional event handlers                   |
\n\n1.9 Assumptions and Dependencies
\n\nAssumptions
\n\nUsers have access to Azure Cloud Shell and Azure portal\n\nUsers have appropriate Azure subscription and permissions to create resources\n\nAudio I/O devices are available on client machines\n\nBash shell environment is available and properly configured\n\nModern web browser with WebSocket support is available\n\nNetwork bandwidth is sufficient for real-time audio streaming
\n\nDependencies
\n\n**Azure Services:** Azure AI Services (VoiceLive), Azure Container Registry, Azure App Service\n\n**Programming Languages:** Python 3.8+, Bash, HTML/JavaScript for client\n\n**Libraries:** Flask, azure-ai-voicelive SDK, asyncio, base64\n\n**Base Files:** Pre-built Flask application template from Microsoft Learning repository\n\n**Deployment Tools:** Azure CLI (az), Azure Dev CLI (azd), Docker\n\n**Models:** GPT-4o or compatible model for assistant behavior
\n\n1.10 Success Criteria / KPIs
\n\n[x] All code implementation sections are completed and properly indented\n\n[x] Deployment script executes successfully on Azure Cloud Shell\n\n[x] Application deploys to Azure App Service without environment variable errors\n\n[x] Web UI loads and displays session state transitions\n\n[x] User can initiate voice session and speak to the assistant\n\n[x] Assistant responds with natural speech within acceptable latency\n\n[x] User can interrupt assistant and have input processed immediately\n\n[x] Application handles errors gracefully with user-friendly messages\n\n[x] Excessive audio chunk messages do not appear in logs under normal operation\n\n[x] Application can be redeployed with option 2 without full redeployment\n\n[ ] User satisfaction score (if applicable)
\n\n1.11 Technical Architecture
\n\nHigh-Level Architecture

```
┌─────────────────────┐
│   Web Browser       │
│  (HTML/JavaScript)  │
└──────────┬──────────┘
           │ WebSocket (WSS)
           │
┌──────────▼──────────────────────┐
│  Flask Application (Python)      │
│  ├─ flask_app.py                │
│  ├─ VoiceLiveAssistant class    │
│  └─ Event handlers              │
└──────────┬──────────────────────┘
           │ WebSocket (VoiceLive SDK)
           │
┌──────────▼────────────────────────┐
│  Azure VoiceLive Service          │
│  └─ Real-time audio AI engine     │
└──────────────────────────────────┘
```
\n\nDeployment Pipeline

```\n\nAzure Cloud Shell
   └─ bash azdeploy.sh
      └─ Deploy AI Model to Azure AI Services
      └─ Build Docker image with ACR Tasks
      └─ Push image to Azure Container Registry
      └─ Create/Update App Service
      └─ Deploy container to App Service
```
\n\n1.12 Milestones & Timeline

| Milestone                          | Estimated Duration | Status        |
| ---------------------------------- | ------------------ | ------------- |
| Environment Setup                  | 5 minutes          | Prerequisite  |
| Download Base Files                | 2 minutes          | Prerequisite  |
| Implement Assistant Initialization | 5 minutes          | Active        |
| Implement Session Configuration    | 3 minutes          | Active        |
| Implement Event Handlers           | 7 minutes          | Active        |
| Code Review and Testing            | 5 minutes          | Active        |
| Deployment Configuration           | 3 minutes          | Active        |
| Execute Deployment                 | 10 minutes         | Active        |
| Application Testing                | 5 minutes          | Active        |
| **Total Duration**                 | **~30 minutes**    | **Estimated** |
\n\n1.13 Usage Instructions (Demonstration Sequence)
\n\nPrerequisites
\n\nAccess to Azure Cloud Shell in Azure portal (https://portal.azure.com)\n\nBash environment configuration\n\nAudio I/O device on client machine\n\nModern web browser with WebSocket support
\n\nStep-by-Step Execution
\n\n**Launch Cloud Shell**\n\nNavigate to Azure portal\n\nClick [\>_] button to open Cloud Shell\n\nSwitch to Bash environment if needed\n\nAccess Classic version for code editor
\n\n**Download Base Files**

   ```bash
   mkdir voice-live-web && cd voice-live-web
   wget https://github.com/MicrosoftLearning/mslearn-ai-language/raw/refs/heads/main/downloads/python/voice-live-web.zip
   unzip voice-live-web.zip
   cd src
   ```
\n\n**Implement Assistant Code Sections**\n\nEdit flask_app.py using `code flask_app.py`\n\nLocate "# BEGIN VOICE LIVE ASSISTANT IMPLEMENTATION" marker\n\nImplement `__init__` method with parameters and state initialization\n\nImplement `start` method with SDK imports\n\nSave with Ctrl+S
\n\n**Implement Session Configuration**\n\nLocate "# BEGIN CONFIGURE VOICE LIVE SESSION" marker\n\nConfigure RequestSession with audio/text modalities\n\nSet voice, audio formats, and VAD parameters\n\nSave with Ctrl+S
\n\n**Implement Event Handlers**\n\nLocate "# BEGIN HANDLE SESSION EVENTS" marker\n\nImplement comprehensive event routing and handlers\n\nInclude session_updated, speech_started, speech_stopped handlers\n\nImplement audio streaming and error handling\n\nSave and exit with Ctrl+Q
\n\n**Review Application Code**\n\nExamine complete implementation\n\nVerify state management and WebSocket integration\n\nConfirm error handling coverage
\n\n**Configure Deployment**\n\nNavigate to root: `cd ~/voice-live-web`\n\nEdit azdeploy.sh deployment script\n\nUpdate resource group name (rg parameter)\n\nUpdate Azure region (location parameter - recommend eastus2 or swedencentral)\n\nSave and exit
\n\n**Execute Deployment**\n\nRun: `bash azdeploy.sh`\n\nSelect option 1 for initial deployment\n\nFollow authentication prompts\n\nVerify model deployment completes successfully\n\nContainer build will proceed automatically
\n\n**Test Application**\n\nWhen deployment completes, copy provided app URL\n\nNavigate to application in web browser\n\nClick "Start session" button\n\nGrant microphone and speaker permissions\n\nBegin speaking when prompted\n\nObserve state transitions and responses\n\nTest interruption by speaking during assistant response
\n\nTroubleshooting Guide

| Issue                                | Resolution                                                                               |
| ------------------------------------ | ---------------------------------------------------------------------------------------- |
| Missing environment variables        | Restart application in App Service                                                       |
| Excessive audio chunk messages       | Stop and restart session                                                                 |
| Application fails to start           | Verify all code implementations for correct indentation; Re-run deployment with option 2 |
| Deployment fails at model deployment | Change region in azdeploy.sh and retry                                                   |
| Deployment interrupted mid-execution | Re-run azdeploy.sh; select option 2 for image-only update                                |
\n\n1.14 Key Takeaways
\n\nReal-time voice AI requires careful session lifecycle management and event handling\n\nNatural conversation flow depends on proper interruption logic implementation\n\nServer-side Voice Activity Detection reduces client-side complexity\n\nContainerized deployment enables consistent, reproducible production environments\n\nAsynchronous event handling with WebSockets enables low-latency bidirectional communication\n\nBase64 audio encoding facilitates web client integration
\n\n1.15 Related Documentation
\n\n[Azure AI VoiceLive SDK Documentation](https://learn.microsoft.com/en-us/azure/ai-services/voice-live/)\n\n[Flask WebSocket Integration](https://flask.palletsprojects.com/)\n\n[Azure Container Registry Documentation](https://learn.microsoft.com/en-us/azure/container-registry/)\n\n[Azure App Service Documentation](https://learn.microsoft.com/en-us/azure/app-service/)\n\n[Azure VoiceLive .NET Client Library](https://www.nuget.org/packages/Azure.AI.VoiceLive/)
\n\n1.16 Questions and Feedback
\n\nShould multi-language SDK implementations be included in the template?\n\nAre there specific voice profiles or localization requirements?\n\nShould custom system prompts be configurable via UI?\n\nIs integration with conversational analytics required?\n\nShould application support message history persistence?

---

**Document Version History**
| Version | Date | Author | Changes |
|---|---|---|---|
| 1.0 | 2026-01-16 | GitHub Copilot | Initial PRD created from lab exercise |
\n
