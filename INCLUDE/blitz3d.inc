format PE GUI 4.0
entry _start

include 'win32ax.inc'
include 'blitz3dsdk.inc'

section '.idata' import data readable writeable

library kernel32,'KERNEL32.DLL',\
     user32,'USER32.DLL',\
     msvcrt,'MSVCRT.DLL',\ 
     b3d,'B3D.DLL'

     include 'api\kernel32.inc'
     include 'api\user32.inc'

import msvcrt,\
         sprintf,'sprintf'

     include 'b3d.inc'

section '.rsrc' resource data readable
     ICON equ '3D.ico'
     include 'res.inc'

section '.code' code readable writeable executable
     ; Include macros data there
     include 'b3dmacro.inc'
_start:
     cinvoke bbBeginBlitz3D
     jmp start

; This code be included at the end of file
postpone
{
     cinvoke bbEndBlitz3D
     invoke ExitProcess,0   
}
