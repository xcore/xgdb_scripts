============
xgdb scripts
============

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
The corresponding values are read from the "Interconnect Registers"
They are described in XS1-L System Specification: http://www.xmos.com/en/published/xsysteml.
The status register offsets can be inferred from the script. E.g. "sysreg read $tap 1 0x0"
reads from register at offset 0x0 which is the "Device identification" register.


tilestate
=========

The tilestate script defines functions that can be used to debug the state of
xCORE hardware resources.
Example usage::

  # Run xgdb
  $ xgdb
  # Attach to device
  (gdb) attach
  # Source tilestate script
  (gdb) source tilestate
  # Display all resources on tile 0
  (gdb) res_print_tile_resources 0
  Tile 0:
  --------
  Timer 0:
      inUse=1, ieMode=E, $ieEnabled=0, ready=1, cond=NONE
      tWaiting=0, tNum=0
  Core 0:
      inUse=1, msync=0, ssync=0, master=core 0
  Lock 0:
      inUse=1, owned=0, owner=core 0
      Slaves=
  Clock Block 0:
      inUse=1, started=1, stopping=0, fallDelay=0, riseDelay=0
      tWaiting=0, tNum=0
      clkSrc=0x00000001, rdySrc=0x00010000
  Clock Block 1:
      inUse=1, started=1, stopping=0, fallDelay=0, riseDelay=0
      tWaiting=0, tNum=0
      clkSrc=0x00000001, rdySrc=0x00010000
  Clock Block 2:
      inUse=1, started=1, stopping=0, fallDelay=0, riseDelay=0
      tWaiting=0, tNum=0
      clkSrc=0x00000001, rdySrc=0x00010000
  Clock Block 3:
      inUse=1, started=1, stopping=0, fallDelay=0, riseDelay=0
      tWaiting=0, tNum=0
      clkSrc=0x00000001, rdySrc=0x00010000
  Clock Block 4:
      inUse=1, started=1, stopping=0, fallDelay=0, riseDelay=0
      tWaiting=0, tNum=0
      clkSrc=0x00000001, rdySrc=0x00010000
  Clock Block 5:
      inUse=1, started=1, stopping=0, fallDelay=0, riseDelay=0
      tWaiting=0, tNum=0
      clkSrc=0x00000001, rdySrc=0x00010000

The commands provided by this script are:
   * ``res_print_port <TILE> <PORTWIDTH> <PORTNUM>`` - Print details of specified port
   * ``res_print_ports <TILE>`` - Print details of all ports on specified tile
   * ``res_print_timer <TILE> <TIMERNUM>`` - Print details of specified timer
   * ``res_print_timers <TILE>`` - Print details of all timers on specified tile
   * ``res_print_chanend <TILE> <CHANEND>`` - Print details of specified channel end
   * ``res_print_chanends <TILE>`` - Print details of all channel ends on specified tile
   * ``res_print_sync <TILE> <SYNCNUM>`` - Print details of specified synchronizer
   * ``res_print_syncs <TILE>`` - Print details of all synchronizers on specified tile
   * ``res_print_core <TILE> <CORENUM>`` - Print details of specified core
   * ``res_print_cores <TILE>`` - Print details of all cores on specified tile
   * ``res_print_lock <TILE> <LOCKNUM>`` - Print details of specified lock
   * ``res_print_locks <TILE>`` - Print details of all locks on specified tile
   * ``res_print_clkblk <TILE> <CLKBLKNUM>`` - Print details of specified clock block
   * ``res_print_clkblks <TILE>`` - Print details of all clock blocks on specified tile
   * ``res_print_divider <TILE>`` - Print details of specified divider
   * ``res_print_tile_resources <TILE>`` - Print details of all resources on specified tile
   * ``res_print_all`` - Print all resources on tiles 0 & 1

*Note*: by default only active resources will be displayed. In order to display
all resources, then after sourcing the tilestate script do::
  (gdb) set $res_print_not_inuse = 1

*Note*: it is possible to print extra detailed information by setting the
following flag after sourcing the script::
  (gdb) set $res_print_details = 1