CREATE EXTENSION azure_ai;
CREATE EXTENSION vector;
select azure_ai.set_setting('azure_openai.endpoint','https://oai-svc-01.openai.azure.com');
select azure_ai.set_setting('azure_openai.subscription_key', '<api-key>');
