local settings = import '../../settings.json';
local buildImage = import 'buildImage.libsonnet';
local tags = import 'tags.libsonnet';

{
  resource: {
    aws_secretsmanager_secret: {
      checkmarx_token: {
        name: 'checkmarx_token'
      }
    }
  }
}