local settings = import '../../settings.json';

function(pipelineTitle, actionTitle, input = null, output = null)
local combined = pipelineTitle + ' ' + actionTitle;
local lowercase = std.asciiLower(combined);
local key = std.strReplace(lowercase, ' ', '_');
local suffix = std.strReplace(lowercase, ' ', '-');
local name = settings.projectName + '-' + suffix;
local ProjectName = '${aws_codebuild_project.' + key + '.name}';
{
  name: name,
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
