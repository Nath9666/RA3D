clear all;
close all;

%%
% paramètres intrinsèques de la caméra
%%
IntrinsicMatrix = [2960.37845 0 0; 0 2960.37845 0; 1841.68855 1235.23369 1];
cameraParams = cameraParameters('IntrinsicMatrix',IntrinsicMatrix);

%%
% Modèle 3D de la boite
%%
p3d = [  0       0.0630    0.0930
       0.1650    0.0630    0.0930
       0.1650      0       0.0930
         0         0       0.0930
         0       0.0630      0
       0.1650    0.0630      0
       0.1650      0         0
         0         0         0];
     
 %%
 %  lecture de l'image courante et des points 2d 
 %%
 img = imread('image_01.jpg');
 p2d_im01 = [1376,1020;
             2239,1066;
             2310,1114;
             1347,1133;
             0,0;
             0,0;
             2278,1589;
             1376,1614];
         
%          p2d_im01 = [1376,1020;
%              2239,1005;
%             2310,1114;
%              0,0;
%              0,0;
%              0,0;
%              2278,1589;
%              1376,1614];
 
 %%
 % Estimation de pose de la caméra
 %%
 %% TODO
 %%
 
 [worldOrientation,worldLocation, status] = estimateWorldCameraPose(p2d_im01,p3d,cameraParams);
 pcshow(p3d,'VerticalAxis','Y','VerticalAxisDir','down','MarkerSize',30);
 hold on
 plotCamera('Size',0.05,'Orientation',worldOrientation,'Location',worldLocation);
 
 rotation = worldOrientation;
 translation = -rotation * worldLocation';
 
 %%
 % Projection du modèle 3D sur l'image courante
 %%
 
 %%
 %% TODO
 %%
 
 c_3d = IntrinsicMatrix'*(rotation*p3d' + translation);
 c_2d = c_3d(1:2,:)./repmat(c_3d(3,:),[2,1]);
 figure;
 imshow(img);
 hold on;
 scatter(c_2d(1,:)', c_2d(2,:)', 15,'r');
 
 imm = c_2d;
 line (imm(1,1:4),imm(2,1:4),'LineWidth',2);
x=[imm(1,4) imm(1,1)];
y=[imm(2,4) imm(2,1)];
line(x,y,'LineWidth',2);

line (imm(1,5:8),imm(2,5:8),'LineWidth',2);
x=[imm(1,8) imm(1,5)];
y=[imm(2,8) imm(2,5)];
line(x,y,'LineWidth',2);

x=[imm(1,1) imm(1,5)];
y=[imm(2,1) imm(2,5)];
line(x,y,'LineWidth',2);

x=[imm(1,2) imm(1,6)];
y=[imm(2,2) imm(2,6)];
line(x,y,'LineWidth',2);

x=[imm(1,3) imm(1,7)];
y=[imm(2,3) imm(2,7)];
line(x,y,'LineWidth',2);

x=[imm(1,4) imm(1,8)];
y=[imm(2,4) imm(2,8)];
line(x,y,'LineWidth',2);
 
 
 
 
 
 
 