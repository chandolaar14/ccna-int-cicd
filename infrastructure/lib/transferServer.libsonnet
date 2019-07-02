local merge = import 'merge.libsonnet';
local repository = import 'repository.libsonnet';
local pipeline = import 'pipeline.libsonnet';
local codebuild = import 'codebuild.libsonnet';
local pipelineAction = import 'pipelineAction.libsonnet';
local sourceAction = import 'sourceAction.libsonnet';
local settings = import '../../settings.json';

merge([
  repository(
    key = 'transfer_server',
    name = settings.projectName + '-transfer-server',
    desc = 'This is the transfer server repository for the ' + settings.projectName + " project.",
  ),
  pipeline(
    key = 'transfer_server',
    name = settings.projectName + '-transfer-server',
    stages = [{
      name: 'Source',
      action: [
        sourceAction('${aws_codecommit_repository.transfer_server.repository_name}'),
      ],
    },{
      name: 'Deploy',
      action: [
        pipelineAction('Deploy', '${aws_codebuild_project.transfer_server_deploy.name}', 'source'),
      ],
    }],
  ),
  codebuild('transfer_server_deploy', settings.projectName + '-transfer-server-deploy', 'buildspec.yml'),
])
