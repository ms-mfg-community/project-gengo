agent: agent

description: "Prompt templates for Voice Live Agent web app development with GitHub Copilot, maintaining project standards."

name: voice-live-agent-web-prompts

model: "Claude Haiku 4.5 (copilot)"


\n\nVoice Live Agent Web Application - Prompt Templates


\n\nOverview



This document provides prompt templates for common tasks when developing or extending the Azure AI Voice Live Agent web application. Use these prompts with GitHub Copilot to accelerate development while maintaining consistency with the project's architecture and coding standards.



---


\n\n1. Implementation Prompts


\n\n1.1 Implement VoiceLive Assistant Class Initialization



**Prompt:**



```text

Create a VoiceLiveAssistant class __init__ method that:
\n\nAccepts parameters: endpoint, credential, model, voice, instructions, and optional state_callback
\n\nStores all Azure VoiceLive connection parameters (endpoint, credential, model, voice, instructions)
\n\nInitializes runtime state variables: connection (None), _response_cancelled (False), _stopping (False)
\n\nSets up the state_callback or defaults to a no-op lambda if not provided
\n\nIncludes comprehensive docstring explaining the purpose and parameters
\n\nAdd the docstring following Google style format



Context: This is for the Flask Voice Live Web application that enables real-time voice interactions.

Follow these guidelines:
\n\nUse type hints for all parameters
\n\nInclude validation for required parameters
\n\nAdd comments explaining state management for connection lifecycle

```


\n\n1.2 Implement Async Start Method with SDK Imports



**Prompt:**



```text

Create an async start method for VoiceLiveAssistant that:
\n\nIs async and awaitable for WebSocket initialization
\n\nImports Azure VoiceLive SDK components: connect and models (RequestSession, ServerVad, AzureStandardVoice, Modality, InputAudioFormat, OutputAudioFormat)
\n\nCreates the WebSocket connection using the connect function with endpoint and credential
\n\nIncludes comprehensive docstring explaining what the method does
\n\nAdd error handling for connection failures
\n\nInclude logging statements for debugging



Context: This method establishes the WebSocket connection to Azure VoiceLive service for real-time voice interactions.

Make sure to:
\n\nUse proper async/await syntax
\n\nHandle import statements at method level to avoid circular dependencies
\n\nInclude type hints where applicable

```


\n\n1.3 Implement Session Configuration



**Prompt:**



```text

Create code to configure the VoiceLive session RequestSession object that:
\n\nSets modalities to both TEXT and AUDIO for bidirectional communication
\n\nUses the instance instructions parameter for assistant behavior
\n\nConfigures voice using AzureStandardVoice
\n\nSets input_audio_format to PCM16
\n\nSets output_audio_format to PCM16
\n\nImplements ServerVad (Voice Activity Detection) with threshold 0.5, prefix_padding_ms 300, silence_duration_ms 500
\n\nUpdates the connection with await conn.session.update(session=session_config)
\n\nIncludes comments explaining each configuration parameter



Context: This is session initialization for Azure VoiceLive real-time voice interactions.

Important notes:
\n\nVAD parameters control how the model detects speech start/stop
\n\nPCM16 format ensures compatibility with web audio APIs
\n\nText modality enables logging and debugging

```


\n\n1.4 Implement Event Router Handler



**Prompt:**



```text

Create an async _handle_event method that:
\n\nAccepts event, conn, and optional verbose parameter
\n\nImports ServerEventType from azure.ai.voicelive.models
\n\nExtracts event_type from the event object
\n\nLogs event type when verbose mode is enabled
\n\nRoutes events to specific handlers based on ServerEventType:
\n\nSESSION_UPDATED → _handle_session_updated()
\n\nINPUT_AUDIO_BUFFER_SPEECH_STARTED → _handle_speech_started(conn)
\n\nINPUT_AUDIO_BUFFER_SPEECH_STOPPED → _handle_speech_stopped()
\n\nRESPONSE_AUDIO_DELTA → _handle_audio_delta(event)
\n\nRESPONSE_AUDIO_DONE → _handle_audio_done()
\n\nRESPONSE_DONE → reset cancellation flag
\n\nERROR → _handle_error(event)
\n\nIncludes comprehensive docstring and type hints



Context: This is the central event dispatcher for Azure VoiceLive session events.

Key requirements:
\n\nMust handle all VoiceLive server event types
\n\nSupport verbose logging for debugging
\n\nRoute to appropriate handler for clean separation of concerns

```


