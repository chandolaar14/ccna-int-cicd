function(title)
local lowercase = std.asciiLower(title);
local key = std.strReplace(lowercase, ' ', '_');
local RepositoryName = '${aws_codecommit_repository.' + key + '.repository_name}';
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
