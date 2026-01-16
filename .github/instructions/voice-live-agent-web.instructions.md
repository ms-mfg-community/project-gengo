---
applyTo: "genai/workspace/11-voice-live-agent/**"
workspaceRoot: "$(git rev-parse --show-toplevel)"
targetPath: '$(git rev-parse --show-toplevel)\genai\workspace\11-voice-live-agent'
---
\n\nVoice Live Agent Web Application Development Instructions
\n\nOverview

These custom instructions provide guidance for developing, implementing, and deploying the Azure AI Voice Live Agent web application. This Flask-based Python application enables real-time, bidirectional voice interactions with an Azure AI Voice Live agent, featuring natural conversation flow with interruption support and containerized deployment.
\n\nCore Architecture Principles
\n\nSession Lifecycle Management
\n\nSessions must maintain clear state transitions: idle → ready → listening → processing → assistant_speaking → ready\n\nAll state transitions must trigger appropriate callbacks for UI updates\n\nGraceful shutdown must clean up resources and cancel in-flight operations
\n\nEvent-Driven Architecture
\n\nImplement comprehensive event handling for all VoiceLive server events\n\nRoute events through a centralized dispatcher for consistency\n\nHandle both success and error events uniformly\n\nLog all events at appropriate verbosity levels for debugging
\n\nReal-Time Communication
\n\nUse WebSocket connections for low-latency, bidirectional communication\n\nEncode audio data as base64 for JSON serialization over WebSocket\n\nStream RESPONSE_AUDIO_DELTA events immediately to prevent buffering delays\n\nImplement backpressure handling for high-volume audio streams
\n\nDevelopment Guidelines
\n\nCode Organization
\n\n**VoiceLiveAssistant Class**: Encapsulates all Voice Live interaction logic\n\n`__init__`: Initialize connection parameters and runtime state\n\n`start`: Establish WebSocket connection and configure session\n\nEvent handlers: Implement one handler per event type\n\n`request_stop`: Graceful shutdown mechanism
\n\n**Event Handlers**: Implement as separate async methods for clarity\n\n`_handle_session_updated`: Session is ready for input\n\n`_handle_speech_started`: User speech detected; implement interruption logic\n\n`_handle_speech_stopped`: User speech ended; transition to processing\n\n`_handle_audio_delta`: Stream assistant audio to clients\n\n`_handle_audio_done`: Audio streaming complete\n\n`_handle_error`: Error occurred during session
\n\nSession Configuration

When configuring the RequestSession:

```python
session_config = RequestSession(
    modalities=[Modality.TEXT, Modality.AUDIO],        # Always dual modality
    instructions=self.instructions,                     # Define assistant behavior
    voice=voice_cfg,                                    # TTS voice configuration
    input_audio_format=InputAudioFormat.PCM16,          # Standard audio format
    output_audio_format=OutputAudioFormat.PCM16,        # Matching format
    turn_detection=ServerVad(
        threshold=0.5,                                  # Sensitivity: 0.0-1.0
        prefix_padding_ms=300,                          # Audio to capture before speech
        silence_duration_ms=500                         # Silence to consider speech ended
    ),
)
```
\n\nInterruption Handling

The application must support natural interruption patterns:
\n\n**Detect User Speech**: Listen for INPUT_AUDIO_BUFFER_SPEECH_STARTED\n\n**Stop Assistant Output**: Call `conn.response.cancel()` to interrupt\n\n**Clear Playback**: Broadcast stop_playback control to WebSocket clients\n\n**Update State**: Transition to listening state\n\n**Set Cancellation Flag**: Mark response as cancelled to skip delta events\n\n**Process User Input**: Continue with normal speech processing

**Critical Implementation Details:**
\n\nOnly cancel responses if assistant is currently speaking or processing\n\nCheck `current_state` before attempting cancellation\n\nHandle exceptions gracefully during cancellation\n\nLog all interruption events for debugging
\n\nAudio Streaming

