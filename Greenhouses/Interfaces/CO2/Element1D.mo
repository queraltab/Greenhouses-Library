within Greenhouses.Interfaces.CO2;
partial model Element1D
  "Partial water mass transfer element with two WaterMassPort connectors that does not store energy"

  Real MC_flow(unit="mg/(m2.s)") "CO2 flow rate from port_a -> port_b";
  Real dC(unit="mg/m3") "port_a.CO2 - port_b.CO2";
public
  Greenhouses.Interfaces.CO2.CO2Port_a port_a annotation (Placement(
        transformation(extent={{-110,-10},{-90,10}}, rotation=0)));
  Greenhouses.Interfaces.CO2.CO2Port_b port_b annotation (Placement(
        transformation(extent={{90,-10},{110,10}}, rotation=0)));
equation
  dC = port_a.CO2 - port_b.CO2;
  port_a.MC_flow = MC_flow;
  port_b.MC_flow = -MC_flow;
  annotation (Documentation(info="<HTML>
<p>
This partial model contains the basic connectors and variables to
allow heat transfer models to be created that <b>do not store energy</b>,
This model defines and includes equations for the temperature
drop across the element, <b>dT</b>, and the heat flow rate
through the element from port_a to port_b, <b>Q_flow</b>.
</p>
<p>
By extending this model, it is possible to write simple
constitutive equations for many types of heat transfer components.
</p>
</html>"), Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
            {100,100}}), graphics));
end Element1D;
