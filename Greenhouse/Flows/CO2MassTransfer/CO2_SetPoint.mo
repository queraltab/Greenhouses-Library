within Greenhouse.Flows.CO2MassTransfer;
model CO2_SetPoint
  "The CO2 setpoint depends on the global radiation and the aperture of the ventilation openings"
  parameter Modelica.SIunits.HeatFlux I_g_max=500
    "Outdoor global radiation at which the maximum CO2 concentration set-point could be reached";
  parameter Real U_vents_max=0.1
    "Window aperture at which the minimum CO2 concentration set-point could be reached";
  parameter Real CO2_Air_ExtMax(unit="umol/mol")=850
    "Maximum CO2 concentration set-point";
  parameter Real CO2_Air_ExtMin(unit="umol/mol")=365
    "Minimum CO2 concentration set-point";

  Real U_vents=0 "Window aperture" annotation(Dialog(group="Varying inputs"));
  Modelica.SIunits.HeatFlux I_g=300 "Outdoor global radiation" annotation(Dialog(group="Varying inputs"));

  Real f_Ig;
  Real g_Uv;
  Real CO2_Air_ExtOn(unit="umol/mol");

  Modelica.Blocks.Interfaces.RealOutput y(unit="mg/m3")
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));
equation
  y=CO2_Air_ExtOn*1.94;
  CO2_Air_ExtOn = f_Ig*g_Uv*(CO2_Air_ExtMax-CO2_Air_ExtMin) + CO2_Air_ExtMin;
  f_Ig = min(1,I_g/I_g_max);
  g_Uv = 1/(1+exp(100*(U_vents-U_vents_max)))*(1-U_vents/U_vents_max);
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
            {100,100}}), graphics={
        Rectangle(
          extent={{-100,100},{100,-100}},
          fillColor={215,215,215},
          fillPattern=FillPattern.Backward,
          pattern=LinePattern.None,
          lineColor={0,0,0}),
        Line(
          points={{-86,76},{-26,76},{-26,-4},{34,-4},{34,76},{94,76}},
          color={0,0,0},
          smooth=Smooth.None),
        Line(
          points={{-86,76},{-86,-4},{-98,-4}},
          color={0,0,0},
          smooth=Smooth.None),
        Text(
          extent={{-116,-4},{84,-104}},
          lineColor={0,0,0},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          textString="CO2"),
        Text(
          extent={{52,70},{148,6}},
          lineColor={0,0,0},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          textString="SP")}));
end CO2_SetPoint;
