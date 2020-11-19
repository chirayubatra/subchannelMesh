Macro CreateInnerHex

  // In the following commands we use the reserved variable name `newp', which
  // automatically selects a new point number. This number is chosen as the
  // highest current point number, plus one. (Note that, analogously to `newp',
  // the variables `newl', `news', `newv' and `newreg' select the highest number
  // amongst currently defined curves, surfaces, volumes and `any entities other
  // than points', respectively.)

  p_1 = newp; Point(p_1) = {pitch, 0, 0, lc};
  p_2 = newp; Point(p_2) = {pitch/2,pitchFace/2,0,lc};
  p_3 = newp; Point(p_3) = {-pitch/2,pitchFace/2,0,lc};
  p_4 = newp; Point(p_4) = {-pitch, 0, 0, lc};
  p_5 = newp; Point(p_5) = {-pitch/2,-pitchFace/2,0,lc};
  p_6 = newp; Point(p_6) = {pitch/2,-pitchFace/2,0,lc};
  
  l_1 = newl; Line(l_1) = {p_1,p_2};
  l_2 = newl; Line(l_2) = {p_2,p_3};
  l_3 = newl; Line(l_3) = {p_3,p_4};
  l_4 = newl; Line(l_4) = {p_4,p_5};
  l_5 = newl; Line(l_5) = {p_5,p_6};
  l_6 = newl; Line(l_6) = {p_6,p_1};
  
  theLoops[i] = newreg; // array to save all the new loops, which can be used later to make surfaces
  Curve Loop(theLoops[i]) = {l_1:l_6};  
  //cl1 = newll; Curve Loop(cl1) = {l_1:l_6};
  theSurface[i] = newreg;
  If (i>1)
	Plane Surface(theSurface[i]) = {theLoops[i],theLoops[i-1]};
	Transfinite Line{l_1:l_6} = i+1; // creates transfinite points to have a structured mesh, no Recombine used
  Else
    Plane Surface(theSurface[i]) = {theLoops[i]};
  EndIf
    
  //cl1 = newll; Curve Loop(cl1) = {l1:l6};
  //ps1 = news; Plane Surface(ps1) = {cl1};
  //out[] = Surface{};
  
Return

Macro HexCan
  pf_1 = newp; Point(pf_1) = {edge, 0, 0, lc};
  pf_2 = newp; Point(pf_2) = {edge/2,FtoF/2,0,lc};
  pf_3 = newp; Point(pf_3) = {-edge/2,FtoF/2,0,lc};
  pf_4 = newp; Point(pf_4) = {-edge, 0, 0, lc};
  pf_5 = newp; Point(pf_5) = {-edge/2,-FtoF/2,0,lc};
  pf_6 = newp; Point(pf_6) = {edge/2,-FtoF/2,0,lc};
  
  lf_1 = newl; Line(lf_1) = {pf_1,pf_2};
  lf_2 = newl; Line(lf_2) = {pf_2,pf_3};
  lf_3 = newl; Line(lf_3) = {pf_3,pf_4};
  lf_4 = newl; Line(lf_4) = {pf_4,pf_5};
  lf_5 = newl; Line(lf_5) = {pf_5,pf_6};
  lf_6 = newl; Line(lf_6) = {pf_6,pf_1}; 
    
  //clh = newll; Curve Loop(clh)={lf1:lf6};

Return

// Macro to create new points on the edge of the subassembly to define corner and edge subchannels 

