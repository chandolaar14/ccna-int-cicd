local merge = import 'merge.libsonnet';
local repository = import 'repository.libsonnet';
local pipeline = import 'pipeline.libsonnet';
local codebuild = import 'codebuild.libsonnet';
local approvalStage = import 'approvalStage.libsonnet';
local singleActionStage = import 'singleActionStage.libsonnet';
local postBuildAction = import 'postBuildAction.libsonnet';
local actionStage = import 'actionStage.libsonnet';
local buildStage = import 'buildStage.libsonnet';

local title = 'Platform Deploy';

merge([
  repository(title, 'Migration Platform Deploy Configuration'),
  pipeline(title,
    stages = [
      buildStage(title),
      actionStage(title, 'Plan', [
        postBuildAction('QA Plan'),
        postBuildAction('UAT Plan'),
      ]),
      approvalStage(),
      actionStage(title, 'Deploy', [
        postBuildAction('QA Deploy'),
        postBuildAction('UAT Deploy'),
      ]),
    ],
  ),
  codebuild(title, 'Build'),
  codebuild(title, 'QA Plan'),
  codebuild(title, 'UAT Plan'),
  codebuild(title, 'QA Deploy'),
  codebuild(title, 'UAT Deploy'),
])
