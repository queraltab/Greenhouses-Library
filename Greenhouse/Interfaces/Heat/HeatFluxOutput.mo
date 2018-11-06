within Greenhouses.Interfaces.Heat;
connector HeatFluxOutput = output Modelica.SIunits.HeatFlux
  "'output Heat Flux' as connector"                                                       annotation (
  defaultComponentName="I",
  Icon(
    coordinateSystem(preserveAspectRatio=true,
      extent={{-100.0,-100.0},{100.0,100.0}},
      initialScale=0.1),
      graphics={
    Polygon(
      lineColor={255,207,14},
      fillColor={255,255,255},
      fillPattern=FillPattern.Solid,
      points={{-100.0,100.0},{100.0,0.0},{-100.0,-100.0}})}),
  Diagram(
    coordinateSystem(preserveAspectRatio=true,
      extent={{-100.0,-100.0},{100.0,100.0}},
      initialScale=0.1),
      graphics={
    Polygon(
      lineColor={255,207,14},
      fillColor={255,255,255},
      fillPattern=FillPattern.Solid,
      points={{-100.0,50.0},{0.0,0.0},{-100.0,-50.0}}),
    Text(
      lineColor={0,0,127},
      extent={{30.0,60.0},{30.0,110.0}},
      textString="%name")}),
  Documentation(info="<html>
<p>
Connector with one output signal of type Real.
</p>
</html>"));
