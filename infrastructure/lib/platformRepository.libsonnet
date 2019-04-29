local settings = import '../../settings.json';
local repository = import 'repository.libsonnet';

repository(
  key = 'platform',
  name = settings.projectName,
  desc = 'This is the platform repository for the ' + settings.projectName + " project.",
)
