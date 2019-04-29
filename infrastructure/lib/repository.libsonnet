function(key, name, desc)
  {
    resource: {
      aws_codecommit_repository: {
        [key]: {
          repository_name: name,
          default_branch: 'master',
          description: desc,
        },
      },
    },
  }
