# Blitz3D FASM SDK

[Blitz3D SDK](https://blitzresearch.itch.io/blitz3d) for [Flat Assembler x86](https://flatassembler.net/). This SDK can make learning Assembly X86 language more fun.

Simple Online Help is placed [here](https://blitz3dfasm.github.io/FASM_B3D_SDK_HELP/help/asm_commands/index.htm)

Blitz3D SDK (B3D.dll) disadvantages [here](https://blitz3dfasm.github.io/FASM_B3D_SDK_HELP/help/asm_commands/main.htm). Read before use this SDK.

# How to use

![B3DFASMSDK](https://github.com/Blitz3DFASM/Blitz3DFASMSDK/assets/133161792/3ee654fe-ede5-41b8-82ec-f4844ac47074)

* Download [this Blits3D FASM SDK](https://github.com/Blitz3DFASM/Blitz3DFASMSDK/archive/refs/heads/main.zip), and extract it to any folder folder.
* Download [Blitz3D SDK V1.05](http://www.google.com/search?q=Blitz3D+SDK+v1.05), and extract it to any folder folder.
* Download [FASM for windows](http://flatassembler.net/download.php), and extract it to any folder folder.
* Copy all files from SDK\INCLUDE folder to FASM\INCLUDE folder.
* Copy **B3D.dll** from *Blitz3D_SDK_V1.05\redist* folder and copy it **to folder with \*.asm files** (The compiled exe file will not run without B3D.dll library in exe file folder).
* Run FASMW.EXE IDE from FASM archive and open one of the *.asm files from this SDK and select Run->Run from main menu for create execute and run example.

**Note:** Also, you can set FASMW.EXE as default application for *.asm files in youre opeartin system. Then, when opening an *.asm file, it will immediately open it in the FASMW IDE, which greatly simplifies work.

# SDK Description:

SDK contains files:
* \INCLUDE - contains files that need to be moved to the FASM\INCLUDE folder.
    * 3D.ico - default icon (It is spelled out in the res.inc file)   
    * b3d.inc - headers of b3d.dll
    * blitz3dsdk.inc - contains Blitz3D constants like key codes, data types and other constants 
    * b3dmacro.inc - contains assember macroses for SDK for easy text output, random generator and other
    * blitz3d.inc - special header, it simplifies the code structure to a minimum, which makes programming easier for novice users. (used throughout the examples).
    * res.inc - contain resources description
* \examples - contain a few examples
* \help\asm_commands - contain few examples from help that match the commands in the [Documentation repository](https://blitz3dfasm.github.io/Blitz3DFASMSDK_HELP/help/asm_commands/index.htm).
* \media - contains media files like: sounds, images, models, textures, which are used in the examples located in the help\ folder

# Typical Blitz3D Assembler x86 appliction source code

Typical FASM application code for Windows consists of:  
* header *format PE GUI 4.0*
* pointer to the beginning of the code *entry start*  

And several sections:
* *.data* - Contains variables, arrays are marked as writable and readable, but not executable.
* *.code* - Contains code, can also contain data but is read-only, marked as readable and executable code, but not writable (modifications).
* *.idata* - Contains information about exported functions of third-party libraries. As a rule, this is a user32, kernel32 and of course b3d "headers".
* *.rsrc* - Contains application resources: icons, application version information, can also contain images, dialogs, menus.

The approach of dividing the code into sections allows you to make the application more secure, for example, you cannot save the code into a variable and execute it. This is protection against code injections.

A typical Blitz3D SDK application has the following structure:
* Before start working with SDK, need to invoke bbBeginBlitz3D at first
* Next, if you use graphics, you need to create a window by bbGraphics3D invoke, then some custom code follows.
* At the end, when exiting the application, need to call bbEndBlitz3D and invoke ExitProcess

While we are not considering the Blitz3D code and functions itself, this is only a description of the assembler code structure of typical Windows application.

    ;******************************************************
    ;*                  Blitz3D on FASM                   *
    ;******************************************************

    format PE GUI 4.0
    entry start

    include 'win32a.inc'
    include 'blitz3dsdk.inc'

    ; ------------ data section -----------------
    section '.data' data readable writeable

    buffer BBCanvas 0
    camera BBCamera 0
    light BBLight 0

    cone BBModel 0
    cube BBModel 0
    sphere BBModel 0

    title db 'Blitz3D 3D Graphics Exmple on FASM', 0
    text db 'Class of cube is: ', 0
    empty_str db 0
    class_name dd 0      ; Pointer to string

    ; ------------ code section ------------------
    section '.code' code readable executable

    start:
          cinvoke bbBeginBlitz3D
          cinvoke bbGraphics3D, 640, 480, 32, 3
          cinvoke bbSetBlitz3DTitle, title, empty_str
          
          cinvoke bbBackBuffer
          mov [buffer],eax
          cinvoke bbSetBuffer, [buffer]

          cinvoke bbCreateCamera, 0            ; paerent 0
          mov [camera], eax
          cinvoke bbCreateLight, 1, 0          ; 1 - direct light, parent null
          mov [light], eax

          cinvoke bbCreateCone, 32, BBTRUE, 0  ; 32 segments, solid, parent null
          mov [cone], eax
          cinvoke bbPositionEntity, [cone], -3f, 0f, 5f
          cinvoke bbEntityColor, [cone], 255f, 32f, 32f

          cinvoke bbCreateCube, 0              ; parent null
          mov [cube], eax
          cinvoke bbPositionEntity, [cube], 0f, 0f, 6.5f
          cinvoke bbEntityColor, [cube], 70f, 155f, 30f

          cinvoke bbCreateSphere, 7, 0         ; detail level - 7, parent null
          mov [sphere], eax
          cinvoke bbPositionEntity, [sphere], 3f, 0f, 5f
          cinvoke bbEntityColor, [sphere], 0f, 128f, 255f

          cinvoke bbEntityClass, [cube]
          mov [class_name], eax    ; Save pointer to string

    main_loop:
          cinvoke bbKeyHit, KEY_ESCAPE ; Wait Esc
          or eax, eax
          jnz exit_from_main_loop

          cinvoke bbTurnEntity, [cube], 0.5f, 2f, 1f
          cinvoke bbTurnEntity, [cone], 0f, 1f, 0.5f
          cinvoke bbTurnEntity, [sphere], 2f, 1f, 0.5f

          cinvoke bbRenderWorld, 1     ; Render world to buffer

          cinvoke bbFlip, BBTRUE       ; Flip buffers
          jmp main_loop;
    exit_from_main_loop:
          cinvoke bbEndBlitz3D
          invoke ExitProcess,0

    section '.idata' import data readable writeable

    library kernel32,'KERNEL32.DLL',\
           user32,'USER32.DLL',\
           b3d,'B3D.DLL'

           include 'api\kernel32.inc'
           include 'api\user32.inc'
           include 'b3d.inc'

    section '.rsrc' resource data readable
           ICON equ '3D.ico'
           include 'res.inc'                      
          
# Simplified code with using blitz3d.inc

Using blitz3d.inc allows to greatly simplify the code.

However, with this approach, both the data and the executable code are in the same *.code* section, which is not very good.

On the positive side:
1. code sections are hidden from the main code, which reduces its size.
3. don't need to call bbBeginBlitz3D at the beginning of the code, this is done automatically.
3. No need to add: bbEndBlitz3D and ExitProcess at the end. A special macro adds this code to the end of the application automatically.

Among the shortcomings, it can also be noted that if you want to connect any other library or change resources, then it will be difficult for you to do this. In a simple way, no way.

        ; Line example
        include "blitz3d.inc"

        r dd 0
        g dd 0
        b dd 0
        x1 dd 0
        y1 dd 0
        x2 dd 0
        y2 dd 0

        start:
             ; Set The Graphic Mode
             cinvoke bbGraphics, 800, 600, 0, 0

             ; Set backbuffer
             cinvoke bbBackBuffer
             cinvoke bbSetBuffer, eax

             ; Wait for ESC to hit
        main_loop:
             cinvoke bbKeyHit, KEY_ESCAPE ; Wait Esc
             or eax, eax
             jnz exit_from_main_loop

             ; Set a random color
             rand [r],255
             rand [g],255
             rand [b],255
             cinvoke bbColor, [r], [g], [b]

             ; Draw a random line
             rand [x1],800
             rand [y1],600
             rand [x2],800
             rand [y2],600
             cinvoke bbLine, [x1],[y1],[x2],[y2]

             cinvoke bbFlip, 0

             jmp main_loop;
        exit_from_main_loop:  
        
# A simple Blitz3D functions replacement writed on Assembly x86 language:

## Basic functions

* [If](#if--then--else--endif)
* [Then](#if--then--else--endif)
* [Else](#if--then--else--endif) 
* [EndIF](#if--then--else--endif)
* [Select Case Default End Select](#select--case--default--end-select)
* [Const](#const)
* [Type Filed End Type New](#type--filed--end-type--new)

### If .. Then .. Else .. EndIF

In Assembly language, branching constructions such as If Then Endif are created using comparison commands and conditional jump commands.

For example, the following code in Blitz3D:

      If 5 > 2 Then 
         Print "5>2" 
      Else
         Print "5<=2" 
      EndIf

is equivalent to the following code in Assembly:

         mov eax, 5 
         mov ebx, 2 
         ja after 
         InPrint "5<=2" 
         jmp end_if 
      after:
         InPrint "5>2" 
      end_if:

The FASM compiler has more advanced macroses located in extended windows headers (which end in 'x'), for example, win32ax.inc has a set of extended macros, for example: *.if .else .elseif .endif .while .endw .repeat .until* . Also file win32ax.inc is included in blitz3d.inc by default. This short example shows how to use this macroses, this is very similar to high-level programming languages.

      .if eax<=100 & ( ecx | edx )
         inc ebx
      .endif
      
During the compilation process, the code above will be converted to this assembler instructions:

            cmp	eax, 100         ; 83 F8 64 - compare eax and 100 (64h)
            ja 	end_if           ; 77 09 - if eax > 100 goto end_if 
            test	ecx, ecx         ; 85 C9 - test, ecx is zero?
            jnz	if_block_start   ; 75 04 - if ecx == 0 goto if_block_start (+4 bytes from here)
            test	edx, edx         ; 85 D5 - test, edx is not zero?
            jz 	L0040370D        ; 74 01 - if ecx != 0 goto end_if (+1 byte from here)
       if_block_start:
            inc	ebx              ; 43 - ebx += 1
       end_if:

also can be noted that register without expression:

      .if ( eax | ebx )
      
is equivalent to compare register with zero:      

      .if ( eax == 0 | ebx == 0 )

### Select .. Case .. Default .. End Select

This is a rather difficult section for beginner programmers.
The Select-Case construct in Blitz3d is slightly different from the classic Switch-Case construct like in C++\C#\Java languages.
In the initial stages, you can simply use the cmp + jmp chains to replace the Select-Case construct.
But in practice, in Assembly language used a more complex and more efficient construction, which includes a jump table.
Full exaple [here](/help/asm_commands/2D_Commands/Basic/Select_Case_Default.asm)

           rand [mission], 0, 7   ; random mission number
           InPrint "Mission %d:", [mission]
           mov eax,[mission]

           cmp eax,(case_table_end-case_table)/4 ; 5
           jae default
           jmp dword [case_table+eax*4]

      mission dd 0

      case_table:
           dd case_0
           dd case_1
           dd case_2
           dd case_3
           dd case_4
      case_table_end:

      case_1:
           InPrint "Your mission is to get the plutonium and get out alive!"
           jmp end_select
      case_2:
           InPrint "Your mission is to destroy all enemies!"
           jmp end_select
      case_3:
           InPrint "Your mission is to steal the enemy building plans!"
           jmp end_select
      case_4:
           InPrint "This is final mission!"
           jmp end_select
      case_0:
      default:
           InPrint "Information about mission %d is not found!", eax
      end_select:   

This may works much faster than the cmp + jmp chain.
If use call instead of jmp, then can essentially make a VMT table as in high-level languages.

### Const

In assembly language, constants are not allocated memory in special place; values are simply substituted into the specified places during the assembly process (in instructions, data cells, etc...).

Blitz3D code:

      Const name = 123

Assembler equivalent:

      name equ 123

### Type .. Filed .. End Type .. New

Instead of TYPE's in assembly language, is possible to use structures. That looks like this:

      ; Structure declaration
      struct color
              red dd ?
              green dd ?
              blue dd ?
      ends

      ; Create data from structure
      cls_color color 255, 128, 64

      ; Data modification
      mov [color.red], 128    

Which is *almost* equivalent to the Blitz3D code:

      ; Structure declaration
      Type my_color
      Field red
      Field green
      Field blue
      End Type 

      ; Create data from structure
      cls_color.my_color = New my_color
      cls_color\red = 255
      cls_color\green = 128
      cls_color\blue = 64
      
Blitz3D works with Types as *dynamic data arrays*, while in assembler structures is necessary to allocate the exact amount of memory for data. 

### True

In Aseembler, this constant is named *BBTRUE* , has a dword size, is equal to 1 and it is located in "blitz3dsdk.inc"
Also is possible to use just 1 instead of named constant. However, this will make the code less clear, because then it will lose the meaning that the given value is a boolean.

### False 

In Aseembler, this constant is named *BBFALSE* , has a dword size, is equal to 0 and it is located in "blitz3dsdk.inc"
Also is possible to use just 0 instead of named constant. However, this will make the code less clear, because then it will lose the meaning that the given value is a boolean.

### Null

In Assembly language, Null is simply replaced by 0.

Also is possible to create a constant:

      Null equ 0

and use it in the code anywere:

      cmp [object], Null 
      je object_is_null

If say more specific, Null is zero adress value, and means the of an object that no exist. It is used to determine whether an object exists or whether it was created after a certain function was executed. Assembly language is not a high-level language. In it, an object is simply an address (pointer) to the memory location where data about the object is stored. An object cannot exist at address zero, which is the beginning of the code. Therefore, the null address is accepted as an indication that there is no object.

For example, when using certain functions, it is necessary to specify a parent object, even if one does not exist, like CreateCube, CreateCone, CreateCamera etc... In such cases as with a rose, you can use 0.

      cinvoke bbCreateSphere, 7, 0  ; create sphere with detail level = 7, parent = null

## Goto label

The equivalent of Goto in assembler is the *jmp* instruction.

In Blitz3D, labels are marked by a period at the beginning of the line. In assembly language, labels are marked by a colon at the end of the label name, and an instruction may follow the label or data may be specified.

This assembler code:

         jmp label1:
         InPrint "This line never gets printed .." 
      label1:

Fully equivalent to blitz3d code:

      Goto label1 
      Print "This line never gets printed .." 
      .label1 

## Include file

FASM has the *include* directive that allows to insert the contents of another source file into the code. Note that *include* is not an instruction of the assembly language, it is a FASM compiler directive, and it is only used during the assembly process.

Example of using (this code is used in almost every example):

      include "blitz3d.inc"

## x87 FPU Basics

### Useful links

Float <-> hex and double <-> hex [Online converter](https://gregstoll.com/~gregstoll/floattohex/)  
[Online Assembler and Disassembler](https://shell-storm.org/online/Online-Assembler-and-Disassembler/) will help find out how many bytes an instruction takes

### Loading values to FPU

The FPU does not allow loading values into itself directly, loading data is only possible from a memory cell.

      value dd 123.4567f
      ...
      code_start:
            fld [value]

In some cases, it is more convenient to use a stack instead of variables to load values.

      push 123.4567f         ; 68 D5 E9 F6 42 - load float value to stack
      fld dword [esp]        ; D9 04 24 - load value from stack to FPU
      add esp, 4             ; 83 C4 04 - clear stack (remove 4 bytes)

This method is also convenient for loading standard registers into the FPU.

      push eax               ; 50 - load integer value eax to stack
      fild dword [esp]       ; D9 04 24 - load integer value from stack to FPU
      add esp, 4             ; 83 C4 04 - clear stack (remove 4 bytes)

To clear the stack, instead of add esp,4 , is possible to use the pop register instruction, it takes 1 byte, unlike add, which takes 3 bytes. But at the same time, data is lost in the register in which the pop is made.

      pop eax                ; 58 - only one byte instead 3 bytes: 83 C4 04 of add esp, 4

## Maths functions

### Sin, Cos and Tan

For Sin, Cos Tan functions is need's to create coefficinet varible (in the data section or in the non-executable fragment of the code section). Varible must be contain pi/180 value:

      pi_div_180   dd	0.0174533f	; float pi/180 = 0.0174533f or 3C8EFA35h in hex

This value is needed to calculate trigonometric functions in degrees.

### Sin(degrees_value)

      fld	dword [pi_div_180]      ; D9 05 xx xx xx xx
      fmul	dword [degrees_value]   ; D8 0D xx xx xx xx
      fsin                          ; D9 FE
      fstp  dword [result]          ; D9 1D xx xx xx xx 
   
### Cos(degrees_value)

      fld	dword [pi_div_180]      ; D9 05 xx xx xx xx
      fmul	dword [degrees_value]   ; D8 0D xx xx xx xx
      fcos                          ; D9 FF 
      fstp  dword [result]          ; D9 1D xx xx xx xx 

### Tan(degrees_value)

The *fptan* instruction pushes two values on the top of the stack: sine (sin(x)) and cosine (cos(x)). The cosine (cos(x)) is not used in this code and is simply removed from the stack with "fstp st(0)".

      fld	dword [pi_div_180]
      fmul	dword [degrees_value]
      fptan
      fstp	ST0               ; remove cos(x)
      fstp  dword [result]    ; save sin(x)
      
### Rnd(from , to)

This assembler code:

      ; Rand example
      include "blitz3d.inc"

      val dd 0

      rnd_state dd 0x1234
      _1_div_65536 dd 0x37800000     ; dd    37800000h = 1f/65536f = 0.0000152587891f
      _0_5_div_65356 dd 0x37000000   ; dd    37000000h = 0.5f/65536f  = 0.00000762939453f

      Rnd:
            push      ecx
            push      esi
            mov       esi,[rnd_state] ; get rnd_state
            mov       eax,esi
            cdq
            mov       ecx,0000ADC8h   ; constant RND_Q=44488
            idiv      ecx
            mov       eax,5E4789C9h   ; constant 1581746633
            mov       ecx,edx
            imul      esi
            sar       edx,14 ;0Eh
            imul      ecx,0000BC8Fh   ; constant RND_A=48271
            mov       eax,edx
            shr       eax,31; 1Fh
            add       edx,eax
            lea       eax,[edx+edx*4] ; 5
            lea       eax,[edx+eax*4] ; 1 + 5*4 = 21
            lea       eax,[eax+eax*8] ; 21 * 9 = 189
            lea       eax,[eax+eax*2] ; 189 * 3 = 567
            shl       eax,1           ; 567 * 2 = 1134
            sub       eax,edx         ; 1134 - 1 = 1133
            lea       edx,[eax+eax*2] ; 1133 * 3 = 3399 ; * RND_R=3399 
            sub       ecx,edx
            mov       [rnd_state],ecx ; save seed
            pop       esi
            jns       rnd_sate_less_than_zero ; if rnd_state < 0 
            add       ecx,7FFFFFFFh   ; constant RND_M=2147483647
            mov       [rnd_state],ecx ; save seed
      rnd_sate_less_than_zero:
            and       ecx,0000FFFFh           ; rnd_state & 65535
            mov       [esp+00h],ecx
            fild      dword [esp+00h]         ; rnd_state & 65536
            fmul      dword [_1_div_65536]
            fadd      dword [_0_5_div_65356]
            fld       dword [esp+0Ch]  ; to
            fsub      dword [esp+08h]  ; to-from
            fmulp     ST1,ST
            fadd      dword [esp+08h]  ; + from
            pop       ecx
            retn      8

      start:
           ; Set The Graphic Mode
           cinvoke bbGraphics, 400, 300, 0, 0

           InPrint "Assembler x86 Rnd example"
           InPrint "RndSeed = %d", [rnd_state]

           ; Generate 20 random numbers between 1 and 100
           mov ecx, 20
      next_value:
           push ecx
           push dword 100f   ; to
           push dword 50f    ; from
           call Rnd
           fistp dword [val] ; get value from FPU
           pop ecx
           push ecx
           InPrint "Random value no %d = %d", ecx, [val]
           pop ecx
           dec ecx
           jns next_value   ; Use jns for 20..0 cycles, or jnz for 20..1 cycles

           cinvoke bbFlip   ; Show screen buffer
           cinvoke bbWaitKey  

Fully equivalent to blitz3d code:

      Print "Blitz3D Rnd example"     
      Print "RndSeed = "+RndSeed()

      For i=20 To 0 Step -1:
         val = Rnd(50,100)
         Print "Random value no " + i + " = " + val
      Next

      WaitKey



The results of the operation in blitz3d and assembler are equivalent:
![изображение](https://github.com/Blitz3DFASM/Blitz3DFASMSDK/assets/133161792/d8924c72-5b42-48d7-8311-ce36e8883e28)

