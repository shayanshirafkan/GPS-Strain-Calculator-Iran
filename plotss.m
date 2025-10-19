clear
clc

%% etsae

figure;
h=worldmap([24 43],[40 64]);

[E,N]=meshgrid(24:0.25:43,40:0.25:64);
z=reshape(e_d*10^(9),97,77);
contourfm(E,N,z);

xlabel('X');ylabel('Y');C=colorbar;C.Label.String=' nanostrain / yr';
title('Dilation')
axis equal

coast=load('coast');
plotm(coast.lat,coast.long,'k-','LineWidth',2);
clear coast
%% i2
figure;
h=worldmap([24 43],[40 64]);

[E,N]=meshgrid(24:0.25:43,40:0.25:64);
z=reshape(I2*10^(9),97,77);
contourfm(E,N,z);

xlabel('X');ylabel('Y');C=colorbar;C.Label.String=' nanostrain / yr';
title('Second invarient I_2')
axis equal

coast=load('coast');
plotm(coast.lat,coast.long,'k-','LineWidth',2);
clear coast

%% exx

figure;
h=worldmap([24 43],[40 64]);

[E,N]=meshgrid(24:0.25:43,40:0.25:64);
z=reshape(e_xx*10^(9),97,77);
contourfm(E,N,z);

xlabel('X');ylabel('Y');C=colorbar;C.Label.String=' nanostrain / yr';
title('e_x')
axis equal

coast=load('coast');
plotm(coast.lat,coast.long,'k-','LineWidth',2);
clear coast
%% eyy
figure;
h=worldmap([24 43],[40 64]);

[E,N]=meshgrid(24:0.25:43,40:0.25:64);
z=reshape(e_yy*10^(9),97,77);
contourfm(E,N,z);

xlabel('X');ylabel('Y');C=colorbar;C.Label.String=' nanostrain / yr';
title('e_y')
axis equal

coast=load('coast');
plotm(coast.lat,coast.long,'k-','LineWidth',2);
clear coast
%% 
figure;
h=worldmap([24 43],[40 64]);

[E,N]=meshgrid(24:0.25:43,40:0.25:64);
z=reshape(e_xy*10^(9),97,77);
contourfm(E,N,z);

xlabel('X');ylabel('Y');C=colorbar;C.Label.String=' nanostrain / yr';
title('exy')
axis equal

coast=load('coast');
plotm(coast.lat,coast.long,'k-','LineWidth',2);
clear coast
%%
load sp
sp(:,1)=e_max;
sp(:,2)=e_min;
for i=1:7469;
sp(i,3)=(1/2)*atan2(2*e_xy(i,1),e_xx(i,1) - e_yy(i,1));
end
plotElli(E , N ,  sp(:,1) , sp(:,2) , sp(:,3))


