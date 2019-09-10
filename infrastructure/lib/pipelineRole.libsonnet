local resourceName = import 'resourceName.libsonnet';
local tags = import 'tags.libsonnet';

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
        }, {
          actions: [
            'codebuild:BatchGetBuilds',
            'codebuild:StartBuild',
            'codepipeline:StartPipelineExecution',
          ],
          resources: ['*'],
        }, {
          actions: [
            'codecommit:Get*',
            'codecommit:*Archive*',
          ],
          resources: [
            '*',
          ],
        }, {
          actions: [
            's3:*',
          ],
          resources: [
            '${aws_s3_bucket.artifact_store.arn}',
            '${aws_s3_bucket.artifact_store.arn}/*',
            '${aws_s3_bucket.release.arn}',
            '${aws_s3_bucket.release.arn}/*',
          ],
        }],
      },
      pipeline_assume: {
        statement: [{
          actions: ['sts:AssumeRole'],
          principals: [{
            type: 'Service',
            identifiers: [
              'codepipeline.amazonaws.com',
              'events.amazonaws.com',
            ],
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
        tags: tags(resourceName('pipeline')),
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
