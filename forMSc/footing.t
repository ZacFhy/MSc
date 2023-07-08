*COMMENT: RIGID STRIP FOOTING, 2D08_SU[R]FACE_FOOTING_5.19, WIDTH d: 1.0m
*COMM
*COMM CONTROL SECTION
*COMM 
	*PROGRAM CONTROL
	START  1,1
	STOP   7,1
    INITIAL E:\tl\DATA\instrsD.f
	NEWDATA 
	SAVE
	INDISC E:\tl\RUN\MESH\MESH_FOOTING24.SVE
*COMM	OUTDISC E:\tl\RUN\RUN2\RUN2.SVE
	NONLINEAR
	PLANE 1
	AUTOMATIC_INCREMENTATION
	DTOL        100, 100
	LTOLERANCE 200, 200, -2
	DFOV       0, 0, 0, 1
	PARDISO
	ITERATION  10, 30
	ALPHA      1, 100, 5
	FLOW 10000, 1000, 10000
*COMM	GID
	*ENDCONTROL
*COMM DATA SECTION
*COMM
   *DEFINE
*COMM 
      *TITLE
         1: RIGID STRIP SURFACE FOOTING
*COMM 
	*DEFINE
	*UPDATE STIFFNESS
	1: 1, 1000, 1, -1
*COMM
*COMM MESH DATA
*COMM 
	*REFERENCE POINTS
	1:  0.0,  0.0
	2:  0.0, -8.0
	3: 12.0, -8.0
	4: 12.0,  0.0 
*COMM
*COMM LINEAR MATERIAL PROPERTIES
*COMM
	*LINEAR MATERIAL PROPERTIES
	1:    1.0, 19.0, 1.0, 0.0, 100000.0, 0.3, 0.0
	2:    1.0, 19.0, 1.0, 0.0, 100000.0, 0.3, 0.0
*COMM
*COMM 3D Mohr-Coulomb (MODEL 16) NONLINEAR MATERIAL PROPERTY
*COMM
	*NONLINEAR MATERIAL PROPERTIES
	1:   16.0,  5.0, 25.0, 25.0
	2:   16.0,  5.0, 25.0, 25.0
*COMM
*COMM ------------------------ 
*SMALL STRAIN STIFFNESS
*COMM ------------------------
*COMM
*COMM London Clay: 	Specifying G degradation 
*COMM 				K adopted the same and prescribed via Poisson ratio
*comm
*comm 	Model number & elastic switch (P1-P2)
    1:1: 	11.0, 1.0
*comm 	Basic max shear and bulk modulus (P3 - P4)
    1:2: 	50681.74, 0.25
*comm	effect of p' (P5 - P7)
    1:3: 	100.0, 1.0, 0.0
*comm 	effect of void ratio (P8-P11)
    1:4:	0.0, 0.0, 0.0, 0.0
*comm 	elasticigy switch (P12)
    1:5:	3.0
*comm	shear modulus degradation (P13 - P18)
    1:6:	0.0003, 0.0, 0.0, 0.805, 0.0163, 1000.0
*comm 	bulk modulus degradation (P19 - P24)
    1:7:	0.0, 0.0, 0.0, 0.0, 0.0, 0.0
*comm 	anisotropic degradation of shear modulus (P25 - P28)
    1:8:  	1.0, 1.0, 1.0, 1.0
*comm 	bulk stiffness and degradation unload / reload (P29 - P30)
    1:9: 	1.0, 1.0
*comm 	degradatin and scaling switch (P31 - P32)
    1:10: 	1.0, 0.0
*comm 	remaining parameters not required (P33 - P49)
*COMM ------------------------------------------------------------
*COMM London Clay: 	Specifying G degradation 
*COMM 				K adopted the same and prescribed via Poisson ratio
*comm
*comm 	Model number & elastic switch (P1-P2)
    2:1: 	11.0, 1.0
*comm 	Basic max shear and bulk modulus (P3 - P4)
    2:2: 	74110.62, 0.25
*comm	effect of p' (P5 - P7)
    2:3: 	100.0, 1.0, 0.0
*comm 	effect of void ratio (P8-P11)
    2:4:	0.0, 0.0, 0.0, 0.0
*comm 	elasticigy switch (P12)
    2:5:	3.0
*comm	shear modulus degradation (P13 - P18)
    2:6:	0.0003, 0.0, 0.0, 1.53, 0.0163, 1000.0
