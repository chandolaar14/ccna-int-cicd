local merge = import 'merge.libsonnet';
local subProject = import 'subProject.libsonnet';

subProject('Demo', 'Configuration and deployment of a demo environment', [
  { type: 'build' },
  { type: 'post-build', title: 'Plan' },
  { type: 'approval' },
  { type: 'post-build', title: 'Deploy' },
])

