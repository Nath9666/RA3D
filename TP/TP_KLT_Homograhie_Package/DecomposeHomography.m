function [R, T] = DecomposeHomography(K, H)
    % Décomposer l'homographie H pour obtenir R et T
    % K est la matrice de la caméra (intrinsèques)
    
    % On commence par inverser la matrice K
    K_inv = inv(K);
    
    % Appliquer l'inverse de K sur l'homographie
    H_prime = K_inv * H;
    
    % Extraire la rotation et la translation à partir de H_prime
    % Supposer une configuration de caméra normale (z=0 pour les translations)
    R = H_prime(:, 1:2); % Les 2 premières colonnes de H_prime sont la rotation
    T = H_prime(:, 3);   % La troisième colonne de H_prime est la translation
    
    % Normaliser les valeurs pour que la norme de R soit 1 (si nécessaire)
    norm_factor = norm(R(:,1));
    R = R / norm_factor;
    T = T / norm_factor;
end