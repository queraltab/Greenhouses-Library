within Greenhouses.Flows.HeatAndVapourTransfer;
model AirThroughScreen
  "Heat and mass flux exchange and air exchange rate through the screen"
  extends Greenhouses.Flows.Interfaces.HeatAndVapour.Element1D;

  /*********************** Parameters ***********************/
  parameter Modelica.SIunits.Area A "floor surface";
  parameter Modelica.SIunits.Length W "length of the screen when closed (SC=1)";
  parameter Real K "Screen flow coefficient (check values in Info)";

  /*********************** Varying inputs ***********************/
  Real SC=0 "Screen closure 1:closed, 0:open" annotation (Dialog(group="Varying inputs"));

  /*********************** Variables ***********************/
  Modelica.SIunits.CoefficientOfHeatTransfer HEC_ab;
  Modelica.SIunits.Density rho_air;
  Modelica.SIunits.Density rho_mean;
  Modelica.SIunits.Density rho_top;
  Modelica.SIunits.SpecificHeatCapacity c_p_air=1005;
  Real f_AirTop;
  Real R=8314 "gas constant";
  Modelica.SIunits.MolarMass M_H = 18;
  Real VEC_AirTop(unit="kg/(s.Pa.m2)") "Mass transfer coefficient";
  Real MV_flow2;

equation
  // Air exchange rate
  // rho_air = Modelica.Media.Interfaces.PartialPureSubstance.density_pT(1e5, HeatPort_a.T);
  // rho_top = Modelica.Media.Interfaces.PartialPureSubstance.density_pT(1e5, HeatPort_b.T);
  rho_air = Modelica.Media.Air.ReferenceAir.Air_pT.density_pT(1e5,HeatPort_a.T);
  rho_top = Modelica.Media.Air.ReferenceAir.Air_pT.density_pT(1e5,HeatPort_b.T);
  rho_mean = (rho_air+rho_top)/2;

  f_AirTop = SC*K*max(1e-9,abs(dT))^0.66 + (1-SC)*(max(1e-9,0.5*rho_mean*W*(1-SC)*Modelica.Constants.g_n*max(1e-9,abs(rho_air - rho_top))))^0.5/rho_mean;

  // Heat exchange coefficient and heat exchange
  HEC_ab=rho_air*c_p_air*f_AirTop;
  Q_flow = A*HEC_ab*dT;

  // Mass exchange coefficient VEC and mass exchange MV
  VEC_AirTop = M_H*f_AirTop/R/287;
  MV_flow2 = A*M_H/R*f_AirTop*(MassPort_a.VP/HeatPort_a.T - MassPort_b.VP/HeatPort_b.T);
  MV_flow = A*VEC_AirTop*dP;

  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
            {100,100}}),
                   graphics={
        Text(
          extent={{-180,-64},{180,-100}},
          lineColor={0,0,255},
          textString="%name"),
        Line(
          points={{-90,-30}},
          color={191,0,0},
          smooth=Smooth.Bezier),
        Line(
          points={{-90,0},{-80,0},{-70,-10},{-50,10},{-30,-10},{-10,10},{10,
              -10},{30,10},{50,-10},{70,10},{80,0},{90,0}},
          color={0,0,0},
          smooth=Smooth.Bezier),
        Line(
          points={{-70,-60},{-70,60}},
          color={0,0,255},
          smooth=Smooth.Bezier,
          arrow={Arrow.None,Arrow.Filled}),
        Line(
          points={{-14,-60},{-14,60}},
          color={0,0,255},
          smooth=Smooth.Bezier,
          arrow={Arrow.Filled,Arrow.None}),
        Line(
          points={{40,-60},{40,60}},
          color={0,0,255},
          smooth=Smooth.Bezier,
          arrow={Arrow.None,Arrow.Filled}),
        Polygon(
          points={{-46,66},{-56,28},{-56,22},{-56,16},{-50,10},{-42,8},{-36,10},
              {-32,18},{-32,22},{-32,28},{-44,58},{-46,66}},
          smooth=Smooth.Bezier,
          fillPattern=FillPattern.Solid,
          fillColor={0,0,255},
          pattern=LinePattern.None),
        Polygon(
          points={{62,56},{52,18},{52,12},{52,6},{58,0},{66,-2},{72,0},{76,8},{76,
              12},{76,18},{64,48},{62,56}},
          smooth=Smooth.Bezier,
          fillPattern=FillPattern.Solid,
          fillColor={0,0,255},
          pattern=LinePattern.None),
        Polygon(
          points={{10,12},{0,-26},{0,-32},{0,-38},{6,-44},{14,-46},{20,-44},{24,
              -36},{24,-32},{24,-26},{12,4},{10,12}},
          smooth=Smooth.Bezier,
          fillPattern=FillPattern.Solid,
          fillColor={0,0,255},
          pattern=LinePattern.None)}),        Documentation(info="<html>
<p>The direct heat exchange between the air compartment below and above the screen is due to the exchange of air between the two compartments. The exchange rate is expressed as a volume flux per m 2 floor surface (m 3 m&QUOT; 2 s&QUOT;&apos;). The air exchange is based on two mechanisms. In the first place, air is transported through the openings in the fabric. In the second place, when the screen is opened a crack for dehumidification, air is exchanged through a relatively large opening. In both cases the air exchange is induced by pressure or density differences. Pressure differences originate from wind speed fluctuations inducing pressure fluctuations in the top compartment through opened windows or leakage. A density difference originates from a temperature difference across the screen.</p>
<p>Temperature-driven air exchange through fully closed screens is intensively studied by Balemans (1989). He measured the air exchange rate through the screen for 12 different types of fabrics as a function of the temperature difference across the material. Subsequently he fitted a function through the data:</p>
<p><img src=\"modelica://Greenhouse/Images/equations/equation-V67vcHV5.png\" alt=\"f_screen = K *dT^0.66\"/></p>
<p>where f screen is the air flux through the screen (m3.m-2.s-1), K the &apos;screen flow coefficient&apos; (m3.m-2.s-1.K-0.66) and AT the temperature difference across the screen (K). The following table lists some of his results extracted from (Balemans, 1989).</p>
<pre><b>Material type         Trade name                 K (m3.m-2.s-1.K-0.66)</b>
Knitted polyester         TD 55                 0.480e-3
Knitted polyester        TD 85                0.372e-3
Woven polyester        Verzuu GPA bandjes        0.203e-3
Film strip fabrics        LS11                0.161e-3
Non-woven                Tyvec gold standard        0.243e-3</pre>
</html>"),
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
            100}}), graphics));
end AirThroughScreen;
