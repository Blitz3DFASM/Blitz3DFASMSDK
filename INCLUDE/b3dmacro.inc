_strBuffer rb 512

macro InText x, y, text, par&
{
   local text_str, skip
   jmp skip
text_str db text,0
skip:
if par eq
   cinvoke bbText, x, y, text_str, BBFALSE, BBFALSE
else
   cinvoke wsprintf, _strBuffer, text_str, par
   cinvoke bbText, x, y, _strBuffer, BBFALSE, BBFALSE
end if
}

macro InPrint text, par&
{
   local text_str, skip
   jmp skip
text_str db text,0
skip:
if par eq
   cinvoke bbPrint, text_str
else
   cinvoke wsprintf, _strBuffer, text_str, par
   cinvoke bbPrint, _strBuffer
end if
}

rsx1   dd 0x87654321
rsx2   dd 0x12345678
rnd_result dd 0

randomuse = 0
macro rand res, min, max
{
      local rndproc, nodiv
randomuse = randomuse + 1

if defined randomuse & randomuse = 1
      jmp rndproc
randomproc:
      inc edi
      mov ecx, edi
      sub ecx, esi
      mov eax,[rsx1]
      mov ebx,[rsx2]
      mov dl,ah
      mov ah,al
      mov al,bh
      mov bh,bl
      xor bl,bl
      rcr dl,1
      rcr eax,1
      rcr ebx,1
      add ebx,[rsx2]
      adc eax,[rsx1]
      add ebx,0x62e962e9
      adc eax,0x36193619
      mov [rsx1],ebx
      mov [rsx2],eax
      xor edx,edx
      cmp eax,0
      je nodiv
      cmp ecx,0
      je nodiv
      div ecx           ; ecx max val (edi-esi)
nodiv:
      add edx,esi
      ret
rndproc:
end if
if max eq
      mov esi,0
      mov edi,min ; (max)
else
      mov esi,min
      mov edi,max
end if
      call randomproc
      mov res,edx
} 

macro pushrand min, max
{
if max eq
   rand eax, 0, min
   push eax
else
   rand eax, min, max
   push eax
end if
}
