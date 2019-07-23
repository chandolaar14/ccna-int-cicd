local settings = import '../../settings.json';
local resourceName = import 'resourceName.libsonnet';
local tags = import 'tags.libsonnet';

{
  data: {
    aws_s3_bucket: {
      tfstate: {
        bucket: settings.tfState.bucket,
      },
    },
    aws_iam_policy_document: {
      codebuild: {
        statement: [{
          actions: [
            'secretsmanager:GetSecretValue',
          ],
          resources: [
            'arn:aws:secretsmanager:us-west-2:362550720160:secret:ccna-int-admin-api-key-NuYPlk',
          ],
        }, {
          actions: [
            'codecommit:Get*',
            'codecommit:List*',
            'codecommit:Git*',
          ],
          resources: [
            '${aws_codecommit_repository.platform.arn}',
            '${aws_codecommit_repository.platform.arn}/*',
            '${aws_codecommit_repository.metaschema_utils.arn}',
            '${aws_codecommit_repository.metaschema_utils.arn}/*',
          ],
        }, {
          actions: [
            'logs:CreateLogGroup',
            'logs:CreateLogStream',
            'logs:PutLogEvents',
          ],
          resources: ['*'],
        }, {
          // These are needed for connecting builds to a VPC
          actions: [
            'ec2:CreateNetworkInterface',
            'ec2:CreateNetworkInterfacePermission',
            'ec2:DescribeDhcpOptions',
            'ec2:DescribeNetworkInterfaces',
            'ec2:DeleteNetworkInterface',
            'ec2:DescribeSubnets',
            'ec2:DescribeSecurityGroups',
            'ec2:DescribeVpcs',
          ],
          resources: ['*'],
        }, {
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
          actions: [
            's3:*',
          ],
          resources: [
            'arn:aws:s3:::*' + settings.projectName + '*/*',
            'arn:aws:s3:::*' + settings.projectName + '*',
          ],
        }, {
          actions: [
            's3:*',
          ],
          resources: [
            '${aws_s3_bucket.release.arn}',
            '${aws_s3_bucket.release.arn}/*',
          ],
        }, {
          actions: [
            'secretsmanager:GetSecretValue',
          ],
          resources: [
            '${data.aws_secretsmanager_secret.by-arn.arn}',
          ],
        }, {
          actions: [
            'kms:*',
          ],
          resources: [
            'arn:aws:kms:us-west-2:362550720160:key/1f4dd8ef-3bca-4f5e-aaae-c039ee3a8cfd',
            'arn:aws:kms:us-east-1:362550720160:key/3d718e09-819b-4331-9795-2cc633526354',
          ],
        }] + (
          if std.length(settings.assumableRoles) == 0
          then []
          else [{
            actions: ['sts:AssumeRole'],
            resources: settings.assumableRoles,
          }]
        ),
      },
      codebuild_assume: {
        statement: [{
          actions: ['sts:AssumeRole'],
          principals: [{
            type: 'Service',
            identifiers: ['codebuild.amazonaws.com'],
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
        tags: tags(resourceName('codebuild')),
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
