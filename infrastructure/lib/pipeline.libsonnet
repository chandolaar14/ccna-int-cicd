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
              ProjectName: 'test',
            },
            input_artifacts: [ 'source' ]
          }],
        }],
      },
    },
  },
}
