{ inputs, ... }:
let

  selectorName = moduleName:
    if builtins.match "^custom/" moduleName != null
    then builtins.replaceStrings ["/"] ["-"] moduleName
    else builtins.replaceStrings [".*/"] [""] moduleName
  ;

  toSelector = module: map
    (sub-selector: [ "#${module.config.name}.${module.distinguishment}${sub-selector}" ])
    (builtins.attrNames module.config.css)
  ;
  toDeclarations = module: module;

  toCSS = inputs.nix-gtk-css.lib.generate;
  
  mkWaybarCss = barName: barConfig:
    let barLocation = import ../shared/barLocation.nix barName barConfig; in
    {
      name = "${barLocation}/style.css";
      value = null;
    };
in
{

}
