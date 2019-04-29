local settings = import '../../settings.json';
local repository = import 'repository.libsonnet';

repository(
  key = 'instance',
  name = settings.instanceName + '-' + settings.projectName,
  desc = 'This is the instance repository for the ' + settings.projectName + " project.",
)
