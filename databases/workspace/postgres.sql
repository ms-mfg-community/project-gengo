create type subcat_enum as enum(
'ado-pipelines',
'ghb-workflows',
'powershell',
'bash',
'azure-cli',
'gh',
'azd',
'ansible',
'dsc',
'devbox',
'rdbms',
'nosql',
'object',
'mem-cached',
'terraform',
'opentofu',
'bicep',
'pulumi',
'azure-data-studio',
'jetbrains',
'neovim',
'visual-studio',
'vscode',
'dotnet',
'go',
'java',
'javascript',
'html',
'css',
'typescript',
'python'
);

alter table prompts
add column subcat subcat_enum;

create type as lang_enum as enum(
'go',
'python',
'java',
'javascript',
'html',
'css',
'typescript',
'dotnet'
);