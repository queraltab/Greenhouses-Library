within Greenhouses.Flows.HeatAndVapourTransfer;
model Convection_Condensation "Upward or downward heat exchange by free convection from an horizontal or inclined surface.
  Mass transfer by condensation from the air (filled port) to the cover/screen (empty port).
  If studying heat exchange of Air-Floor: connect the filled port to the floor and the unfilled port to the air."
  extends Greenhouses.Interfaces.HeatAndVapour.Element1D;

  /*********************** Parameters ***********************/
  parameter Modelica.Units.SI.Angle phi
    "inclination of the surface (0 if horizontal, 25 for typical cover)";
  parameter Modelica.Units.SI.Area A "floor surface";
  parameter Boolean floor=false
    "true if floor, false if cover or thermal screen heat flux";
  //parameter Real X=3 "characteristic dimension of the floor - half diameter of Benard-cell" annotation (Dialog(enable=(not upward)));
  parameter Boolean thermalScreen=false
    "presence of a thermal screen in the greenhouse" annotation (Dialog(enable=(not floor)));
  parameter Boolean Air_Cov=true
    "True if heat exchange air-cover, False if heat exchange air-screen"                             annotation (Dialog(enable=(not floor and thermalScreen)));
  parameter Boolean topAir=false "False if MainAir-Cov; True for: TopAir-Cov"
                                                                  annotation (Dialog(enable=(thermalScreen and not floor and Air_Cov)));

  /*********************** Varying inputs ***********************/
  Real SC=0 "Screen closure 1:closed, 0:open" annotation (Dialog(enable=(thermalScreen and not floor), group="Varying inputs"));

  /*********************** Variables ***********************/
  Modelica.Units.SI.CoefficientOfHeatTransfer HEC_ab;
  Real VEC_ab(unit="kg/(s.Pa.m2)") "Mass transfer coefficient";
  Real s=11
    "Slope of the differentiable switch function for vapour pressure differences";
  Modelica.Units.SI.CoefficientOfHeatTransfer HEC_up_flr;
  Modelica.Units.SI.CoefficientOfHeatTransfer HEC_down_flr;

equation
  //Heat Transfer
  if not floor then
    if thermalScreen then
      if Air_Cov then
        if not topAir then
          //Exchange main air-cover (with screen)
          HEC_ab=(1-SC)*1.7*max(1e-9,abs(dT))^0.33*(cos(phi))^(-0.66)
            "Changed 17/4/18, before it was 0";
        else
          //Exchange top air-cover
          HEC_ab=SC*1.7*max(1e-9,abs(dT))^0.33*(cos(phi))^(-0.66)
            "Changed 17/4/18. SC added";
        end if;
      else
        //Exchange air-screen
        HEC_ab=SC*1.7*max(1e-9,abs(dT))^0.33;
      end if;
    else
      //Exchange main air-cover (no screen)
      HEC_ab = 1.7*max(1e-9,abs(dT))^0.33*(cos(phi))^(-0.66);
    end if;
    HEC_up_flr=0 "dummy";
    HEC_down_flr=0;
  else
    //if HeatPort_a.T>HeatPort_b.T then
    //  HEC_ab = 1.7*max(1e-9,abs(dT))^0.33;
    //else
    //  HEC_ab = 1.3*max(1e-9,abs(dT))^0.25;
    //end if;
    // The conditions here above are smoothed using a differentiable switch function, in order to avoid events during simulation
     HEC_up_flr=1/(1+exp(-s*dT))*1.7*abs(dT)^0.33 "Used for dT>0";
     HEC_down_flr=1/(1+exp(s*dT))*1.3*abs(dT)^0.25 "Used for dT<0";
     HEC_ab = HEC_up_flr+HEC_down_flr;
  end if;

  Q_flow = A*HEC_ab*dT;

  //Mass Transfer
  VEC_ab=max(0,6.4e-9*HEC_ab);
  MV_flow=max(0,A*VEC_ab*dP)
    "The fluxes due to condensation are prohibited from being negative";

//   if dP>0 then
//     VEC_ab = 6.4e-9*HEC_ab;
//     MV_flow = A*VEC_ab*dP;
//   else
//     VEC_ab = 0;
//     MV_flow=0
//       "The fluxes due to condensation are prohibited from being negative";
//   end if;

  annotation (Icon(graphics={
        Rectangle(
          extent={{-10,80},{10,-80}},
          lineColor={0,0,0},
          fillColor={192,192,192},
          fillPattern=FillPattern.Backward,
          origin={0,-50},
          rotation=-90),
        Line(
          points={{-16,6},{2,-14},{40,-10},{48,8},{48,20}},
          color={0,0,255},
          smooth=Smooth.Bezier,
          arrow={Arrow.Filled,Arrow.None},
          origin={-60,18},
          rotation=-90),
        Text(
          extent={{-180,20},{180,-20}},
          textString="%name",
          lineColor={0,0,255},
          origin={0,-104},
          rotation=360),
        Polygon(
          points={{8,66},{-2,28},{-2,22},{-2,16},{4,10},{12,8},{18,10},{22,18},{
              22,22},{22,28},{10,58},{8,66}},
          smooth=Smooth.Bezier,
          fillPattern=FillPattern.Solid,
          fillColor={0,0,255},
          pattern=LinePattern.None),
        Polygon(
          points={{68,68},{58,30},{58,24},{58,18},{64,12},{72,10},{78,12},{82,20},
              {82,24},{82,30},{70,60},{68,68}},
          smooth=Smooth.Bezier,
          fillPattern=FillPattern.Solid,
          fillColor={0,0,255},
          pattern=LinePattern.None),
        Polygon(
          points={{40,22},{30,-16},{30,-22},{30,-28},{36,-34},{44,-36},{50,-34},
              {54,-26},{54,-22},{54,-16},{42,14},{40,22}},
          smooth=Smooth.Bezier,
          fillPattern=FillPattern.Solid,
          fillColor={0,0,255},
          pattern=LinePattern.None),
        Line(
          points={{-16,-6},{2,14},{40,10},{48,-8},{48,-20}},
          color={0,0,255},
          smooth=Smooth.Bezier,
          origin={-26,18},
          rotation=-90)}), Diagram(coordinateSystem(preserveAspectRatio=false,
          extent={{-100,-100},{100,100}}), graphics));
end Convection_Condensation;
