local settings = import '../../settings.json';
local buildImage = import 'buildImage.libsonnet';

{
  resource: {
    aws_codebuild_project: {
      qa_plan: {
        name: settings.instanceName + '-' + settings.projectName + '-qa-plan',
        service_role: '${aws_iam_role.codebuild.arn}',
        environment: [{
          compute_type: 'BUILD_GENERAL1_SMALL',
          type: 'LINUX_CONTAINER',
          image: buildImage,
        }],
        source: [{
          type: 'CODEPIPELINE',
          buildspec: 'buildspec-qa-plan.yml',
        }],
        artifacts: [{
          type: 'CODEPIPELINE',
        }],
      },
    },
  },
}
