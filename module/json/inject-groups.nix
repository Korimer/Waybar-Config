allModules:
let
  moduleListToIds = moduleList: map
    (module: module.distinguishedName)
    moduleList
  ;

  # awesome
  addModuleListToSettings = module: moduleList:
    module //
    {
      config = module.config //
      {
        settings = module.config.settings //
          {modules = moduleList;};
      };
    };

  injectGroupModules = module:
  if ( allModules.groupModules ? ${module.config.name} )
    then
      let
        groupModules = allModules.groupModules.${module.config.name};
        groupModuleIds = moduleListToIds groupModules;
      in
        addModuleListToSettings module groupModuleIds
    else module
  ;

  injectedAllModules = map injectGroupModules allModules.allModules;
in
  injectedAllModules
