
pro lookup_goft, ion=ion, w0=w0, gotdir=gotdir,n_e_lg=n_e_lg, logt=logt, goft_mat=goft_mat, watom=watom, filenm=filenm

if keyword_set(ion) eq 0 then begin
   print,'Check input directories'
   print,'lookup_goft, ion=ion, w0=w0, gotdir=gotdir,n_e_lg=n_e_lg, logt=logt, goft_mat=goft_mat, watom=watom, filenm=filenm'
   return
endif

; Returns G(T,n) values reading dat files created by table_goft.pro

; INPUT:
; ion: (string) acronym of the ion or filter number in case of SDO/AIA filter
; w0: (float) wavelength of line center (not needed for SDO/AIA filter)
; gotdir: (string) directory path to where the .dat G(T,n) file is.
; filenm: (string) name helping defining the .dat file. Necessary for
; SDO/AIA filter: set filenm = 'aia'

; OUTPUT:
; n_e_lg: number density array (logarithm) where G(T,n) is defined
; logt: temperature array (logarithm) where G(T,n) is defined
; goft_mat: G(T,n) function evaluated at (n_e, t)
; watom = get_atomic_weight(enum), where enum is the nuclear charge of element

if keyword_set(w0) then w0nm = string(round(w0),format='(i4.4)')

; by default it looks for tables in which coronal abundances are included:
nab = '_abco'

if keyword_set(filenm) then filegot = 'goft_table_'+filenm+ion+nab+'.dat' else filegot = 'goft_table_'+ion+'_'+w0nm+nab+'.dat'

if file_test(gotdir+filegot) eq 0 then begin
   print,'G(T,n) table could not be found'
   filename = dialog_pickfile(filter='*.dat',/read) 
endif else begin 
   filename = gotdir+filegot
endelse
print,'G(n,T) table: '+filegot

  watom = 0
  openr,unit,filename,/get_lun
  readf,unit,ion
  readf,unit,w00
  readf,unit,watom
  readf,unit,numn,numt
  logt = fltarr(numt)
  readf,unit,logt
  goft_mat = fltarr(numn,numt)
  n_e_lg = dblarr(numn)
  g_t = fltarr(numt)
  i = 0

  while(eof(unit) eq 0) do begin
     readf,unit,n_e_0
     readf,unit,g_t
     goft_mat[i,*] = g_t
     n_e_lg[i] = n_e_0
     i = i+1
  endwhile
  free_lun,unit
end
