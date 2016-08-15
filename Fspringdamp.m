function F= Fspringdamp(y,v,m,k,y0,gamma)
%
%  force due to spring and friction
%  damping force is in direction opposite v
%  units are mks

F=  -k*(y-y0)-2*m*gamma*v;


