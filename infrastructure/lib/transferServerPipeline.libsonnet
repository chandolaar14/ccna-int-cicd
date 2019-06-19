local settings = import '../../settings.json';
local pipeline = import 'pipeline.libsonnet';

pipeline(
  key = 'transfer_server',
  name = settings.projectName + '-transfer-server',
  stages = [{
    name: 'Source',
    action: [{
      name: 'Source',
      category: 'Source',
      provider: 'CodeCommit',
      version: '1',
      owner: 'AWS',
      configuration: {
        RepositoryName: '${aws_codecommit_repository.transfer_server.repository_name}',
        BranchName: 'master',
      },
      output_artifacts: [ 'source' ]
    }],
  },{
    name: 'Deploy',
    action: [{
      name: 'Deploy',
      category: 'Build',
      provider: 'CodeBuild',
      version: '1',
      owner: 'AWS',
      configuration: {
        ProjectName: '${aws_codebuild_project.transfer_server_deploy.name}',
      },
      input_artifacts: [ 'source' ],
    }],
  }],
)
