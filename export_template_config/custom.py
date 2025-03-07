target="template_release"
production="yes"
optimize="size"

deprecated="no" # This may break the web export
minizip="no" # This may break the web export
#brotli="no" <-- This breaks fonts. Found out after recompiling like 20 times.
vulkan="no"
openxr="no"
use_volk="no"
disable_3d="yes"
graphite="no"

modules_enabled_by_default="no"
module_gdscript_enabled="yes"
module_freetype_enabled="yes"
module_minimp3_enabled = "yes"
module_ogg_enabled = "yes"
module_text_server_fb_enabled="yes"
module_regex_enabled = "yes"
module_vorbis_enabled = "yes"
module_webp_enabled = "yes"
module_jpg_enabled = "yes"
module_svg_enabled = "yes"