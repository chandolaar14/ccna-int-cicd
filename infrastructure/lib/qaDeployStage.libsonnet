local settings = import '../../settings.json';
local buildImage = import 'buildImage.libsonnet';
local tags = import 'tags.libsonnet';

{
  resource: {
    aws_codebuild_project: {
      qa_deploy: {
        name: settings.instanceName + '-' + settings.projectName + '-qa-deploy',
        service_role: '${aws_iam_role.codebuild.arn}',
        environment: [{
          compute_type: 'BUILD_GENERAL1_SMALL',
          type: 'LINUX_CONTAINER',
          image: buildImage,
        }],
        source: [{
          type: 'CODEPIPELINE',
          buildspec: 'buildspec-qa-deploy.yml',
        }],
        artifacts: [{
          type: 'CODEPIPELINE',
        }],
        tags: tags(settings.instanceName + '-' + settings.projectName + '-qa-deploy'),
      },
    },
  },
}