*comm 	bulk modulus degradation (P19 - P24)
    2:7:	0.0, 0.0, 0.0, 0.0, 0.0, 0.0
*comm 	anisotropic degradation of shear modulus (P25 - P28)
    2:8:  	1.0, 1.0, 1.0, 1.0
*comm 	bulk stiffness and degradation unload / reload (P29 - P30)
    2:9: 	1.0, 1.0
*comm 	degradatin and scaling switch (P31 - P32)
    2:10: 	1.0, 0.0
*comm 	remaining parameters not required (P33 - P49)
*COMM
*COMM CHANGE MATERIAL PROPERTIES
*COMM
	*CHANGE MATERIAL PROPERTIES
	1: 1, 1, 2
	2: 1, 2, 3
*COMM
*COMM BOUNDARY CONDITIONS
*COMM
	*PRESCRIBED DISPLACEMENTS
	1:   1,1000,    1,    1,    4, 0 
	2:   1,1000,    2,    2,    3, 0
*COMM   Displacements defined here.
	3:   1,    2,    2, -747, -692, 1
    4:   3,    3,    2, -747, -692, 2
    5:   4,    4,    2, -747, -692, 3
    6:   5,    5,    2, -747, -692, 4
    7:   6,    7,    2, -747, -692, 5
*COMM
	*DISPLACEMENT VALUES
	1: 2.0, -0.001
    2: 2.0, -0.003
    3: 2.0, -0.005
	4: 2.0, -0.09
    5: 2.0, -0.1
*COMM
*COMM POST-PROCESSING
*COMM		
	*XY-GRAPH
*COMM Nodes (x,y)   1:(0,0);   2:(0,-1);   3:(1,-1);     4:(1,0)
	1: 7, 7, 1, 4102, 2, 692, 0, 4502, 4,   1, 0, 0, 0, 0, 1, 1
*COMM 	2: 5, 5, 1, 4102, 2, 622, 0, 5302, 1, 188, 0, 0, 0, 0, 1, 1
*COMM 	3: 5, 5, 1, 4102, 2, 719, 0, 5302, 1, 228, 0, 0, 0, 0, 1, 1
*COMM 	4: 5, 5, 1, 4102, 2, 747, 0, 5302, 1, 220, 0, 0, 0, 0, 1, 1
*COMM   Element containing x=0,y=0
*COMM 	5: 5, 5, 1, 6511, 1, 208, 1, 9005, 1, 208, 1, 0, 0, 0, 1, 1, 0, 0, 1, 0
*COMM 	6: 5, 5, 1, 6510, 1, 208, 1, 9006, 1, 208, 1, 0, 0, 0, 1, 1, 0, 0, 1, 0
*COMM   Element containing x=0m,y=-1m
*COMM 	7: 5, 5, 1, 6511, 1, 192, 1, 9005, 1, 192, 1, 0, 0, 0, 1, 1, 0, 0, 1, 0
*COMM 	8: 5, 5, 1, 6510, 1, 192, 1, 9006, 1, 192, 1, 0, 0, 0, 1, 1, 0, 0, 1, 0
*COMM   Element containing x=1m,y=-1m
*COMM 	9:  5, 5, 1, 6511, 1, 222, 1, 9005, 1, 222, 1, 0, 0, 0, 1, 1, 0, 0, 1, 0
*COMM 	10: 5, 5, 1, 6510, 1, 222, 1, 9006, 1, 222, 1, 0, 0, 0, 1, 1, 0, 0, 1, 0
*COMM
 	*PLOT
 	1: 0, 7, 1, 9003
*COMM 	2: 0, 7, 1, 4105
*COMM	3: 1, 15, 1, 2002
*COMM 
*COMM 4052: DISPLACEMENT 4502: REACTION (NEEDS TO BE DEFINED FOR A SECTION OF NODES)
*COMM 
	*SECTIONING
	1: 2, 208,-211, 231, -234
	*comm --- Material 1
	2: 2, 9,-12,24,25,47,-52,80,-91,108,-171,180,-211,216,-235
	*comm --- Material 2
	3: 2, 1,-8,13,-23,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,92,93,94,95,96,97,98,99,100,101,102,103,104,105,106,107,172,173,174,175,176,177,178,179,212,213,214,215
*COMM
*ENDDATA