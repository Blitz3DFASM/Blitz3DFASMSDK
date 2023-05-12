; bbKeyHit Example
include "blitz3d.inc"

hits dd 0
current dd 0

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
     cinvoke bbFlip         ; In the loop, it is necessary to call the bbFlip,
                            ;otherwise the key hits will not be counted.

     cinvoke bbMilliSecs
     mov ebx,[current]
     add ebx,5000
     cmp eax, ebx           ; if MilliSecs() < current+5000
     jb wait_loop           ; goto wait_loop

     ; Print the results
     cinvoke bbKeyHit, 1 ;KEY_ESCAPE
     mov [hits], eax
     InPrint "Pressed ESC %i times.", [hits]

     ; Delay for show result
     cinvoke bbDelay, 3000 ;Wait 3 sec