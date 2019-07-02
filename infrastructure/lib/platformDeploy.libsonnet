local merge = import 'merge.libsonnet';
local repository = import 'repository.libsonnet';
local pipeline = import 'pipeline.libsonnet';
local codebuild = import 'codebuild.libsonnet';
local pipelineAction = import 'pipelineAction.libsonnet';
local sourceAction = import 'sourceAction.libsonnet';
local approvalAction = import 'approvalAction.libsonnet';
local settings = import '../../settings.json';

merge([
  repository(
    key = 'platform_deploy',
    name = settings.projectName + '-platform-deploy',
    desc = 'This is the platform-deploy repository for the ' + settings.projectName + " project.",
  ),
  pipeline(
    key = 'platform_deploy',
    name = settings.projectName + '-platform-deploy',
    stages = [{
      name: 'Source',
      action: [
        sourceAction('${aws_codecommit_repository.platform_deploy.repository_name}'),
      ],
    },{
      name: 'Build',
      action: [
        pipelineAction('Build', '${aws_codebuild_project.platform_deploy_build.name}', 'source', 'buildPackage'),
      ],
    },{
      name: 'Plan',
      action: [
        pipelineAction('QA_Plan', '${aws_codebuild_project.platform_deploy_qa_plan.name}', 'buildPackage'),
        pipelineAction('UAT_Plan', '${aws_codebuild_project.platform_deploy_uat_plan.name}', 'buildPackage'),
      ],
    },{
      name: 'Approval',
      action: [
        approvalAction('Approval'),
      ],
    },{
      name: 'Deploy',
      action: [
        pipelineAction('QA_Deploy', '${aws_codebuild_project.platform_deploy_qa_deploy.name}', 'buildPackage'),
        pipelineAction('UAT_Deploy', '${aws_codebuild_project.platform_deploy_uat_deploy.name}', 'buildPackage'),
      ],
    }],
  ),
  codebuild('platform_deploy_build', settings.projectName + '-platform-deploy-build', 'buildspec-build.yml'),
  codebuild('platform_deploy_qa_plan', settings.projectName + '-platform-deploy-qa-plan', 'buildspec-qa-plan.yml'),
  codebuild('platform_deploy_uat_plan', settings.projectName + '-platform-deploy-uat-plan', 'buildspec-uat-plan.yml'),
  codebuild('platform_deploy_qa_deploy', settings.projectName + '-platform-deploy-qa-deploy', 'buildspec-qa-deploy.yml'),
  codebuild('platform_deploy_uat_deploy', settings.projectName + '-platform-deploy-uat-deploy', 'buildspec-uat-deploy.yml'),
])
