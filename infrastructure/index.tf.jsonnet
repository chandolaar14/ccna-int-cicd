local merge = import 'lib/merge.libsonnet';
local backend = import 'lib/backend.libsonnet';
local provider = import 'lib/provider.libsonnet';

local releaseBucket = import 'lib/releaseBucket.libsonnet';
local artifactStore = import 'lib/artifactStore.libsonnet';
local platformRepository = import 'lib/platformRepository.libsonnet';
local instanceRepository = import 'lib/instanceRepository.libsonnet';
local testDataRepository = import 'lib/testDataRepository.libsonnet';
local buildStage = import 'lib/buildStage.libsonnet';
local instanceBuildStage = import 'lib/instanceBuildStage.libsonnet';
local deliverStage = import 'lib/deliverStage.libsonnet';
local qaPlanStage = import 'lib/qaPlanStage.libsonnet';
local qaDeployStage = import 'lib/qaDeployStage.libsonnet';
local testDataSyncStage = import 'lib/testDataSyncStage.libsonnet';
local functionalTestStage = import 'lib/functionalTestStage.libsonnet';
local codeBuildRole = import 'lib/codeBuildRole.libsonnet';
local pipelineRole = import 'lib/pipelineRole.libsonnet';
local platformPipeline = import 'lib/platformPipeline.libsonnet';
local instancePipeline = import 'lib/instancePipeline.libsonnet';
local testDataPipeline = import 'lib/testDataPipeline.libsonnet';
local platformFailureAlert = import 'lib/platformFailureAlert.libsonnet';

merge([
  backend('infrastructure'),
  provider,
  releaseBucket,
  artifactStore,
  platformRepository,
  instanceRepository,
  testDataRepository,
  buildStage,
  instanceBuildStage,
  deliverStage,
  qaPlanStage,
  qaDeployStage,
  testDataSyncStage,
  functionalTestStage,
  codeBuildRole,
  platformPipeline,
  instancePipeline,
  testDataPipeline,
  pipelineRole,
  platformFailureAlert,
])