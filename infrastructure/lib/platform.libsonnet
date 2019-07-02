local merge = import 'merge.libsonnet';
local repository = import 'repository.libsonnet';
local pipeline = import 'pipeline.libsonnet';
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
  {
    resource: {
      aws_codebuild_project: {
        build: {
          name: settings.projectName + '-build',
          service_role: '${aws_iam_role.codebuild.arn}',
          environment: [{
            compute_type: 'BUILD_GENERAL1_SMALL',
            type: 'LINUX_CONTAINER',
            image: buildImage,
          }],
          source: [{
            type: 'CODEPIPELINE',
            buildspec: 'buildspec-build.yml',
          }],
          artifacts: [{
            type: 'CODEPIPELINE',
          }],
          tags: tags(settings.projectName + '-build'),
        },
        metaschema_test: {
          name: settings.projectName + '-metaschema-test',
          service_role: '${aws_iam_role.codebuild.arn}',
          environment: [{
            compute_type: 'BUILD_GENERAL1_SMALL',
            type: 'LINUX_CONTAINER',
            image: buildImage,
          }],
          source: [{
            type: 'CODEPIPELINE',
            buildspec: 'buildspec-metaschema-tests.yml',
          }],
          artifacts: [{
            type: 'CODEPIPELINE',
          }],
          tags: tags(settings.projectName + '-metaschema-test'),
        },
        functional_test: {
          name: settings.projectName + '-functional-test',
          service_role: '${aws_iam_role.codebuild.arn}',
          environment: [{
            compute_type: 'BUILD_GENERAL1_SMALL',
            type: 'LINUX_CONTAINER',
            image: buildImage,
          }],
          source: [{
            type: 'CODEPIPELINE',
            buildspec: 'buildspec-functional-tests.yml',
          }],
          artifacts: [{
            type: 'CODEPIPELINE',
          }],
          tags: tags(settings.projectName + '-functional-test'),
        },
        performance_test: {
          name: settings.projectName + '-performance-test',
          service_role: '${aws_iam_role.codebuild.arn}',
          environment: [{
            compute_type: 'BUILD_GENERAL1_SMALL',
            type: 'LINUX_CONTAINER',
            image: buildImage,
          }],
          source: [{
            type: 'CODEPIPELINE',
            buildspec: 'buildspec-performance-tests.yml',
          }],
          artifacts: [{
            type: 'CODEPIPELINE',
          }],
          tags: tags(settings.projectName + '-performance-test'),
        },
        platform_tag: {
          name: settings.projectName + '-tag',
          service_role: '${aws_iam_role.codebuild.arn}',
          environment: [{
            compute_type: 'BUILD_GENERAL1_SMALL',
            type: 'LINUX_CONTAINER',
            image: buildImage,
          }],
          source: [{
            type: 'CODEPIPELINE',
            buildspec: 'buildspec-tag.yml',
          }],
          artifacts: [{
            type: 'CODEPIPELINE',
          }],
          tags: tags(settings.projectName + '-tag'),
        },
        deliver: {
          name: settings.projectName + '-deliver',
          service_role: '${aws_iam_role.codebuild.arn}',
          environment: [{
            compute_type: 'BUILD_GENERAL1_SMALL',
            type: 'LINUX_CONTAINER',
            image: buildImage,
          }],
          source: [{
            type: 'CODEPIPELINE',
            buildspec: 'buildspec-deliver.yml',
          }],
          artifacts: [{
            type: 'CODEPIPELINE',
          }],
          tags: tags(settings.projectName + '-deliver'),
        },
      },
    },
  },
])
