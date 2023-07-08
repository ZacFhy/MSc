      SUBROUTINE INSTRS(   PRPL,  PRPNL,    NEL,  IETYP, MATNOS,     XC,
     S                       YC,     ZC,     S1,     S2,     S3,     S4,
     S                       S5,     S6,     S7,     S8,     PW,     VR,
     S                                              DOS,    TMP,   DOLS)
      INCLUDE 'DP.T'
C****
C****           TEMPLATE FOR THE INITIAL STRESS SUBROUTINE
C****           ==========================================
C****
C**** This is a user defined subroutine for introducing initial 
C**** stresses/forces, pore fluid stresses, void ratios, degree of
C**** saturation, degree of liquid saturation and temperature into 
C**** a nonlinear analysis. 
C****
C**** The following parameters are passed to this routine:-
C****
C****   - The arrays PRPL(I) and PRPNL(I) contain the linear and
C****     and nonlinear material properties for the current
C****     integration point.
C****
C****   - NEL is the current element number
C****
C****   - IETYP is the current element type, i.e.
C****         IETYP = 1 for solid elements
C****         IETYP = 2 for joint elements
C****         IETYP = 3 for beam elements
C****         IETYP = 4 for membrane elements
C****         IETYP = 5 for bar elements
C****         IETYP = 6 for shell elements
C****
C****   - MATNOS is the current material property number
C****
C****   - XC and YC are the x and y global coordinates of the
C****     current integration point
C****
C****   - ZC is the global z coordinate of the current integration
C****     point for full 3D analysis, is the THETA coordinate for
C****     Fourier series aided analyses and is set to zero for all
C****     other analyses
C****
C****
C**** The following parameters must be set in this routine:-
C****
C****   - S1, S2, S3, S4, S5, S6, S7 and S8. These are equivalenced  
C****     to the element stresses and/or forces and are dependent
C****     on the element type.  See notes for each element type
C****
C****   - PW   = The pore fluid stress
C****
C****   - VR   = The void ratio. This is used by some of the
C****            nonlinear and variable permeability models and 
C****            is also used in Thermal Analyses.
C****            If not specified a default of VR=0.0 will be assumed.
C****
C****   - DOS  = The degree of saturation. This is used by some 
C****            of the Soil Characteristic Curve models and is also
C****            used in Thermal Analyses. Note DOS should be given 
C****            a value greater or equal to 0 and less or equal to 1.
C****            If not specified a default of DOS=1.0 will be assumed.
C****
C****   - TMP  = The temperature
C****
C****   - DOLS = The degree of liquid saturation. This is used by some 
C****            of the Liquid Characteristic Curve models and is also
C****            used in Thermal Analyses. Note DOLS should be given 
C****            a value greater or equal to 0 and less or equal to 1.
C****            If not specified a default of DOLS=1.0 will be assumed.
C****
C****   Note: If values are not set they will default to zero
C****
C****      NOTE: ICFEP USES A TENSION POSITIVE SIGN CONVENTION
C****      ===================================================
C****
      DIMENSION PRPL(*), PRPNL(*), PAR(8)
      EQUIVALENCE (PAR(1),  SX, TSP,  FA,  SA,  FX), 
     E            (PAR(2),  SY,  SN, BMA, SOP,  SB,  FB,SFXY),
     E            (PAR(3), SXY, TST,   S, SAB, FAB,SFXZ),   
     E            (PAR(4),  SZ, FOP, XMA, BMY),
     E            (PAR(5), SXZ,BMOP, XMB, BMZ),
     E            (PAR(6), SYZ,XMAB, BMT),
     E            (PAR(7), SFA),  
     E            (PAR(8), SFB)
C****
C**** ZERO ARRAY -PAR(I)-
C****
      CALL RZERO(PAR,8)
C****
C**** SET INITIAL STRESSES
C****
C****
      IF(IETYP.EQ.1) THEN
C****
C****                   SOLID/BRICK ELEMENTS
C****                   ====================
C****
C****     The following parameters must be set here:-
C****
C****      SX   =   SIGX   (or SIGR       for axi-symmetric analyses)
C****      SY   =   SIGY   (or SIGZ       for axi-symmetric analyses)
C****      SXY  =   SIGXY  (or SIGRZ      for axi-symmetric analyses)
C****      SZ   =   SIGZ   (or SIG(THETA) for axi-symmetric analyses)
C****      PW   =   Pore fluid stress
C****      VR   =   Void ratio
C****      DOS  =   Degree of saturation
C****      TMP  =   Temperature
C****      DOLS =   Degree of liquid saturation
C****    
C****     In addition for 3D and Fourier series aided analysis the
C****     following stress components must be set:-
C****
C****      SXZ  =   SIGXZ  (or SIGRT      for Fourie aided analyses)
C****      SYZ  =   SIGYZ  (or SIGZT      for Fourie aided analyses)
C****
C****     NOTE: For elements using a total stress constitutive model
C****           (i.e. Non linear models 19 & 24) then the stress
C****           parameters (SX, SY, ....) should contain total stress
C****           values and the pore water pressure, PW, should be set
C****           to zero. For effective stress constitutive models the
C****           stress parameters (SX, SY, ....) should contain 
C****           effective stress values and the pore water pressure
C****           should be set in PW.
C****
C****
      SY  = YC * 19.0 - 10.0
      SX  = SY * 0.577
	  SXY = 0.0
	  PW  = 0.0
	  SZ  = SX
      ELSE IF(IETYP.EQ.2) THEN
