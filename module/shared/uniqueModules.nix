barConfig:
let
  distinguishedElem = elem: num: {
    distinguishedName = "${elem.name}#id${toString num}";
    config = elem;
  };
  
  distinguishElements = accumulated: newElements: builtins.foldl'
    (acc: elem:
      let elemNum = if (acc.elemCount ? ${elem.name}) then acc.elemCount.${elem.name} + 1 else 1;
      in
      {
        elemCount = acc.elemCount // { ${elem.name} = elemNum; };
        elems = acc.elems ++ [ (distinguishedElem elem elemNum) ];
      }
    )
    {
      elemCount = accumulated;
      elems = [];
    }
    newElements
  ;

  groupModules = map
    (name: { name = "group/${name}"; value = barConfig.groups.${name}; })
    (builtins.attrNames barConfig.groups);

  standardModules = [
    { name = "modules-left";   value = barConfig.modulesLeft; }
    { name = "modules-center"; value = barConfig.modulesCenter; }
    { name = "modules-right";  value = barConfig.modulesRight; }
  ];

  distinguish = cur_staging: module_attrpair:
    let
      asDistinguished =
        distinguishElements cur_staging.accumulated module_attrpair.value;
    in
    {
      staged =
        cur_staging.staged // { ${module_attrpair.name} = asDistinguished.elems; };
      accumulated =
        asDistinguished.elemCount;
    };

  distinguishedGroupModules = builtins.foldl'
    distinguish
    {
      staged = {};
      accumulated = {};
    }
    groupModules
  ;

  distinguishedStandardModules = builtins.foldl'
    distinguish
    {
      staged = {};
      accumulated = distinguishedGroupModules.accumulated;
    }
    standardModules
  ;
in
{
  standardModules = distinguishedStandardModules.staged;
  groupModules = distinguishedGroupModules.staged;
}

# produces:

#   {
#     standardModules = {
#       modules-left = [
#         {
#           distinguishedName = "battery#id1";
#           config = { name = "battery"; settings = { ... }; css = { ... }; };
#         }
#       ];
#       modules-right = [  ];
#       modules-center = [  ];
#     };
#     groupModules = {
#       "group/name1" = [  ];
#       "group/whatevername" = [  ];
#       "group/blahblahblah" = [  ];
#     }
#   }
