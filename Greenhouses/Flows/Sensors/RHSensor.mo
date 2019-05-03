within Greenhouses.Flows.Sensors;
model RHSensor "Relative Humidity sensor"

  Modelica.SIunits.Pressure P_atm=101325 "Atmospheric pressure";
  Real R_a = 287 "Gas constant for dry air R_a = R_d (J/(kg.K))";
  Real R_s = 461.5;
  Modelica.SIunits.MassFraction w_air "Air humidity ratio (kg water / kg dry air)";

  Modelica.Blocks.Interfaces.RealOutput RH
    "Absolute temperature as output signal"
    annotation (Placement(transformation(extent={{90,-10},{110,10}}, rotation=0)));
  Greenhouses.Interfaces.Vapour.WaterMassPort_a massPort annotation (Placement(
        transformation(extent={{-110,-50},{-90,-30}}, rotation=0)));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPort annotation (
      Placement(transformation(extent={{-110,30},{-90,50}},  rotation=0)));
equation
  massPort.MV_flow = 0;
  heatPort.Q_flow = 0;

  // Relative humidity
  w_air = massPort.VP * R_a / (P_atm - massPort.VP) / R_s;
  RH=Modelica.Media.Air.MoistAir.relativeHumidity_pTX(P_atm, heatPort.T, {w_air});


  annotation (
    Diagram(coordinateSystem(preserveAspectRatio=false,extent={{-100,-100},{100,
            100}}),     graphics),
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
            100,100}}), graphics={
        Line(points={{-90,0},{90,0}},color={0,0,255}),
        Text(
          extent={{100,-20},{0,-120}},
          lineColor={0,0,0},
          textString="RH"),
        Text(
          extent={{-150,130},{150,90}},
          textString="%name",
          lineColor={0,0,255})}),
    Documentation(info="<HTML>
<p>
This is an ideal absolute temperature sensor which returns
the temperature of the connected port in Kelvin as an output
signal.  The sensor itself has no thermal interaction with
whatever it is connected to.  Furthermore, no
thermocouple-like lags are associated with this
sensor model.
</p>
</html>"));
end RHSensor;
