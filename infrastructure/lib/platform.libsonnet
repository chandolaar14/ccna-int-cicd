local merge = import 'merge.libsonnet';
local subProject = import 'subProject.libsonnet';

subProject('Platform', 'Platform code', [
  { type: 'build' },
  { type: 'action', title: 'Test', actions: [
    { type: 'post-build', title: 'Functional Tests' },
    { type: 'post-build', title: 'Metaschema Tests' },
    { type: 'post-build', title: 'Performance Tests' },
    { title: 'Checkmarx Scan', input: 'source' },
  ]},
  { type: 'single-action', title: 'Tag', input: 'buildPackage', output: 'versionedPackage' },
  { type: 'single-action', title: 'Deliver', input: 'versionedPackage' },
])

