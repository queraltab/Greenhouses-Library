within Greenhouses.Flows.Interfaces.Vapour;
partial model Element1D
  "Partial water mass transfer element with two WaterMassPort connectors that does not store energy"

  Modelica.SIunits.MassFlowRate MV_flow "Mass flow rate from port_a -> port_b";
  Modelica.SIunits.PressureDifference dP "port_a.VP - port_b.VP";
public
  Greenhouses.Flows.Interfaces.Vapour.WaterMassPort_a port_a annotation (
      Placement(transformation(extent={{-110,-10},{-90,10}}, rotation=0)));
  Greenhouses.Flows.Interfaces.Vapour.WaterMassPort_b port_b annotation (
      Placement(transformation(extent={{90,-10},{110,10}}, rotation=0)));
equation
  dP = port_a.VP - port_b.VP;
  port_a.MV_flow = MV_flow;
  port_b.MV_flow = -MV_flow;
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
