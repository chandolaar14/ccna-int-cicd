local merge = import 'merge.libsonnet';
local subProject = import 'subProject.libsonnet';

subProject('Transfer Server', 'AWS Transfer Server for Platform and Migration testing', [
  { type: 'single-action', title: 'Deploy', input: 'source' },
])

