local merge = import 'lib/merge.libsonnet';
local backend = import 'lib/backend.libsonnet';
local provider = import 'lib/provider.libsonnet';

local releaseBucket = import 'lib/releaseBucket.libsonnet';
local artifactStore = import 'lib/artifactStore.libsonnet';
local platform = import 'lib/platform.libsonnet';
local instanceRepository = import 'lib/instanceRepository.libsonnet';
local testDataRepository = import 'lib/testDataRepository.libsonnet';
local instanceBuildStage = import 'lib/instanceBuildStage.libsonnet';
local checkmarxScanStage = import 'lib/checkmarxScanStage.libsonnet';
local qaPlanStage = import 'lib/qaPlanStage.libsonnet';
local qaDeployStage = import 'lib/qaDeployStage.libsonnet';
local testDataSyncStage = import 'lib/testDataSyncStage.libsonnet';
local secretsManager = import 'lib/secretsManager.libsonnet';
local codeBuildRole = import 'lib/codeBuildRole.libsonnet';
local pipelineRole = import 'lib/pipelineRole.libsonnet';
local instancePipeline = import 'lib/instancePipeline.libsonnet';
local testDataPipeline = import 'lib/testDataPipeline.libsonnet';
local platformFailureAlert = import 'lib/platformFailureAlert.libsonnet';

local demo = import 'lib/demo.libsonnet';

local uatPlanStage = import 'lib/uatPlanStage.libsonnet';
local uatDeployStage = import 'lib/uatDeployStage.libsonnet';
local prodPlanStage = import 'lib/prodPlanStage.libsonnet';
local prodDeployStage = import 'lib/prodDeployStage.libsonnet';

local transferServerRepository = import 'lib/transferServerRepository.libsonnet';
local transferServerDeployStage = import 'lib/transferServerDeployStage.libsonnet';
local transferServerPipeline = import 'lib/transferServerPipeline.libsonnet';

local platformDeploy = import 'lib/platformDeploy.libsonnet';

local migrationUtilsRepository = import 'lib/migrationUtilsRepository.libsonnet';


merge([
  backend('infrastructure'),
  provider,
  releaseBucket,
  artifactStore,
  instanceRepository,
  testDataRepository,
  instanceBuildStage,
  qaPlanStage,
  qaDeployStage,
  uatPlanStage,
  uatDeployStage,
  prodPlanStage,
  prodDeployStage,
  testDataSyncStage,
  checkmarxScanStage,
  secretsManager,
  codeBuildRole,
  instancePipeline,
  testDataPipeline,
  pipelineRole,
  platformFailureAlert,
  transferServerRepository,
  transferServerDeployStage,
  transferServerPipeline,
  migrationUtilsRepository,

  platform,
  demo,
  platformDeploy,
])