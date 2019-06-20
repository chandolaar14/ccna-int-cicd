local settings = import '../../settings.json';
local pipeline = import 'pipeline.libsonnet';
local name = settings.projectName + '-platform-deploy';

pipeline(
  key = 'platform_deploy',
  name = name,
  stages = [{
    name: 'Source',
    action: [{
      name: 'Source',
      category: 'Source',
      provider: 'CodeCommit',
      version: '1',
      owner: 'AWS',
      configuration: {
        RepositoryName: '${aws_codecommit_repository.platform_deploy.repository_name}',
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
        ProjectName: '${aws_codebuild_project.platform_deploy_build.name}',
      },
      input_artifacts: [ 'source' ],
      output_artifacts: [ 'buildPackage' ],
    }],
  },{
    name: 'Plan',
    action: [{
      name: 'QA_Plan',
      category: 'Build',
      provider: 'CodeBuild',
      version: '1',
      owner: 'AWS',
      configuration: {
        ProjectName: '${aws_codebuild_project.platform_deploy_qa_plan.name}',
      },
      input_artifacts: [ 'buildPackage' ],
    },{
      name: 'UAT_Plan',
      category: 'Build',
      provider: 'CodeBuild',
      version: '1',
      owner: 'AWS',
      configuration: {
        ProjectName: '${aws_codebuild_project.platform_deploy_uat_plan.name}',
      },
      input_artifacts: [ 'buildPackage' ],
    }],
  },{
    name: 'Approval',
    action: [{
      name: 'Approval',
      category: 'Approval',
      provider: 'Manual',
      version: '1',
      owner: 'AWS',
    }],
  },{
    name: 'Deploy',
    action: [{
      name: 'QA_Deploy',
      category: 'Build',
      provider: 'CodeBuild',
      version: '1',
      owner: 'AWS',
      configuration: {
        ProjectName: '${aws_codebuild_project.platform_deploy_qa_deploy.name}',
      },
      input_artifacts: [ 'buildPackage' ],
    },{
      name: 'UAT_Deploy',
      category: 'Build',
      provider: 'CodeBuild',
      version: '1',
      owner: 'AWS',
      configuration: {
        ProjectName: '${aws_codebuild_project.platform_deploy_uat_deploy.name}',
      },
      input_artifacts: [ 'buildPackage' ],
    }],
  }],
)
