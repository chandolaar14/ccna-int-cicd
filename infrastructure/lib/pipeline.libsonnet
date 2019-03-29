local settings = import '../../settings.json';

{
  resource: {
    aws_codepipeline: {
      pipeline: {
        name: settings.projectName,

        role_arn: '${aws_iam_role.pipeline.arn}',

        artifact_store: {
          type: 'S3',
          location: '${aws_s3_bucket.artifact_store.bucket}',
        },

        stage: [{
          name: 'Source',
          action: [{
            name: 'Source',
            category: 'Source',
            provider: 'CodeCommit',
            version: '1',
            owner: 'AWS',
            configuration: {
              RepositoryName: '${aws_codecommit_repository.code.repository_name}',
              BranchName: 'master',
            },
            output_artifacts: [ 'source' ]
          }],
        },{
          name: 'Build',
          action: [{
            name: 'Build',
            category: 'Build',
            provider: 'CodeBuild',
            version: '1',
            owner: 'AWS',
            configuration: {
              ProjectName: '${aws_codebuild_project.build.name}',
            },
            input_artifacts: [ 'source' ],
            output_artifacts: [ 'buildPackage' ],
          }],
        },{
          name: 'Test',
          action: [{
            name: 'Functional',
            category: 'Test',
            provider: 'CodeBuild',
            version: '1',
            owner: 'AWS',
            configuration: {
              ProjectName: '${aws_codebuild_project.functional_test.name}',
            },
            input_artifacts: [ 'buildPackage' ],
          }],
        }],
      },
    },
  },
}