Macro NewPoints

  w=edge-((rows-1)*pitch);
  pf_7 = newp; Point(pf_7) = {edge-w/4, Sqrt(3)*w/4,0,lc};
  pf_8 = newp; Point(pf_8) = {(edge-w/4)-((rows-1)*pitch*Cos(Pi/3)),(Sqrt(3)*w/4)+((rows-1)*pitch*Sin(Pi/3)),0,lc};
  //p[]=Translate {-(rows-1)*pitch*Cos(Pi/3),(rows-1)*pitch*Sin(Pi/3),0} { Duplicata{ Point{p7}; } };
  pf_9 = newp; Point(pf_9)={((rows-1)/2)*pitch, FtoF/2,0,lc};
  pf_10 = newp; Point(pf_10)={-((rows-1)/2)*pitch, FtoF/2,0,lc};
  pf_11 = newp; Point(pf_11) = {-((edge-w/4)-((rows-1)*pitch*Cos(Pi/3))),(Sqrt(3)*w/4)+((rows-1)*pitch*Sin(Pi/3)),0,lc};
  pf_12 = newp; Point(pf_12) = {-(edge-w/4), Sqrt(3)*w/4,0,lc};
  pf_13 = newp; Point(pf_13)= {-(edge-w/4), -Sqrt(3)*w/4,0,lc};
  pf_14 = newp; Point(pf_14) = {-((edge-w/4)-((rows-1)*pitch*Cos(Pi/3))),-((Sqrt(3)*w/4)+((rows-1)*pitch*Sin(Pi/3))),0,lc};
  pf_15 = newp; Point(pf_15)={-((rows-1)/2)*pitch, -FtoF/2,0,lc};
  pf_16 = newp; Point(pf_16)={((rows-1)/2)*pitch, -FtoF/2,0,lc};
  pf_17 = newp; Point(pf_17) = {(edge-w/4)-((rows-1)*pitch*Cos(Pi/3)),-((Sqrt(3)*w/4)+((rows-1)*pitch*Sin(Pi/3))),0,lc};
  pf_18 = newp; Point(pf_18) = {edge-w/4, -Sqrt(3)*w/4,0,lc};

Return  

// Macro to create edge and corner surfaces 

Macro edgeSurfaces
	For j In {0:5}	
		lo_1[j] = newl; Line(lo_1[j]) = {p~{j+1},pf~{7+2*j}};
		lo_2[j] = newl; Line(lo_2[j]) = {pf~{7+2*j},pf~{8+2*j}};
		If (j==5)
			lo_3[j] = newl; Line(lo_3[j]) = {pf~{8+2*j},p~{j-4}};		
		Else
			lo_3[j] = newl; Line(lo_3[j]) = {pf~{8+2*j},p~{j+2}};
		EndIf
		//lo4=newl; Line(lo4)={p2,p1};
		fl_1[j]=newreg; Curve Loop(fl_1[j])={lo_1[j]:lo_3[j],-l~{j+1}};	
		ps_1 = news; Plane Surface(ps_1) = {fl_1[j]};
		Transfinite Line{lo_2[j]} = i+1;
		Transfinite Surface{ps_1};
		Recombine Surface{ps_1};
		// for the cornerSurfaces
		lc_1[j] = newl; Line(lc_1[j]) = {pf~{1+j},pf~{7+2*j}};
		If(j==0)
			lc_2[j] = newl; Line(lc_2[j]) = {pf~{1+j},pf~{18}};
		Else 
			lc_2[j] = newl; Line(lc_2[j]) = {pf~{1+j},pf~{6+2*j}};
		EndIf
		//Printf("lc_1:%g,lc_2:%g,lo_1:%g,lo_2:%g,lo_3=%g",lc_1,lc_2,lo_1,lo_2,lo_3);
		If (j>0)
		cl_1[j]=newreg; Curve Loop(cl_1[j]) = {lc_1[j],-lo_1[j],-lo_3[j-1],-lc_2[j]};
		//Else
		//cl_1[j]=newreg; Curve Loop (cl_1[j]) = {lc_1[j],-lo_1[j],-lo_3[j+4],-lc_2[j]};
		cs_1 = news; Plane Surface(cs_1) = {cl_1[j]};
		Transfinite Surface{cs_1};
		Recombine Surface{cs_1};
		EndIf		
	EndFor	
		cl_1[0]=newreg; Curve Loop (cl_1[0]) = {lc_1[0],-lo_1[0],-lo_3[5],-lc_2[0]};
		cs_2 = news; Plane Surface(cs_2) = {cl_1[0]};
		Transfinite Surface{cs_2};
		Recombine Surface{cs_2};
		
Return


// this is unused macro, merged into Macro edgeSurfaces
Macro cornerSurfaces
	For k In {0:5}
	//j=5;
		lc_1 = newl; Line(lc_1) = {pf~{1+k},pf~{7+2*k}};
		If(k==0)
			lc_2 = newl; Line(lc_2) = {pf~{1+k},pf~{18}};
		Else 
			lc_2 = newl; Line(lc_2) = {pf~{1+k},pf~{6+2*k}};
		EndIf
	//cl_1=newreg; Curve Loop(cl_1) = {lc_1,-lo_1,-lo_2 , -lc_2};
	//cs_1 = news; Plane Surface(cs_1) = {cl_1};
	//Transfinite Surface{cl_1};
	//Recombine Surface{ps_1};
	EndFor
	
	
	//lc_1 = newl; Line(lc_1) = {pf~{2},pf~{9}};
Return
	



