local pipelineAction = import 'pipelineAction.libsonnet';

function(pipelineTitle, stageTitle, actions)
local combined = pipelineTitle + ' ' + stageTitle;
local lowercase = std.asciiLower(combined);
local name =  std.strReplace(lowercase, ' ', '_');
{
  name: name,
  action: [
    pipelineAction(pipelineTitle, action.title,
      input = if std.objectHas(action, 'input') then action.input else null,
      output = if std.objectHas(action, 'output') then action.output else null,
    )
    for action in actions
  ],
}

