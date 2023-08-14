within Greenhouses.Flows.HeatAndVapourTransfer.VentilationRates;
model NaturalVentilationRate_1
  "Air exchange rate from the greenhouse air to the outside air function of wind and temperature by De Jong (1990)"

  /*********************** Parameters ***********************/
  parameter Modelica.Units.SI.Angle phi=25/180*Modelica.Constants.pi
    "inclination of the roof (0 if horizontal, 25 for typical cover)";
  parameter Real fr_window=0.078 "number of windows per m2 greenhouse";
  parameter Modelica.Units.SI.Length l "length of the window";
  parameter Modelica.Units.SI.Length h "width of the window";
    parameter Boolean thermalScreen=false
    "presence of a thermal screen in the greenhouse";

  /*********************** Varying inputs ***********************/
  Modelica.Units.SI.Velocity u=0 "Wind speed"
    annotation (Dialog(group="Varying inputs"));
  Modelica.Units.SI.Angle theta_l=0 "window opening at the leeside side"
    annotation (Dialog(group="Varying inputs"));
  Modelica.Units.SI.Angle theta_w=0 "window opening at the windward side"
    annotation (Dialog(group="Varying inputs"));
  Modelica.Units.SI.TemperatureDifference dT=10
    annotation (Dialog(group="Varying inputs"));

  /*********************** Variables ***********************/
  Real f_vent;
  Real f_vent_wind;
  Real f_vent_temp;
  Real C_f
    "constant of discharge of energy caused by friction in the window opening";
  Real beta "thermal expansion coefficient";
  output Real f_vent_top
    "Air exchange rate at the top air compartment in presence of a thermal screen";
  output Real f_vent_air "Air exchange rate at the main air compartment";

equation
  // Temperature driven ventilation
  C_f = 0.6 "de Jong (1990)";
  beta = 1/283;
  f_vent_temp = C_f*l/3*(abs(Modelica.Constants.g_n*beta*dT))^0.5*(h*(sin(phi)-sin(phi-theta_l)))^1.5 + C_f*l/3*(abs(Modelica.Constants.g_n*beta*dT))^0.5*(h*(sin(phi)-sin(phi-theta_w)))^1.5;

  // Wind driven ventilation
  f_vent_wind = (2.29e-2*(1-exp(-theta_l/21.1)) + 1.2e-3*theta_w*exp(theta_w/211))*l*h*u;

  // Air exchange rate from greenhouse air to outside air
  f_vent = 0.5*fr_window*(f_vent_wind^2 + (f_vent_temp)^2)^0.5
    "Based on De Jong(1990)";

  if thermalScreen then
    f_vent_top=f_vent;
    f_vent_air=0;
  else
    f_vent_top=0;
    f_vent_air=f_vent;
  end if;

  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
            {100,100}}),
                   graphics={
        Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={175,175,175},
          fillColor={215,215,215},
          fillPattern=FillPattern.Sphere,
          radius=50),
        Text(
          extent={{-122,-40},{118,-98}},
          lineColor={0,0,0},
          textString="f_vent"),
        Line(
          points={{-90,-30}},
          color={191,0,0},
          smooth=Smooth.Bezier),
        Line(
          points={{0,84}},
          color={0,0,255},
          smooth=Smooth.None,
          arrow={Arrow.None,Arrow.Filled}),
        Polygon(
          points={{-60,-32},{60,-32},{60,48},{0,88},{-60,48},{-60,-32}},
          lineColor={0,0,0},
          smooth=Smooth.None,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-60,36},{60,36}},
          color={0,0,0},
          smooth=Smooth.None),
        Text(
          extent={{-24,60},{28,46}},
          lineColor={0,0,0},
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid,
          textString="top"),
        Text(
          extent={{-20,16},{24,2}},
          lineColor={0,0,0},
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid,
          textString="air"),
        Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={0,0,0},
          radius=50),
        Polygon(
          points={{-160,80},{-160,80}},
          lineColor={0,0,255},
          smooth=Smooth.None,
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{20,76},{44,60},{42,58},{18,74},{20,76}},
          lineColor={0,0,0},
          smooth=Smooth.None,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(
          points={{10,60},{16,72},{42,78}},
          color={0,0,0},
          smooth=Smooth.Bezier,
          arrow={Arrow.None,Arrow.Filled}),
        Line(
          points={{12,16},{26,50},{42,62},{64,68}},
          color={0,0,0},
          smooth=Smooth.Bezier,
          arrow={Arrow.None,Arrow.Filled}),
        Polygon(
          points={{-20,76},{-44,60},{-42,58},{-18,74},{-20,76}},
          lineColor={0,0,0},
          smooth=Smooth.None,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-8,60},{-14,72},{-42,80}},
          color={0,0,0},
          smooth=Smooth.Bezier,
          arrow={Arrow.None,Arrow.Filled}),
        Line(
          points={{-8,16},{-22,50},{-38,62},{-60,68}},
          color={0,0,0},
          smooth=Smooth.Bezier,
          arrow={Arrow.None,Arrow.Filled})}),
                                   Diagram(coordinateSystem(preserveAspectRatio=false,
                  extent={{-100,-100},{100,100}}), graphics),
    Documentation(info="<html>
<p>The natural ventilation rate due to roof ventilation is described by De Jong (1990):</p>
<p><img src=\"modelica://Greenhouse/Images/equations/equation-aKE9z08k.png\" alt=\"f_vent = 1/2*fr_window*sqrt(f_wind^2+f_temp^2)\"/> <img src=\"modelica://Greenhouse/Images/equations/equation-6K5EcVLa.png\" alt=\"[m^3*s^(-1)*m^(-2)]\"/></p>
<p>where</p>
<ul>
<li><img src=\"modelica://Greenhouse/Images/equations/equation-FQzCwHCL.png\" alt=\"fr_window\"/> (<img src=\"modelica://Greenhouse/Images/equations/equation-8QBlN9a3.png\" alt=\"m^(-2)\"/>) is the number of windows per square meter of greenhouse floor,</li>
<li><img src=\"modelica://Greenhouse/Images/equations/equation-uCs4trsV.png\" alt=\"f_wind\"/> (<img src=\"modelica://Greenhouse/Images/equations/equation-iriclMzy.png\" alt=\"m^3*s^(-1)*window^(-1)\"/>) is the wind driven ventilation,</li>
<li><img src=\"modelica://Greenhouse/Images/equations/equation-YLWJwXVI.png\" alt=\"f_temp\"/> (<img src=\"modelica://Greenhouse/Images/equations/equation-iriclMzy.png\" alt=\"m^3*s^(-1)*window^(-1)\"/>) is the temperature driven ventilation.</li>
</ul>
<p><br>The contribution of the temperature driven vetilation in the total ventilation is small but can be important during nighttime and in winter. It is described by:</p>
<p><img src=\"modelica://Greenhouse/Images/equations/equation-KgLoUH3j.png\" alt=\"f_temp = C_f*l/3*sqrt(abs(g*beta*Delta_T))*H^1.5\"/> <img src=\"modelica://Greenhouse/Images/equations/equation-Uu7SYX78.png\" alt=\"[m^3*s^(-1)*window^(-1)]\"/></p>
<p>where</p>
<ul>
<li><img src=\"modelica://Greenhouse/Images/equations/equation-E5GKpApS.png\" alt=\"C_f\"/> (-) is the discharge coefficient caused by friction in the window opening,</li>
<li><img src=\"modelica://Greenhouse/Images/equations/equation-Dw3J3OBh.png\" alt=\"l\"/> (<img src=\"modelica://Greenhouse/Images/equations/equation-SkYWBr2i.png\" alt=\"m\"/>) is the length of the window</li>
<li><img src=\"modelica://Greenhouse/Images/equations/equation-nKYJHYZG.png\"/> (<img src=\"modelica://Greenhouse/Images/equations/equation-Qb39i1BZ.png\"/>) is the gravitational acceleration,</li>
<li><img src=\"modelica://Greenhouse/Images/equations/equation-vACQNxvE.png\" alt=\"beta\"/> (<img src=\"modelica://Greenhouse/Images/equations/equation-kGMmc0lP.png\" alt=\"K^(-1)\"/>) is the thermal expansion coefficient,</li>
<li><img src=\"modelica://Greenhouse/Images/equations/equation-5SJtt8Hx.png\" alt=\"Delta_T\"/> (<img src=\"modelica://Greenhouse/Images/equations/equation-fKuUy3XB.png\" alt=\"K\"/>) is the temperature difference of the greenhouse air and outside air,</li>
<li><img src=\"modelica://Greenhouse/Images/equations/equation-Szlw8tWA.png\" alt=\"H\"/> (<img src=\"modelica://Greenhouse/Images/equations/equation-tgB0DkcM.png\" alt=\"m\"/>) is the height of the front opening of the window (<img src=\"modelica://Greenhouse/Images/equations/equation-aUFe1Eaw.png\" alt=\"H = h*(sin(psi) - sin(psi-theta))\"/> with <img src=\"modelica://Greenhouse/Images/equations/equation-RxlVPLRC.png\" alt=\"h\"/> the window width, <img src=\"modelica://Greenhouse/Images/equations/equation-aEiWqYrc.png\" alt=\"psi\"/> the roof slope and <img src=\"modelica://Greenhouse/Images/equations/equation-K6ifk7Jp.png\" alt=\"theta\"/> the opening angle of the window).</li>
</ul>
<p>The wind speed driven ventilation is computed differently for vents in the windward side and the leeside side. De Jong used &apos;Window Functions&apos; to relate the air exhange with the wind speed and the opening of a window. The air exchange is described by:</p>
<p><img src=\"modelica://Greenhouse/Images/equations/equation-hni52FxL.png\" alt=\"f_wind = (2.29e-2*(1-exp(-theta_l/21.1)) + 1.2e-3*theta_w*exp(theta_w/211))*A_0*u_wind\"/> <img src=\"modelica://Greenhouse/Images/equations/equation-Uu7SYX78.png\" alt=\"[m^3*s^(-1)*window^(-1)]\"/></p>
<p>where </p>
<ul>
<li><img src=\"modelica://Greenhouse/Images/equations/equation-jSZJvZAH.png\" alt=\"theta_l\"/> (<img src=\"modelica://Greenhouse/Images/equations/equation-HJWCUH2x.png\" alt=\"rad\"/>) is the opening angle of the leeside ventilators,</li>
<li><img src=\"modelica://Greenhouse/Images/equations/equation-HEQm1gVP.png\" alt=\"theta_w\"/> (<img src=\"modelica://Greenhouse/Images/equations/equation-X27wgSp5.png\" alt=\"rad\"/>) is the opening angle of the windward ventilators,</li>
<li><img src=\"modelica://Greenhouse/Images/equations/equation-L2K7pUSc.png\" alt=\"A_0\"/> (<img src=\"modelica://Greenhouse/Images/equations/equation-u8YOxRtR.png\" alt=\"m^2\"/>) is the surface of a window (<img src=\"modelica://Greenhouse/Images/equations/equation-kqhgVO0G.png\" alt=\"A_0 = l*h\"/>),</li>
<li><img src=\"modelica://Greenhouse/Images/equations/equation-sG3mNxEX.png\"/> (<img src=\"modelica://Greenhouse/Images/equations/equation-AsBQsj6u.png\"/>) is the wind speed.</li>
</ul>
</html>"));
end NaturalVentilationRate_1;
