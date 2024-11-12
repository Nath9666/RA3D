# Analyse du code annexe A

## a) Quelle  est  la  fonction Matlab  utilisée pour  la  détection  des  points  caractéristiques  dans  la région d'intérêt. Expliquer son principe.

Dans ce code, la fonction MATLAB utilisée pour détecter les points caractéristiques dans la région d'intérêt est :

### **`detectMinEigenFeatures`**

Cette fonction fait partie de la boîte à outils **Computer Vision Toolbox** de MATLAB. Elle est utilisée pour détecter des points d'intérêt ou caractéristiques (souvent des coins ou des régions avec des variations d'intensité notables) dans une image.

---

### Principe de Fonctionnement de `detectMinEigenFeatures`

La fonction **`detectMinEigenFeatures`** repose sur l'algorithme **Min-Eigenvalue** de Shi et Tomasi, qui est une amélioration de la méthode de détection de coins de Harris. Elle identifie des points où l'intensité des pixels change fortement dans plusieurs directions, ce qui est typiquement le cas aux coins des objets.

Voici le principe de l’algorithme de Min-Eigenvalue :

1. **Matrice de Structure** :

   - Pour chaque pixel de l'image, on calcule une matrice de structure \( M \), qui mesure le changement d'intensité local autour de ce pixel.
2. **Valeurs Propres** :

   - La robustesse d'un point caractéristique (son "intérêt") est déterminée par les valeurs propres (\( \lambda_1 \) et \( \lambda_2 \)) de la matrice \( M \).
   - Dans le cas d'un coin, les deux valeurs propres sont élevées, ce qui signifie qu'il y a un fort changement d'intensité dans deux directions perpendiculaires (un coin présente des changements dans les deux directions x et y).
3. **Critère Min-Eigenvalue** :

   - Plutôt que d'utiliser la somme ou le produit des valeurs propres comme dans d'autres méthodes (par exemple, le détecteur de Harris), l'algorithme de Min-Eigenvalue utilise la plus petite des deux valeurs propres, \( \text{min}(\lambda_1, \lambda_2) \), pour décider si un pixel est un point caractéristique.
   - Si cette valeur propre minimale dépasse un certain seuil, le point est considéré comme un coin ou une caractéristique significative.
4. **Détection dans une Région d'Intérêt (ROI)** :

   - La fonction permet de restreindre la détection des points caractéristiques à une **région d'intérêt** (ROI), spécifiée par l'argument `'ROI'`.
   - En limitant la détection des points à une zone spécifique (comme un visage ou un objet d’intérêt), on peut optimiser le suivi ou l’analyse uniquement dans cette zone.

---

### Exemple d'Utilisation

Dans votre code, la détection des points caractéristiques est réalisée comme suit :

```matlab
points = detectMinEigenFeatures(rgb2gray(objectFrame), 'ROI', objectRegion);
```

1. **Conversion en niveaux de gris** : La détection est effectuée sur une image en niveaux de gris, car les gradients d'intensité sont plus simples et plus rapides à calculer qu'en couleur.
2. **Spécification de la région d'intérêt** : `'ROI', objectRegion` indique que seuls les points de la région définie dans `objectRegion` sont détectés.

## b) Remplacer cette  fonction  par  les détecteurs  suivants:  Harris,  Surf  et Orb. Exécuter à chaque fois le code et comparer les résultats
