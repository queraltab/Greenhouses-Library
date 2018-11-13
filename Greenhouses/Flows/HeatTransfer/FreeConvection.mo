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
          rotation=360)}));
end FreeConvection;
