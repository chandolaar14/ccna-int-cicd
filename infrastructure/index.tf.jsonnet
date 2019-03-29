local merge = import 'lib/merge.libsonnet';
local backend = import 'lib/backend.libsonnet';
local provider = import 'lib/provider.libsonnet';

local artifactStore = import 'lib/artifactStore.libsonnet';
local repository = import 'lib/repository.libsonnet';
local buildStage = import 'lib/buildStage.libsonnet';
local buildRole = import 'lib/buildRole.libsonnet';
local pipelineRole = import 'lib/pipelineRole.libsonnet';
local pipeline = import 'lib/pipeline.libsonnet';

merge([
  backend('infrastructure'),
  provider,
  artifactStore,
  repository,
  buildStage,
  buildRole,
  pipeline,
  pipelineRole,
])