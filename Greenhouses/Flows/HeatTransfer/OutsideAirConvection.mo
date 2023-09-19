within Greenhouses.Flows.HeatTransfer;
model OutsideAirConvection
  "Cover heat exchange by convection with outside air function of wind speed"
  extends Modelica.Thermal.HeatTransfer.Interfaces.Element1D;

  /*********************** Parameters ***********************/
  parameter Modelica.Units.SI.Area A "floor surface";
  parameter Modelica.Units.SI.Angle phi
    "inclination of the surface (0 if horizontal, 25 for typical cover)";

  /*********************** Varying inputs ***********************/
  Modelica.Units.SI.Velocity u=0 "Wind speed"
    annotation (Dialog(group="Varying inputs"));

  /*********************** Variables ***********************/
  Modelica.Units.SI.CoefficientOfHeatTransfer HEC_ab;
  Real alpha;
  Real s=11
    "Slope of the differentiable switch function for vapour pressure differences";
  Real alpha_a;
  Real alpha_b;
  Real du;

equation
//    if u<4 then
//      alpha = 2.8 + 1.2*u;
//    else
//      alpha = 2.5*u^0.8;
//    end if;

  //The conditions here above are smoothed using a differentiable switch function, in order to avoid events during simulation
  du=4-u;
  alpha_a=1/(1+exp(-s*du))*(2.8 + 1.2*u) "Used for du>0, i.e. u<4";
  alpha_b=1/(1+exp(s*du))*2.5*u^0.8 "Used for du<0, i.e. u>4";
  alpha = alpha_a+alpha_b;

  //alpha=max(2.8,2.5*u^0.8) "Approximation to avoid many events during solution";

  HEC_ab = alpha/cos(phi);
  Q_flow = A*HEC_ab*dT;

  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}),
                         graphics={
        Line(
          points={{12,24},{2,34},{2,44},{-18,44},{-18,64},{-38,64},{-38,74},{-44,80}},
          color={0,0,255},
          smooth=Smooth.Bezier,
          arrow={Arrow.None,Arrow.Filled}),
        Line(
          points={{-76,58},{-66,48},{-66,38},{-46,38},{-46,18},{-26,18},{-26,8},{-20,
              2}},
          color={0,0,255},
          smooth=Smooth.Bezier,
          arrow={Arrow.None,Arrow.Filled}),
        Text(
          extent={{-180,-86},{180,-126}},
          textString="%name",
          lineColor={0,0,255}),
        Polygon(
          points={{-60,-60},{-40,-80},{100,60},{80,80},{-60,-60}},
          lineColor={0,0,0},
          smooth=Smooth.None,
          fillColor={192,192,192},
          fillPattern=FillPattern.Backward)}), Diagram(coordinateSystem(
          preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
        graphics),
    Documentation(info="<html>
    <p><big>The convection at the outer side of the greenhouse cover is modeled according 
    to the experimental work of [1], who characterised the heat exchange coefficient 
    at this saw-tooth surface as a function of the wind speed. The wind speed, being a boundary 
    condition, is an input of the model. The main parameter is the cover tilt.</p>
    <p>[1] G.P.A Bot. Greenhouse climate : from physical processes to a dynamic
model. PhD thesis, Wageningen University, 1983.</p>
</html>"));
end OutsideAirConvection;
