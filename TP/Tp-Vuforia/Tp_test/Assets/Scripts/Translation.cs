using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using Vuforia;

public class Translation : MonoBehaviour
{
    public GameObject Image1 = null; // Image capté
    public GameObject Image2 = null; // Image capté
    public GameObject objectTranslate; // L'objet à déplacer
    private Vector3 dist; // Distance entre les deux objets
    private float mod = 0f; // Modificateur de déplacement
    // Start is called once before the first execution of Update after the MonoBehaviour is created
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        var SpherePosition = Image1.GetComponent<MarkDist>();
        var CubePosition = Image2.GetComponent<MarkDist>();

        dist = SpherePosition.delta - CubePosition.delta;

        if (SpherePosition.goIn == true && CubePosition.goIn == true)
        {
            mod = dist.magnitude;
            objectTranslate.transform.position.x = Camera.main.transform.position.x - dist;
            Debug.Log("Distance : " + mod);
        }
    }
}
