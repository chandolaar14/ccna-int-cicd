local settings = import '../../settings.json';
local buildImage = import 'buildImage.libsonnet';

{
  resource: {
    aws_codebuild_project: {
      uat_plan: {
        name: settings.instanceName + '-' + settings.projectName + '-uat-plan',
        service_role: '${aws_iam_role.codebuild.arn}',
        environment: [{
          compute_type: 'BUILD_GENERAL1_SMALL',
          type: 'LINUX_CONTAINER',
          image: buildImage,
        }],
        source: [{
          type: 'CODEPIPELINE',
          buildspec: 'buildspec-uat-plan.yml',
        }],
        artifacts: [{
          type: 'CODEPIPELINE',
        }],
      },
    },
  },
}
