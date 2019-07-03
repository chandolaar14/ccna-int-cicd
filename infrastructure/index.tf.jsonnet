local subProjects = import '../subProjects.json';

local merge = import 'lib/merge.libsonnet';
local backend = import 'lib/backend.libsonnet';
local provider = import 'lib/provider.libsonnet';

local releaseBucket = import 'lib/releaseBucket.libsonnet';
local artifactStore = import 'lib/artifactStore.libsonnet';
local secretsManager = import 'lib/secretsManager.libsonnet';
local codeBuildRole = import 'lib/codeBuildRole.libsonnet';
local pipelineRole = import 'lib/pipelineRole.libsonnet';
local platformFailureAlert = import 'lib/platformFailureAlert.libsonnet';

local subProject = import 'lib/subProject.libsonnet';
local repository = import 'lib/repository.libsonnet';

merge([
  backend('infrastructure'),
  provider,
  releaseBucket,
  artifactStore,
  secretsManager,
  codeBuildRole,
  pipelineRole,
  platformFailureAlert,
] + [
  subProject(subProjectDefinition.title, subProjectDefinition.description, subProjectDefinition.stages)
  for subProjectDefinition in subProjects
  if std.objectHas(subProjectDefinition, 'stages')
] + [
  repository(subProjectDefinition.title, subProjectDefinition.description)
  for subProjectDefinition in subProjects
  if !std.objectHas(subProjectDefinition, 'stages')
])