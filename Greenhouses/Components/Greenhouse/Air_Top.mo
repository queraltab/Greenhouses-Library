within Greenhouses.Components.Greenhouse;
model Air_Top "Temperature of air in top compartment computed by static equation because of
its small heat capacity"

  /******************** Parameters ********************/
  parameter Modelica.Units.SI.SpecificHeatCapacity c_p=1e3;
  parameter Modelica.Units.SI.Length h_Top
    "Height of the top air compartment (mean greenhouse height minus thermal screen height)";
  parameter Modelica.Units.SI.Area A "Greenhouse floor surface";

  /******************** Initialization ********************/
  parameter Modelica.Units.SI.Temperature T_start=298
    annotation (Dialog(tab="Initialization"));
  parameter Boolean steadystate=false
    "if true, sets the derivative of T to zero during Initialization"
    annotation (Dialog(group="Initialization options", tab="Initialization"));
  parameter Boolean steadystateVP=true
    "if true, sets the derivative of vapour pressure (VP) to zero during Initialization"
    annotation (Dialog(group="Initialization options", tab="Initialization"));

  /******************** Variables ********************/
  Modelica.Units.SI.HeatFlowRate Q_flow "Heat flow rate from port_a -> port_b";
  Modelica.Units.SI.Temperature T;
  Modelica.Units.SI.Density rho;
  Real RH(min=0,max=1) "Relative humidity of the air";
  Modelica.Units.SI.Volume V;

  Modelica.Units.SI.Pressure P_atm=101325 "Atmospheric pressure";
  Real R_a = 287 "Gas constant for dry air R_a = R_d (J/(kg.K))";
  Real R_s = 461.5;
  Modelica.Units.SI.MassFraction w_air "Air humidity ratio (kg water / kg dry air)";

  /******************** Connectors ********************/
protected
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature preTem
    "Port temperature"
    annotation (Placement(transformation(extent={{-44,10},{-64,30}})));
  Modelica.Blocks.Sources.RealExpression portT(y=T) "Port temperature"
    annotation (Placement(transformation(extent={{-16,10},{-36,30}})));
public
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPort(
    T(start=T_start)) "Heat port for sensible heat input"
    annotation (Placement(transformation(extent={{-32,-10},{-12,10}}),
        iconTransformation(extent={{-32,-10},{-12,10}})));

  BasicComponents.AirVP air(V_air=V, steadystate=steadystateVP)
    annotation (Placement(transformation(extent={{38,24},{58,44}})));
  Interfaces.Vapour.WaterMassPort_a massPort annotation (Placement(
        transformation(extent={{12,-10},{32,10}}), iconTransformation(extent={{
            12,-10},{32,10}})));
equation
  V=A*h_Top;
  // Balance on the floor
  heatPort.Q_flow = Q_flow;
  rho = Modelica.Media.Air.ReferenceAir.Air_pT.density_pT(1e5,heatPort.T);
  der(T) = 1/(rho*c_p*V)*Q_flow;

  //RH = massPort.VP/.Greenhouses.Functions.SaturatedVapourPressure(heatPort.T -273.15);
  w_air = massPort.VP * R_a / (P_atm - massPort.VP) / R_s;
  RH=Modelica.Media.Air.MoistAir.relativeHumidity_pTX(P_atm, heatPort.T, {w_air});

  connect(portT.y,preTem. T)
    annotation (Line(points={{-37,20},{-42,20}}, color={0,0,127}));
  connect(preTem.port,heatPort)
    annotation (Line(points={{-64,20},{-68,20},{-68,0},{-22,0}},
                                                           color={191,0,0}));
  connect(air.port, massPort) annotation (Line(
      points={{48,34},{48,0},{22,0}},
      color={170,213,255},
      smooth=Smooth.None));
initial equation
  if steadystate then
    der(T)=0;
  end if;
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}),
                         graphics), Icon(coordinateSystem(preserveAspectRatio=false,
          extent={{-100,-100},{100,100}}), graphics={
                                          Text(
          extent={{-110,-54},{110,-114}},
          lineColor={0,0,0},
          textString="%name"), Ellipse(
          extent={{-60,60},{60,-60}},
          lineColor={0,0,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Sphere)}),
    Documentation(info="<html>
    <p><big>This is a simplified model of the <a href=\"modelica://Greenhouses.Components.Greenhouse.Air\">Air</a> model. The top air zone has a very low capacity and is only modeled when the screen is drawn (i.e. mostly at night, to mitigate losses in the lack of short-wave radiation). For this reason, in this model the heat input from short-wave radiation is neglected. </p>
    <p><big>The model has the same parameters than the Air model, considering that the height of the top air zone is equal to the mean greenhouse height minus the height of the thermal screen.</p>
</html>"));
end Air_Top;
