within Greenhouses.Flows.HeatAndVapourTransfer.VentilationRates;
model NaturalVentilationRate_2
  "Air exchange rate from the greenhouse air to the outside air function of wind and temperature by Boulard and Baille (1995)"

  /*********************** Parameters ***********************/
  parameter Boolean thermalScreen=false
    "Presence of a thermal screen in the greenhouse";
  parameter Real C_d=0.75
    "Ventilation discharge coefficient, function of greenhouse shape";
  parameter Real C_w=0.09
    "Ventilation global wind pressure coefficient, function of greenhouse shape";
  parameter Real eta_RfFlr=0.1
    "Ratio between the maximum roof vent area and the greenhouse floor area A_roof/A_floor";
  parameter Modelica.SIunits.Length h_vent=0.68
    "Vertical dimension of a single ventilation opening";
  parameter Real c_leakage=1.5e-4 "Greenhouse leakage coefficient";

  /*********************** Varying inputs ***********************/
  Real SC=0 "Screen closure 1:closed, 0:open" annotation (Dialog(enable=(thermalScreen and not floor), group="Varying inputs"));
  Real U_roof(min=0,max=1)=0 "Control of the aperture of the roof vents"  annotation (Dialog(group="Varying inputs"));
  Modelica.SIunits.Velocity u= 0 "Wind speed"     annotation (Dialog(group="Varying inputs"));
  Modelica.SIunits.TemperatureDifference dT=10 "T_a-T_b" annotation (Dialog(group="Varying inputs"));
  Modelica.SIunits.Temperature T_a=293.15 annotation (Dialog(group="Varying inputs"));
  Modelica.SIunits.Temperature T_b=276.15 annotation (Dialog(group="Varying inputs"));

  /*********************** Variables ***********************/
  Real f_vent;
  Real f_leakage "Air exchange rate due to leakage";
  Modelica.SIunits.Temperature T_mean;
  output Real f_vent_top
    "Air exchange rate at the top air compartment in presence of a thermal screen";
  output Real f_vent_air "Air exchange rate at the main air compartment";

equation
  T_mean = (T_a+T_b)/2;
  // Roof ventilation
  f_vent = U_roof*eta_RfFlr*C_d/2*abs(Modelica.Constants.g_n*h_vent/2*abs(dT)/T_mean + C_w*u^2)^0.5;

  // Leakage rate
  f_leakage = max(0.25,u)*c_leakage;

  if thermalScreen then
    f_vent_top=SC*f_vent+0.5*f_leakage "Changed 17/4/18. Added SC";
    f_vent_air=(1-SC)*f_vent+0.5*f_leakage
      "Changed 17/4/18. Added (1-SC)*f_vent";
  else
    f_vent_top=0;
    f_vent_air=f_vent+f_leakage;
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
<p>The natural ventilation rate due to roof ventilation is described by Boulard and Baille (1995):</p>
<p><img src=\"modelica://Greenhouse/Images/equations/equation-rir3RVCo.png\" alt=\"f_vent = U_Roof*A_Roof*C_d/(2*A_Flr)*sqrt(g*h_vent/2 * (T_Air-T_Out)/(T_mean+273.15)+C_w*u_wind^2)\"/>     <img src=\"modelica://Greenhouse/Images/equations/equation-6K5EcVLa.png\"/></p>
<p>where </p>
<ul>
<li><img src=\"modelica://Greenhouse/Images/equations/equation-zPdExBEt.png\" alt=\"U_Roof\"/> (-) is the control of the aperture of the roof vents,</li>
<li><img src=\"modelica://Greenhouse/Images/equations/equation-tKDVOv8F.png\" alt=\"A_Roof\"/> (<img src=\"modelica://Greenhouse/Images/equations/equation-2AopL9t6.png\" alt=\"m^2\"/>) is the maximum roof ventilation area,</li>
<li><img src=\"modelica://Greenhouse/Images/equations/equation-kfX7lSeV.png\" alt=\"A_Flr\"/> (<img src=\"modelica://Greenhouse/Images/equations/equation-2AopL9t6.png\" alt=\"m^2\"/>) is the greenhouse floor area,</li>
<li><img src=\"modelica://Greenhouse/Images/equations/equation-Q54vaOWD.png\" alt=\"C_d\"/> (-) is the discharge coefficient which depends on the greenhouse shape and on the use of an outdoor thermal screen,</li>
<li><img src=\"modelica://Greenhouse/Images/equations/equation-nKYJHYZG.png\" alt=\"g\"/> (<img src=\"modelica://Greenhouse/Images/equations/equation-Qb39i1BZ.png\" alt=\"m*s^(-2)\"/>) is the gravitational acceleration,</li>
<li><img src=\"modelica://Greenhouse/Images/equations/equation-ZnYZgLFo.png\" alt=\"h_vent\"/> (<img src=\"modelica://Greenhouse/Images/equations/equation-SiE04HIG.png\" alt=\"m\"/>) is the vertical dimension of a single ventilation opening,</li>
<li><img src=\"modelica://Greenhouse/Images/equations/equation-8jBgOszZ.png\" alt=\"T_mean\"/> (<img src=\"modelica://Greenhouse/Images/equations/equation-UgZEqmEh.png\" alt=\"degC\"/>) is the mean temperature of the greenhouse air and outside air,</li>
<li><img src=\"modelica://Greenhouse/Images/equations/equation-RAkAjgmU.png\" alt=\"C_w\"/> (-) is the global wind pressure coefficient which depends on the greenhouse shape and on the use of an outdoor thermal screen,</li>
<li><img src=\"modelica://Greenhouse/Images/equations/equation-sG3mNxEX.png\" alt=\"u_wind\"/> (<img src=\"modelica://Greenhouse/Images/equations/equation-AsBQsj6u.png\" alt=\"m*s^(-1)\"/>) is the wind speed.</li>
</ul>
<p>Since it is considered that the greenhouse does not have side vents, the whole ventilation rate is through the roof vents.</p>
<p>The discharge coefficients <img src=\"modelica://Greenhouse/Images/equations/equation-nkZgtttD.png\" alt=\"C_w\"/> and <img src=\"modelica://Greenhouse/Images/equations/equation-k9DjDLQw.png\" alt=\"C_d\"/> depend on the use of an external shading screen. However, it is considered that in the studied greenhouse there is no external shading screen.</p>
</html>"));
end NaturalVentilationRate_2;
