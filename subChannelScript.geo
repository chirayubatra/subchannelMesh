// Call the geometry file, which has all the input data for the geometry

Include "chanGeometry.geo";

// including the file to enable the function calling later

Include "macroHex.geo";

// loop to make all the hexagons, no of innerHex = rows-1, and call Hexcan is
// used to create the outer curve loop. I think that can be omitted, but have
// kept to make a uniform mesh later to check 

For i In {1:rows-1}
	pitch = i*pitch;
	pitchFace = i*pitchFace;
	Call CreateInnerHex;
	pitch = pitch/i;
	pitchFace = pitchFace/i;
	// this loop checks when we are at the last inner Hex, then call  other
	// Macros to create edge and corner subchannel surfaces
	If (i==rows-1)   
		Call HexCan;
		Call NewPoints;
		//Call HexCan;
		Call edgeSurfaces;
		//Call cornerSurfaces;
	EndIf	
EndFor

// this is used to store all surfaces in one array and then name them later. 
bottom[] = Surface { : }; 
h=1;
//m=1;
m=3.7;
newEntities[]=
Extrude{0,0,m}
{		
	Surface{:};		
	//Surface {43};
	Layers{{4,22,4},{h/4,3*h/4, h}};
	Recombine;	
};

Physical Surface("hbottom") = {bottom[]};

allVolumes[] = Volume{:};

//Physical Surface("htop") = 

Physical Volume("subChannel") = {allVolumes[]};

// --- Mesh creation, enable this to directly create the Mesh
// to generate 2D mesh from the script
//Mesh 2;
// to generate 3D mesh 
Mesh 3;


// ----- Script ends here -----


// just to check the code 


out[]=Surface{:};
//For j In {0:#out[]-1}
//	Printf("The Surface number %g is %g",j,out[j]) ;
//EndFor

//Printf("Value of w is: %g",w);

For j In {0:#newEntities[]-1}
	Printf("The newEntity %g is %g",j,newEntities[j]) ;
EndFor
//+


//+
//Physical Surface("htop") = {398, 464, 442, 508, 486, 530, 574, 332, 354, 420, 376, 552, 124, 186, 248, 310};
//+
//Physical Surface("htop_internal") = {124, 186, 248, 310};

//+
Physical Surface("htop") = {536, 412, 350, 288, 226, 164, 598, 682, 474, 660};
//+
Physical Surface("htop") += {704, 748, 792, 836, 880};
//+
Physical Surface("htop") += {770, 726, 924, 814, 858, 902};
