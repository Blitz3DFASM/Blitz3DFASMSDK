; bbLoadImage bbDrawImage bbMouseX bbMouseY
include "blitz3d.inc"

bullet BBImage 0
rel_path db "../../../../media/"
image_file db "bullet.png", 0

start:
     cinvoke bbBeginBlitz3D
     cinvoke bbGraphics, 640, 480, 0, 3

     cinvoke bbBackBuffer
     cinvoke bbSetBuffer, eax

     ; Try to load image from app run path
     cinvoke bbLoadImage, image_file
     cmp eax,0
     jne image_loaded
     ; If image is not loaded try to load it from media folder of SDK
     cinvoke bbLoadImage, rel_path
image_loaded:
     mov [bullet],eax

main_loop:
     cinvoke bbKeyHit, KEY_ESCAPE ; Wait Esc
     or eax, eax
     jnz exit

     cinvoke bbCls

     cinvoke bbMouseX
     lea esi,[eax-16]  ; esi = MouseX - 16
     cinvoke bbMouseY
     lea edi,[eax-16]  ; edi = MouseY - 16

     cinvoke bbDrawImage, [bullet], esi, edi, 0

     cinvoke bbFlip, BBTRUE       ; Flip buffers
     jmp main_loop;
exit:
