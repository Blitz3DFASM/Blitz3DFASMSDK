; WritePixelFast Example
include "blitz3d.inc"

buffer BBCanvas 0
image BBCanvas 0

x dd 0
y dd 0
delta_x dd 7
delta_y dd 7
img_buf dd 0

start:
      cinvoke bbBeginBlitz3D
      cinvoke bbGraphics, 640, 480, 32, 3

      cinvoke bbCreateImage, 256, 256, 1
      mov [image], eax

      cinvoke bbImageBuffer, [image], 0 ; get buffer of image frame=0
      mov [img_buf],eax
      cinvoke bbSetBuffer, eax

      cinvoke bbLockBuffer, [img_buf]

      mov [y],255
next_y:
      mov [x],255
next_x:
      ; Generate pixel
      mov eax,512
      sub eax,[x]
      sub eax,[y]
      shr eax,1      ; red
      shl eax,8
      add eax,[x]    ; green
      shl eax,8
      add eax,[y]    ; blue
      cinvoke bbWritePixelFast, [x], [y], eax, [img_buf]

      dec [x]
      jns next_x
      dec [y]
      jns next_y

      cinvoke bbUnlockBuffer, [img_buf]

      cinvoke bbBackBuffer
      mov [buffer],eax
      cinvoke bbSetBuffer, [buffer]

main_loop:
      cinvoke bbKeyHit, KEY_ESCAPE ; Wait Esc
      or eax, eax
      jnz exit_from_main_loop

      ; Draw texture
      cinvoke bbDrawImage, [image], [x], [y], 0

      ; Simple animation
      mov eax,[delta_x]
      add [x],eax
      mov eax,[delta_y]
      add [y],eax
      cmp [x], 1
      jb x_ok
      cmp [x], 640-256
      jna x_ok
      neg [delta_x]
x_ok:
      cmp [y], 1
      jb y_ok
      cmp [y], 480-256
      jna y_ok
      neg [delta_y]
y_ok:

      cinvoke bbFlip, BBTRUE       ; Flip buffers
      jmp main_loop;
exit_from_main_loop:
