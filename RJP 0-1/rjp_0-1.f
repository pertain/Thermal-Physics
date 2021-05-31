C RJP 0-1
C Compute values of X and Y for a given function
      Open(1, file='RJP 0-1 Table.txt')
      Open(2, file='RJP 0-1 Data.txt')
      Print *, 'Enter step size, DelX, and boundaries, Xi, Xf'
      Read *, DelX,Xi,Xf
C Table title (first page)
      Write(1,100)
  100 Format(34x,'RJP 0-1')
      Write(1,110)
  110 Format(34x,'Table 1',//)
C Column heading (first page)
      Write(1,200)
  200 Format(29x,'X',15x,'Y',/)
C Begin Row count
      K=0
C Variables
      N=((Abs(Xf-Xi))/DelX)+2
      X=Xi
C Begin loop
      Do 800, i=1,N
      Z=((X**2)/30)
      Y=((X**2)*exp(-Z))
C Write data to output file
      Write(2,600) X,Y
      Write(1,700) X,Y
      K=K+1
C Define page cutoff
      If(K.eq.51) Then
      Write(1,300)
  300 Format(2x)
C Restart row count for next page
      K=0
C Table title (subsequent pages)
      Write(1,400)
  400 Format(34x,'RJP 0-1')
      Write(1,410)
  410 Format(29x, 'TABLE 1 Continued',//)
C Column heading for subsequent pages
      Write(1,500)
  500 Format(29x,'X',15x,'Y',/)
      Else
      Continue
      Endif
C Format table data
  600 Format(27x,f5.2,10x,f6.3,5x)
  700 Format(27x,f5.2,10x,f6.3,5x)
      Print *,'X=',X,'Y=',Y
      X=X+DelX
C End loop
  800 Continue
      Close(1)
      Close(2)
      End
