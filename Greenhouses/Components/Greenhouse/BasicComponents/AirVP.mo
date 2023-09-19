within Greenhouses.Components.Greenhouse.BasicComponents;
model AirVP
  "Greenhouse air vapour pressure by numerical integration of the differential equation of the moisture content"
  import Greenhouse = Greenhouses;

  /*********************** Parameters ***********************/
  Modelica.Units.SI.Volume V_air=1e3 annotation (Dialog(group="Varying inputs"));

  /*********************** Initialization ***********************/
  parameter Modelica.Units.SI.Pressure VP_start=0.04e5
    annotation (Dialog(tab="Initialization"));
  parameter Boolean steadystate=true
    "if true, sets the derivative of VP to zero during Initialization"     annotation (Dialog(group="Initialization options", tab="Initialization"));

  /*********************** Variables ***********************/
  Real R(unit="J/(kmol.K)")=8314 "gas constant";
  Modelica.Units.SI.Temperature T=291;
  Modelica.Units.SI.MolarMass M_H=18e-3
    "kg/mol masse molaire du vapeur d'eau dans l'air";
  Modelica.Units.SI.MassFlowRate MV_flow;
  Modelica.Units.SI.Pressure VP(start=VP_start);

  /******************** Connectors ********************/
  Greenhouse.Interfaces.Vapour.WaterMassPort_a port(VP(start=VP_start))
    "Saturation pressure" annotation (Placement(transformation(extent={{60,40},
            {80,60}}), iconTransformation(extent={{-10,-10},{10,10}})));

  Greenhouse.Flows.Sources.Vapour.PrescribedPressure prescribedPressure
    annotation (Placement(transformation(extent={{-50,6},{-30,26}})));
protected
  Modelica.Blocks.Sources.RealExpression portVP(y=VP) "Port temperature"
    annotation (Placement(transformation(extent={{-86,6},{-66,26}})));
equation
  port.MV_flow = MV_flow;
  der(VP) = 1/(M_H*1e3*V_air/(R*T))*(MV_flow);
  connect(prescribedPressure.port, port) annotation (Line(
      points={{-30,16},{-18,16},{-18,50},{70,50}},
      color={170,213,255},
      smooth=Smooth.None));
  connect(portVP.y, prescribedPressure.VP) annotation (Line(
      points={{-65,16},{-52,16}},
      color={0,0,127},
      smooth=Smooth.None));
initial equation
  if steadystate then
    der(VP)=0;
  end if;
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics), Icon(coordinateSystem(
          preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics={
                               Ellipse(
          extent={{-60,60},{60,-60}},
          lineColor={0,0,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Sphere), Text(
          extent={{-74,98},{74,62}},
          lineColor={170,213,255},
          lineThickness=0.5,
          fillColor={170,213,255},
          fillPattern=FillPattern.Solid,
          textString="%name")}),
    Documentation(info="<html>
    <p>This model applies the mass balance on the moisture content of the air. The water vapour pressure of the air is computed by numerical integration of the differential equation of the moisture content. The mass balance takes into account all the flows connected to the vapor port.</p>
</html>"));
end AirVP;
