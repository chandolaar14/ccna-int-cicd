local settings = import '../../settings.json';

{
  resource: {
    aws_codebuild_project: {
      deliver: {
        name: settings.projectName + '-deliver',
        service_role: '${aws_iam_role.codebuild.arn}',
        environment: [{
          compute_type: 'BUILD_GENERAL1_SMALL',
          type: 'LINUX_CONTAINER',
          image: 'beauknowssoftware/builder:1.0.2',
        }],
        source: [{
          type: 'CODEPIPELINE',
          buildspec: 'buildspec-deliver.yml',
        }],
        artifacts: [{
          type: 'CODEPIPELINE',
        }],
      },
    },
  },
}
