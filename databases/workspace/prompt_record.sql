-- create type lang_enum as enum(
-- 'go',
-- 'python',
-- 'java',
-- 'javascript',
-- 'html',
-- 'css',
-- 'typescript',
-- 'dotnet'
-- );

-- create type prompt_type_enum as enum(
--     'chat',
--     'inline'
-- );

create type shot_count_enum as enum(
    'zero',
    'one',
    'multi'
);

create type ide_enum as enum(
    'vscode',
    'visual-studio',
    'azure-data-studio',
    'jetbrains-suite',
    'vim-neovim'
);

create type aoai_model_enum as enum(
    'gpt-3.5-turbo',
    'gpt-4o',
    'o1-mini',
    '01-preview',
    'unknown'
);

create type indicate_relevant_code_enum as enum(
    'true',
    'false',
    'na'
);

create type suggestion_accuracy_enum as enum(
    'high',
    'medium',
    'low'
);

create type match_classification_enum as enum(
    'good',
    'acceptable',
    'unacceptable'
);

create type thumbs_enum as enum(
    'helpful',
    'unhelpful'
);

-- Metadata
alter table prompts
-- add column relevant_code indicate_relevant_code_enum
-- add column optimization_ref text,
-- Add boolean columns for optimization rules checklist
add column general_to_specific boolean,
add column short BOOLEAN,
add column simple BOOLEAN,
add column specific BOOLEAN,
add column iterate BOOLEAN,
add column keep_history_relevant BOOLEAN,
add column add_slash_skills BOOLEAN,
add column look_for_sparkles BOOLEAN,
-- System prompts
add column indicate_role BOOLEAN,
add column indicate_tone BOOLEAN,
add column specify_steps BOOLEAN,
add column specify_output_format BOOLEAN,
-- Chat participants
add column at_workspace BOOLEAN,
add column at_vscode BOOLEAN,
add column at_terminal BOOLEAN,
add column at_github BOOLEAN,
add column at_devbox BOOLEAN,
add column use_voice BOOLEAN,
-- Good coding practices
add column use_consistent_styles BOOLEAN,
add column use_descriptive_names BOOLEAN,
add column use_comments BOOLEAN,
add column use_single_responsibility BOOLEAN,
-- Testing
add column unit_test_framework_primary text,
add column unit_test_framework_socondary text,
add column integration_test_framework_primary text,
add column integration_test_framework_secondary text,
add column include_unit_test BOOLEAN,
add column include_integration_test BOOLEAN,
add column include_performance_test BOOLEAN,
add column include_load_test BOOLEAN,
add column include_reliability_test BOOLEAN,
add column include_security_test BOOLEAN,
-- Suggestion properties
add column suggestion_description text,
add column suggestion_filtered BOOLEAN,
add column suggestion_accuracy suggestion_accuracy_enum,
add column next_likely_question text,
-- Reference sources
add column primary_reference text,
add column secondary_reference text,
-- Feedback
add column thumbs thumbs_enum,
add column feedback_postive text,
add column feedback_negative text,
add column feedback_feature_request text;








