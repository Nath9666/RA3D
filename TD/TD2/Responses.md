### 1. Explication des Affichages des Fonctions `pcshow` et `plotCamera`

Les fonctions `pcshow` et `plotCamera` permettent de visualiser des éléments en 3D, particulièrement utiles dans un contexte de vision par ordinateur pour comprendre la position d’un modèle par rapport à une caméra.

1. **`pcshow`** :

   - Cette fonction est utilisée pour afficher un nuage de points 3D dans un graphique en 3D. Dans ce code, si l’on appelle `pcshow(p3d)`, cela affichera les points 3D du modèle de la boîte dans l’espace 3D. Cette visualisation permet de voir comment sont disposés les points dans le modèle, et de vérifier s’ils représentent bien la boîte attendue.
   - Par exemple, en utilisant `pcshow(p3d, 'VerticalAxis', 'y', 'VerticalAxisDir', 'down')`, cela permet de visualiser les points 3D en fixant l’axe vertical (ici, l’axe Y) et d’inverser l’axe vertical (paramètre `'down'`), pour mieux comprendre la disposition du modèle dans l’espace.
2. **`plotCamera`** :

   - Cette fonction permet de visualiser la position et l’orientation estimée de la caméra dans le même espace 3D. Après avoir estimé la pose de la caméra (c’est-à-dire sa position et orientation), en appelant `plotCamera('Location', WorldCamera.Translation, 'Orientation', WorldCamera.Rotation, 'Size', 0.05)`, on peut afficher une représentation virtuelle de la caméra dans l’espace.
   - Cela permet de vérifier si la pose estimée de la caméra semble correcte par rapport aux points 3D de la boîte.

En combinant `pcshow` et `plotCamera`, on obtient une représentation graphique en 3D de la boîte et de la position estimée de la caméra, ce qui permet de visualiser comment la caméra « voit » la boîte dans l’espace.

---

### 2. Explication des Arguments d’Entrée/Sortie de la Fonction `estimateWorldCameraPose`

La fonction `estimateWorldCameraPose` peut prendre plusieurs arguments supplémentaires pour affiner l’estimation de la pose de la caméra.

- **Arguments d'entrée** :

  - **`MaxReprojectionError`** : Définit l’erreur de reprojection maximale (en pixels) pour considérer qu’un appariement 2D-3D est valide. Par exemple, si on fixe `MaxReprojectionError` à 2, seuls les points dont l’erreur de reprojection est de 2 pixels ou moins seront inclus dans l’estimation.
  - **`Confidence`** : Fixe le niveau de confiance (entre 0 et 1) pour l’estimation de la pose. Ce paramètre influence la sévérité avec laquelle l’algorithme traite les appariements qui respectent l’erreur de reprojection.
  - **`MaxNumTrials`** : Indique le nombre maximal d’itérations pour l’algorithme afin de trouver une bonne estimation de pose. Plus de tentatives augmentent les chances de trouver une solution valide, mais allongent le temps de calcul.
  - **`EstimateSkew`** : Permet de déterminer si on doit estimer ou non la présence d’une distorsion angulaire (ou « skew ») dans la matrice intrinsèque de la caméra. Utile si la matrice intrinsèque pourrait inclure cette distorsion.
  - **`Verbose`** : Si activé (`true`), produit des informations de sortie supplémentaires pour aider au débogage.
- **Arguments de sortie** :

  - **`inlierIdx`** : Retourne les indices des points 2D-3D qui respectent la contrainte d’erreur de reprojection. Cela permet d’isoler les appariements les plus fiables.
  - **`reprojectionErrors`** : Fournit les erreurs de reprojection pour chaque point valide (`inlier`), ce qui permet d’analyser la précision de chaque appariement individuellement.

Ces arguments permettent d’affiner et de rendre plus robuste l’estimation de la pose de la caméra selon les besoins spécifiques de l’application.

---

### 3. Commande pour Fixer l’Erreur de Reprojection à 2 Pixels et Obtenir les Indices des Appariements Valides

Pour configurer un seuil d’erreur de reprojection de 2 pixels et obtenir les indices des appariements 2D-3D valides, vous pouvez utiliser la commande suivante :

```matlab
[WorldCamera, inlierIdx] = estimateWorldCameraPose(p2d_im01, p3d, cameraParams, 'MaxReprojectionError', 2);
```

Dans cette commande :

- `MaxReprojectionError` est fixé à 2, ce qui signifie que seuls les points avec une erreur de reprojection inférieure ou égale à 2 pixels sont pris en compte.
- `inlierIdx` contient les indices des points 2D-3D qui respectent ce critère, ce qui permet de filtrer les correspondances de mauvaise qualité.

---

### Compléter le Script `squelette_pnp_one_frame.m` pour Estimer la Pose de la Caméra avec la Méthode PnP

Pour compléter ce script et estimer la pose de la caméra en utilisant la méthode PnP (Perspective-n-Point), voici les étapes principales :

1. **Définir le Modèle 3D et les Points 2D de l'Image** : Les matrices `p3d` et `p2d_im01` doivent contenir respectivement les coordonnées 3D des points de la boîte et leurs projections 2D dans l'image.
2. **Définir les Paramètres Intrinsèques de la Caméra** : Créez la matrice intrinsèque `IntrinsicMatrix` et utilisez-la pour configurer `cameraParams`.
3. **Estimer la Pose de la Caméra** : Utilisez `estimateWorldCameraPose` avec un seuil d’erreur de reprojection de 2 pixels pour calculer la position et l'orientation de la caméra par rapport au modèle 3D.
4. **Afficher les Résultats avec `pcshow` et `plotCamera`** : Affichez les points 3D de la boîte et la pose estimée de la caméra pour vérifier visuellement les résultats.
