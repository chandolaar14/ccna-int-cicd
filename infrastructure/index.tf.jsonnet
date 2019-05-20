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
local metaschemaTestStage = import 'lib/metaschemaTestStage.libsonnet';
local performanceTestStage = import 'lib/performanceTestStage.libsonnet';
local codeBuildRole = import 'lib/codeBuildRole.libsonnet';
local pipelineRole = import 'lib/pipelineRole.libsonnet';
local platformPipeline = import 'lib/platformPipeline.libsonnet';
local instancePipeline = import 'lib/instancePipeline.libsonnet';
local testDataPipeline = import 'lib/testDataPipeline.libsonnet';
local platformFailureAlert = import 'lib/platformFailureAlert.libsonnet';

local demoRepository = import 'lib/demoRepository.libsonnet';
local demoBuildStage = import 'lib/demoBuildStage.libsonnet';
local demoPlanStage = import 'lib/demoPlanStage.libsonnet';
local demoDeployStage = import 'lib/demoDeployStage.libsonnet';
local demoPipeline = import 'lib/demoPipeline.libsonnet';
local uatPlanStage = import 'lib/uatPlanStage.libsonnet';
local uatDeployStage = import 'lib/uatDeployStage.libsonnet';
local prodPlanStage = import 'lib/prodPlanStage.libsonnet';
local prodDeployStage = import 'lib/prodDeployStage.libsonnet';

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
  uatPlanStage,
  uatDeployStage,
  prodPlanStage,
  prodDeployStage,
  testDataSyncStage,
  functionalTestStage,
  metaschemaTestStage,
  performanceTestStage,
  codeBuildRole,
  platformPipeline,
  instancePipeline,
  testDataPipeline,
  pipelineRole,
  platformFailureAlert,
  demoRepository,
  demoBuildStage,
  demoPlanStage,
  demoDeployStage,
  demoPipeline,
])