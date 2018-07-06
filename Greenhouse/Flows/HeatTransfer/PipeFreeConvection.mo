within Greenhouse.Flows.HeatTransfer;
model PipeFreeConvection
  "Heating pipe heat exchange by free or hindered convection with air"
  extends Modelica.Thermal.HeatTransfer.Interfaces.Element1D;

  /*********************** Parameters ***********************/
  parameter Modelica.SIunits.Area A "floor surface";
  parameter Modelica.SIunits.Length d
    "characteristic dimension of the pipe (pipe diameter)";
  parameter Modelica.SIunits.Length l
    "length of heating pipes per m^2 floor surface";
  parameter Boolean freePipe=true
    "true if pipe in free air, false if hindered pipe";

  /*********************** Variables ***********************/
  Modelica.SIunits.CoefficientOfHeatTransfer HEC_ab;
  Real alpha;

equation
  if abs(dT)>0 then
    if freePipe then
      alpha = 1.28*d^(-0.25)*max(1e-9,abs(dT))^0.25;
    else
      alpha = 1.99*max(1e-9,abs(dT))^0.32;
    end if;
  else
    alpha=0;
  end if;
  HEC_ab = alpha*Modelica.Constants.pi*d*l;
  Q_flow = A*HEC_ab*dT;

  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
            {100,100}}), graphics={Ellipse(
          extent={{-80,40},{0,-40}},
          lineColor={0,0,0},
          fillColor={135,135,135},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-16,38},{-6,48},{-6,58},{14,58},{14,78},{34,78},{34,88},{40,94}},
          color={0,0,255},
          smooth=Smooth.Bezier,
          arrow={Arrow.None,Arrow.Filled}),
        Line(
          points={{2,0},{14,0},{24,10},{44,-10},{64,10},{76,-2},{76,-2},{86,-2}},
          color={0,0,255},
          smooth=Smooth.Bezier,
          arrow={Arrow.None,Arrow.Filled}),
        Line(
          points={{-10,-34},{0,-44},{0,-54},{20,-54},{20,-74},{40,-74},{40,-84},{46,
              -90}},
          color={0,0,255},
          smooth=Smooth.Bezier,
          arrow={Arrow.None,Arrow.Filled}),
        Text(
          extent={{-180,-84},{180,-120}},
          textString="%name",
          lineColor={0,0,255})}));
end PipeFreeConvection;
