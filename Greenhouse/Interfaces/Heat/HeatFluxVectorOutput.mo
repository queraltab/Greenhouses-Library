within Greenhouses.Interfaces.Heat;
connector HeatFluxVectorOutput =output Modelica.SIunits.HeatFlux
  "Heat Flux output connector used for vector of connectors"
                                                            annotation (
  defaultComponentName="u",
  Icon(graphics={Ellipse(
        extent={{-100,100},{100,-100}},
        lineColor={255,207,14},
        fillColor={255,255,255},
        fillPattern=FillPattern.Solid)}, coordinateSystem(
      extent={{-100,-100},{100,100}},
      preserveAspectRatio=true,
      initialScale=0.2)),
  Diagram(coordinateSystem(
      preserveAspectRatio=false,
      initialScale=0.2,
      extent={{-100,-100},{100,100}}), graphics={Text(
        extent={{-10,85},{-10,60}},
        lineColor={0,0,127},
        textString="%name"), Ellipse(
        extent={{-50,50},{50,-50}},
        lineColor={255,207,14},
        fillColor={255,255,255},
        fillPattern=FillPattern.Solid)}),
  Documentation(info="<html>
<p>
Real input connector that is used for a vector of connectors,
for example <a href=\"modelica://Modelica.Blocks.Interfaces.PartialRealMISO\">PartialRealMISO</a>,
and has therefore a different icon as RealInput connector.
</p>
</html>"));
