function(name, ProjectName, input_artifact = null, output_artifact = null, category = 'Build')
{
  name: name,
  category: category,
  provider: 'CodeBuild',
  version: '1',
  owner: 'AWS',
  configuration: {
	ProjectName: ProjectName,
  },
  [if input_artifact != null then 'input_artifacts']: [input_artifact],
  [if output_artifact != null then 'output_artifacts']: [output_artifact],
}
