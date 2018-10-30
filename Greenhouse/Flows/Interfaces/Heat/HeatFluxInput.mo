within Greenhouses.Flows.Interfaces.Heat;
connector HeatFluxInput =
                      input Modelica.SIunits.HeatFlux
  "'input Heat Flux' as connector"                                                annotation (
  defaultComponentName="I",
  Icon(graphics={
    Polygon(
      lineColor={255,207,14},
      fillColor={255,207,14},
      fillPattern=FillPattern.Solid,
      points={{-100.0,100.0},{100.0,0.0},{-100.0,-100.0}})},
    coordinateSystem(extent={{-100.0,-100.0},{100.0,100.0}},
      preserveAspectRatio=true,
      initialScale=0.2)),
  Diagram(
    coordinateSystem(preserveAspectRatio=true,
      initialScale=0.2,
      extent={{-100.0,-100.0},{100.0,100.0}}),
      graphics={
    Polygon(
      lineColor={255,207,14},
      fillColor={255,207,14},
      fillPattern=FillPattern.Solid,
      points={{0.0,50.0},{100.0,0.0},{0.0,-50.0},{0.0,50.0}}),
    Text(
      lineColor={0,0,127},
      extent={{-10.0,60.0},{-10.0,85.0}},
      textString="%name")}),
  Documentation(info="<html>
<p>
Connector with one input signal of type Real.
</p>
</html>"));
