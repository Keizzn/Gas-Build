# AnyKernel2 Ramdisk Mod Script
# osm0sis @ xda-developers

## AnyKernel setup
# begin properties
properties() { '
kernel.string=Hi there
do.devicecheck=1
do.modules=0
do.cleanup=1
do.cleanuponabort=0
device.name1=rolex
device.name2=redmi4a
device.name3=riva
device.name4=redmi5a
device.name5=
'; } # end properties

# shell variables
block=/dev/block/bootdevice/by-name/boot;
is_slot_device=0;
ramdisk_compression=auto;


## AnyKernel methods (DO NOT CHANGE)
# import patching functions/variables - see for reference
. /tmp/anykernel/tools/ak2-core.sh;


# Messages
ui_print " This kernel is built using Nusantara Clang  ";
ui_print "                  _ _ _                      ";
ui_print "                 |  _ _| _                   ";
ui_print "                 | |_ _ | |                  ";
ui_print "                 |_ _  || |                  ";
ui_print "                  _ _| || |                  ";
ui_print "                 |_ _ _||_|                  ";
ui_print "  _    _  _ _ _  _   _  _____  _ _ _  _   _  ";
ui_print " |  \/  ||  _  || \ | ||_   _||  _  || | / / ";
ui_print " | |\/| || | | ||  \| |  | |  | | | || |/ /  ";
ui_print " | |  | || |_| || |\  |  | |  | |_| || |\ \  ";
ui_print " |_|  |_||_ _ _||_| \_|  |_|  |_ _ _||_| \_\ ";
ui_print "                 K E R N E L                 ";
ui_print "                  KeiFaisal                  ";
ui_print "            May soon be abandoned            ";
ui_print "---------------------------------------------";

## AnyKernel install
dump_boot;

# end ramdisk changes

write_boot;

## end install

