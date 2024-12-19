using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using Vuforia;

public class PlanetOrbit : MonoBehaviour
{
    public GameObject sun; // Marqueur du Soleil
    public GameObject planet; // Marqueur de la Plan�te (ex. Terre)
    public float orbitSpeed = 10f; // Vitesse de rotation autour du Soleil

    private ObserverBehaviour sunObserver; // ObserverBehaviour pour le marqueur Soleil
    private ObserverBehaviour planetObserver; // ObserverBehaviour pour le marqueur Plan�te

    private bool isSunDetected = false; // Indique si le Soleil est d�tect�
    private bool isPlanetDetected = false; // Indique si la Plan�te est d�tect�e

    void Start()
    {
        // R�cup�ration des ObserverBehaviours
        sunObserver = sun.GetComponent<ObserverBehaviour>();
        planetObserver = planet.GetComponent<ObserverBehaviour>();
    }

    void Update()
    {
        // V�rification des d�tections
        isSunDetected = sunObserver.TargetStatus.Status == Status.TRACKED;
        isPlanetDetected = planetObserver.TargetStatus.Status == Status.TRACKED;

        // Si les deux cartes sont d�tect�es, faire tourner la plan�te autour du Soleil
        if (isSunDetected && isPlanetDetected)
        {
            RotatePlanetAroundSun();
        }
    }

    // Fonction pour faire tourner la plan�te autour du Soleil
    void RotatePlanetAroundSun()
    {
        if (sun != null && planet != null)
        {
            planet.transform.RotateAround(sun.transform.position, Vector3.up, orbitSpeed * Time.deltaTime);
        }
    }
}
