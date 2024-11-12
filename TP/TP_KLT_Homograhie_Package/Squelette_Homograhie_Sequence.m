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
points = detectMinEigenFeatures(rgb2gray(objectFrame),'ROI',objectRegion);
%%


 
%% Afficher les points .
%% TODO
%%


%% Create a tracker object.
%%
tracker = vision.PointTracker('MaxBidirectionalError',1);

%% Initialize the tracker.
%% initialize(tracker,points.Location,objectFrame);
%%

initialize(tracker,points,objectFrame);

%% Read, track, display points, and results in each video frame.
%%

while hasFrame(videoReader)
      
    %% TODO
    %%
    
    % 1- Lire la frame courante
    % 2- Extraire les 4 coins de la cible en utilsant le KLT.
    % 3- Calculer  l'homographie H, en utilsant la fonction ComputeH.m   
    % 4- Extaraire les paramètres de la pose 3D à partir de l'homographie H
    %    (voir formules du cours)
    % 5- Calculer la Matrice de projection  globale
    % 6- Projeter le cube dans l'image courante en utilsant la foction
    %    Project3DModel.m
    % 7- Sauvegarder l'image augmentée    
end
