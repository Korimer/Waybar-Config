selector: attrs:
let
  asDeclarations = map
    (name: {
      property = name;
      value = attrs.${name};
    })
    (builtins.attrNames attrs)
  ;
  
  rule = {
    selectors = [ selector ];
    declarations = asDeclarations;
  };
in
  rule
