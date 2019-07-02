local buildImage = import 'buildImage.libsonnet';
local tags = import 'tags.libsonnet';
local settings = import '../../settings.json';
local pipeCase = import 'pipeCase.libsonnet';
local snakeCase = import 'snakeCase.libsonnet';

function(pipelineTitle, actionTitle)
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
          compute_type: 'BUILD_GENERAL1_SMALL',
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
