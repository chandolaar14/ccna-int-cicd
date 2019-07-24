local settings = import '../../settings.json';
local buildImage = import 'buildImage.libsonnet';
local pipeCase = import 'pipeCase.libsonnet';
local snakeCase = import 'snakeCase.libsonnet';
local tags = import 'tags.libsonnet';

function(pipelineTitle, actionTitle, computeType='BUILD_GENERAL1_SMALL')
  local combined = pipelineTitle + ' ' + actionTitle;
  local key = snakeCase(combined);
  local name = pipeCase(settings.projectName + ' ' + combined);
  local buildspec = 'buildspec-' + pipeCase(actionTitle) + '.yml';
  {
    resource: {
      aws_codebuild_project: {
        [key]: {
          name: name,
          service_role: '${aws_iam_role.codebuild.arn}',
          environment: [{
            compute_type: computeType,
            type: 'LINUX_CONTAINER',
            image: buildImage,
          }],
          source: [{
            type: 'CODEPIPELINE',
            buildspec: buildspec,
          }],
          artifacts: [{
            type: 'CODEPIPELINE',
          }],
          tags: tags(name),
        },
      },
    },
  }
