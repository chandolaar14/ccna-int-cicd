local merge = import 'merge.libsonnet';
local repository = import 'repository.libsonnet';
local pipeline = import 'pipeline.libsonnet';
local codebuild = import 'codebuild.libsonnet';
local pipelineAction = import 'pipelineAction.libsonnet';
local sourceAction = import 'sourceAction.libsonnet';
local settings = import '../../settings.json';

merge([
  repository(
    key = 'test_data',
    name = settings.projectName + '-test-data',
    desc = 'This is the test data repository for the ' + settings.projectName + " project.",
  ),
  pipeline(
    key = 'test-data',
    name = 'test-data-' + settings.projectName,
    stages = [{
      name: 'Source',
      action: [
        sourceAction('${aws_codecommit_repository.test_data.repository_name}'),
      ],
    },{
      name: 'Sync',
      action: [
        pipelineAction('Build', '${aws_codebuild_project.test_data_sync.name}', 'source'),
      ],
    }],
  ),
  codebuild('test_data_sync', 'test-data-' + settings.projectName + '-sync', 'buildspec-sync.yml'),
])
