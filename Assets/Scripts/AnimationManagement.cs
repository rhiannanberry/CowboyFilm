using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class AnimationManagement : MonoBehaviour
{
	public GameObject cowboyYellow, cowboyOrange;
	public Transform ridingPosition;
    // Start is called before the first frame update
    void Start()
    {
        SetRiding();
    }

    // Update is called once per frame
    void Update()
    {
        
    }
	
	public void SetRiding() {
	cowboyYellow.transform.SetParent(ridingPosition);	
	cowboyYellow.transform.position = ridingPosition.position;
	cowboyYellow.transform.rotation = ridingPosition.rotation;
	}
}
