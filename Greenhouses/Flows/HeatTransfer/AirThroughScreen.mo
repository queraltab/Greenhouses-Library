within Greenhouses.Flows.HeatTransfer;
model AirThroughScreen "Heat exchange and air exchange rate through the screen"
  extends Modelica.Thermal.HeatTransfer.Interfaces.Element1D;

  /*********************** Parameters ***********************/
  parameter Modelica.Units.SI.Area A "floor surface";
  parameter Modelica.Units.SI.Length W "length of the screen when closed (SC=1)";
  parameter Real K "Screen flow coefficient (check values in Info)";

  /*********************** Varying inputs ***********************/
  Real SC=0 "Screen closure 1:closed, 0:open" annotation (Dialog(group="Varying inputs"));

  /*********************** Variables ***********************/
  Modelica.Units.SI.CoefficientOfHeatTransfer HEC_ab;
  Modelica.Units.SI.Density rho_air;
  Modelica.Units.SI.Density rho_mean;
  Modelica.Units.SI.Density rho_top;
  Modelica.Units.SI.SpecificHeatCapacity c_p_air=1005;
  Real f_AirTop;

equation
  // Air exchange rate
  rho_air = Modelica.Media.Air.ReferenceAir.Air_pT.density_pT(1e5,port_a.T);
  rho_top = Modelica.Media.Air.ReferenceAir.Air_pT.density_pT(1e5,port_b.T);
  rho_mean = (rho_air+rho_top)/2;

  f_AirTop = SC*K*max(1e-9,abs(dT))^0.66 + (1-SC)*(max(1e-9,0.5*rho_mean*W*(1-SC)*Modelica.Constants.g_n*max(1e-9,abs(rho_air - rho_top))))^0.5/rho_mean;

  // Heat exchange coefficient and heat exchange
  HEC_ab=rho_air*c_p_air*f_AirTop;
  Q_flow = A*HEC_ab*dT;

  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
            {100,100}}),
                   graphics={
        Text(
          extent={{-160,-64},{160,-100}},
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
          points={{-50,-60},{-50,60}},
          color={0,0,255},
          smooth=Smooth.Bezier,
          arrow={Arrow.None,Arrow.Filled}),
        Line(
          points={{0,-60},{0,60}},
          color={0,0,255},
          smooth=Smooth.Bezier,
          arrow={Arrow.Filled,Arrow.None}),
        Line(
          points={{50,-60},{50,60}},
          color={0,0,255},
          smooth=Smooth.Bezier,
          arrow={Arrow.None,Arrow.Filled})}), Documentation(info="<html>
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
