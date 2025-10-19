clear
clc
load gps
gps(:,1)=gps(:,1)/10;
gps(:,2)=gps(:,2)/10;
gps(:,3)=gps(:,3);
landa=40:0.25:64;
phi=24:0.25:43;
for i=1:399;
    coor(i,:) =curv(gps(i,2),gps(i,1),0 );
end

dx=gps(:,3)*10^(-3);
dy=gps(:,4)*10^(-3);
Q=zeros(2*399,2*399);
% for i=1:399;
%     Q(2*i-1,2*i-1)=gps(i,5)^2 * 10^(-6);
%     Q(2*i-1,2*i)=gps(i,5)*gps(i,6) * 10^(-6);
%         Q(2*i,2*i-1)=gps(i,5)*gps(i,6) * 10^(-6);
%      Q(2*i,2*i)=gps(i,6)^2 * 10^(-6);
% end
for i=1:399;
Q(2*i-1,2*i-1)=gps(i,5)^2 * 10^(-6);
Q(2*i,2*i)=gps(i,6)^2 * 10^(-6);
end

for i=1:77;
s=[];

    for j=1:97;
  s=curv(phi(1,i),landa(1,j),0);
  L(j,:)=[s , phi(1,i),landa(1,j)];
    end
    P{1,i}= L;
end
r=[];
for i=1:77;
    r=[r;P{1,i}];
end    
for i=1:399;
    Y(2*i-1,1)=dx(i,1);
    Y(2*i,1)=dy(i,1);
end
for i=1:7469;
    A=[];
   for j=1:399;
       A(2*j-1,:)=[1  0 r(i,2)-coor(j,2)  r(i,1)-coor(j,1)    r(i,2)-coor(j,2)  0];
       A(2*j,:)=[0   1 -(r(i,1)-coor(j,1))    0      r(i,1)-coor(j,1)     r(i,2)-coor(j,2)];
   end
   q=zeros(798,798);
%    for k=1:399;
%        q(2*k-1,2*k-1)=norm(r(i,1)-coor(j,1));
%        q(2*k,2*k)=norm(r(i,2)-coor(j,2));
%    end

h=[];

   for k=1:399;
       n1=[];
       n1=sqrt((r(i,1)-coor(k,1))^2+(r(i,2)-coor(k,2))^2);
       h(k,1)=n1;
       n1=25*exp(-n1^2/(10^13));
       q(2*k-1,2*k-1)=n1;
       q(2*k,2*k)=n1;
   end
   hh=[];
   hh=min(min(h));
   w=(q)+inv(Q);
   p3=[];
   q3=[];
   qq3=[];
   tt=[];
p3=inv(A'*w*A)*A'*w*Y;
q3=(p3(4,1)+p3(6,1))/2 +sqrt(((p3(4,1)-p3(6,1))/2)^(2)+p3(5,1)^(2));
qq3=(p3(4,1)+p3(6,1))/2- sqrt(((p3(4,1)-p3(6,1))/2)^(2)+p3(5,1)^(2));
% tt=(1/2)*atan(2*p3(5,1)/((p3(4,1)-p3(6,1))));
 tt=(1/2)*atan2(2*p3(5,1),((p3(4,1)-p3(6,1))));
sp(i,:)=[q3 qq3 tt r(i,4) r(i,5)];
 str(i,:)=p3';  
 etc(i,:)=[(p3(4,1)+p3(6,1))/2 p3(4,1)*p3(6,1)-p3(5,1)^(2)  r(i,4) r(i,5) hh];
end
% load sp
% load str
% load etc
figure;
h=worldmap({'Iran'});
load coastlines
plotm(coastlat,coastlon,'g')
xx=etc(:,3);
yy=etc(:,4);
tt=etc(:,1)*10^9;
scatterm(xx,yy,20,tt,'filled')
xlabel('X');ylabel('Y');colorbar
title('etc')
axis equal

figure;
h=worldmap({'Iran'});
load coastlines
plotm(coastlat,coastlon,'g')
xx=etc(:,3);
yy=etc(:,4);
tt=str(:,4)*10^9;
scatterm(xx,yy,20,tt,'filled')
xlabel('X');ylabel('Y');colorbar
title('exx')
axis equal


figure;
h=worldmap({'Iran'});
load coastlines
plotm(coastlat,coastlon,'g')
xx=etc(:,3);
yy=etc(:,4);
tt=str(:,5)*10^9;
scatterm(xx,yy,20,tt,'filled')
xlabel('X');ylabel('Y');colorbar
title('exy')
axis equal

figure;
h=worldmap({'Iran'});
load coastlines
plotm(coastlat,coastlon,'g')
xx=etc(:,3);
yy=etc(:,4);
tt=str(:,6)*10^9;
scatterm(xx,yy,20,tt,'filled')
xlabel('X');ylabel('Y');colorbar
title('eyy')
axis equal

figure;
h=worldmap({'Iran'});
load coastlines
plotm(coastlat,coastlon,'g')
xx=etc(:,3);
yy=etc(:,4);
tt=etc(:,5);
scatterm(xx,yy,1.5,tt,'filled')
xlabel('X');ylabel('Y');colorbar
title('elipse')
axis equal

for i=1:10:100;
 theta0 =(sp(i,3));
 a=abs(sp(i,1))*10^(6);
 b=abs(sp(i,2))*10^(6);
 xsp1=sp(i,4);
 ysp1=sp(i,5);

x1=a*cos(0)*cos(theta0)-sin(theta0)*b*sin(0)+xsp1;
y1=a*cos(0)*sin(theta0)+cos(theta0)*b*sin(0)+ysp1;

x2=a*cos(pi)*cos(theta0)-sin(theta0)*b*sin(pi)+xsp1;
y2=a*cos(pi)*sin(theta0)+cos(theta0)*b*sin(pi)+ysp1;

x3=a*cos(pi/2)*cos(theta0)-sin(theta0)*b*sin(pi/2)+xsp1;
y3=a*cos(pi/2)*sin(theta0)+cos(theta0)*b*sin(pi/2)+ysp1;
x4=a*cos(3*pi/2)*cos(theta0)-sin(theta0)*b*sin(3*pi/2)+xsp1;
y4=a*cos(3*pi/2)*sin(theta0)+cos(theta0)*b*sin(3*pi/2)+ysp1;

xt=[xsp1,x1,x2];
yt=[ysp1,y1,y2];
xxt=[xsp1,x3,x4];
yyt=[ysp1,y3,y4];
if sp(i,1)>=0 && sp(i,2)>=0;
plotm(xt,yt,'b')
hold on
plotm(xxt,yyt,'b');  
hold on
elseif sp(i,1)>=0 && sp(i,2)< 0;
    plotm(xt,yt,'b')
hold on
plotm(xxt,yyt,'r');  
hold on
elseif sp(i,1)<0 && sp(i,2)>= 0;
    plotm(xt,yt,'r')
hold on
plotm(xxt,yyt,'b');  
hold on
elseif sp(i,1)<0 && sp(i,2)< 0;
    plotm(xt,yt,'r')
hold on
plotm(xxt,yyt,'r');  
hold on
end
end
