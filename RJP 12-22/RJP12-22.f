C   William Ersing
C   RJP 12-22

C   Numerically integrate the Maxwell-Boltzman speed distribution 
C   function for 10,000 diatomic nitrogen molecules @ T = 300K
C   from Vi to Vf in steps of size dV. The purpose is to determine
C   the number of molecules that have speed between V and V + dV
C   for each step, dV. All velocities are in m/s.
      Real :: Mass, Kconst, Ntot, Nv, Nvdv
      Integer :: dv, vi, vf, v, Rows, Steps
      Open (1, File='RJP 12-22 Output.txt')
      Open (2, File='RJP 12-22 Table.txt')
      Print *, 'Enter integer values for dv, vi, vf'
      Read *, dv,vi,vf
C     Variables used
      v = vi
C     v = (dv / 2) + vi
      T = 300
      Mass = 2.32E-26
      Kconst = 1.38E-23
      Ntot = 1.00E4
      Steps = (abs(vf - vi) / dv) + 1
      pi = 3.14
      C1 = (4 * Ntot) / (sqrt(pi)) * (sqrt(Mass / (2 * Kconst * T))**3)
      C2 = (Mass / (2 * Kconst * T))
      Nvdv=0.0
C     Column headings for 'Output' file
      Write(1,100)
  100 Format(9x,'Step',7x,'v',7x,'Nv',7x,'Nvdv',/)
C     Title (first page) for 'Table' file
      Write(2,200)
  200 Format(///,45x,'RJP 12-22 - TABLE',/)
      Write(2,210)
  210 Format(32x,'The number of molecules with speed between')
      Write(2,220)
  220 Format(36x,'v and v + dv for each interval dv',//)
C     Column headings (first page) for 'Table' file
      Write(2,300)
  300 Format(41x,'v',8x,'Nv',8x,'Nvdv'/)
C     Begin Row count
      Rows = 0
C     Calculates speed probability, (P), number of particles with speed
C     between v and v + dv for each step dv, (Ndv), and total number
C     of particles with speed between vi and vf, (Nvdv)
      Do 900, i = 1, Steps
            P = (C1 * v**2) * (exp(-C2 * v**2))
            Nv = P * dv 
            Nvdv = Nvdv + Nv
C           Populate 'Output' file with values
            Write(1,400) i, v, Nv, Nvdv
C           Data formatting for 'Output' file
  400       Format(5x,i7,4x,i5,2x,f7.3,2x,f9.3)
C           Populate 'Table' file with values
            Write(2,800) v, Nv, Nvdv
            Rows = Rows + 1
C           Define page cutoff
            If(Rows.eq.51) Then
            Write(2,500)
  500       Format(//////////)
C           Restart row count for next page
            Rows = 0
C           Title (subsequent pages) for 'Table' file
            Write(2,600)
  600       Format(38x, 'RJP 12-22 - TABLE (Continued)',//)
C           Column heading (subsequent pages) for 'Table' file
            Write(2,700)
  700       Format(41x,'v',8x,'Nv',8x,'Nvdv'/)
            Else
            Continue
            Endif
C           Data formatting for 'Table' file
  800       Format(37x,i5,4x,f7.3,4x,f9.3)
C           Displays data in the console
            Print *, i,'  v=',v,'  Nv=',Nv,'  Nvdv=',Nvdv  
            v = v + dv
  900       Continue
      Close(1)
      Close(2)
      End
