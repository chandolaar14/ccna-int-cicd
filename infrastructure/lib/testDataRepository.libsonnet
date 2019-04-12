local settings = import '../../settings.json';
local repository = import 'repository.libsonnet';

repository(
  key = 'test_data',
  name = settings.projectName + '-test-data',
)
