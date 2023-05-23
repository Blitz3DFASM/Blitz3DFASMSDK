# 3D Commands

## Enitiy State

### EntityDistance

Function returns the distance between centers of src_entity and dest_entity. 

The distance between two points in 3D space can be calculated by the formula:

      float Vector_distance( const Vector &a, const Vector &b )const{
          float dx=a.x-b.x;
          float dy=a.y-b.y;
          float dz=a.z-b.z;
          return sqrtf(dx*dx+dy*dy+dz*dz);
      }

Which is equivalent in assembly language to:

        mov     eax,a_xyz        ; Load pointer to the coordinates of point a into the eax register
        mov     ecx,b_xyz        ; Load pointer to the coordinates of point b into the ecx register
        
        ; Сalculate the coordinates difference for each axis:
        fld     dword [ecx]       ; ST0 = a.x
        fsub    dword [eax]       ; ST0 = a.x-b.x
        fld     dword [ecx+4]     ; ST0 = a.y    ; ST1 = a.x-b.x
        fsub    dword [eax+4]     ; ST0 = a.y-b.y; ST1 = a.x-b.x
        fld     dword [ecx+8]     ; ST0 = a.z    ; ST1 = a.y-b.y; ST2 = a.x-b.x
        fsub    dword [eax+8]     ; ST0 = a.z-b.z; ST1 = a.y-b.y; ST2 = a.x-b.x
        
        ; Calculate the square of the length of the difference vector a and b:
        fld     ST0               ; ST0 = a.z-b.z                         ; ST1 = a.z-b.z
        fmulp   ST1,ST            ; ST0 = (a.z-b.z)^2                     ; ST1 = a.y-b.y*(a.z-b.z)
        fld     ST1               ; ST0 = a.y-b.y*(a.z-b.z)               ; ST1 = a.y-b.y*(a.z-b.z)
        fmulp   ST2,ST            ; ST0 = (a.y-b.y*(a.z-b.z))^2           ; ST1 = a.x-b.x*(a.y-b.y*(a.z-b.z))
        faddp   ST1,ST            ; ST0 = (a.y-b.y*(a.z-b.z))^2 + a.x-b.x*(a.y-b.y*(a.z-b.z)); ST1 = a.x-b.x*(a.y-b.y*(a.z-b.z))
        fld     ST1               ; ST0 = a.x-b.x*(a.y-b.y*(a.z-b.z))     ; ST1 = a.x-b.x*(a.y-b.y*(a.z-b.z))
        fmulp   ST2,ST            ; ST0 = (a.x-b.x*(a.y-b.y*(a.z-b.z)))^2

        ; Calculate the square root of the obtained value:
        fsqrt                     ; ST0 = sqrt((a.x-b.x*(a.y-b.y*(a.z-b.z)))^2)





