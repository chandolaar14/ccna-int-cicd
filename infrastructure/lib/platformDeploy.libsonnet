local merge = import 'merge.libsonnet';
local subProject = import 'subProject.libsonnet';

subProject('Platform Deploy', 'Migration Platform Deploy Configuration', [
  { type: 'build' },
  { type: 'action', title: 'Plan', actions: [
    { type: 'post-build', title: 'QA Plan' },
    { type: 'post-build', title: 'UAT Plan' },
  ]},
  { type: 'approval' },
  { type: 'action', title: 'Deploy', actions: [
    { type: 'post-build', title: 'QA Deploy' },
    { type: 'post-build', title: 'UAT Deploy' },
  ]},
])
