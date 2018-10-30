within Greenhouses.Flows.HeatAndVapourTransfer.VentilationRates;
model ForcedVentilationRate
  "Air exchange rate due to a forced ventilation system"

  /*********************** Parameters ***********************/
  parameter Modelica.SIunits.Area A "Greenhouse floor surface";
  parameter Modelica.SIunits.VolumeFlowRate phi_VentForced
    "Air flow capacity of the forced ventilation system";

  /*********************** Varying inputs ***********************/
  Real U_VentForced=0 "Control of the forced ventilation"  annotation (Dialog(group="Varying inputs"));

  /*********************** Variables ***********************/
  output Real f_ventForced "Air exchange rate at the main air compartment";

equation
  f_ventForced = U_VentForced*phi_VentForced/A;

  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
            {100,100}}),
                   graphics={
        Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={175,175,175},
          fillColor={215,215,215},
          fillPattern=FillPattern.Sphere,
          radius=50),
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
        Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={0,0,0},
          radius=50),
        Polygon(
          points={{-20,52},{-20,52}},
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
        Polygon(
          points={{-20,76},{-44,60},{-42,58},{-18,74},{-20,76}},
          lineColor={0,0,0},
          smooth=Smooth.None,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{0,24},{-6,44},{0,64},{6,44},{0,24}},
          lineColor={0,0,0},
          smooth=Smooth.Bezier,
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-4,50},{0,62},{4,50},{4,40},{0,24},{-4,40},{-4,50}},
          lineColor={0,0,0},
          smooth=Smooth.None,
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{0,24},{-28,-4},{-18,14},{0,24}},
          lineColor={0,0,0},
          smooth=Smooth.Bezier,
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{14,14},{-14,-14},{-4,4},{14,14}},
          lineColor={0,0,0},
          smooth=Smooth.Bezier,
          fillPattern=FillPattern.Solid,
          origin={-14,10},
          rotation=180),
        Polygon(
          points={{0,24},{-10,18},{-22,6},{-28,-4},{-18,2},{-6,14},{0,24}},
          lineColor={0,0,0},
          smooth=Smooth.None,
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{0,24},{28,-4},{18,14},{0,24}},
          lineColor={0,0,0},
          smooth=Smooth.Bezier,
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-14,14},{14,-14},{4,4},{-14,14}},
          lineColor={0,0,0},
          smooth=Smooth.Bezier,
          fillPattern=FillPattern.Solid,
          origin={14,10},
          rotation=180),
        Polygon(
          points={{0,24},{10,18},{22,6},{28,-4},{18,2},{6,14},{0,24}},
          lineColor={0,0,0},
          smooth=Smooth.None,
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-120,-40},{120,-98}},
          lineColor={0,0,0},
          textString="f_forced")}),Diagram(coordinateSystem(preserveAspectRatio=false,
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
end ForcedVentilationRate;
