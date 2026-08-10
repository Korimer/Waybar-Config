allModules:
  builtins.mapAttrs (name: value:
    (map
      (module: module.distinguishedName)
      value
    )
  )
  allModules.standardModules