\n\n1.5 Implement Speech Interruption Handler



**Prompt:**



```text

Create an async _handle_speech_started method that:
\n\nUpdates state to "listening" with message "Listening… speak now"
\n\nBroadcasts stop_playback control to all WebSocket clients
\n\nGets current assistant state from assistant_state global dict
\n\nChecks if current_state is in {"assistant_speaking", "processing"}
\n\nIf interrupting, sets _response_cancelled = True and calls await conn.response.cancel()
\n\nLogs interruption event for debugging
\n\nIf not interrupting, logs why cancellation wasn't needed
\n\nIncludes comprehensive error handling with try-except
\n\nLog all exceptions at debug level



Context: This handles natural conversation interruption when user speaks during assistant response.

Important details:
\n\nMust gracefully handle edge cases (timing issues, already-cancelled responses)
\n\nCancellation flag prevents processing of cancelled response audio
\n\nLogging enables debugging of interruption issues

```


\n\n1.6 Implement Audio Streaming Handler



**Prompt:**



```text

Create an async _handle_audio_delta method that:
\n\nSkips processing if _response_cancelled flag is set (return immediately)
\n\nChecks if assistant_state["state"] is not "assistant_speaking"
\n\nIf not, updates state to "assistant_speaking" with message "Assistant speaking…"
\n\nExtracts audio_data from event.delta using getattr
\n\nIf audio_data exists:
\n\nEncodes to base64 using base64.b64encode()
\n\nDecodes to UTF-8 string
\n\nBroadcasts to WebSocket clients with type "audio"
\n\nInclude docstring and error handling



Context: This streams real-time assistant audio to web clients for playback.

Key requirements:
\n\nBase64 encoding required for JSON WebSocket transport
\n\nOnly update state once on first delta (not for every delta)
\n\nRespect cancellation flag to skip interrupted responses
\n\nImmediate broadcast (no buffering) for low latency

```


\n\n1.7 Implement Error Handler



**Prompt:**



```text

Create an async _handle_error method that:
\n\nExtracts error and message from the event object
\n\nUses getattr with default fallback for safe extraction
\n\nCreates user-friendly error message
\n\nUpdates state to "error" with error message
\n\nLogs error for debugging with event details



Context: This handles VoiceLive errors and communicates them to users.

Include:
\n\nDocstring with error handling strategy
\n\nSafe attribute extraction using getattr
\n\nState callback to update UI

```



---


\n\n2. Testing Prompts


\n\n2.1 Create Unit Test for Session Configuration



**Prompt:**



```

Write a pytest test for VoiceLiveAssistant session configuration that:
\n\nMocks the Azure VoiceLive SDK components
\n\nVerifies RequestSession is created with correct parameters
\n\nAsserts modalities include both TEXT and AUDIO
\n\nAsserts input/output audio format is PCM16
\n\nVerifies ServerVad configuration (threshold=0.5, prefix_padding_ms=300, silence_duration_ms=500)
\n\nMocks the connection and verifies session.update is called
\n\nInclude both success and failure test cases



Framework: pytest

Include fixtures for mocking Azure SDK components

```


\n\n2.2 Create Integration Test for Event Handling



**Prompt:**



```

Write a pytest integration test for event handling that:
\n\nSets up a mock VoiceLiveAssistant instance
\n\nSimulates various ServerEventType events
\n\nVerifies correct handler is called for each event type
\n\nConfirms state transitions are correct
\n\nTests interruption logic with speech_started and speech_stopped events
\n\nInclude edge cases (rapid events, out-of-order events)



Framework: pytest with async support (pytest-asyncio)

Include assertions for state changes and logging

```



---


\n\n3. Debugging Prompts


\n\n3.1 Diagnose Audio Streaming Issues



