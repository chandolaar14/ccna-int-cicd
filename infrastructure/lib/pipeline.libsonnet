local settings = import '../../settings.json';
local tags = import 'tags.libsonnet';

function(key, name, stages)
  {
    resource: {
      aws_codepipeline: {
        [key]: {
          name: name,

          role_arn: '${aws_iam_role.pipeline.arn}',

          artifact_store: {
            type: 'S3',
            location: '${aws_s3_bucket.artifact_store.bucket}',
          },

          stage: stages,
          tags: tags(name),
        },
      },
    },
  }
