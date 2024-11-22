using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using Vuforia;

public class MarkDist : MonoBehaviour {
    public GameObject imageTracker; // L'objet tracker d'image
    public Vector3 delta; // La différence de position
    public bool goIn = false; // Statut de suivi

    void Update() {
        // Récupérer le composant ObserverBehaviour de l'image tracker
        var trackableImage = imageTracker.GetComponent<ObserverBehaviour>();
        // Récupérer le statut actuel de l'image tracker
        var statusImage = trackableImage.TargetStatus.Status;

        // Si l'image est suivie
        if (statusImage == Status.TRACKED) {
            goIn = true;
            // Calculer la différence de position entre la caméra et l'objet
            delta = Camera.main.transform.position - transform.position;
        } else {
            goIn = false;
        }
    }
}