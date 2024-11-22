using UnityEngine;

public class RotateObject : MonoBehaviour {
    public GameObject objectRotate; // L'objet à faire tourner
    public float rotateSpeed = 50f; // Vitesse de rotation
    bool rotateStatus = false; // Statut de la rotation

    // Méthode pour changer l'échelle de l'objet
    public void ScaleOn() {
        objectRotate.transform.localScale = new Vector3(1.1f, 1.1f, 1.1f);
    }

    // Méthode pour activer ou désactiver la rotation
    public void ToggleRotation() {
        rotateStatus = !rotateStatus;
    }

    // Update est appelé une fois par frame
    void Update() {
        if (rotateStatus) {
            // Faire tourner l'objet autour de l'axe Y
            objectRotate.transform.Rotate(Vector3.up, rotateSpeed * Time.deltaTime);
        }
    }
}