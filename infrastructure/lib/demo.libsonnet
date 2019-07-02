local merge = import 'merge.libsonnet';
local repository = import 'repository.libsonnet';
local pipeline = import 'pipeline.libsonnet';
local codebuild = import 'codebuild.libsonnet';
local approvalStage = import 'approvalStage.libsonnet';
local postBuildStage = import 'postBuildStage.libsonnet';
local sourceStage = import 'sourceStage.libsonnet';
local buildStage = import 'buildStage.libsonnet';

local title = 'Demo';

merge([
  repository(title, 'Configuration and deployment of a demo environment'),
  pipeline(title,
    stages = [
      sourceStage(title),
      buildStage(title),
      postBuildStage(title, 'Plan'),
      approvalStage(),
      postBuildStage(title, 'Deploy'),
    ],
  ),
  codebuild(title, 'Build'),
  codebuild(title, 'Plan'),
  codebuild(title, 'Deploy'),
])
