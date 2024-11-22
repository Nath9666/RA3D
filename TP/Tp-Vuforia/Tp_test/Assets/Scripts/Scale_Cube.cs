using UnityEngine;

public class ScaleCube : MonoBehaviour {
    // Utilisé pour l'initialisation
    void Start() {
    }

    // Update est appelé une fois par frame
    void Update() {
        // si la touche W est appuyée
        if (Input.GetKeyDown(KeyCode.W)) {
            // si le cube a un scale inférieur à 5 (ne pas effectuer un scale au-dessus de 5)
            if (transform.localScale.x < 1 && transform.localScale.y < 1 && transform.localScale.z < 1) {
                // alors faire une transformation scale incrémentée sur le gameobject
                transform.localScale += new Vector3(0.1f, 0.1f, 0.1f);
            }
        }

        // si la touche X est appuyée
        if (Input.GetKeyDown(KeyCode.X)) {
            // si le cube a un scale supérieur à 1 (ne pas effectuer un scale négatif)
            if (transform.localScale.x > 0 && transform.localScale.y > 0 && transform.localScale.z > 0) {
                // alors faire une transformation scale décrémentée sur le gameobject
                transform.localScale -= new Vector3(0.1f, 0.1f, 0.1f);
            }
        }
    }
}