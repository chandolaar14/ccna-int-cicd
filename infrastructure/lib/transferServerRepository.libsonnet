local settings = import '../../settings.json';
local repository = import 'repository.libsonnet';

repository(
  key = 'transfer_server',
  name = settings.projectName + '-transfer-server',
  desc = 'This is the transfer server repository for the ' + settings.projectName + " project.",
)
