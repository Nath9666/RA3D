function h= Project3DModel(frame, K, R_opt, T_opt, cube3d)
    % Assurez-vous que R_opt est une matrice 3x3
    if size(R_opt, 2) == 2
        R_opt = [R_opt, cross(R_opt(:,1), R_opt(:,2))];
    end
    
    % Assurez-vous que T_opt est un vecteur 3x1
    if size(T_opt, 2) ~= 1
        T_opt = T_opt';
    end
    
    % Projeter les points 3D dans l'image
    c_3d = K * (R_opt * cube3d' + T_opt);
    
    % Normaliser les coordonnées homogènes
    c_3d = c_3d ./ c_3d(3, :);
    
    % Afficher les points projetés
    h = frame;
    imshow(h);
    hold on;
    plot(c_3d(1, :), c_3d(2, :), 'r*');
    
    % Relier les points projetés avec des lignes
    % Relier les points du cube
    imm = c_3d(1:2, :);
    line(imm(1, 1:4), imm(2, 1:4), 'LineWidth', 2, 'Color', 'red');
    line([imm(1, 4), imm(1, 1)], [imm(2, 4), imm(2, 1)], 'LineWidth', 2, 'Color', 'red');
    line(imm(1, 5:8), imm(2, 5:8), 'LineWidth', 2, 'Color', 'red');
    line([imm(1, 8), imm(1, 5)], [imm(2, 8), imm(2, 5)], 'LineWidth', 2, 'Color', 'red');
    for i = 1:4
        line([imm(1, i), imm(1, i+4)], [imm(2, i), imm(2, i+4)], 'LineWidth', 2, 'Color', 'red');
    end
    
    hold off;
    frame = getframe(gca);
    h = frame.cdata;
end