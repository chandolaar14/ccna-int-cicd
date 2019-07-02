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
    key = 'demo',
    name = settings.demoEnvName + '-' + settings.projectName,
    desc = 'This is the demo repository for the ' + settings.projectName + " project.",
  ),
  pipeline(
    key = 'demo',
    name = settings.demoEnvName + '-' + settings.projectName,
    stages = [{
      name: 'Source',
      action: [
        sourceAction('${aws_codecommit_repository.demo.repository_name}'),
      ],
    },{
      name: 'Build',
      action: [
        pipelineAction('Build', '${aws_codebuild_project.demo_build.name}', 'source', 'buildPackage'),
      ],
    },{
      name: 'Demo_Plan',
      action: [
        pipelineAction('Demo_Plan', '${aws_codebuild_project.demo_plan.name}', 'buildPackage'),
      ],
    },{
      name: 'Demo_Approval',
      action: [
        approvalAction('Demo_Approval'),
      ],
    },{
      name: 'Demo_Deploy',
      action: [
        pipelineAction('Demo_Deploy', '${aws_codebuild_project.demo_deploy.name}', 'buildPackage'),
      ],
    }],
  ),
  codebuild('demo_build', 'demo-' + settings.projectName + '-build', 'buildspec-build.yml'),
  codebuild('demo_plan', 'demo-' + settings.projectName + '-demo-plan', 'buildspec-demo-plan.yml'),
  codebuild('demo_deploy', 'demo-' + settings.projectName + '-demo-deploy', 'buildspec-demo-deploy.yml'),
])
