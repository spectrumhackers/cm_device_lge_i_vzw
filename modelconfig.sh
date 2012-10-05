#!/bin/sh

MODEL_SPECIFIC_FILES="
	system/build.prop
	system/framework/framework-res.apk
	system/app/Mms.apk
	system/usr/keylayout/hub_synaptics_touch.kl"

PRODUCT_REMOVE_FILES=""

PRODUCT_REMOVE_RES="{layout,drawable,mipmap,menu,xml}-{large,sw580,sw600,sw768,xhdpi,xlarge}*"

# Keep only en, fr, it, de, es
PACKAGE_REMOVE_FILES="
	LatinIME.apk:res/{raw,xml}-{ar,bg,cs,cs-ZZ,da,el,fa,fi,hr,hr-AL,hu,hu-ZZ,iw,ka,nb,nl,nl-BE,pl,pt,ru,sr,sv,tr}"
