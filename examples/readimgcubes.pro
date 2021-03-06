
pro readimgcubes, set=set, co,ce,ro,re,va,vae,aa,dimt,tarr,r0,ka_rt,wk_rt,wave, gridx, gridy, gridz,gridz_ext, imgcube00d=imgcube00d,imgcube30d=imgcube30d,imgcube45d=imgcube45d,imgcube60d=imgcube60d,ion=ion

if n_params(0) lt 1 then begin
   print,'readimgcubes, set=set, co,ce,ro,re,va,vae,aa,dimt,tarr,r0,ka_rt,wk_rt,wave, gridx, gridy, gridz,gridz_ext, imgcube00d=imgcube00d,imgcube30d=imgcube30d,imgcube45d=imgcube45d,imgcube60d=imgcube60d,ion=ion'
   return
endif

;  dimx = 204 & nwave = 100 & dimt = 30
  if set eq 2 then begin
;     dim00d = 342 & dim30d = 398 & dim45d = 386 & dim60d = 348
     dir = '/volume1/scratch/set2/'
     dir2 = dir
;     dir2 = '/users/cpa/pantolin/Modeling/cubes/set2/'
     ka_n = '_ka2.24'
     ion = 'fe9'
  endif
  if set eq 23 then begin
;     dim00d = 342 & dim30d = 398 & dim45d = 386 & dim60d = 348
     dir = '/volume1/scratch/set2/193/'
     dir2 = '/volume1/scratch/set2/'
;     dir2 = '/users/cpa/pantolin/Modeling/cubes/set2/'
     ka_n = '_ka2.24'
     ion = 'fe12'
  endif
  if set eq 21 then begin
;     dim00d = 342 & dim30d = 398 & dim45d = 386 & dim60d = 348
     dir = '/volume1/scratch/set2/high_T/'
     dir2 = '/volume1/scratch/set2/high_T/'
;     dir2 = '/users/cpa/pantolin/Modeling/cubes/set2/'
     ka_n = '_ka2.24_highT'
     ion = 'fe9'
  endif
  if set eq 22 then begin
;     dim00d = 342 & dim30d = 398 & dim45d = 386 & dim60d = 348
     dir = '/volume1/scratch/set2/sm/'
     dir2 = '/volume1/scratch/set2/sm/'
;     dir2 = '/users/cpa/pantolin/Modeling/cubes/set2/'
     ka_n = '_ka2.24_sm'
     ion = 'fe9'
  endif
  if set eq 24 then begin
;     dim00d = 342 & dim30d = 398 & dim45d = 386 & dim60d = 348
     dir = '/volume1/scratch/set2/hgres/fe9/angs/'
;     dir = '/volume1/scratch/set2/hgres/fe9/'
;     dir = '/users/cpa/pantolin/Modeling/cubes/set2/'
;     dir2 = dir
     dir2 = '/volume1/scratch/set2/hgres/'
     ka_n = '_ka2.24_hgres'
     ion = 'fe9'
  endif
  if set eq 25 then begin
;     dim00d = 342 & dim30d = 398 & dim45d = 386 & dim60d = 348
;     dir = '/users/cpa/pantolin/Modeling/cubes/set2/'
     dir = '/volume1/scratch/set2/hgres2d/'
;     dir2 = '/users/cpa/pantolin/Modeling/cubes/set2/'
     dir2 = dir
     ka_n = '_ka2.24_hgres2d'
     ion = '.fe9'
  endif
  if set eq 26 then begin
;     dim00d = 342 & dim30d = 398 & dim45d = 386 & dim60d = 348
;     dir = '/users/cpa/pantolin/Modeling/cubes/set2/'
     dir = '/volume1/scratch/set2/hgres2d/'
     dir2 = dir
     ka_n = '_ka2.24_hgres2d'
     ion = '.fe12'
  endif
  if set eq 3 or set eq 31 then begin
;     dim00d = 404 & dim30d = 452 & dim45d = 430 & dim60d = 379
     dir = '/volume1/scratch/set3/'
     dir2 = dir
     ka_n = '_ka1.25'
     ion = 'fe9'
  endif
  
restore,dir+'imgcubes'+ka_n+'_'+ion+'.sav'
if ion eq 'fe9' and set eq 24 then restore,'/volume1/scratch/set2/hgres/fe9/imgcubes_ka2.24_hgres_00d_fe9.sav'
restore,dir2+'params'+ka_n+'.sav'

end
