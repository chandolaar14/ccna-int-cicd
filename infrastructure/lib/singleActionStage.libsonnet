local actionStage = import 'actionStage.libsonnet';

// a stage with a single action

function(pipelineTitle, title, input = null, output = null)
  actionStage(pipelineTitle, title, [
    { title: title, input: input, output: output },
  ])

