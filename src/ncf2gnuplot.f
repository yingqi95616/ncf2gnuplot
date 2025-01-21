      program relative_contr
c******************************************************************************
c
c The relative contribution of different VOC sources to NO -> NO2 conversion.
c
c Written by: Qi Ying
c
c******************************************************************************
      implicit none

c ioapi headers
      INCLUDE 'PARMS3.EXT'      ! I/O parameters definitions
      INCLUDE 'FDESC3.EXT'      ! file header data structure
      INCLUDE 'IODECL3.EXT'     ! I/O definitions and declarations

c name of the program
      CHARACTER*16 pname
      DATA pname/'extract_data'/
      INTEGER       LOGUNIT
      CHARACTER*16 Sfenv, sfenvout
      CHARACTER*256 Sfile, sfout
      LOGICAL, external ::  SETENVVAR

      integer nfiles
      real, allocatable :: rdata(:,:), rdata1(:,:)
      character*16 sname
      integer itime1, idate1, ilayer1, ilayer2
      integer t, itime, idate, ierr
      integer i,j,k,n, ix,iy
      character*1 cc
      real rmax, rmin
      real rscale

      rscale=1.0

c start IOAPI
      LOGUNIT = INIT3()

      read (*,'(a)') sname
      read (*,*) idate1, itime1
      read (*,*) ilayer1, ilayer2

c read input file name
      read (*,'(a)') sfile
c set input filename to enviromental variable
      SFENV='SFILE'
        IF ( .NOT.SETENVVAR(Sfenv,Sfile) )
     &      CALL M3EXIT(pname,0,0,'FAIL TO SET INPUT FILE',-1)
c open input file
        IF ( .NOT.OPEN3(SFENV,FSREAD3,pname) )
     &      CALL M3EXIT(pname,0,0,'FAIL TO OPEN INPUT FILE',-1)
c get file description
        IF ( .NOT.DESC3(SFENV) )
     &      CALL M3EXIT(pname,0,0,'FAIL TO GET FILE DESC',-1)

c allocate memory for the output variable
        allocate(rdata(ncols3d, nrows3d),stat=ierr)
        if (ierr.ne.0)
     &   CALL M3EXIT(pname,0,0,'FAIL TO ALLOCATE MEMORY FOR rdata',-1)
        allocate(rdata1(ncols3d, nrows3d),stat=ierr)
        if (ierr.ne.0)
     &   CALL M3EXIT(pname,0,0,'FAIL TO ALLOCATE MEMORY FOR rdata1',-1)

c read the input values 
      print *,mxrec3d,ncols3d, nrows3d, nlays3d, tstep3d
      print *,nvars3d,(vname3d(i),i=1, nvars3d)
      rdata=0.

      do i=ilayer1, ilayer2
120   IF ( .NOT.READ3(SFENV,sname,ilayer1,idate1,itime1,rdata1))
     +       CALL M3EXIT (pname,0,0,'FAIL TO READ DATA',-1)
      do ix=1, ncols3d
        do iy=1, nrows3d
          rdata(ix,iy)=rdata(ix,iy)+rdata1(ix,iy)
        enddo
      enddo
      enddo

c find max and min
      rmax=-1e20
      rmin=1e20

      do ix=1, ncols3d
        do iy=1, nrows3d
          if (rdata(ix,iy).ne.rdata(ix,iy)) then 
            rdata(ix,iy)=0.0
            continue
          endif
          rmax=max(rmax, rdata(ix,iy))
          rmin=min(rmin, rdata(ix,iy))
        enddo
      enddo

c write output for plotting program
      read (*,'(a)') sfout
      open (unit=1, file=sfout, status='unknown')
      DO j =  1, nrows3d
         WRITE (1,'(250(E12.5,1X))') (rdata(i,j)*rscale,i=1,ncols3d),
     +            (rdata(ncols3d,j)*rscale)
!         WRITE (1,'(E12.5)') (rdata(i,j)*rscale,i=1,ncols3d),
!     +            (rdata(ncols3d,j)*rscale)
      ENDDO
c the additional line is needed because gnuplot assumes data at grid
c cell edge instead of center.
      j=nrows3d
      WRITE (1,'(250(E12.5,1X))') (rdata(i,j)*rscale,i=1,ncols3d),
     +            (rdata(ncols3d,j)*rscale)

      write (1,*) '#'
      write (1,*) rmin, rmax
      CLOSE (1)

c program completed
      call m3exit(pname,0,0,'Successful completion of program.',0)
      end