C****
C****                    JOINT/INTERFACE ELEMENTS
C****                    ========================
C****
C****    The following parameters must be set here:-
C****
C****     TSP  =   Shear stress along joint. For full 3D analyses
C****              it is the shear stress in the direction of nodes
C****              1 to 5 in the parent isoparametric element.
C****     SN   =   Normal stress across joint
C****     PW   =   Pore fluid stress
C****     VR   =   Void ratio
C****     DOS  =   Degree of saturation
C****     TMP  =   Temperature
C****     DOLS =   Degree of liquid saturation
C****
C****    In addition for 3D and Fourier series aided analysis the
C****    following stress component must be set:-
C****
C****     TST  =   Shear stress in THETA (ZC) direction for Fourier
C****              series aided analyses. For full 3D analysis it is
C****              the shear stress in the plane of the element
C****              perpendicular to TSP (i.e. in the direction of 
C****              nodes 1 to 2 in the parent isoparametric element).
C****
C****
      ELSE IF(IETYP.EQ.3) THEN
C****
C****                    BEAM ELEMENTS
C****                    =============
C****
C****    The following parameters must be set here:-
C****
C****     For axisymmetric, plane stress and plane strain analyses:
C****
C****        FA   =   Axial force
C****        BMA  =   Moment
C****        S    =   Shear force
C****        FOP  =   Out of plane force
C****        BMOP =   Out of plane moment
C****        PW   =   Pore fluid stress
C****        VR   =   Void ratio
C****        DOS  =   Degree of saturation
C****        TMP  =   Temperature
C****        DOLS =   Degree of liquid saturation
C****
C****     For full 3D analyses:
C****
C****        FX   =   Axial force (in local x direction)
C****        SFXY =   Shear force (in local y direction)
C****        SFXZ =   Shear force (in local z direction)
C****        BMY  =   Moment around the local y direction
C****        BMZ  =   Moment around the local z direction
C****        BMT  =   Twisting Moment (around the local x direction)
C****        PW   =   Pore fluid stress
C****        VR   =   Void ratio
C****        DOS  =   Degree of saturation
C****        TMP  =   Temperature
C****        DOLS =   Degree of liquid saturation
C****
C****
      ELSE IF(IETYP.EQ.4) THEN
C****
C****                   MEMBRANE ELEMENTS
C****                   =================
C****
C****     The following parameters must be set here:-
C****
C****     For axisymmetric, plane stress and plane strain analyses:
C****
C****        SA   =   Axial stress
C****        SOP  =   Out of plane stress
C****        PW   =   Pore fluid stress
C****        VR   =   Void ratio
C****        DOS  =   Degree of saturation
C****        TMP  =   Temperature
C****        DOLS =   Degree of liquid saturation
C****
C****     For full 3D analyses:
C****
C****        SA   =   In plane direct stress in the direction of maximum 
C****                 element curvature
C****        SB   =   In plane direct stress in the direction of minimum 
C****                 element curvature
C****        SAB  =   In plane shear stress  
C****        PW   =   Pore fluid stress
C****        VR   =   Void ratio
C****        DOS  =   Degree of saturation
C****        TMP  =   Temperature
C****        DOLS =   Degree of liquid saturation
C****
C****
      ELSE IF(IETYP.EQ.5) THEN
C****
C****                   BAR ELEMENTS
C****                   ============
C****
C****    The following parameters must be set here:-
C****
C****     FA   =   Axial force
C****     PW   =   Pore fluid stress
C****     VR   =   Void ratio
C****     DOS  =   Degree of saturation
C****     TMP  =   Temperature
C****     DOLS =   Degree of liquid saturation
C****
C****    In addition for axisymmetric, plane stress and plane strain
C****    analyses the following force component must be set:-
C****
C****     FOP  =   Out of plane force
C****
C****
      ELSE IF(IETYP.EQ.6) THEN
C****
C****                    SHELL ELEMENTS
C****                    =============
C****
C****    The following parameters must be set here:-
C****
C****     For axisymmetric, plane stress and plane strain analyses:
C****
C****        FA   =   Axial force
C****        BMA  =   Moment
C****        S    =   Shear force
C****        FOP  =   Out of plane force
C****        BMOP =   Out of plane moment
C****        PW   =   Pore fluid stress
C****        VR   =   Void ratio
C****        DOS  =   Degree of saturation
C****        TMP  =   Temperature
C****        DOLS =   Degree of liquid saturation
C****
C****     For full 3D analyses:
C****
C****        FA   =   In plane direct force in the direction of maximum 
C****                 element curvature
C****        FB   =   In plane direct force in the direction of minimum 
C****                 element curvature
C****        FAB  =   In plane shear force  
C****        XMA  =   Moment around the direction of maximum curvature
C****        XMB  =   Moment around the direction of minimum curvature
C****        XMAB =   Twisting moment
C****        SFA  =   Transverse shear force acting on planes 
C****                 perpendicular to the direction of maximum
C****                 curvature
C****        SFB  =   Transverse shear force acting on planes 
C****                 perpendicular to the direction of minimum 
C****                 curvature
C****        PW   =   Pore fluid stress
C****        VR   =   Void ratio
C****        DOS  =   Degree of saturation
C****        TMP  =   Temperature
C****        DOLS =   Degree of liquid saturation
C****
C****
      END IF
C****
C**** SET RETURN ARGUEMENTS -S1, S2, S3, S4, S5, S6, S7 AND S8-
C****
      S1 = PAR(1)
      S2 = PAR(2)
      S3 = PAR(3)
      S4 = PAR(4)
      S5 = PAR(5)
      S6 = PAR(6)
      S7 = PAR(7)
      S8 = PAR(8)
C****
C****
      RETURN
      END
