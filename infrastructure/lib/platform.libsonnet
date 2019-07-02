local merge = import 'merge.libsonnet';
local repository = import 'repository.libsonnet';
local pipeline = import 'pipeline.libsonnet';
local codebuild = import 'codebuild.libsonnet';
local pipelineAction = import 'pipelineAction.libsonnet';
local settings = import '../../settings.json';
local buildImage = import 'buildImage.libsonnet';
local tags = import 'tags.libsonnet';

merge([
  repository(
    key = 'platform',
    name = settings.projectName,
    desc = 'This is the platform repository for the ' + settings.projectName + " project.",
  ),
  pipeline(
    key = 'platform',
    name = settings.projectName,
    stages = [{
      name: 'Source',
      action: [{
        name: 'Source',
        category: 'Source',
        provider: 'CodeCommit',
        version: '1',
        owner: 'AWS',
        configuration: {
          RepositoryName: '${aws_codecommit_repository.platform.repository_name}',
          BranchName: 'master',
        },
        output_artifacts: [ 'source' ]
      }],
    },{
      name: 'Build',
      action: [
        pipelineAction('Build', '${aws_codebuild_project.build.name}', 'source', 'buildPackage'),
      ],
    },{
      name: 'Test',
      action: [
        pipelineAction('Functional', '${aws_codebuild_project.functional_test.name}', 'buildPackage', category = 'Test'),
        pipelineAction('Metaschema', '${aws_codebuild_project.metaschema_test.name}', 'buildPackage', category = 'Test'),
        pipelineAction('Performance', '${aws_codebuild_project.performance_test.name}', 'buildPackage', category = 'Test'),
        pipelineAction('Checkmarx_Scan', '${aws_codebuild_project.checkmarx_scan.name}', 'source', category = 'Test'),
      ],
    },{
      name: 'Tag',
      action: [
        pipelineAction('Tag', '${aws_codebuild_project.platform_tag.name}', 'buildPackage', 'versionedPackage'),
      ],
    },{
      name: 'Deliver',
      action: [
        pipelineAction('Deliver', '${aws_codebuild_project.deliver.name}', 'versionedPackage'),
      ],
    }],
  ),
  codebuild('build', settings.projectName + '-build', 'buildspec-build.yml'),
  codebuild('metaschema_test', settings.projectName + '-metaschema-test', 'buildspec-metaschema-tests.yml'),
  codebuild('functional_test', settings.projectName + '-functional-test', 'buildspec-functional-tests.yml'),
  codebuild('performance_test', settings.projectName + '-performance-test', 'buildspec-performance-tests.yml'),
  codebuild('platform_tag', settings.projectName + '-tag', 'buildspec-tag.yml'),
  codebuild('deliver', settings.projectName + '-deliver', 'buildspec-deliver.yml'),
])
