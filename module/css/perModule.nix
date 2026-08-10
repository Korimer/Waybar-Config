module:
let
  toRule = import ./toCSSRule.nix;

  replaceGroup = name: let match = builtins.match ".*/(.*)" name; in
    if match == null then name else builtins.head match;

  selectorName =
    let moduleName = module.config.name; in "#" + (
      if builtins.match "^custom/.*" moduleName != null
      then builtins.replaceStrings ["/"] ["-"] moduleName
      else replaceGroup moduleName
  );

  baseRule = toRule
    selectorName
    module.config.style.base
  ;

  bySelector = module.config.style.bySelector;

  selectorRules = map
    (selector: toRule
      "${selectorName}${selector}"
      bySelector.${selector}
    ) 
    (builtins.attrNames bySelector);

  allRules = [ baseRule ] ++ selectorRules;
in
  allRules
