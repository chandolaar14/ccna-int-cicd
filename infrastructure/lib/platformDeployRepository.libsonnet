local settings = import '../../settings.json';
local repository = import 'repository.libsonnet';
local name = settings.projectName + '-platform-deploy';

repository(
  key = 'platform_deploy',
  name = name,
  desc = 'This is the platform-deploy repository for the ' + settings.projectName + " project.",
)
