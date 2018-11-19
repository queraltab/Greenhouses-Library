within Greenhouses.Flows.HeatTransfer;
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
          lineColor={0,0,255})}), Documentation(info="<html>
<p><big>The magnitude of convective heat from the heating pipes to the air depends 
on the pipe position, which implies a free exchange (i.e. pipes in free air) or 
a hindered exchange (i.e. pipes situated close to the canopy and near the floor). 
In free convection, the Nusselt (Nu) number describing the exchange process can be 
defined as a function of the Rayleigh (Ra) number [1]. Therefore, the free exchange 
is modeled based on the Nu-Ra relation. The hindered exchange, 
considered to be forced, is modeled by experimental correlations derived by [2]. 
The user should indicate which exchange is modeled by means of the Boolean parameter 'freePipe'. 
The diameter of the pipes and the installed pipe length per ground area are also parameters, 
required to compute the heat exchange coefficient.</p>
<p>[1] Luc Balemans. Assessment of criteria for energetic effectiveness of
greenhouse screens. PhD thesis, Agricultural University, Ghent,
1989.</p>
<p>[2] G.P.A Bot. Greenhouse climate : from physical processes to a dynamic
model. PhD thesis, Wageningen University, 1983.</p>
</html>"));
end PipeFreeConvection;
