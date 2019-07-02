local merge = import 'merge.libsonnet';
local repository = import 'repository.libsonnet';
local pipeline = import 'pipeline.libsonnet';
local codebuild = import 'codebuild.libsonnet';
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
      action: [{
        name: 'Build',
        category: 'Build',
        provider: 'CodeBuild',
        version: '1',
        owner: 'AWS',
        configuration: {
          ProjectName: '${aws_codebuild_project.build.name}',
        },
        input_artifacts: [ 'source' ],
        output_artifacts: [ 'buildPackage' ],
      }],
    },{
      name: 'Test',
      action: [{
        name: 'Functional',
        category: 'Test',
        provider: 'CodeBuild',
        version: '1',
        owner: 'AWS',
        configuration: {
          ProjectName: '${aws_codebuild_project.functional_test.name}',
        },
        input_artifacts: [ 'buildPackage' ],
      },{
        name: 'Metaschema',
        category: 'Test',
        provider: 'CodeBuild',
        version: '1',
        owner: 'AWS',
        configuration: {
          ProjectName: '${aws_codebuild_project.metaschema_test.name}',
        },
        input_artifacts: [ 'buildPackage' ],
      },{
        name: 'Performance',
        category: 'Test',
        provider: 'CodeBuild',
        version: '1',
        owner: 'AWS',
        configuration: {
          ProjectName: '${aws_codebuild_project.performance_test.name}',
        },
        input_artifacts: [ 'buildPackage' ],
      },{
        name: 'Checkmarx_Scan',
        category: 'Test',
        provider: 'CodeBuild',
        version: '1',
        owner: 'AWS',
        configuration: {
          ProjectName: '${aws_codebuild_project.checkmarx_scan.name}',
        },
        input_artifacts: [ 'source' ]
    }],
    },{
      name: 'Tag',
      action: [{
        name: 'Tag',
        category: 'Build',
        provider: 'CodeBuild',
        version: '1',
        owner: 'AWS',
        configuration: {
          ProjectName: '${aws_codebuild_project.platform_tag.name}',
        },
        input_artifacts: [ 'buildPackage' ],
        output_artifacts: [ 'versionedPackage' ],
      }],
    },{
      name: 'Deliver',
      action: [{
        name: 'Deliver',
        category: 'Build',
        provider: 'CodeBuild',
        version: '1',
        owner: 'AWS',
        configuration: {
          ProjectName: '${aws_codebuild_project.deliver.name}',
        },
        input_artifacts: [ 'versionedPackage' ],
      }],
    }],
  ),
  codebuild('build', settings.projectName + '-build', 'buildspec-build.yml'),
  codebuild('metaschema_test', settings.projectName + '-metaschema-test', 'buildspec-metaschema-tests.yml'),
  codebuild('functional_test', settings.projectName + '-functional-test', 'buildspec-functional-tests.yml'),
  codebuild('performance_test', settings.projectName + '-performance-test', 'buildspec-performance-tests.yml'),
  codebuild('platform_tag', settings.projectName + '-tag', 'buildspec-tag.yml'),
  codebuild('deliver', settings.projectName + '-deliver', 'buildspec-deliver.yml'),
])
