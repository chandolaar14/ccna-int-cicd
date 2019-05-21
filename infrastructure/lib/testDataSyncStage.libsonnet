local settings = import '../../settings.json';
local buildImage = import 'buildImage.libsonnet';
local tags = import 'tags.libsonnet';

{
  resource: {
    aws_codebuild_project: {
      test_data_sync: {
        name: 'test-data-' + settings.projectName + '-sync',
        service_role: '${aws_iam_role.codebuild.arn}',
        environment: [{
          compute_type: 'BUILD_GENERAL1_SMALL',
          type: 'LINUX_CONTAINER',
          image: buildImage,
        }],
        source: [{
          type: 'CODEPIPELINE',
          buildspec: 'buildspec-sync.yml',
        }],
        artifacts: [{
          type: 'CODEPIPELINE',
        }],
        tags: tags('test-data-' + settings.projectName + '-sync'),
      },
    },
  },
}
