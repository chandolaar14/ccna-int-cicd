local settings = import '../../settings.json';
local buildImage = import 'buildImage.libsonnet';

{
  resource: {
    aws_codebuild_project: {
      functional_test: {
        name: settings.projectName + '-functional-test',
        service_role: '${aws_iam_role.codebuild.arn}',
        environment: [{
          compute_type: 'BUILD_GENERAL1_SMALL',
          type: 'LINUX_CONTAINER',
          image: buildImage,
        }],
        source: [{
          type: 'CODEPIPELINE',
          buildspec: 'buildspec-functional-tests.yml',
        }],
        artifacts: [{
          type: 'CODEPIPELINE',
        }],
      },
    },
  },
}