When streaming assistant audio:

```python
async def _handle_audio_delta(self, event):
    if self._response_cancelled:
        return  # Skip cancelled responses

    if assistant_state.get("state") != "assistant_speaking":
        self.state_callback("assistant_speaking", "Assistant speaking…")

    audio_data = getattr(event, "delta", None)
    if audio_data:
        audio_b64 = base64.b64encode(audio_data).decode("utf-8")
        _broadcast({"type": "audio", "audio": audio_b64})
```

**Key Points:**
\n\nAlways check cancellation flag before processing\n\nUpdate state on first audio delta only (not every delta)\n\nEncode audio as base64 for JSON transport\n\nBroadcast immediately; don't buffer
\n\nState Management

Maintain a global `assistant_state` dictionary:

```python
assistant_state = {
    "state": "idle",  # Current conversation state
    "session_id": None,  # Current session identifier
    "connected": False,  # Connection status
    "error": None,  # Last error, if any
}
```

Use state_callback for all state transitions:

```python
self.state_callback(new_state, human_readable_message)
```
\n\nDeployment Configuration
\n\nAzure Resources

The deployment script (`azdeploy.sh`) creates:
\n\n**Azure AI Services**: Hosts the VoiceLive model (gpt-4o)\n\n**Azure Container Registry**: Stores container image\n\n**Azure App Service**: Runs the Flask application
\n\nRegion Selection

Recommended regions for gpt-4o model:
\n\n**eastus2** (primary recommendation)\n\n**swedencentral** (alternative)\n\n**eastus**, **westus2** (if above unavailable)

If deployment fails in chosen region, try alternative regions.
\n\nEnvironment Variables

The application requires:

```bash
AZURE_AI_VOICELIVE_ENDPOINT=https://<region>.tts.speech.microsoft.com/
AZURE_AI_VOICELIVE_KEY=<api-key>
AZURE_OPENAI_ENDPOINT=https://<deployment-name>.openai.azure.com/
AZURE_OPENAI_API_KEY=<api-key>
AZURE_OPENAI_DEPLOYMENT_NAME=gpt-4o
```

Verify these are set in App Service Configuration after deployment.
\n\nContainer Building

ACR Tasks builds the image using:
\n\nDockerfile from repository root\n\nMulti-stage build for size optimization\n\nLatest Python 3.11 runtime\n\nAll dependencies from requirements.txt
\n\nTesting and Validation
\n\nLocal Testing (if running locally)
\n\nSet up Python virtual environment:

   ```bash
   python -m venv venv
   source venv/bin/activate  # or venv\Scripts\activate on Windows
   pip install -r requirements.txt
   ```
\n\nConfigure environment variables in .env file
\n\nRun Flask app:

   ```bash
   FLASK_APP=src/flask_app.py FLASK_ENV=development python -m flask run
   ```
