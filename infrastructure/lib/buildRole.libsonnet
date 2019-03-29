local resourceName = import 'resourceName.libsonnet';

{
  data: {
    aws_iam_policy_document: {
      build: {
        statement: [{
          actions: [
            'logs:CreateLogGroup',
            'logs:CreateLogStream',
            'logs:PutLogEvents',
          ],
          resources: ['*'],
        },{
          actions: [
            's3:PutObject',
            's3:GetObject',
            's3:GetObjectVersion',
          ],
          resources: [
            '${aws_s3_bucket.artifact_store.arn}/*',
          ],
        }],
      },
      build_assume: {
        statement: [{
          actions: [ 'sts:AssumeRole' ],
          principals: [{
            type: 'Service',
            identifiers: [ 'codebuild.amazonaws.com' ],
          }],
        }],
      },
    },
  },
  resource: {
    aws_iam_role: {
      build: {
        name: resourceName('build'),
        assume_role_policy: '${data.aws_iam_policy_document.build_assume.json}',
      },
    },
    aws_iam_role_policy: {
      build: {
        role: '${aws_iam_role.build.id}',
        policy: '${data.aws_iam_policy_document.build.json}',
      },
    },
  },
}
