using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ScaleUpdate : MonoBehaviour {
    public GameObject Image1 = null; // Premier objet d'image
    public GameObject Image2 = null; // Deuxième objet d'image
    private Vector3 dist; // Distance entre les deux objets
    private float mod = 0f; // Modificateur de mise à l'échelle

    // Update est appelé une fois par frame
    void Update() {
        // Récupérer les composants markDist des deux images
        var SpherePosition = Image1.GetComponent<MarkDist>();
        var CubePosition = Image2.GetComponent<MarkDist>();

        // Calculer la distance entre les deux objets
        dist = SpherePosition.delta - CubePosition.delta;

        // Si les deux objets sont suivis
        if (SpherePosition.goIn == true && CubePosition.goIn == true) {
            // Calculer le modificateur de mise à l'échelle basé sur la distance
            mod = dist.magnitude;
            // Appliquer la mise à l'échelle à l'objet actuel
            Image1.transform.GetChild(0).gameObject.transform.localScale= new Vector3(0.15f/mod , 0.15f/mod , 0.15f/mod);
            Debug.Log("Distance : " + mod);
        }
    }
}