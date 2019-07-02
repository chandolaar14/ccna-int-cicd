local merge = import 'merge.libsonnet';
local repository = import 'repository.libsonnet';
local pipeline = import 'pipeline.libsonnet';
local codebuild = import 'codebuild.libsonnet';
local singleActionStage = import 'singleActionStage.libsonnet';

local title = 'Transfer Server';

merge([
  repository(title, 'AWS Transfer Server for Platform and Migration testing'),
  pipeline(title,
    stages = [
      singleActionStage(title, 'Deploy', input = 'source'),
    ],
  ),
  codebuild(title, 'Deploy'),
])
