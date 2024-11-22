using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using Vuforia;

public class ChangeRotate : MonoBehaviour
{
    // Start is called once before the first execution of Update after the MonoBehaviour is created
    public GameObject Image1 = null; // Image capté
    public GameObject Image2 = null; // Image capté
    public GameObject objectRotate; // L'objet à faire tourner
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        var trackableImage = Image1.GetComponent<ObserverBehaviour>();
        var statusImage = trackableImage.TargetStatus.Status;
        var trackableImage2 = Image2.GetComponent<ObserverBehaviour>();

        if (statusImage == Status.TRACKED){
            objectRotate.transform.rotation = trackableImage.transform.rotation;
        }
    }
}
