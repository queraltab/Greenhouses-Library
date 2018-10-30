within Greenhouses.Flows.Sources.CO2;
model FixedCO2Flow "Fixed CO2 flow boundary condition"
  parameter Real MC_flow(unit="mg/(m2.s)") "Fixed heat flow rate at port";

  Greenhouses.Flows.Interfaces.CO2.CO2Port_b port annotation (Placement(
        transformation(extent={{90,-10},{110,10}}, rotation=0)));
equation
  port.MC_flow = -MC_flow;
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
            100,100}}), graphics={
        Text(
          extent={{-150,100},{150,60}},
          lineColor={0,0,0},
          textString="%name"),
        Text(
          extent={{-150,-55},{150,-85}},
          lineColor={0,0,0},
          textString="MC_flow=%MC_flow"),
        Line(
          points={{-100,-20},{48,-20}},
          color={95,95,95},
          thickness=0.5),
        Line(
          points={{-100,20},{46,20}},
          color={95,95,95},
          thickness=0.5),
        Polygon(
          points={{40,0},{40,40},{70,20},{40,0}},
          lineColor={95,95,95},
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{40,-40},{40,0},{70,-20},{40,-40}},
          lineColor={95,95,95},
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{70,40},{90,-40}},
          lineColor={95,95,95},
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid)}),
    Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
            {100,100}}), graphics={
        Text(
          extent={{-100,40},{0,-36}},
          lineColor={0,0,0},
          textString="MC_flow=const."),
        Line(
          points={{-48,-20},{60,-20}},
          color={95,95,95},
          thickness=0.5),
        Line(
          points={{-48,20},{60,20}},
          color={95,95,95},
          thickness=0.5),
        Polygon(
          points={{60,0},{60,40},{90,20},{60,0}},
          lineColor={95,95,95},
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{60,-40},{60,0},{90,-20},{60,-40}},
          lineColor={95,95,95},
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid)}),
    Documentation(info="<HTML>
<p>
This model allows a specified amount of heat flow rate to be \"injected\"
into a thermal system at a given port.  The constant amount of heat
flow rate Q_flow is given as a parameter. The heat flows into the
component to which the component FixedHeatFlow is connected,
if parameter Q_flow is positive.
</p>
<p>
If parameter alpha is &lt;&gt; 0, the heat flow is multiplied by (1 + alpha*(port.T - T_ref))
in order to simulate temperature dependent losses (which are given with respect to reference temperature T_ref).
</p>
</html>"));
end FixedCO2Flow;
