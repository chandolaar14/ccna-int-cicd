local pascalCase = import 'pascalCase.libsonnet';

function(title = 'Approval')
local name = pascalCase(title);
{
  name: name,
  action: [{
    name: name,
    category: 'Approval',
    provider: 'Manual',
    version: '1',
    owner: 'AWS',
  }],
}

