local settings = import '../../settings.json';

{
  resource: {
    aws_codebuild_project: {
      build: {
        name: settings.projectName + '-build',
        service_role: '${aws_iam_role.build.arn}',
        environment: [{
          compute_type: 'BUILD_GENERAL1_SMALL',
          type: 'LINUX_CONTAINER',
          image: 'beauknowssoftware/builder:1.0.2',
        }],
        source: [{
          type: 'CODEPIPELINE',
        }],
        artifacts: [{
          type: 'CODEPIPELINE',
        }],
      },
    },
  },
}
