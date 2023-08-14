within Greenhouses.Interfaces.Heat;
partial model Element1D_discretized
  "Partial heat transfer element with two HeatPort connectors that does not store energy"

  // Discretization
  parameter Integer nNodes(min=1)=2 "Number of discrete flow volumes";

  Modelica.Units.SI.HeatFlowRate Q_flow[nNodes] "Heat flow rate from port_a -> port_b";
  Modelica.Units.SI.TemperatureDifference dT[nNodes] "port_a.T - port_b.T";
  Greenhouses.Interfaces.Heat.HeatPorts_a[nNodes] heatPorts_a annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-100,0}), iconTransformation(
        extent={{-40,-10},{40,10}},
        rotation=90,
        origin={-90,0})));
  Modelica.Fluid.Interfaces.HeatPorts_b[nNodes] heatPorts_b annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={100,0}), iconTransformation(extent={{-40,-10},{40,10}},
        rotation=90,
        origin={90,0})));
equation
  dT = heatPorts_a.T - heatPorts_b.T;
  heatPorts_a.Q_flow = Q_flow;
  heatPorts_b.Q_flow = -Q_flow;
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
            {100,100}}), graphics),
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
        graphics));
end Element1D_discretized;
