local settings = import '../../settings.json';
local snakeCase = import 'snakeCase.libsonnet';
local pascalCase = import 'pascalCase.libsonnet';

function(pipelineTitle, actionTitle, input = null, output = null)
local key = snakeCase(pipelineTitle + ' ' + actionTitle);
local ProjectName = '${aws_codebuild_project.' + key + '.name}';
{
  name: pascalCase(actionTitle),
  category: 'Build',
  provider: 'CodeBuild',
  version: '1',
  owner: 'AWS',
  configuration: {
	ProjectName: ProjectName,
  },
  [if input != null then 'input_artifacts']: [input],
  [if output != null then 'output_artifacts']: [output],
}
