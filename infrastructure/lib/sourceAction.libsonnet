function(RepositoryName)
{
  name: 'Source',
  category: 'Source',
  provider: 'CodeCommit',
  version: '1',
  owner: 'AWS',
  configuration: {
    RepositoryName: RepositoryName,
    BranchName: 'master',
  },
  output_artifacts: [ 'source' ]
}
