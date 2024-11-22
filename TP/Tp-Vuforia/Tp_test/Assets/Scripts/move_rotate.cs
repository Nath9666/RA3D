using UnityEngine;

public class MoveRotate : MonoBehaviour {
    public float speed; // vitesse à définir dans l'interface Unity
    public float rotateSpeed; // vitesse de rotation à définir dans l'interface Unity

    // Utilisé pour l'initialisation
    void Start() {
    }

    // Update est appelé une fois par frame
    void Update() {
        // si la touche flèche du haut est appuyée, alors faire une transformation de type translation selon un vecteur
        // avec la vitesse speed définie précédemment
        if (Input.GetKey(KeyCode.UpArrow)) {
            transform.Translate(Vector3.forward * Time.deltaTime * speed);
        }

        // si la touche flèche du bas est appuyée, alors faire une transformation de type translation selon un vecteur
        // avec la vitesse speed définie précédemment
        if (Input.GetKey(KeyCode.DownArrow)) {
            transform.Translate(Vector3.back * Time.deltaTime * speed);
        }

        // si la touche flèche de gauche est appuyée, alors faire une transformation de type rotation sur x
        // avec la vitesse rotateSpeed définie précédemment
        if (Input.GetKey(KeyCode.LeftArrow)) {
            transform.Rotate(Vector3.down, Time.deltaTime * rotateSpeed);
        }

        // si la touche flèche de droite est appuyée, alors faire une transformation de type rotation sur x
        // avec la vitesse rotateSpeed définie précédemment
        if (Input.GetKey(KeyCode.RightArrow)) {
            transform.Rotate(Vector3.up, Time.deltaTime * rotateSpeed);
        }
    }
}