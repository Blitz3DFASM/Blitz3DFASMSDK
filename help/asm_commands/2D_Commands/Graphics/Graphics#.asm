; bbGaraphicsWidth, bbGaraphicsHeight, bbGaraphicsDepth, bbGaraphicsBuffer Example
include "blitz3d.inc"

start:
     ; Set The Graphic Mode
     cinvoke bbGraphics, 800, 600, 0, 0

     ; Set frontbuffer
     cinvoke bbFrontBuffer
     cinvoke bbSetBuffer, eax

     cinvoke bbGraphicsWidth
     InPrint "Screen width is: %i", eax
     cinvoke bbGraphicsHeight
     InPrint "Screen height is: %i", eax
     cinvoke bbGraphicsDepth
     InPrint "Screen color depth is: %i", eax
     cinvoke bbGraphicsBuffer
     InPrint "Current buffer handle is: %i", eax

     cinvoke bbWaitKey

