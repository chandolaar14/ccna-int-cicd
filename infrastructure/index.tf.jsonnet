local pipelines = import '../pipelines.json';

local merge = import 'lib/merge.libsonnet';
local backend = import 'lib/backend.libsonnet';
local provider = import 'lib/provider.libsonnet';

local releaseBucket = import 'lib/releaseBucket.libsonnet';
local artifactStore = import 'lib/artifactStore.libsonnet';
local secretsManager = import 'lib/secretsManager.libsonnet';
local codeBuildRole = import 'lib/codeBuildRole.libsonnet';
local pipelineRole = import 'lib/pipelineRole.libsonnet';
local platformFailureAlert = import 'lib/platformFailureAlert.libsonnet';
local migrationUtilsRepository = import 'lib/migrationUtilsRepository.libsonnet';

local subProject = import 'lib/subProject.libsonnet';

merge([
  backend('infrastructure'),
  provider,
  releaseBucket,
  artifactStore,
  secretsManager,
  codeBuildRole,
  pipelineRole,
  platformFailureAlert,
  migrationUtilsRepository,
] + [
  subProject(pipeline.title, pipeline.description, pipeline.stages)
  for pipeline in pipelines
])