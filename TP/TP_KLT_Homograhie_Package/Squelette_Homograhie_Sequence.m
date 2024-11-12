clear all;
close all;

%********************************************
% Modèle 3D de la boite. Les coordonnées des 
% coins de la boite sont définis dans un
% repère local de la boite
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
% paramètres intrinsèques de la caméra
%---------------------------------------
K = [606.209         0             320.046
     0               606.719       238.926
     0              0                  1 ];  
%-------------------------------------------------
% Les points 3D correspondent aux quatre 
% coins de la face avant de la boite (voir énoncé
%-------------------------------------------------
p3d =   [0         0       0
          0.125     0       0
          0.125     0.090   0
          0         0.090   0];  

%------------------------------
% lecture de la séquence vidéo
%-----------------------------
videoReader = VideoReader('box_video_data.avi');

%--------------------------------------------------------------
% Lire la 1ère image de la séquence vidéo, contenant la cible
%--------------------------------------------------------------
objectFrame = readFrame(videoReader);
figure;
imshow(objectFrame); 

%%
%% Définir les points d'intérêts à suivre dans la séquence vidéo
points = detectHarrisFeatures(rgb2gray(objectFrame));

%% Afficher les points .
pointImage = insertMarker(objectFrame,points.Location,'+','Color','white');

%% Create a tracker object.
tracker = vision.PointTracker('MaxBidirectionalError',1);

%% Initialize the tracker.
initialize(tracker,points.Location,objectFrame);

%% Read, track, display points, and results in each video frame.
while hasFrame(videoReader)
    % 1- Lire la frame courante
    frame = readFrame(videoReader);
    
    % 2- Extraire les 4 coins de la cible en utilsant le KLT.
    [points, validity] = tracker(frame);
    visiblePoints = points(validity, :);
    
    % Assurez-vous que nous avons au moins 4 points valides
    if size(visiblePoints, 1) < 4
        continue;
    end
    
    % 3- Calculer l'homographie H, en utilsant la fonction ComputeH.m   
    H = ComputeH(p3d, visiblePoints(1:4, :));
    
    % 4- Extraire les paramètres de la pose 3D à partir de l'homographie H
    %    (voir formules du cours)
    [R_opt, T_opt] = DecomposeHomography(K, H);
    
    % 5- Calculer la Matrice de projection globale
    P = K * [R_opt T_opt];
    
    % 6- Projeter le cube dans l'image courante en utilsant la foction
    %    Project3DModel.m
    Project3DModel(frame, K, R_opt, T_opt, cube3d);
    
    % 7- Sauvegarder l'image augmentée
    % (Vous pouvez utiliser imwrite pour sauvegarder les images si nécessaire)
    %videoPlayer(h); % Afficher l'image augmentée
end

%release(videoPlayer);