**Prompt:**



```

I'm experiencing excessive "audio chunk" messages in the application logs and audio playback is stuttering.

Debug this issue by:
\n\nChecking if _response_cancelled flag is being set correctly
\n\nVerifying state transitions are happening as expected
\n\nAdding detailed logging to track audio delta events
\n\nIdentifying potential causes:
\n\nRapid interruptions causing flag conflicts
\n\nWebSocket message queue overflow
\n\nAsync event handling race conditions
\n\nSuggest code changes to fix identified issues



Current behavior: Logs show many RESPONSE_AUDIO_DELTA events in rapid succession

Expected behavior: Audio streams smoothly without excessive logging

```


\n\n3.2 Diagnose Connection Issues



**Prompt:**



```

The application fails with a WebSocket connection error to Azure VoiceLive.

Help me debug by:
\n\nChecking environment variable configuration (endpoint, credentials)
\n\nVerifying endpoint format (should be https://...)
\n\nConfirming credentials are valid and not expired
\n\nChecking if Azure region supports VoiceLive service
\n\nIdentifying network/firewall issues
\n\nProviding step-by-step debugging checklist
\n\nSuggesting temporary diagnostic logging to identify the root cause



Error message received: "Connection refused to VoiceLive service"

```



---


\n\n4. Extension Prompts


\n\n4.1 Add Session Persistence



**Prompt:**



```

Extend the VoiceLiveAssistant class to support session persistence:
\n\nStore conversation history (user inputs, assistant responses)
\n\nSave sessions to Azure Cosmos DB or similar
\n\nAdd methods: save_session(), load_session(), get_session_history()
\n\nImplement session recovery on reconnection
\n\nMaintain backward compatibility with existing code
\n\nInclude docstrings and error handling



agent: agent

description: "Prompt templates for Voice Live Agent web app development with GitHub Copilot, maintaining project standards."

name: voice-live-agent-web-prompts

model: "Claude Haiku 4.5 (copilot)"

Voice Live Agent Web Application - Prompt Templates

Overview

This document provides prompt templates for common tasks when developing or extending the Azure AI Voice Live Agent web application. Use these prompts with GitHub Copilot to accelerate development while maintaining consistency with the project's architecture and coding standards.

---

1. Implementation Prompts

1.1 Implement VoiceLive Assistant Class Initialization

**Prompt:**

```text
Create a VoiceLiveAssistant class __init__ method that:

Accepts parameters: endpoint, credential, model, voice, instructions, and optional state_callback

Stores all Azure VoiceLive connection parameters (endpoint, credential, model, voice, instructions)

Initializes runtime state variables: connection (None), _response_cancelled (False), _stopping (False)

Sets up the state_callback or defaults to a no-op lambda if not provided

Includes comprehensive docstring explaining the purpose and parameters

Add the docstring following Google style format

```

Context: This is for the Flask Voice Live Web application that enables real-time voice interactions.

Follow these guidelines:

Use type hints for all parameters

Include validation for required parameters

Add comments explaining state management for connection lifecycle

1.2 Implement Async Start Method with SDK Imports

**Prompt:**

```text
Create an async start method for VoiceLiveAssistant that:

Is async and awaitable for WebSocket initialization

Imports Azure VoiceLive SDK components: connect and models (RequestSession, ServerVad, AzureStandardVoice, Modality, InputAudioFormat, OutputAudioFormat)

Creates the WebSocket connection using the connect function with endpoint and credential

Includes comprehensive docstring explaining what the method does

Add error handling for connection failures

Include logging statements for debugging

```

Context: This method establishes the WebSocket connection to Azure VoiceLive service for real-time voice interactions.

Make sure to:

Use proper async/await syntax

Handle import statements at method level to avoid circular dependencies

Include type hints where applicable

1.3 Implement Session Configuration

**Prompt:**

```text
Create code to configure the VoiceLive session RequestSession object that:

Sets modalities to both TEXT and AUDIO for bidirectional communication

Uses the instance instructions parameter for assistant behavior

Configures voice using AzureStandardVoice

Sets input_audio_format to PCM16

