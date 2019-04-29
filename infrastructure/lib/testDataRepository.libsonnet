local settings = import '../../settings.json';
local repository = import 'repository.libsonnet';

repository(
  key = 'test_data',
  name = settings.projectName + '-test-data',
  desc = 'This is the test data repository for the ' + settings.projectName + " project.",
)
