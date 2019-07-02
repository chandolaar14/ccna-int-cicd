function(title = 'Approval')
local lowercase = std.asciiLower(title);
local name =  std.strReplace(lowercase, ' ', '_');
{
  name: name,
  action: [{
    name: name,
    category: 'Approval',
    provider: 'Manual',
    version: '1',
    owner: 'AWS',
  }],
}

