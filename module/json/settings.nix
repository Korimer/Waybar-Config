allModules:
let
  preparedModules = import ./inject-groups.nix allModules;

  allSettings = builtins.foldl'
    (acc: elem: acc // { ${elem.distinguishedName} = elem.config.settings; } )
    {}
    preparedModules
  ;
in
  allSettings
