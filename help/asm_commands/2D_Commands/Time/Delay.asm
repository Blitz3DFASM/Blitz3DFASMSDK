; bbDelay Example
include "blitz3d.inc"

start:
     ; Set The Graphic Mode
     cinvoke bbGraphics, 800, 600, 0, 0

     InPrint "Print text and wait five seconds"

     cinvoke bbDelay, 5000

     InPrint "Print text after delay. Press any key for exit"

     ; Wait key
     cinvoke bbWaitKey