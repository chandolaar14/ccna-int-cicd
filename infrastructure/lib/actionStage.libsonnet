local pipelineAction = import 'pipelineAction.libsonnet';
local pascalCase = import 'pascalCase.libsonnet';

function(pipelineTitle, stageTitle, actions)
{
  name: pascalCase(stageTitle),
  action: [
    pipelineAction(pipelineTitle, action.title,
      inputs = if std.objectHas(action, 'inputs') then action.inputs else null,
      output = if std.objectHas(action, 'output') then action.output else null,
    )
    for action in actions
  ],
}

