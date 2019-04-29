local settings = import '../../settings.json';
local pipeline = import 'pipeline.libsonnet';

pipeline(
  key = 'demo',
  name = settings.demoEnvName + '-' + settings.projectName,
  stages = [{
    name: 'Source',
    action: [{
      name: 'Source',
      category: 'Source',
      provider: 'CodeCommit',
      version: '1',
      owner: 'AWS',
      configuration: {
        RepositoryName: '${aws_codecommit_repository.demo.repository_name}',
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
        ProjectName: '${aws_codebuild_project.demo_build.name}',
      },
      input_artifacts: [ 'source' ],
      output_artifacts: [ 'buildPackage' ],
    }],
  },{
    name: 'Demo_Plan',
    action: [{
      name: 'Demo_Plan',
      category: 'Build',
      provider: 'CodeBuild',
      version: '1',
      owner: 'AWS',
      configuration: {
        ProjectName: '${aws_codebuild_project.demo_plan.name}',
      },
      input_artifacts: [ 'buildPackage' ],
    }],
  },{
    name: 'Demo_Approval',
    action: [{
      name: 'Demo_Approval',
      category: 'Approval',
      provider: 'Manual',
      version: '1',
      owner: 'AWS',
    }],
  },{
    name: 'Demo_Deploy',
    action: [{
      name: 'Demo_Deploy',
      category: 'Build',
      provider: 'CodeBuild',
      version: '1',
      owner: 'AWS',
      configuration: {
        ProjectName: '${aws_codebuild_project.demo_deploy.name}',
      },
      input_artifacts: [ 'buildPackage' ],
    }],
  }],
)
