============
xgdb scripts
============

:Maintainer: https://github.com/rlsosborne
:Description: Useful xCORE debugger scripts

xlreg
=====

The xlreg script defines a function that can be used to display the link state.
Example usage::

  # Run xgdb
  $ xgdb
  # Attach to device
  (gdb) attach
  # Source xlreg script
  (gdb) source xlreg
  # Call xlreg function to display link state
  (gdb) xlreg
  Thread 1 (tile[0] core[0]):
  Tile 0 (Tap 0)
  SSwitch
    Node id 0x0000
    PLL 0x1007700
    BootMode : 0x0013
    Dirs: 0000000000000000
    Link 0  not enabled
    Link 1  not enabled
    Link 2  not enabled
    Link 3  not enabled
    Link 4  not enabled
    Link 5  not enabled
    Link 6  not enabled
    Link 7  not enabled
    PLink 0 siu:F diu:F junk:F net:0 srctargetid:0 srctargettype:0
    PLink 1 siu:F diu:F junk:F net:0 srctargetid:0 srctargettype:0
    PLink 2 siu:F diu:F junk:F net:0 srctargetid:0 srctargettype:0
    PLink 3 siu:F diu:F junk:F net:0 srctargetid:0 srctargettype:0
  PSwitch
    PLink 0 siu:F diu:F junk:F net:0 srctargetid:0 srctargettype:3
    PLink 1 siu:F diu:F junk:F net:0 srctargetid:0 srctargettype:3
    PLink 2 siu:F diu:F junk:F net:0 srctargetid:0 srctargettype:3
    PLink 3 siu:F diu:F junk:F net:0 srctargetid:0 srctargettype:3
 
Description
===========

Notation
--------
* ``2w``: 2 wire mode
* ``5w``: 5 wire mode
* ``x/x``: inter-token delay/inter-symbol delay
* ``d:x``: Direction
* ``snd``: Link has credits and can transmit True/False
* ``rec``: Link has issued credits and can receive True/False
* ``siu``: Source in use
* ``diu``: Destination in use

Related Documentation
---------------------
The corresponding values are read from the "Interconnect Registers”.
They are described in XS1-L System Specification: http://www.xmos.com/en/published/xsysteml.
The status register offsets can be inferred from the script. E.g. "sysreg read $tap 1 0x0"
reads from register at offset 0x0 which is the "Device identification”  register

