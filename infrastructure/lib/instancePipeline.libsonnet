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
    name: 'Build',
    action: [{
      name: 'Build',
      category: 'Build',
      provider: 'CodeBuild',
      version: '1',
      owner: 'AWS',
      configuration: {
        ProjectName: '${aws_codebuild_project.instance_build.name}',
      },
      input_artifacts: [ 'source' ],
      output_artifacts: [ 'buildPackage' ],
    }],
  },{
    name: 'QA_Plan',
    action: [{
      name: 'QA_Plan',
      category: 'Build',
      provider: 'CodeBuild',
      version: '1',
      owner: 'AWS',
      configuration: {
        ProjectName: '${aws_codebuild_project.qa_plan.name}',
      },
      input_artifacts: [ 'buildPackage' ],
    }],
  },{
    name: 'QA_Approval',
    action: [{
      name: 'QA_Approval',
      category: 'Approval',
      provider: 'Manual',
      version: '1',
      owner: 'AWS',
    }],
  },{
    name: 'QA_Deploy',
    action: [{
      name: 'QA_Deploy',
      category: 'Build',
      provider: 'CodeBuild',
      version: '1',
      owner: 'AWS',
      configuration: {
        ProjectName: '${aws_codebuild_project.qa_deploy.name}',
      },
      input_artifacts: [ 'buildPackage' ],
    }],
  }],
)