\n\nNavigate to http://localhost:5000
\n\nProduction Testing
\n\nAccess deployed App Service URL from deployment script output\n\nGrant audio permissions when prompted\n\nTest sequence:\n\nClick "Start session" → verify "Session ready" message\n\nSpeak normally → verify assistant responds\n\nInterrupt assistant → verify immediate response to new input\n\nLet assistant finish → verify return to ready state\n\nTest with different audio inputs\n\nVerify error handling with network interruption
\n\nTroubleshooting Checklist
\n\n[ ] All code implementations have correct indentation\n\n[ ] Environment variables are set in App Service\n\n[ ] Container image built successfully (check ACR)\n\n[ ] App Service pulling correct image\n\n[ ] WebSocket connection established (check browser console)\n\n[ ] Audio permissions granted by user\n\n[ ] Microphone and speaker functional\n\n[ ] No excessive errors in App Service logs
\n\nCommon Issues and Solutions
\n\nIssue: "Missing environment variables" Error
\n\n**Cause**: App Service configuration incomplete\n\n**Solution**: Restart App Service after updating configuration; verify all required variables set
\n\nIssue: Excessive "audio chunk" Messages in Log
\n\n**Cause**: Audio streaming buffer overflow or rapid state transitions\n\n**Solution**: Stop and restart session; check network latency; reduce VAD threshold if needed
\n\nIssue: Application Fails to Start
\n\n**Cause**: Code indentation errors or incomplete implementations\n\n**Solution**:\n\nCheck indentation in all code sections\n\nRun `python -m py_compile src/flask_app.py` to verify syntax\n\nRe-run deployment with `bash azdeploy.sh` and option 2
\n\nIssue: Deployment Fails at Model Deployment
\n\n**Cause**: Region quota exceeded or service unavailable\n\n**Solution**: Update region in azdeploy.sh; wait 5 minutes; try again
\n\nIssue: WebSocket Connection Fails
\n\n**Cause**: SSL/TLS certificate issue or endpoint configuration\n\n**Solution**:\n\nCheck browser console for specific error\n\nVerify AZURE_AI_VOICELIVE_ENDPOINT format\n\nEnsure WSS (not WS) connection\n\nCheck firewall/network policies
\n\nBest Practices
\n\nCode Quality
\n\nAlways include docstrings on class and method definitions\n\nUse type hints for function parameters and returns\n\nImplement comprehensive error handling with specific exception types\n\nLog events with appropriate severity levels\n\nUse async/await consistently throughout
\n\nPerformance
\n\nStream audio immediately; don't buffer\n\nBatch WebSocket broadcasts only when necessary\n\nClean up connections and resources on shutdown\n\nMonitor memory usage during long-running sessions
\n\nSecurity
\n\nStore credentials in Azure Key Vault or App Service secure settings\n\nUse HTTPS/WSS for all communication\n\nValidate all user inputs before processing\n\nImplement rate limiting on WebSocket connections\n\nLog security-relevant events for audit trails
\n\nMaintainability
\n\nKeep event handlers focused and single-purpose\n\nExtract reusable logic into helper functions\n\nDocument all configuration parameters\n\nVersion API responses for client compatibility\n\nImplement feature flags for gradual rollout
\n\nIntegration Points
\n\nClient-Side WebSocket Messages

**Sent by Flask App:**

```json
{"type": "status", "state": "listening", "message": "Listening…"}
{"type": "audio", "audio": "<base64-encoded-audio>"}
{"type": "log", "level": "debug", "msg": "Debug message"}
{"type": "control", "action": "stop_playback"}
```

**Received from Browser:**

```json
{"action": "start_session"}
{"action": "stop_session"}
{"audio": "<base64-encoded-user-audio>"}
```
\n\nAzure VoiceLive SDK Events

Subscribe to all ServerEventType events:
\n\nSESSION_UPDATED\n\nINPUT_AUDIO_BUFFER_SPEECH_STARTED\n\nINPUT_AUDIO_BUFFER_SPEECH_STOPPED\n\nRESPONSE_AUDIO_DELTA\n\nRESPONSE_AUDIO_DONE\n\nRESPONSE_DONE\n\nERROR
\n\nRelated Resources
\n\n[Voice Live Agent Web Lab Exercise](../11-voice-live-agent-web.md)\n\n[Voice Live Agent Web PRD](../prd-11-voice-live-agent-web.md)\n\n[Azure AI VoiceLive Documentation](https://learn.microsoft.com/en-us/azure/ai-services/voice-live/)\n\n[Flask-SocketIO WebSocket Integration](https://flask-socketio.readthedocs.io/)\n\n[Azure Container Registry Documentation](https://learn.microsoft.com/en-us/azure/container-registry/)

---

**Instruction Version History**
| Version | Date | Updated | Changes |
|---|---|---|---|
| 1.0 | 2026-01-16 | GitHub Copilot | Initial custom instructions created |
\n
