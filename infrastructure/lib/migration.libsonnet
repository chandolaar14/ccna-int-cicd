local merge = import 'merge.libsonnet';
local repository = import 'repository.libsonnet';
local pipeline = import 'pipeline.libsonnet';
local codebuild = import 'codebuild.libsonnet';
local approvalStage = import 'approvalStage.libsonnet';
local postBuildStage = import 'postBuildStage.libsonnet';
local buildStage = import 'buildStage.libsonnet';

local title = 'Migration';

merge([
  repository(title, 'Migration configuration'),
  pipeline(title,
    stages = [
      buildStage(title),
      postBuildStage(title, 'QA Plan'),
      postBuildStage(title, 'QA Deploy'),
      postBuildStage(title, 'UAT Plan'),
      approvalStage('UAT Approval'),
      postBuildStage(title, 'UAT Deploy'),
      postBuildStage(title, 'Prod Plan'),
      approvalStage('Prod Approval'),
      postBuildStage(title, 'Prod Deploy'),
    ],
  ),
  codebuild(title, 'Build'),
  codebuild(title, 'QA Plan'),
  codebuild(title, 'QA Deploy'),
  codebuild(title, 'UAT Plan'),
  codebuild(title, 'UAT Deploy'),
  codebuild(title, 'Prod Plan'),
  codebuild(title, 'Prod Deploy'),
])
