local merge = import 'lib/merge.libsonnet';
local backend = import 'lib/backend.libsonnet';
local provider = import 'lib/provider.libsonnet';

local releaseBucket = import 'lib/releaseBucket.libsonnet';
local artifactStore = import 'lib/artifactStore.libsonnet';
local platformRepository = import 'lib/platformRepository.libsonnet';
local instanceRepository = import 'lib/instanceRepository.libsonnet';
local buildStage = import 'lib/buildStage.libsonnet';
local instanceBuildStage = import 'lib/instanceBuildStage.libsonnet';
local deliverStage = import 'lib/deliverStage.libsonnet';
local qaPlanStage = import 'lib/qaPlanStage.libsonnet';
local qaDeployStage = import 'lib/qaDeployStage.libsonnet';
local functionalTestStage = import 'lib/functionalTestStage.libsonnet';
local codeBuildRole = import 'lib/codeBuildRole.libsonnet';
local pipelineRole = import 'lib/pipelineRole.libsonnet';
local platformPipeline = import 'lib/platformPipeline.libsonnet';
local instancePipeline = import 'lib/instancePipeline.libsonnet';
local platformFailureAlert = import 'lib/platformFailureAlert.libsonnet';

merge([
  backend('infrastructure'),
  provider,
  releaseBucket,
  artifactStore,
  platformRepository,
  instanceRepository,
  buildStage,
  instanceBuildStage,
  deliverStage,
  qaPlanStage,
  qaDeployStage,
  functionalTestStage,
  codeBuildRole,
  platformPipeline,
  instancePipeline,
  pipelineRole,
  platformFailureAlert,
])