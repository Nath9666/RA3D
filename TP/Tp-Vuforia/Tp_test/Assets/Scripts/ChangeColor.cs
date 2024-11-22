using UnityEngine;

public class ChangeColor : MonoBehaviour
{
    public GameObject objectColor; // L'objet à changer de couleur
    public Material materialColor; // La couleur à appliquer
    public Material DefaultColor; // La couleur à appliquer
    public GameObject Image1 = null; // Image capté

    // Start is called once before the first execution of Update after the MonoBehaviour is created
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        var SpherePosition = Image1.GetComponent<MarkDist>();

        if (SpherePosition.goIn == true)
        {
            objectColor.GetComponent<Renderer>().material = materialColor;
        }
        else
        {
            objectColor.GetComponent<Renderer>().material = DefaultColor;
        }
    }
}
