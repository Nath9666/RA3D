using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using Vuforia;

public class PlanetOrbit : MonoBehaviour
{
    public GameObject sun; // Marqueur du Soleil
    public GameObject planet; // Marqueur de la Planète (ex. Terre)
    public float orbitSpeed = 10f; // Vitesse de rotation autour du Soleil

    private ObserverBehaviour sunObserver; // ObserverBehaviour pour le marqueur Soleil
    private ObserverBehaviour planetObserver; // ObserverBehaviour pour le marqueur Planète

    private bool isSunDetected = false; // Indique si le Soleil est détecté
    private bool isPlanetDetected = false; // Indique si la Planète est détectée

    void Start()
    {
        // Récupération des ObserverBehaviours
        sunObserver = sun.GetComponent<ObserverBehaviour>();
        planetObserver = planet.GetComponent<ObserverBehaviour>();
    }

    void Update()
    {
        // Vérification des détections
        isSunDetected = sunObserver.TargetStatus.Status == Status.TRACKED;
        isPlanetDetected = planetObserver.TargetStatus.Status == Status.TRACKED;

        // Si les deux cartes sont détectées, faire tourner la planète autour du Soleil
        if (isSunDetected && isPlanetDetected)
        {
            RotatePlanetAroundSun();
        }
    }

    // Fonction pour faire tourner la planète autour du Soleil
    void RotatePlanetAroundSun()
    {
        if (sun != null && planet != null)
        {
            planet.transform.RotateAround(sun.transform.position, Vector3.up, orbitSpeed * Time.deltaTime);
        }
    }
}
