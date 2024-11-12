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

% Affichage des points 3D et de la position estimée de la caméra
figure;
pcshow(p3d, 'VerticalAxis', 'y', 'VerticalAxisDir', 'down', 'MarkerSize', 30);
hold on;
plotCamera('Size', 0.05, 'Orientation', worldOrientation, 'Location', worldLocation);
title('Points du Modèle 3D et Pose Estimée de la Caméra');
hold off;
