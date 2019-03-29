local settings = import '../../settings.json';

{
  resource: {
    aws_codecommit_repository: {
      code: {
        repository_name: settings.projectName,
        default_branch: 'master',
      },
    },
  },
}
