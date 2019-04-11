local resourceName = import 'resourceName.libsonnet';

{
  resource: {
    aws_sns_topic: {
      platform_failure: {
        name: resourceName('failure'),
      },
    },
  },
}
