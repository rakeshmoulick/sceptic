c Example of drawing a 3-D web and projected contour plot.
	program hidtest3surftest
	integer nx,ny,ud,i,j,iLx
	parameter (iLx=50,ny=20)
	real z,x,y,r,yy
	dimension z(iLx,ny),x(iLx,ny),y(iLx,ny),work(iLx+2,ny+2)
	integer nl
	parameter (nl=10)
	real cl(nl),ht
c       contour storage.
	character pp(4,iLx,ny)
	parameter (ht=.02)
	include 'world3.h'
c Set up data etc.
	nx=10
	do 10 i=1,nl
	   cl(i)=ht*(-1.+i*2./nl)
 10	continue
c	call pfset(-1)
	do 1 j=1,ny
	   yj=(float(j)-ny/3. +0.5)
	   yy=yj*yj
c For surf3d routine the order has to be x,y increasing.
	   do 2 i=1,nx
	      y(i,j)=yj
	      x(i,j)=(float(i)-nx/3.+0.5)
	      r=sqrt(x(i,j)*x(i,j)+yy)/2.
c       z(i,j)=ht*sin(x(i))*sin(y(j))/(x(i)*y(j))
	      z(i,j)=ht*sin(r)/r
	      ud=i-1
 2	   continue
 1	continue
c Start of actual plotting.
 98	call pltinit(0.,1.,0.,1.)
c       Plot the surface. With axes (1). Web color 10, axis color 7.
	j=1 + 256*10 + 256*256*7
	call surf3d(x,y,z,iLx,nx,ny,j,work)
c	j=1 + 256*10 + 256*256*7
c	call hidweb(x,y,z,iLx,nx,ny,j)
c       Draw a contour plot in perspective. Need to reset color anyway.
	call color(4)
	call axregion(-scbx3,scbx3,-scby3,scby3)
	call scalewn(x(1,1),x(nx,1),y(1,1),y(1,ny),.false.,.false.)
	call hdprset(-3,scbz3)
c	write(*,*) 'Done hdprset'
c       call axis   ! if desired.
	call scalewn(1.,float(nx),1.,float(ny),.false.,.false.)
c       Contour without labels, direct on mesh.
c	write(*,*) 'Done scalewn'
	call contourl(z,pp,iLx,nx,ny,cl,nl,r,r,16)
c	call contourl(z,pp,iLx,nx,ny,cl,nl,r,r,16)
c	write(*,*) 'Done contourl'
	call color(15)
c How to enable interactive plot rotation. Just this call instead of pltend:
	if(ieye3d().ne.0) goto 98
	end