Sets output_audio_format to PCM16

Implements ServerVad (Voice Activity Detection) with threshold 0.5, prefix_padding_ms 300, silence_duration_ms 500

Updates the connection with await conn.session.update(session=session_config)

Includes comments explaining each configuration parameter

```

Context: This is session initialization for Azure VoiceLive real-time voice interactions.

Important notes:

VAD parameters control how the model detects speech start/stop

PCM16 format ensures compatibility with web audio APIs

Text modality enables logging and debugging

1.4 Implement Event Router Handler

**Prompt:**

```text
Create an async _handle_event method that:

Accepts event, conn, and optional verbose parameter

Imports ServerEventType from azure.ai.voicelive.models

Extracts event_type from the event object

Logs event type when verbose mode is enabled

Routes events to specific handlers based on ServerEventType:

SESSION_UPDATED → _handle_session_updated()

INPUT_AUDIO_BUFFER_SPEECH_STARTED → _handle_speech_started(conn)

INPUT_AUDIO_BUFFER_SPEECH_STOPPED → _handle_speech_stopped()

RESPONSE_AUDIO_DELTA → _handle_audio_delta(event)

RESPONSE_AUDIO_DONE → _handle_audio_done()

RESPONSE_DONE → reset cancellation flag

ERROR → _handle_error(event)

Includes comprehensive docstring and type hints

```

Context: This is the central event dispatcher for Azure VoiceLive session events.

Key requirements:

Must handle all VoiceLive server event types

Support verbose logging for debugging

Route to appropriate handler for clean separation of concerns

1.5 Implement Speech Interruption Handler

**Prompt:**

```text
Create an async _handle_speech_started method that:

Updates state to "listening" with message "Listening… speak now"

Broadcasts stop_playback control to all WebSocket clients

Gets current assistant state from assistant_state global dict

Checks if current_state is in {"assistant_speaking", "processing"}

If interrupting, sets _response_cancelled = True and calls await conn.response.cancel()

Logs interruption event for debugging

If not interrupting, logs why cancellation wasn't needed

Includes comprehensive error handling with try-except

Log all exceptions at debug level

```

Context: This handles natural conversation interruption when user speaks during assistant response.

Important details:

Must gracefully handle edge cases (timing issues, already-cancelled responses)

Cancellation flag prevents processing of cancelled response audio

Logging enables debugging of interruption issues

1.6 Implement Audio Streaming Handler

**Prompt:**

```text
Create an async _handle_audio_delta method that:

Skips processing if _response_cancelled flag is set (return immediately)

Checks if assistant_state["state"] is not "assistant_speaking"

If not, updates state to "assistant_speaking" with message "Assistant speaking…"

Extracts audio_data from event.delta using getattr

If audio_data exists:

Encodes to base64 using base64.b64encode()

Decodes to UTF-8 string

Broadcasts to WebSocket clients with type "audio"

Include docstring and error handling

```

Context: This streams real-time assistant audio to web clients for playback.

Key requirements:

Base64 encoding required for JSON WebSocket transport

Only update state once on first delta (not for every delta)

Respect cancellation flag to skip interrupted responses

Immediate broadcast (no buffering) for low latency

1.7 Implement Error Handler

**Prompt:**

```text
Create an async _handle_error method that:

Extracts error and message from the event object

Uses getattr with default fallback for safe extraction

Creates user-friendly error message

Updates state to "error" with error message

Logs error for debugging with event details

```

Context: This handles VoiceLive errors and communicates them to users.

Include:

Docstring with error handling strategy

Safe attribute extraction using getattr

State callback to update UI

---

2. Testing Prompts

2.1 Create Unit Test for Session Configuration

**Prompt:**

```
Write a pytest test for VoiceLiveAssistant session configuration that:

Mocks the Azure VoiceLive SDK components

Verifies RequestSession is created with correct parameters

Asserts modalities include both TEXT and AUDIO

Asserts input/output audio format is PCM16

Verifies ServerVad configuration (threshold=0.5, prefix_padding_ms=300, silence_duration_ms=500)

Mocks the connection and verifies session.update is called

