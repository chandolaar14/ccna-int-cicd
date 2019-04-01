local resourceName = import 'resourceName.libsonnet';

{
  data: {
    aws_iam_policy_document: {
      pipeline: {
        statement: [{
          actions: [
            's3:GetObject',
            's3:GetObjectVersion',
            's3:GetBucketVersioning',
          ],
          resources: [
            '${aws_s3_bucket.artifact_store.arn}',
            '${aws_s3_bucket.artifact_store.arn}/*',
          ],
        },{
          actions: [
            'codebuild:BatchGetBuilds',
            'codebuild:StartBuild',
          ],
          resources: ['*'],
        },{
          actions: [
            'codecommit:Get*',
            'codecommit:*Archive*',
          ],
          resources: [
            '${aws_codecommit_repository.platform.arn}',
            '${aws_codecommit_repository.instance.arn}',
          ],
        },{
          actions: [
            's3:*',
          ],
          resources: [
            '${aws_s3_bucket.artifact_store.arn}',
            '${aws_s3_bucket.artifact_store.arn}/*',
          ],
        }],
      },
      pipeline_assume: {
        statement: [{
          actions: [ 'sts:AssumeRole' ],
          principals: [{
            type: 'Service',
            identifiers: [ 'codepipeline.amazonaws.com' ],
          }],
        }],
      },
    },
  },
  resource: {
    aws_iam_role: {
      pipeline: {
        name: resourceName('pipeline'),
        assume_role_policy: '${data.aws_iam_policy_document.pipeline_assume.json}',
      },
    },
    aws_iam_role_policy: {
      pipeline: {
        role: '${aws_iam_role.pipeline.id}',
        policy: '${data.aws_iam_policy_document.pipeline.json}',
      },
    },
  },
}
