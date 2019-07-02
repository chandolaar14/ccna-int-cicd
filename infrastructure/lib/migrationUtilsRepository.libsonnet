local settings = import '../../settings.json';
local repository = import 'repository.libsonnet';
local name = settings.projectName + '-migration-utils';

repository('Migration Utils', 'Migration configuration generation utilities')