Include both success and failure test cases

```

Framework: pytest

Include fixtures for mocking Azure SDK components

2.2 Create Integration Test for Event Handling

**Prompt:**

```
Write a pytest integration test for event handling that:

Sets up a mock VoiceLiveAssistant instance

Simulates various ServerEventType events

Verifies correct handler is called for each event type

Confirms state transitions are correct

Tests interruption logic with speech_started and speech_stopped events

Include edge cases (rapid events, out-of-order events)

```

---

3. Debugging Prompts

3.1 Diagnose Audio Streaming Issues

**Prompt:**

```
I'm experiencing excessive "audio chunk" messages in the application logs and audio playback is stuttering.

Debug this issue by:

Checking if _response_cancelled flag is being set correctly

Verifying state transitions are happening as expected

Adding detailed logging to track audio delta events

Identifying potential causes:

Rapid interruptions causing flag conflicts

WebSocket message queue overflow

Async event handling race conditions

Suggest code changes to fix identified issues

Current behavior: Logs show many RESPONSE_AUDIO_DELTA events in rapid succession

Expected behavior: Audio streams smoothly without excessive logging

```

3.2 Diagnose Connection Issues

**Prompt:**

```
The application fails with a WebSocket connection error to Azure VoiceLive.

Help me debug by:

Checking environment variable configuration (endpoint, credentials)

