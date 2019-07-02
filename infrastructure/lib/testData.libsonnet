local merge = import 'merge.libsonnet';
local repository = import 'repository.libsonnet';
local pipeline = import 'pipeline.libsonnet';
local codebuild = import 'codebuild.libsonnet';
local singleActionStage = import 'singleActionStage.libsonnet';
local sourceStage = import 'sourceStage.libsonnet';

local title = 'Test Data';

merge([
  repository(title, 'Data for Platform and Migration testing'),
  pipeline(title,
    stages = [
      sourceStage(title),
      singleActionStage(title, 'Sync', input = 'source'),
    ],
  ),
  codebuild(title, 'Sync'),
])
