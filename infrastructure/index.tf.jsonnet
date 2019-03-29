local merge = import 'lib/merge.libsonnet';
local backend = import 'lib/backend.libsonnet';
local provider = import 'lib/provider.libsonnet';

local artifactStore = import 'lib/artifactStore.libsonnet';
local repository = import 'lib/repository.libsonnet';
local buildStage = import 'lib/buildStage.libsonnet';
local functionalTestStage = import 'lib/functionalTestStage.libsonnet';
local codeBuildRole = import 'lib/codeBuildRole.libsonnet';
local pipelineRole = import 'lib/pipelineRole.libsonnet';
local pipeline = import 'lib/pipeline.libsonnet';

merge([
  backend('infrastructure'),
  provider,
  artifactStore,
  repository,
  buildStage,
  functionalTestStage,
  codeBuildRole,
  pipeline,
  pipelineRole,
])