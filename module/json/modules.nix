barConfig:
let
  allModules = import ../shared/uniqueModules.nix barConfig;
in
  builtins.mapAttrs (name: value:
    (map
      (module: module.distinguishedName)
      value
    )
  )
  allModules.standardModules
