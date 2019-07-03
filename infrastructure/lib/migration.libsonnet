local merge = import 'merge.libsonnet';
local subProject = import 'subProject.libsonnet';

subProject('Migration', 'Migration configuration', [
  { type: 'build' },
  { type: 'post-build', title: 'QA Plan' },
  { type: 'post-build', title: 'QA Deploy' },
  { type: 'post-build', title: 'UAT Plan' },
  { type: 'approval', title: 'UAT Approval' },
  { type: 'post-build', title: 'UAT Deploy' },
  { type: 'post-build', title: 'Prod Plan' },
  { type: 'approval', title: 'Prod Approval' },
  { type: 'post-build', title: 'Prod Deploy' },
])

