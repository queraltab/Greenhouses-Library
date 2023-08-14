within Greenhouses.Components.Greenhouse;
model Air
  /******************** Parameters ********************/
  parameter Integer N_rad=2
    "Short-wave radiations are 2: if sun and illumination; 1 if just sun";
  parameter Modelica.SIunits.Density rho=1.2;
  parameter Modelica.SIunits.SpecificHeatCapacity c_p=1e3;
  parameter Modelica.SIunits.Area A "Greenhouse floor surface";

  Real h_Air(unit="m")=4 "Height of the main air zone" annotation(Dialog(group="Varying inputs"));

  /******************** Initialization ********************/
  parameter Modelica.SIunits.Temperature T_start=298 annotation(Dialog(tab = "Initialization"));
  parameter Boolean steadystate=false
    "if true, sets the derivative of T to zero during Initialization"
    annotation (Dialog(group="Initialization options", tab="Initialization"));
  parameter Boolean steadystateVP=true
    "if true, sets the derivative of vapour pressure (VP) to zero during Initialization"
    annotation (Dialog(group="Initialization options", tab="Initialization"));

  /******************** Variables ********************/
  Modelica.SIunits.HeatFlowRate Q_flow "Heat flow rate from port_a -> port_b";
  Modelica.SIunits.Temperature T;
  Modelica.SIunits.Power P_Air;
  Real RH(min=0,max=1) "Relative humidity of the air";
  Modelica.SIunits.Volume V;

  Modelica.SIunits.Pressure P_atm=101325 "Atmospheric pressure";
  Real R_a = 287 "Gas constant for dry air R_a = R_d (J/(kg.K))";
  Real R_s = 461.5;
  Modelica.SIunits.MassFraction w_air "Air humidity ratio (kg water / kg dry air)";

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

  BasicComponents.AirVP airVP(V_air=V, steadystate=steadystateVP)
    annotation (Placement(transformation(extent={{38,24},{58,44}})));
  Interfaces.Vapour.WaterMassPort_a massPort annotation (Placement(
        transformation(extent={{12,-10},{32,10}}), iconTransformation(extent={{
            12,-10},{32,10}})));
  Interfaces.Heat.HeatFluxVectorInput R_Air_Glob[N_rad] annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=-90,
        origin={-50,60})));
equation
  if max({cardinality(R_Air_Glob[i]) for i in 1:size(R_Air_Glob, 1)}) == 0 then
    for i in 1:N_rad loop
      R_Air_Glob[i]=0;
    end for;
  end if;
  P_Air = sum(R_Air_Glob)*A;

  V= A*h_Air;
  // Balance on the floor
  heatPort.Q_flow = Q_flow;
  der(T) = 1/(rho*c_p*V)*(Q_flow + P_Air);

  // Relative humidity
  //RH = massPort.VP/.Greenhouses.Functions.SaturatedVapourPressure(heatPort.T -273.15); "less accurate"
  w_air = massPort.VP * R_a / (P_atm - massPort.VP) / R_s;
  RH=Modelica.Media.Air.MoistAir.relativeHumidity_pTX(P_atm, heatPort.T, {w_air});

  connect(portT.y,preTem. T)
    annotation (Line(points={{-37,20},{-42,20}}, color={0,0,127}));
  connect(preTem.port,heatPort)
    annotation (Line(points={{-64,20},{-68,20},{-68,0},{-22,0}},
                                                           color={191,0,0}));
  connect(airVP.port, massPort) annotation (Line(
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
    <p><big>This model applies an energy and a moisture mass balance on the air. The energy balance is done by taking into account:</p>
<ul>
<li><big>Sensible heat flows (i.e. all the flows connected to the heat port). These include sensible heat flows caused by convection at the heating pipes, the floor, the canopy, the cover, the thermal screen; and by ventilation with the top air zone and the outdoor air. The exchange between the two air zones through the thermal screen occurs because of the porosity material, nature of the latter. The exchange with the outside air accounts for infiltration/exfiltration and natural ventilation through the greenhouse windows.</li>
<li><big>Short-wave radiation from the sun and/or supplementary lighting absorbed by the greenhouse construction elements and later released to the air (i.e. the forced flow from the input).</li>
</ul>
<p><big>Since the short-wave radiation can origin from two sources (the sun and supplementary illumination), the short-wave radiation input connector (i.e. <a href=\"modelica://Greenhouses.Interfaces.Heat.HeatFluxVectorInput\">HeatFluxVectorInput</a>) has the form of a vector. The parameter <i>N_rad</i> defines the dimension of the vector and needs to be set by the user. Therefore, if there is no supplementary lighting, the user must set <i>N_rad</i> to 1 (i.e. radiation only form the sun). However, if there is supplementary lighting, the user must set <i>N_rad</i> to 2 (i.e. radiatio from sun + lighting).</p>
<p><big>The vapor pressure of water of the greenhouse air is increased by the transpiration of the canopy and decreased by air exchange and condensation at the cover and the screen. This pressure is determined by the moisture mass balance on the air. </p>
<p><big></p>
</html>"));
end Air;
