 % Charger la vidéo
 videoReader = VideoReader('box_video_data.avi');
 videoPlayer = vision.VideoPlayer('Position', [100, 100, 680, 520]);
 
 % Lire le premier cadre de la vidéo et le montrer pour définir les coins manuellement
 objectFrame = readFrame(videoReader);
 figure; imshow(objectFrame);
 title('Cliquez sur les 4 coins de la boîte dans l ordre');
 hold on;
 
 % Sélection manuelle des 4 coins de la boîte (dans le sens horaire ou anti-horaire)
 [x, y] = ginput(4); % Utilisateur clique sur les coins de la boîte
 cornerPoints = [x, y]; % Stocker les coordonnées des coins en matrice
 
 % Afficher les coins sélectionnés
 objectImage = insertMarker(objectFrame, cornerPoints, 'o', 'Color', 'red');
 imshow(objectImage);
 title('Red circles indicate the selected corners');
 
 % Créer un traqueur de points
 tracker = vision.PointTracker('MaxBidirectionalError', 1);
 
 % Initialiser le traqueur avec les coins sélectionnés
 initialize(tracker, cornerPoints, objectFrame);
 
 % Boucle pour lire et suivre les coins dans chaque image de la vidéo
 while hasFrame(videoReader)
     frame = readFrame(videoReader);  % Lire l'image courante
     [points, validity] = tracker(frame); % Mettre à jour la position des coins
 
     % Filtrer les points valides
     validPoints = points(validity, :);
 
     % Afficher les coins suivis dans l'image courante
     if size(validPoints, 1) == 4
         frame = insertMarker(frame, validPoints, 'o', 'Color', 'green'); % Points valides en vert
     end
     videoPlayer(frame); % Afficher l'image dans le lecteur vidéo
 end
 
 % Libérer les ressources du lecteur vidéo
 release(videoPlayer);