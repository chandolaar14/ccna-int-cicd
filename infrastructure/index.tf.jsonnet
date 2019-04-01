local merge = import 'lib/merge.libsonnet';
local backend = import 'lib/backend.libsonnet';
local provider = import 'lib/provider.libsonnet';

local artifactStore = import 'lib/artifactStore.libsonnet';
local platformRepository = import 'lib/platformRepository.libsonnet';
local instanceRepository = import 'lib/instanceRepository.libsonnet';
local buildStage = import 'lib/buildStage.libsonnet';
local qaStage = import 'lib/qaStage.libsonnet';
local functionalTestStage = import 'lib/functionalTestStage.libsonnet';
local codeBuildRole = import 'lib/codeBuildRole.libsonnet';
local pipelineRole = import 'lib/pipelineRole.libsonnet';
local platformPipeline = import 'lib/platformPipeline.libsonnet';
local instancePipeline = import 'lib/instancePipeline.libsonnet';

merge([
  backend('infrastructure'),
  provider,
  artifactStore,
  platformRepository,
  instanceRepository,
  buildStage,
  qaStage,
  functionalTestStage,
  codeBuildRole,
  platformPipeline,
  instancePipeline,
  pipelineRole,
])