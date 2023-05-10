; KeyHit Example
include "blitz3d.inc"

current dd 0;

start:
     ; Set The Graphic Mode
     cinvoke bbGraphics, 800, 600, 0, 0

     ; Set up the timer
     cinvoke bbMilliSecs
     mov [current], eax
     InPrint "Press ESC a bunch of times for five seconds..."

     cinvoke bbFlip

     ; Wait 5 seconds
wait_loop:
     cinvoke bbMilliSecs
     mov ebx,[current]
     add ebx,5000
     cmp eax, ebx
     jb wait_loop           ;While MilliSecs() < current+5000
                            ;Wend

     ; Print the results
     cinvoke bbKeyHit, 1
     mov esi, eax
     InPrint "Pressed ESC %d times.", esi