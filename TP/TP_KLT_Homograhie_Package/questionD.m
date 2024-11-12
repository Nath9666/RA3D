% 1. Charger la vidéo et initialiser l'objet de suivi
videoReader = VideoReader('box_video_data.avi'); % Charger la vidéo
videoPlayer = vision.VideoPlayer('Position', [100, 100, 680, 520]); % Création d'un lecteur vidéo pour l'affichage

% 2. Lire le premier cadre et définir la région d'intérêt
firstFrame = readFrame(videoReader); % Lire la première image
imshow(firstFrame); % Afficher la première image
title('Sélectionnez les coins de la boîte dans la première image');

% Sélectionner manuellement les 4 coins de la boîte à l'aide de la souris
% Vous pouvez utiliser 'getPosition(imrect)' pour obtenir la position de l'objet manuellement
h = imrect; % Créer un objet interactif pour sélectionner la boîte
objectRegion = round(getPosition(h)); % Obtenir la position de la boîte sélectionnée
close;

% 3. Définir les coins de la boîte comme points à suivre
% Les 4 coins sont les 4 points de la boîte sélectionnée
points = [objectRegion(1), objectRegion(2); % Coin supérieur gauche
          objectRegion(1) + objectRegion(3), objectRegion(2); % Coin supérieur droit
          objectRegion(1), objectRegion(2) + objectRegion(4); % Coin inférieur gauche
          objectRegion(1) + objectRegion(3), objectRegion(2) + objectRegion(4)]; % Coin inférieur droit

% Convertir l'image en niveaux de gris pour détecter les points caractéristiques
grayFirstFrame = rgb2gray(firstFrame);

% Afficher les points sélectionnés sur l'image
imshow(firstFrame);
hold on;
plot(points(:,1), points(:,2), 'g+'); % Afficher les points avec un marqueur '+'
title('Coins de la boîte sélectionnés');

% 4. Initialiser le tracker de points
tracker = vision.PointTracker('MaxBidirectionalError', 1); % Créer un objet PointTracker avec un seuil d'erreur

% Initialiser le tracker avec les points de la première image
initialize(tracker, points, firstFrame); 

% 5. Suivi des points à travers les frames de la vidéo
while hasFrame(videoReader)
    % Lire un nouveau cadre
    frame = readFrame(videoReader); 
  
    % Suivre les points dans le cadre actuel
    [trackedPoints, validity] = tracker(frame);
  
    % Afficher les points suivis sur l'image
    outputFrame = insertMarker(frame, trackedPoints(validity, :), '+'); % Insérer des marqueurs pour les points suivis
    videoPlayer(outputFrame); % Afficher le cadre avec les points suivis
  
    % Mettre à jour les points pour le suivi dans les prochains cadres
    trackedPoints(validity, :) = trackedPoints(validity, :);
end

% Libérer les ressources du lecteur vidéo
release(videoPlayer);