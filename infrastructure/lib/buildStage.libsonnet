local settings = import '../../settings.json';
local buildImage = import 'buildImage.libsonnet';
local tags = import 'tags.libsonnet';

{
  resource: {
    aws_codebuild_project: {
      build: {
        name: settings.projectName + '-build',
        service_role: '${aws_iam_role.codebuild.arn}',
        environment: [{
          compute_type: 'BUILD_GENERAL1_SMALL',
          type: 'LINUX_CONTAINER',
          image: buildImage,
        }],
        source: [{
          type: 'CODEPIPELINE',
          buildspec: 'buildspec-build.yml',
        }],
        artifacts: [{
          type: 'CODEPIPELINE',
        }],
        tags: tags(settings.projectName + '-build'),
      },
    },
  },
}