Verifying endpoint format (should be https://...)

Confirming credentials are valid and not expired

Checking if Azure region supports VoiceLive service

Identifying network/firewall issues

Providing step-by-step debugging checklist

Suggesting temporary diagnostic logging to identify the root cause

Error message received: "Connection refused to VoiceLive service"

```

---

4. Extension Prompts

4.1 Add Session Persistence

**Prompt:**

```
Extend the VoiceLiveAssistant class to support session persistence:

Store conversation history (user inputs, assistant responses)

Save sessions to Azure Cosmos DB or similar

Add methods: save_session(), load_session(), get_session_history()

Implement session recovery on reconnection

Maintain backward compatibility with existing code

Include docstrings and error handling

Context: Sessions should persist conversation context for analytics and user experience.

Requirements:

Minimal performance impact

Secure storage of conversation data

Privacy consideration for voice data

```

4.2 Add Custom Metrics and Monitoring

**Prompt:**

```
Add monitoring and metrics to the VoiceLiveAssistant class:

Track session duration, audio latency, error rates

Integrate with Azure Application Insights

Create custom events for:

Session start/stop

Interruption events

Error occurrences

State transitions

Add performance counters for latency tracking

Implement metrics batching to reduce overhead

Context: Operations team needs visibility into application health and performance.

Include:

Docstrings explaining metrics

Configuration options for sampling

Example queries for common insights

```

4.3 Add Multi-Language Support

**Prompt:**

```
Extend the Voice Live Agent to support multiple languages:

Accept language parameter in __init__

Configure appropriate voice based on language

Set system instructions in specified language

Handle language-specific audio formats

Provide list of supported languages and voices

Include language validation

Supported languages to include: English, Spanish, French, German, Mandarin, Japanese

Use Azure Text-to-Speech voice names for each language.

```

---

5. Deployment Prompts

5.1 Create Deployment Validation Script

**Prompt:**

```
Create a PowerShell or Bash script that validates the deployment:

Check if resource group exists

Verify Azure Container Registry image exists and is tagged correctly

Confirm App Service is running and healthy

Test WebSocket endpoint connectivity

Verify environment variables are set correctly

Check App Service logs for errors

Validate database connections (if applicable)

Report deployment status with specific health metrics

Include retry logic for transient failures

```

5.2 Create Deployment Rollback Script

**Prompt:**

```
Create a Bash script that rolls back a failed deployment:

Identify previous working image version

Revert App Service to previous container image

Verify connectivity to VoiceLive service

Check application health after rollback

Log rollback action and reason

Alert on-call team if manual intervention needed

Support both automatic and manual rollback triggers

Include safety checks to prevent accidental rollback

```

---

6. Refactoring Prompts

6.1 Refactor Event Handlers for Reusability

**Prompt:**

```
Refactor the VoiceLiveAssistant event handler methods to be more reusable:

Create an event handler base class

Implement handlers as class methods

Add middleware support for cross-cutting concerns (logging, metrics)

Support handler composition and chaining

Maintain backward compatibility

Goals:

Reduce code duplication

Enable easier testing

Support plugin architecture for custom handlers

Improve maintainability and readability

```

6.2 Optimize Audio Streaming Performance

**Prompt:**

```
Optimize the audio streaming in _handle_audio_delta for better performance:

Implement audio frame buffering with configurable batch size

Add audio compression options (if compatible with PCM16)

Optimize base64 encoding (consider lazy encoding)

Implement backpressure handling for slow clients

Profile current implementation to identify bottlenecks

Benchmark improvements

Constraints:

Must maintain < 500ms latency

Cannot break existing client implementations

Audio quality must not degrade

```

---

7. Documentation Prompts

7.1 Generate API Documentation

**Prompt:**

```
Generate comprehensive API documentation for VoiceLiveAssistant class:

Document all public methods with parameters and return types

Include usage examples for common scenarios

Document all events and callbacks

Create sequence diagrams for key workflows

Include troubleshooting section for common issues

Format as Markdown for GitHub wiki

Include:

Quick start guide

Advanced configuration options

Best practices

Performance tuning guide

```

7.2 Generate Architecture Decision Records

**Prompt:**

```
Create Architecture Decision Records (ADRs) for key design decisions:

ADR-001: Why WebSocket for real-time communication

ADR-002: Why async/await for event handling

ADR-003: Session interruption strategy

ADR-004: Audio encoding strategy (base64 over WebSocket)

ADR-005: Deployment containerization approach

For each ADR include:

Context and problem statement

Decision and rationale

Consequences (positive and negative)

Alternatives considered

```

---

Usage Guidelines

**Customize prompts** with your specific requirements and constraints

**Provide context** about your environment and existing code

**Ask for clarification** if the generated code doesn't match expectations

**Iterate** with follow-up prompts to refine implementations

**Test thoroughly** before using generated code in production

Related Resources

[Voice Live Agent Web Lab Exercise](../11-voice-live-agent-web.md)

[Voice Live Agent Web PRD](../prd-11-voice-live-agent-web.md)

[Voice Live Agent Web Instructions](../../.github/instructions/voice-live-agent-web.instructions.md)

[GitHub Copilot Best Practices](https://github.com/features/copilot)

---

**Prompt Templates Version History**

| Version | Date | Updated | Changes |

|---|---|---|---|

| 1.0 | 2026-01-16 | GitHub Copilot | Initial prompt templates created |


```

Create Architecture Decision Records (ADRs) for key design decisions:
\n\nADR-001: Why WebSocket for real-time communication
\n\nADR-002: Why async/await for event handling
\n\nADR-003: Session interruption strategy
\n\nADR-004: Audio encoding strategy (base64 over WebSocket)
\n\nADR-005: Deployment containerization approach



For each ADR include:
\n\nContext and problem statement
\n\nDecision and rationale
\n\nConsequences (positive and negative)
\n\nAlternatives considered

```



---


\n\nUsage Guidelines


\n\n**Customize prompts** with your specific requirements and constraints
\n\n**Provide context** about your environment and existing code
\n\n**Ask for clarification** if the generated code doesn't match expectations
\n\n**Iterate** with follow-up prompts to refine implementations
\n\n**Test thoroughly** before using generated code in production


\n\nRelated Resources


\n\n[Voice Live Agent Web Lab Exercise](../11-voice-live-agent-web.md)
\n\n[Voice Live Agent Web PRD](../prd-11-voice-live-agent-web.md)
\n\n[Voice Live Agent Web Instructions](../../.github/instructions/voice-live-agent-web.instructions.md)
\n\n[GitHub Copilot Best Practices](https://github.com/features/copilot)



---



**Prompt Templates Version History**

| Version | Date | Updated | Changes |

|---|---|---|---|

| 1.0 | 2026-01-16 | GitHub Copilot | Initial prompt templates created |

\n
