barConfig:
let
  allModules = import ../shared/uniqueModules.nix barConfig;
in
  allModules
#{
#  modules-left = allModules.modules-left;
#  modules-center = allModules.modules-center;
#  modules-right = allModules.modules-right;
#}
