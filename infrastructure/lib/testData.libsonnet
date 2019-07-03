local subProject = import 'subProject.libsonnet';

subProject('Test Data', 'Data for Platform and Migration testing', [
  { type: 'single-action', title: 'Sync', input: 'source' },
])

