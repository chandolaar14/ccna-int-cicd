local settings = import '../../settings.json';
local pipeline = import 'pipeline.libsonnet';

pipeline(
  key = 'instance',
  name = settings.instanceName + '-' + settings.projectName,
  stages = [{
    name: 'Source',
    action: [{
      name: 'Source',
      category: 'Source',
      provider: 'CodeCommit',
      version: '1',
      owner: 'AWS',
      configuration: {
        RepositoryName: '${aws_codecommit_repository.instance.repository_name}',
        BranchName: 'master',
      },
      output_artifacts: [ 'source' ]
    }],
  },{
    name: 'QA',
    action: [{
      name: 'QA',
      category: 'Build',
      provider: 'CodeBuild',
      version: '1',
      owner: 'AWS',
      configuration: {
        ProjectName: '${aws_codebuild_project.qa.name}',
      },
      input_artifacts: [ 'source' ],
    }],
  }],
)
