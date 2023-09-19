within Greenhouses.Interfaces.HeatAndVapour;
partial model Element1D
  "Partial water mass transfer element with two WaterMassPort connectors that does not store energy"

  Modelica.Units.SI.HeatFlowRate Q_flow "Heat flow rate from port_a -> port_b";
  Modelica.Units.SI.TemperatureDifference dT "port_a.T - port_b.T";

  Modelica.Units.SI.MassFlowRate MV_flow "Mass flow rate from port_a -> port_b";
  Modelica.Units.SI.PressureDifference dP "port_a.VP - port_b.VP";
public
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a HeatPort_a annotation (Placement(transformation(extent={{-110,10},
            {-90,30}}, rotation=0)));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b HeatPort_b annotation (Placement(transformation(extent={{90,10},
            {110,30}},rotation=0)));
  Greenhouses.Interfaces.Vapour.WaterMassPort_a MassPort_a annotation (
      Placement(transformation(extent={{-110,-30},{-90,-10}}, rotation=0)));
  Greenhouses.Interfaces.Vapour.WaterMassPort_b MassPort_b annotation (
      Placement(transformation(extent={{90,-30},{110,-10}}, rotation=0)));
equation
  dP = MassPort_a.VP - MassPort_b.VP;
  MassPort_a.MV_flow = MV_flow;
  MassPort_b.MV_flow = -MV_flow;

  dT = HeatPort_a.T - HeatPort_b.T;
  HeatPort_a.Q_flow = Q_flow;
  HeatPort_b.Q_flow = -Q_flow;

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
