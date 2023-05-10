include "blitz3d.inc"

start:
     ; Set The Graphic Mode
     cinvoke bbGraphics, 800, 600, 0, 0

     ; Set ClsColor to red
     cinvoke bbClsColor, 255,0,0

     ; Set current drawing buffer to the color set by the ClsColor command
     cinvoke bbCls

     InPrint "Print Text"

     ; Wait key
     cinvoke bbWaitKey