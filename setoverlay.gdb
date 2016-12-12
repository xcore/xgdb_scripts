connect --reset-to-mode-pins
p __overlay_address
disconnect
connect --xscope
load
set variable __overlay_address=$1
c