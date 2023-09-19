within Greenhouses.Components.Greenhouse.BasicComponents;
model Layer
  /******************** Parameters ********************/
  parameter Modelica.Units.SI.Density rho;
  parameter Modelica.Units.SI.SpecificHeatCapacity c_p;
  Modelica.Units.SI.Volume V=1 annotation (Dialog(group="Varying inputs"));
  parameter Modelica.Units.SI.Area A "floor surface";

  /******************** Initialization ********************/
  parameter Boolean steadystate=true
    "if true, sets the derivative of T to zero during Initialization"
    annotation (Dialog(group="Initialization options", tab="Initialization"));

  /******************** Variables ********************/
  Modelica.Units.SI.HeatFlowRate Q_flow "Heat flow rate from port_a -> port_b";
  Modelica.Units.SI.Temperature T;

  /******************** Connectors ********************/
protected
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature preTem
    "Port temperature"
    annotation (Placement(transformation(extent={{-44,10},{-64,30}})));
  Modelica.Blocks.Sources.RealExpression portT(y=T) "Port temperature"
    annotation (Placement(transformation(extent={{-16,10},{-36,30}})));
public
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPort
    "Heat port for sensible heat input"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}}),
        iconTransformation(extent={{-10,-10},{10,10}})));

equation
  // Balance on the layer
  heatPort.Q_flow = Q_flow;
  der(T) = 1/(rho*c_p*V)*(Q_flow);

  connect(portT.y,preTem. T)
    annotation (Line(points={{-37,20},{-42,20}}, color={0,0,127}));
  connect(preTem.port,heatPort)
    annotation (Line(points={{-64,20},{-68,20},{-68,0},{0,0}},
                                                           color={191,0,0}));

initial equation
   if steadystate then
     der(T)=0;
   end if;
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}),
                         graphics), Icon(coordinateSystem(preserveAspectRatio=false,
          extent={{-100,-100},{100,100}}), graphics={
        Rectangle(
          extent={{-20,80},{20,-80}},
          lineColor={0,0,0},
          fillColor={192,192,192},
          fillPattern=FillPattern.Backward,
          origin={0,0},
          rotation=90),                   Text(
          extent={{-110,-34},{110,-94}},
          lineColor={0,0,0},
          textString="%name")}),
    Documentation(info="<html>
    <p><big>This model computes the energy balance on a surface. The energy balance takes into account all the heat flows connected to the heat port. The properties of the surface are parameters of the model. </p>
</html>"));
end Layer;
