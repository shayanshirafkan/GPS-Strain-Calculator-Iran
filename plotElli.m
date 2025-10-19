function plotElli(lat , lon ,  a , b , teta)

a = reshape(a , size(lat ,1) , size(lat,2));
b = reshape(b , size(lat ,1) , size(lat,2));
teta = reshape(teta , size(lat ,1) , size(lat,2));

int1 = 5;

teta = teta(1:int1:end,1:int1:end);
lat = lat(1:int1:end,1:int1:end);
lon = lon(1:int1:end,1:int1:end);
a = a(1:int1:end,1:int1:end);
b = b(1:int1:end,1:int1:end);

a = a(:);
b = b(:);
teta = teta(:);
lat = lat(:);
lon = lon(:);

a = a .* 1e9;
b = b .* 1e9;

int2 = 1e1;

x1 = lat + (abs(a)./2 .* cos(teta))./int2 ;
y1 = lon + (abs(a)./2 .* sin(teta))./int2;
x2 = lat - (abs(a)./2 .* cos(teta))./int2;
y2 = lon - (abs(a)./2 .* sin(teta))./int2;

x3 = lat + (abs(b)./2 .* cos(teta+pi/2))./int2 ;
y3 = lon + (abs(b)./2 .* sin(teta+pi/2))./int2;
x4 = lat - (abs(b)./2 .* cos(teta+pi/2))./int2;
y4 = lon - (abs(b)./2 .* sin(teta+pi/2))./int2;

figure
h = worldmap([20 45],[35 70]);
coast=load('coast');
plotm(coast.lat,coast.long,'k-','LineWidth',2);
clear coast


title('Map of strain rate')
hold on

extA = find(a< 0);
conA = find(a >= 0);
extB = find(b < 0);
conB = find(b >= 0);

for i = 1 : sum(a< 0)
    plotm([x1(extA(i)),x2(extA(i))],[y1(extA(i)),y2(extA(i))],'Color','b','LineWidth',1.8);
end
for i = 1 : sum(a >= 0)
    plotm([x1(conA(i)) x2(conA(i))],[y1(conA(i)) y2(conA(i))],'Color','r','LineWidth',1.8);
end
for i = 1 : sum(b < 0)
    plotm([x3(extB(i)),x4(extB(i))],[y3(extB(i)),y4(extB(i))],'Color','b','LineWidth',1.8);
end
for i = 1 : sum(b >= 0)
    plotm([x3(conB(i)),x4(conB(i))],[y3(conB(i)),y4(conB(i))],'Color','r','LineWidth',1.8);
end

geoshow(h ,[23 23],[65 65+25/int2], 'Color','r','LineWidth',1.8);
textm(22,65,'50 ns/yr')

% x1=a.*cos(0).*cos(teta)-sin(teta).*b.*sin(0)+xs;
% y1=a.*cos(0).*sin(teta)+cos(teta).*b.*sin(0)+ys;
%
% x2=a.*cos(pi).*cos(teta)-sin(teta).*b*sin(pi)+xs;
% y2=a.*cos(pi).*sin(teta)+cos(teta).*b*sin(pi)+ys;
%
% x3=a.*cos(pi/2).*cos(teta)-sin(teta).*b*sin(pi/2)+xs;
% y3=a.*cos(pi/2).*sin(teta)+cos(teta).*b*sin(pi/2)+ys;
% x4=a.*cos(3*pi/2).*cos(teta)-sin(teta).*b*sin(3*pi/2)+xs;
% y4=a.*cos(3*pi/2).*sin(teta)+cos(teta).*b*sin(3*pi/2)+ys;
% xt=[xsp1,x1,x2];
% yt=[ysp1,y1,y2];
% xxt=[xsp1,x3,x4];
% yyt=[ysp1,y3,y4];
% plotm(xt,yt,'b','LineWidth',1.5);
% hold on
% plotm(xxt,yyt,'r','LineWidth',1.5);

end



