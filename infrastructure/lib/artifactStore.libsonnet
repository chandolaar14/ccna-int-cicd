local bucketName = import 'bucketName.libsonnet';

{
  resource: {
    aws_s3_bucket: {
      artifact_store: {
        bucket: bucketName('artifact-store'),
        acl: 'private',
      },
    },
  },
}
