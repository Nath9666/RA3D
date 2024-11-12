clear all;
close all;

% Paramètres intrinsèques de la caméra
IntrinsicMatrix = [2960.37845 0 0; 0 2960.37845 0; 1841.68855 1235.23369 1];
cameraParams = cameraParameters('IntrinsicMatrix', IntrinsicMatrix);

% Modèle 3D de la boîte
p3d = [0 0.0630 0.0930; 0.1650 0.0630 0.0930; 0.1650 0 0.0930; 0 0 0.0930;
       0 0.0630 0; 0.1650 0.0630 0; 0.1650 0 0; 0 0 0];

% Chargement de l'image et des points 2D
img = imread('.\image_01.jpg');
p2d_im01 = [1376,1020; 2239,1066; 2310,1114; 1347,1133; 0,0; 0,0; 2278,1589; 1376,1614];

% Estimation de la pose de la caméra avec un seuil d'erreur de reprojection
[worldOrientation, worldLocation] = estimateWorldCameraPose(p2d_im01, p3d, cameraParams, 'MaxReprojectionError', 2);

% Projection des points 3D sur l'image
projectedPoints = worldToImage(cameraParams, worldOrientation, worldLocation, p3d);

% Affichage de l'image
figure;
imshow(img);
hold on;

% Superposition des points projetés du modèle 3D
plot(projectedPoints(:,1), projectedPoints(:,2), 'ro', 'MarkerSize', 8, 'LineWidth', 2);
title('Image avec la projection du modèle 3D de la boîte');
hold off;
