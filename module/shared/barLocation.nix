barName: barConfig:
let root = "waybar/${barName}"; in
{
  config = "${root}/config.jsonc";
  style = "${root}/style.css";
}
