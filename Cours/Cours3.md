Mettre en correspondance des informations 3D a travers un model de la piece 3D et donc remonté à la pose de la camera

il y a donc une relation entre :

- la position de la camera
- la position du repere du monde
- le model 3D

une fois cela fait on fait la matrice de projection que l'on calcule, voir les cour 2 et td1

calibre la camera en fonction de notre position ansi que la matrice K, matrice intrinsèque, qui est utilisé 

# Suivi de point 2D - KLT

On a une image avec 4 points detecté, en 2 images

On va pouvoir calculer 

hypothèse:

- luminosité constante
- petit mouvement
- coherance spaciale, les points bouge de la meme maniere

## Constante de luminosité

I(x,y,t) = I(x+ u, y + v, T+ 1)

Mais attention, probleme de l'ouverture

1 equation 2 inconnu
