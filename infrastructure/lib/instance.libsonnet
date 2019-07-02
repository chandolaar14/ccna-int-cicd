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
    key = 'instance',
    name = settings.instanceName + '-' + settings.projectName,
    desc = 'This is the instance repository for the ' + settings.projectName + " project.",
  ),
  pipeline(
    key = 'instance',
    name = settings.instanceName + '-' + settings.projectName,
    stages = [{
      name: 'Source',
      action: [
        sourceAction('${aws_codecommit_repository.instance.repository_name}'),
      ],
    },{
      name: 'Build',
      action: [
        pipelineAction('Build', '${aws_codebuild_project.instance_build.name}', 'source', 'buildPackage'),
      ],
    },{
      name: 'QA_Plan',
      action: [
        pipelineAction('QA_Plan', '${aws_codebuild_project.qa_plan.name}', 'buildPackage'),
      ],
    },{
      name: 'QA_Deploy',
      action: [
        pipelineAction('QA_Deploy', '${aws_codebuild_project.qa_deploy.name}', 'buildPackage'),
      ],
    },{
      name: 'UAT_Plan',
      action: [
        pipelineAction('UAT_Plan', '${aws_codebuild_project.uat_plan.name}', 'buildPackage'),
      ],
    },{
      name: 'UAT_Approval',
      action: [
        approvalAction('UAT_Approval'),
      ],
    },{
      name: 'UAT_Deploy',
      action: [
        pipelineAction('UAT_Deploy', '${aws_codebuild_project.uat_deploy.name}', 'buildPackage'),
      ],
    },{
      name: 'Prod_Plan_Stage',
      action: [
        pipelineAction('Prod_Plan_Action', '${aws_codebuild_project.prod_plan.name}', 'buildPackage'),
      ],
    },{
      name: 'Prod_Approval_Stage',
      action: [
        approvalAction('Prod_Approval_Action'),
      ],
    },{
      name: 'Prod_Deploy_Stage',
      action: [
        pipelineAction('Prod_Deploy_Action', '${aws_codebuild_project.prod_deploy.name}', 'buildPackage'),
      ],
    }],
  ),
  codebuild('instance_build', settings.instanceName + '-' + settings.projectName + '-build', 'buildspec-build.yml'),
  codebuild('qa_plan', settings.instanceName + '-' + settings.projectName + '-qa-plan', 'buildspec-qa-plan.yml'),
  codebuild('qa_deploy', settings.instanceName + '-' + settings.projectName + '-qa-deploy', 'buildspec-qa-deploy.yml'),
  codebuild('uat_plan', settings.instanceName + '-' + settings.projectName + '-uat-plan', 'buildspec-uat-plan.yml'),
  codebuild('uat_deploy', settings.instanceName + '-' + settings.projectName + '-uat-deploy', 'buildspec-uat-deploy.yml'),
  codebuild('prod_plan', settings.instanceName + '-' + settings.projectName + '-prod-plan', 'buildspec-prod-plan.yml'),
  codebuild('prod_deploy', settings.instanceName + '-' + settings.projectName + '-prod-deploy', 'buildspec-prod-deploy.yml'),
])
