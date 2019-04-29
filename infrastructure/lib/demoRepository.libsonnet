local settings = import '../../settings.json';
local repository = import 'repository.libsonnet';

repository(
  key = 'demo',
  name = settings.demoEnvName + '-' + settings.projectName,
  desc = 'This is the demo repository for the ' + settings.projectName + " project.",
)
