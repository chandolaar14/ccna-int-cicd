local resourceName = import 'resourceName.libsonnet';
local settings = import '../../settings.json';

{
  data: {
    aws_s3_bucket: {
      tfstate: {
        bucket: 'tfstate.aws.beauknowssoftware.com',
      },
    },
    aws_iam_policy_document: {
      codebuild: {
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
        }, {
          actions: [
            's3:ListBucket',
            's3:GetObject',
            's3:PutObject',
          ],
          resources: [
            '${data.aws_s3_bucket.tfstate.arn}',
            '${data.aws_s3_bucket.tfstate.arn}/*',
          ],
        }, {
          actions: [ 'sts:AssumeRole' ],
          resources: settings.assumableRoles,
        }],
      },
      codebuild_assume: {
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
      codebuild: {
        name: resourceName('codebuild'),
        assume_role_policy: '${data.aws_iam_policy_document.codebuild_assume.json}',
      },
    },
    aws_iam_role_policy: {
      codebuild: {
        role: '${aws_iam_role.codebuild.id}',
        policy: '${data.aws_iam_policy_document.codebuild.json}',
      },
    },
  },
}
