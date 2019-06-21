local settings = import '../../settings.json';
local repository = import 'repository.libsonnet';
local name = settings.projectName + '-migration-utils';

repository(
  key = 'migration_utils',
  name = name,
  desc = 'This is the migration-utils repository for the ' + settings.projectName + " project.",
)
