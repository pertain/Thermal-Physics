C RJP 2-30

C  Use the ideal gas law to find the specific volume of carbon dioxide
C  when pressure and temperature are known. Substitute this value into
C  the squared term in Van der Waals equation and solve for the v term.
C  Now substitute the newly acquired value of v into the squared term of
C  Van der Waals equation again and solve for the v term again. Repeat
C  the steps involving Van der Waals equation until the fifth decimal
C  place remains static.

      Open(1, file='RJP 2-30 Table.txt')
      Print *, 'Enter Pressure, Temp, & number of steps, N'
      Read *, Pressure,Temp,N


C  Table title (first page)
      Write(1,100)
  100 Format(38x,'TABLE 1',//)
      Write(1,110)
  110 Format(21x,'Iterative solution for the specific volume'/)
      Write(1,120)
  120 Format(23x,'of a compressed tank of carbon dioxide',//)
C  Column heading (first page)
      Write(1,200)
  200 Format(26x,'Iteration',16x,'v',//)
C  Begin Row count
      K = 0
C  Variables
C     Gas constant
      R = 8.31E3
C     Van der Waals constants for carbon dioxide
      aConstant = 366E3
      bConstant = 0.0429
      RT = R * Temp
C     Initial specific volume (obtained from the ideal gas law)
      v0 = RT/Pressure
      vPrevious = v0

C Begin loop
      Do 700, i=1,N
C     Iterate Van der Waals equation
      A = (aConstant / (vPrevious**2))
      B = Pressure + A
      C = RT / B
      vNew = C + bConstant
C      vf = (RT/(P+(a/(v**2))))+b
C Write data to output file
      Write(1,600) i,vNew
      K = K + 1
C Define page cutoff
      If(K.eq.50) Then
      Write(1,300)
  300 Format(2x)
C Restart row count for next page
      K = 0
C Table title (subsequent pages)
      Write(1,400)
C  400 Format(34x,'RJP 2-30')
C     Write(1,410)
  400 Format(33x, 'TABLE 1 Continued',//)
C Column heading for subsequent pages
      Write(1,500)
  500 Format(26x,'Iteration',16x,'v',/)
      Else
      Continue
      Endif
C Format table data
C 600 Format(24x,i8,15x,f10.8,10x)
  600 Format(24x,i8,15x,f10.8,10x)
      Print *,'Iteration=',i,'v=',vNew
      vPrevious = vNew
C End loop
  700 Continue
      Close(1)
      End
