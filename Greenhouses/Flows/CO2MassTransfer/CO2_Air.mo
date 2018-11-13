within Greenhouses.Flows.CO2MassTransfer;
model CO2_Air "CO2 mass balance of an air volume"
  import Greenhouse = Greenhouses;

  /*********************** Parameters ***********************/
  Modelica.SIunits.Length cap_CO2=4
    "Capacity of the air to store CO2, equals the height of the air compartment"
                                                                                 annotation(Dialog(group="Varying inputs"));

  /*********************** Initialization ***********************/
  parameter Real CO2_start(unit="mg/m3")=1940 annotation(Dialog(tab = "Initialization"));
  parameter Boolean steadystate=true
    "if true, sets the derivative of VP to zero during Initialization"     annotation (Dialog(group="Initialization options", tab="Initialization"));

  /*********************** Variables ***********************/
  Real MC_flow(unit="mg/(m2.s)");
  Real CO2(unit="mg/m3",start=CO2_start,min=0);
  Real CO2_ppm;

  /******************** Connectors ********************/
  Greenhouse.Interfaces.CO2.CO2Port_a port(CO2(start=CO2_start))
    "Partial CO2 pressure" annotation (Placement(transformation(extent={{60,40},
            {80,60}}), iconTransformation(extent={{-10,-10},{10,10}})));

  Greenhouse.Flows.Sources.CO2.PrescribedConcentration prescribedPressure
    annotation (Placement(transformation(extent={{-50,6},{-30,26}})));
protected
  Modelica.Blocks.Sources.RealExpression portCO2(y=CO2) "Port temperature"
    annotation (Placement(transformation(extent={{-86,6},{-66,26}})));
equation
  port.MC_flow = MC_flow;
  der(CO2) = 1/cap_CO2 * MC_flow;
  CO2_ppm = CO2/1.94
    "1ppm=1.94mgCO2/m3air from 22.71108 l/mol and molar mass of CO2 44.01 g/mol";

  connect(prescribedPressure.port, port) annotation (Line(
      points={{-30,16},{-18,16},{-18,50},{70,50}},
      color={95,95,95},
      smooth=Smooth.None));
  connect(portCO2.y, prescribedPressure.CO2) annotation (Line(
      points={{-65,16},{-52,16}},
      color={0,0,127},
      smooth=Smooth.None));
initial equation
  if steadystate then
    der(CO2)=0;
  end if;
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics), Icon(coordinateSystem(
          preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics={
                               Ellipse(
          extent={{10,40},{90,-40}},
          lineColor={191,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Sphere),
                               Ellipse(
          extent={{-90,40},{-10,-40}},
          lineColor={191,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Sphere),
                               Ellipse(
          extent={{-60,60},{60,-60}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Sphere), Text(
          extent={{-160,-64},{160,-98}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={170,213,255},
          fillPattern=FillPattern.Solid,
          textString="%name")}));
end CO2_Air;
