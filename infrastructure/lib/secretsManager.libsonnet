local settings = import '../../settings.json';
local buildImage = import 'buildImage.libsonnet';
local tags = import 'tags.libsonnet';

{
  data: {
    aws_secretsmanager_secret: {
      "by-arn": {
        arn: 'arn:aws:secretsmanager:us-west-2:362550720160:secret:checkmarx-token-Kna7GY'
      }
    }
  }
}
