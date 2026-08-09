barConfig:
let
  allModules = import ../shared/uniqueModules.nix barConfig;
  flatten = list: builtins.foldl' (acc: elem: acc ++ elem) [] list;
  
  modulesUnsorted = flatten (
    ( builtins.attrValues allModules.groupModules )
    ++ ( builtins.attrValues allModules.standardModules )
  );
  
  allSettings = builtins.foldl'
    (acc: elem: acc // { ${elem.distinguishedName} = elem.config.settings; } )
    {}
    modulesUnsorted
  ;
in
  allSettings
