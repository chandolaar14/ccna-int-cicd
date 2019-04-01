local settings = import '../../settings.json';
local pipeline = import 'pipeline.libsonnet';

pipeline(
  key = 'platform',
  name = settings.projectName,
  stages = [{
    name: 'Source',
    action: [{
      name: 'Source',
      category: 'Source',
      provider: 'CodeCommit',
      version: '1',
      owner: 'AWS',
      configuration: {
        RepositoryName: '${aws_codecommit_repository.platform.repository_name}',
        BranchName: 'master',
      },
      output_artifacts: [ 'source' ]
    }],
  },{
    name: 'Build',
    action: [{
      name: 'Build',
      category: 'Build',
      provider: 'CodeBuild',
      version: '1',
      owner: 'AWS',
      configuration: {
        ProjectName: '${aws_codebuild_project.build.name}',
      },
      input_artifacts: [ 'source' ],
      output_artifacts: [ 'buildPackage' ],
    }],
  },{
    name: 'Test',
    action: [{
      name: 'Functional',
      category: 'Test',
      provider: 'CodeBuild',
      version: '1',
      owner: 'AWS',
      configuration: {
        ProjectName: '${aws_codebuild_project.functional_test.name}',
      },
      input_artifacts: [ 'buildPackage' ],
    }],
  },{
    name: 'Approval',
    action: [{
      name: 'Approval',
      category: 'Approval',
      provider: 'Manual',
      version: 1,
      owner: 'AWS',
    }],
  }],
)
