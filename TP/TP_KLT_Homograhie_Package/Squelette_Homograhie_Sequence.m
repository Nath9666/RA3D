clear all;
close all;
%********************************************
% Modèle 3D de la boite (en repère local de la boite)
%********************************************
cube3d = [0         0       0
          0.125     0       0
          0.125     0.090   0
          0         0.090   0 
       
          0         0      -0.070
          0.125     0      -0.070
          0.125     0.090  -0.070
          0         0.090  -0.070 ];
%---------------------------------------
% Paramètres intrinsèques de la caméra
%---------------------------------------
K = [606.209         0             320.046
     0               606.719       238.926
     0               0             1];  
%-------------------------------------------------
% Les points 3D correspondant aux coins de la face avant de la boîte
%-------------------------------------------------
p3d = [0         0       0
        0.125     0       0
        0.125     0.090   0
        0         0.090   0];  
%------------------------------
% Lecture de la séquence vidéo
%-----------------------------
videoReader = VideoReader('box_video_data.avi');
videoPlayer = vision.VideoPlayer('Position', [100, 100, 680, 520]);

% Créer un objet VideoWriter pour enregistrer la vidéo augmentée
outputVideo = VideoWriter('output.avi');

open(outputVideo);

%--------------------------------------------------------------
% Lire la 1ère image de la séquence vidéo, contenant la cible
%--------------------------------------------------------------
objectFrame = readFrame(videoReader);
figure;
imshow(objectFrame);
%--------------------------------------------------------
% Détecter les coins de la boîte dans l'image
%--------------------------------------------------------
% Sélectionner les 4 coins de la boîte que l'utilisateur va suivre
hold on;
title('Sélectionner les coins de la boîte');
[x, y] = ginput(4); % Permet à l'utilisateur de sélectionner les coins
points2d = [x, y]; % Points 2D à suivre dans l'image
%--------------------------------------------------------
% Initialiser le tracker pour suivre les points sélectionnés
%--------------------------------------------------------
tracker = vision.PointTracker('MaxBidirectionalError', 1);
initialize(tracker, points2d, objectFrame);
%--------------------------------------------------------
% Traitement de la séquence vidéo
%--------------------------------------------------------
while hasFrame(videoReader)
    % 1. Lire la frame courante
    frame = readFrame(videoReader);
    % 2. Extraire les 4 coins de la cible en utilisant le tracker
    [trackedPoints, validity] = tracker(frame);
    
    % 3. Calculer l'homographie H entre les points 3D et 2D
    % Utiliser les points 3D (p3d) et les points 2D (trackedPoints)
    H = ComputeH(p3d, trackedPoints(validity, :));
    
    % 4. Estimer la pose 3D de la caméra à partir de l'homographie H
    % Calculer R (rotation) et T (translation) en résolvant H
    % Il faut résoudre pour obtenir R_opt et T_opt.
    % Ceci peut être effectué via des méthodes de décomposition d'homographie
    % (en prenant en compte les matrices K et les relations géométriques)
    [R_opt, T_opt] = DecomposeHomography(K, H);
    
    % 5. Calculer la Matrice de projection globale
    % La matrice de projection P = K*[R_opt | T_opt] permet de projeter les points 3D dans l'image
    P = K * [R_opt, T_opt];
    % 6. Projeter le cube 3D dans l'image
    augmentedFrame = Project3DModel(frame, K, R_opt, T_opt, cube3d);
    % 7. Sauvegarder l'image augmentée
    videoPlayer(augmentedFrame); % Afficher l'image augmentée
    writeVideo(outputVideo, augmentedFrame); % Enregistrer l'image augmentée dans la vidéo
end

% Relâcher les objets après la lecture de toute la séquence
release(videoPlayer);
close(outputVideo);