clear
clc

 tg = linspace(0,2*pi,1000);
 theta0 =pi/6;
 a=5;
 b=3;
 xsp1=5;
 ysp1=6;
 x = a*sin(tg+theta0)+xsp1;
 y = b*cos(tg)+ysp1;
 
   x1=a*cos(0)*cos(theta0)-sin(theta0)*b*sin(0)+xsp1;
 y1=a*cos(0)*sin(theta0)+cos(theta0)*b*sin(0)+ysp1;
 
    x2=a*cos(pi)*cos(theta0)-sin(theta0)*b*sin(pi)+xsp1;
 y2=a*cos(pi)*sin(theta0)+cos(theta0)*b*sin(pi)+ysp1;
    x3=a*cos(pi/2)*cos(theta0)-sin(theta0)*b*sin(pi/2)+xsp1;
 y3=a*cos(pi/2)*sin(theta0)+cos(theta0)*b*sin(pi/2)+ysp1;
     x4=a*cos(3*pi/2)*cos(theta0)-sin(theta0)*b*sin(3*pi/2)+xsp1;
 y4=a*cos(3*pi/2)*sin(theta0)+cos(theta0)*b*sin(3*pi/2)+ysp1;
 h=ellipse(a,b,theta0,xsp1,ysp1,'r')
figure
 grid on
xt=[xsp1,x1,x2];
yt=[ysp1,y1,y2];
xxt=[xsp1,x3,x4];
yyt=[ysp1,y3,y4];
hold on
plot(xt,yt,'b')
 hold on
 plot(xxt,yyt,'g');
% figure
%  plot(x,y)
%  axis equal
%  grid on
%  hold on
