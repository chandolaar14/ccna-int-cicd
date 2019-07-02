local buildImage = import 'buildImage.libsonnet';
local tags = import 'tags.libsonnet';
local settings = import '../../settings.json';

function(pipelineTitle, actionTitle)
local combined = pipelineTitle + ' ' + actionTitle;
local lowercase = std.asciiLower(combined);
local key = std.strReplace(lowercase, ' ', '_');
local suffix = std.strReplace(lowercase, ' ', '-');
local name = settings.projectName + '-' + suffix;
local buildspec = 'buildspec-' + suffix + '.yml';
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
