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

        mov     eax,a_xyz
        mov     ecx,b_xyz
        fld     dword [ecx]
        fsub    dword [eax]
        fld     dword [ecx+4]
        fsub    dword [eax+4]
        fld     dword [ecx+8]
        fsub    dword [eax+8]
        fld     ST0
        fmulp   ST1,ST
        fld     ST1
        fmulp   ST2,ST
        faddp   ST1,ST
        fld     ST1
        fmulp   ST2,ST
        faddp   ST1,ST
        fsqrt

