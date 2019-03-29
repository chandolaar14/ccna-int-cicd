local settings = import '../../settings.json';

function(name)
  std.join('.', [name, settings.projectName, settings.s3Suffix])

