barConfig:
let
  distinguishElements = accumulated: newElements: builtins.foldl'
    (acc: elem:
      let elemNum = if (acc.elemCount ? elem) then acc.elemCount.${elem} + 1 else 1;
      in
      {
        elemCount = acc.elemCount // { ${elem} = elemNum + 1; };
        elems = acc.elems ++ [ "${elem}#id${toString elemNum}" ];
      }
    )
    {
      elemCount = accumulated;
      elems = [];
    }
    newElements
  ;

  groupNames = map 
    (name: "group/${name}")
    (builtins.attrNames barConfig.groups)
  ;

  getModuleNames = moduleList: map (module: module.name) moduleList;

  toDistinguish = [
    { name = "groups"; value = groupNames; }
    { name = "modules-left";   value = getModuleNames barConfig.modulesLeft; }
    { name = "modules-center"; value = getModuleNames barConfig.modulesCenter; }
    { name = "modules-right";  value = getModuleNames barConfig.modulesRight; }
  ];

  stagingDistinguished = builtins.foldl'
    (acc: elem: 
      let
        asDistinguished = distinguishElements acc.accumulated elem.value;
      in
      {
        staged = acc.staged // { ${elem.name} = asDistinguished.elems; };
        accumulated = asDistinguished.elemCount;
      })
    {
      staged = {};
      accumulated = {};
    }
    toDistinguish
  ;

in
  stagingDistinguished.staged
