within Greenhouses.Flows.HeatTransfer;
model FreeConvection "Upward or downward heat exchange by free convection from an horizontal or inclined 
  surface. If studying heat exchange of Air-Floor: connect the filled port to the floor 
  and the unfilled port to the air."
  extends Modelica.Thermal.HeatTransfer.Interfaces.Element1D;

  /*********************** Parameters ***********************/
  parameter Modelica.SIunits.Angle phi
    "inclination of the surface (0 if horizontal, 25 for typical cover)";
  parameter Modelica.SIunits.Area A "floor surface";
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
  Modelica.SIunits.CoefficientOfHeatTransfer HEC_ab;
  Real s=11
    "Slope of the differentiable switch function for vapour pressure differences";
  Modelica.SIunits.CoefficientOfHeatTransfer HEC_up_flr;
  Modelica.SIunits.CoefficientOfHeatTransfer HEC_down_flr;

equation
  if not floor then
    if thermalScreen then
      if Air_Cov then
        if not topAir then
          //Exchange main air-cover (with screen)
          HEC_ab=0;
        else
          //Exchange top air-cover
          HEC_ab=1.7*max(1e-9,abs(dT))^0.33*(cos(phi))^(-0.66);
        end if;
      else
        //Exchange air-screen
        HEC_ab=SC*1.7*max(1e-9,abs(dT))^0.33;
      end if;
    else
      //Exchange main air-cover (no screen)
      HEC_ab = 1.7*max(1e-9,abs(dT))^0.33*(cos(phi))^(-0.66);
    end if;
    HEC_up_flr=0;
    HEC_down_flr=0;
  else
//     if port_a.T>port_b.T then
//       HEC_ab = 1.7*max(1e-9,abs(dT))^0.33;
//     else
//       HEC_ab = 1.3*max(1e-9,abs(dT))^0.25;
//     end if;
// The conditions here above are smoothed using a differentiable switch function, in order to avoid events during simulation
     HEC_up_flr=1/(1+exp(-s*dT))*1.7*abs(dT)^0.33 "Used for dT>0";
     HEC_down_flr=1/(1+exp(s*dT))*1.3*abs(dT)^0.25 "Used for dT<0";
     HEC_ab = HEC_up_flr+HEC_down_flr;
  end if;

  Q_flow = A*HEC_ab*dT;

  annotation (Icon(graphics={
        Rectangle(
          extent={{-10,80},{10,-80}},
          lineColor={0,0,0},
          fillColor={192,192,192},
          fillPattern=FillPattern.Backward,
          origin={0,-50},
          rotation=-90),
        Line(
          points={{-40,-6.90379e-015},{-10,18},{40,10},{50,-20},{50,-28}},
          color={0,0,255},
          smooth=Smooth.Bezier,
          origin={28,20},
          rotation=-90),
        Line(
          points={{-40,-6},{2,-24},{40,-10},{50,20},{50,28}},
          color={0,0,255},
          smooth=Smooth.Bezier,
          arrow={Arrow.Filled,Arrow.None},
          origin={-28,20},
          rotation=-90),
        Text(
          extent={{-180,20},{180,-20}},
          textString="%name",
          lineColor={0,0,255},
          origin={0,-104},
          rotation=360)}), Documentation(info="<html>
<p><big>The upward or downward heat exchange by free convection from an horizontal or 
inclined surface is modeled. In free convection, the Nusselt (Nu) number describing 
the exchange process can be defined as a function of the Rayleigh (Ra) number [1]. 
The heat exchange coefficients are therefore modeled based on the Nu-Ra relation. 
The model can be used for convection at the cover (upward flow, inclined surface), 
the floor (upward/downward flow, horizontal surface) or the screen (upward flow, 
horizontal surface). The bi-direction nature of the convective flow on the floor 
is due to the latter can be warmer or colder than the air above it. The different 
natures of the flows lead to different Nu-Ra relations for each surface. Therefore, 
the user should indicate (by means of the Boolean parameters) which surface is 
being modeled. 
</p>
<p><big>
Depending on the status of the thermal screen, the heat flow to the 
cover can originate either from the top or the main air zone, and the heat flow to 
the screen can have a different magnitude. Therefore, when the model is used for 
the cover or the screen, the screen closure (control variable in the global system)
is a required input.</p>
<p>[1] Luc Balemans. Assessment of criteria for energetic effectiveness of
greenhouse screens. PhD thesis, Agricultural University, Ghent,
1989.</p>
</html>"));
end FreeConvection;
