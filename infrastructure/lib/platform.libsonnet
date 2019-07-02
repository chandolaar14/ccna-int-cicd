local merge = import 'merge.libsonnet';
local repository = import 'repository.libsonnet';
local pipeline = import 'pipeline.libsonnet';
local codebuild = import 'codebuild.libsonnet';
local singleActionStage = import 'singleActionStage.libsonnet';
local actionStage = import 'actionStage.libsonnet';
local postBuildAction = import 'postBuildAction.libsonnet';
local sourceStage = import 'sourceStage.libsonnet';
local buildStage = import 'buildStage.libsonnet';

local title = 'Platform';

merge([
  repository(title, 'Platform code'),
  pipeline(title,
    stages = [
      sourceStage(title),
      buildStage(title),
      actionStage(title, 'Test', [
        postBuildAction('Functional Tests'),
        postBuildAction('Metaschema Tests'),
        postBuildAction('Performance Tests'),
        postBuildAction('Checkmarx Scan'),
      ]),
      singleActionStage(title, 'Tag', input = 'buildPackage', output = 'versionedPackage'),
      singleActionStage(title, 'Deliver', input = 'versionedPackage'),
    ],
  ),
  codebuild(title, 'Build'),
  codebuild(title, 'Metaschema Tests'),
  codebuild(title, 'Functional Tests'),
  codebuild(title, 'Performance Tests'),
  codebuild(title, 'Checkmarx Scan'),
  codebuild(title, 'Tag'),
  codebuild(title, 'Deliver'),
])
