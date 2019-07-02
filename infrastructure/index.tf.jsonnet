local merge = import 'lib/merge.libsonnet';
local backend = import 'lib/backend.libsonnet';
local provider = import 'lib/provider.libsonnet';

local releaseBucket = import 'lib/releaseBucket.libsonnet';
local artifactStore = import 'lib/artifactStore.libsonnet';
local secretsManager = import 'lib/secretsManager.libsonnet';
local codeBuildRole = import 'lib/codeBuildRole.libsonnet';
local pipelineRole = import 'lib/pipelineRole.libsonnet';
local platformFailureAlert = import 'lib/platformFailureAlert.libsonnet';
local transferServerRepository = import 'lib/transferServerRepository.libsonnet';
local transferServerDeployStage = import 'lib/transferServerDeployStage.libsonnet';
local transferServerPipeline = import 'lib/transferServerPipeline.libsonnet';
local migrationUtilsRepository = import 'lib/migrationUtilsRepository.libsonnet';

local demo = import 'lib/demo.libsonnet';
local instance = import 'lib/instance.libsonnet';
local platform = import 'lib/platform.libsonnet';
local platformDeploy = import 'lib/platformDeploy.libsonnet';
local testData = import 'lib/testData.libsonnet';

merge([
  backend('infrastructure'),
  provider,
  releaseBucket,
  artifactStore,
  secretsManager,
  codeBuildRole,
  pipelineRole,
  platformFailureAlert,
  transferServerRepository,
  transferServerDeployStage,
  transferServerPipeline,
  migrationUtilsRepository,

  demo,
  instance,
  platform,
  platformDeploy,
  testData,
])