local sourceAction = import 'sourceAction.libsonnet';

// a stage with a single action

function(title)
{
  name: 'Source',
  action: [
    sourceAction(title),
  ],
}

