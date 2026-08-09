barConfig:
let
  allModules = import ../shared/uniqueModules.nix barConfig;

  preparedModules = import ./inject-groups.nix allModules;

  allSettings = builtins.foldl'
    (acc: elem: acc // { ${elem.distinguishedName} = elem.config.settings; } )
    {}
    preparedModules
  ;
in
  allSettings
