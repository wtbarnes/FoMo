
pro params, set, it, ix, ro, re, va, vae, co, ce, aa, r0, gridx, gridy, gridz, dimx, dimy, dimz, tarr, kafix, ka_rt, wk_rt, te, rho, vr, vz, velx, vely, velz

if n_params(0) lt 1 then begin
   print,'params, set, it, ix, ro, re, va, vae, co, ce, aa, r0, gridx, gridy, gridz, dimx, dimy, dimz, tarr, kafix, ka_rt, wk_rt, te, rho, vr, vz, velx, vely, velz'
   return
endif

; Read paramaters from params_'+kanm+'.sav file and from one
; slice'...'.sav file determined by set, ix and it
; INPUT:
; set = case considered: 
;       set = 2 -> base model ka = 2.24
;       set = 21 -> high T model (base model with high external temp.)
;       set = 22 -> smooth model (base model with smooth density prof.)
;       set = 24 -> hgres model (base model with high spatial resolution)
;       set = 3 -> long lambda model (longer wavelength, ka = 1.25)
; it = time step
; ix = position along x axis (radial axis)
; OUTPUT:
; ro = internal density: rho[dimx/2,dimy/2,dimz/2]
; re = external density: rho[0,0,0]
; va = internal Alfven velocity: calculated at (dimx/2,dimy/2,dimz/2)
; vae = external Alfven velocity: calculated at (0,0,0)
; co = internal sound speed: calculated at (dimx/2,dimy/2,dimz/2)
; ce = external sound speed: calculated at (0,0,0)
; aa = radius of cylinder
; r0 = center value of grid along x axis : gridx[-1]/2
; gridx = grid along x axis (radial direction)
; gridy = grid along y axis (radial direction)
; gridz = grid along z axis (longitudinal direction)
; dimx = number of points along x axis
; dimy = number of points along y axis
; dimz = number of points along z axis
; tarr = time array
; wk_rt = w/k solutions corresponding to trapped modes
; ka_rt = ka values of w/k solutions corresponding to trapped modes
; kafix = location in ka_rt array of the ka value considered
; te = (y,z) array of temperature at position ix and time it
; rho = (y,z) array of density at position ix and time it
; vr = (y,z) array of radial velocity at position ix and time it
; vz = (y,z) array of longitudinal velocity at position ix and time it
; velx = (y,z) array of velocity along x at position ix and time it
; vely = (y,z) array of velocity along y at position ix and time it
; velz = (y,z) array of velocity along z at position ix and time it

;if set eq 2 then begin dir = '/volume1/scratch/set2/' & kanm = 'ka2.24' & endif
;if set eq 3 then begin dir = '/volume1/scratch/set3/' & kanm = 'ka1.27' & endif

if set eq 2 then begin dir = '/users/cpa/pantolin/Modeling/cubes/set2/' & kanm = 'ka2.24' & endif
if set eq 24 then begin dir = '/users/cpa/pantolin/Modeling/cubes/set2/' & kanm = 'ka2.24_hgres' & endif
if set eq 21 then begin dir = '/users/cpa/pantolin/Modeling/cubes/set2/' & kanm = 'ka2.24_highT' & endif
if set eq 22 then begin dir = '/users/cpa/pantolin/Modeling/cubes/set2/' & kanm = 'ka2.24_sm' & endif
if set eq 3 then begin dir = '/users/cpa/pantolin/Modeling/cubes/set3/' & kanm = 'ka1.25' & endif
;snum = fix(strmid(slize,11,3))
   
restore,dir+'params_'+kanm+'.sav'
restore, dir+'slice_'+kanm+'_'+string(it,format='(i3.3)')+'t_'+string(ix,format='(i3.3)')+'x'+'.sav'
;   restore,'cubes_'+string(it,format='(i3.3)')+'.sav'
gridx0=gridx
gridx = gridx0[ix]
sizes = size(te)
dimx = sizes[1] & dimy = sizes[2] & dimz = sizes[3]
velx = fltarr(dimx,dimy,dimz)
vely = fltarr(dimx,dimy,dimz)
velz = fltarr(dimx,dimy,dimz)

for i=0,dimx-1 do begin
   for j=0,dimy-1 do begin
      velx[i,j,*] = vr[i,j,*]*(gridx[i]-r0)/sqrt((gridx[i]-r0)^2+(gridy[j]-r0)^2)
      vely[i,j,*] = vr[i,j,*]*(gridy[j]-r0)/sqrt((gridx[i]-r0)^2+(gridy[j]-r0)^2)
   endfor
endfor
velz = vz

end