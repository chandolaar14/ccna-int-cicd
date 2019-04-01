local settings = import '../../settings.json';
local repository = import 'repository.libsonnet';

repository(
  key = 'instance',
  name = settings.instanceName + '-' + settings.projectName,
)
