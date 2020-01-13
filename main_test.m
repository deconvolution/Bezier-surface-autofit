
clear all;
close all;
%% input
alp=1;
iteration=15;
%% true model
x=0:.1:10;
y=-5:.1:5;
[x2,y2]=meshgrid(x,y);
z2=x2.^2+10*cos(y2);
true_model=zeros(3,size(x2,1)*size(x2,2));
true_model(1,:)=x2(:);
true_model(2,:)=y2(:);
true_model(3,:)=z2(:);
figure(1)
plot3(true_model(1,:),true_model(2,:),true_model(3,:),'.','color','blue');
xlabel('x');
ylabel('y');
zlabel('z');
shg;
%% transform (right hand rule)
translation=0;
rx=0;
ry=0;
rz=0;
true_model2=transform_true_model(true_model,translation,rx,ry,rz);
shg;
%% control points
% x-first dimension, y-second dimension
cx=[0;5;10];
cy=[-5;-2;-1;0;-1;-2;3;5];
K=zeros(size(cx,1),size(cy,1),3);
[K(:,:,2),K(:,:,1)]=meshgrid(cy,cx);
%% interval of u and v
u_interval=.1;
v_interval=.1;
hatN=bezier_surface(K,u_interval,v_interval);
%% plot initial condition
figure(2)
ax=scatter3(reshape(K(:,:,1),[size(K,1)*size(K,2),1]),reshape(K(:,:,2),[size(K,1)*size(K,2),1]),reshape(K(:,:,3),[size(K,1)*size(K,2),1]),'o','red');
hold on;
CO=zeros(size(hatN,1),size(hatN,2),3);
CO(:,:,1)=1; % red
CO(:,:,2)=1; % green
CO(:,:,3)=0; % blue
ax2=surf(hatN(:,:,1),hatN(:,:,2),hatN(:,:,3),CO,'facealpha',.5);
hold on;
ax3=plot3(true_model(1,:),true_model(2,:),true_model(3,:),'.','color',[.3,0,1]);
xlabel('x');
ylabel('y');
zlabel('z');
legend([ax,ax2,ax3],'control point','Bizier surface','true surface','location',[.1,.9,.1,.1],'orientation','vertical');
shg;
%% run fitting function
% pro=0: plot progress. pro=1: only plot result. pro=other: do not plot
pro=0;
K=find_controlp(true_model,K,u_interval,v_interval,alp,iteration,0);
%% recover original coordinate
K2=transform_K(K,-translation,-rx,-ry,-rz);