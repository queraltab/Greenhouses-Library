within Greenhouses.Components.HVAC;
model Dehumidifier
  "Dehumidifier model based on the characteristics of the industrial dehumidifier CD520L"

  /******************** Parameters ********************/
  //parameter Modelica.SIunits.MassFlowRate MV_machine=2.894e-3;
  parameter Modelica.SIunits.Volume V_air "Air volume";

  /******************** Varying inputs ********************/

  //Real T(unit="degC") "Temperature of the air in Celsius";
  Modelica.SIunits.Power W_el_nom = 5700 "Nominal electrical power";
  Modelica.SIunits.Power W_el;
  Modelica.SIunits.Volume V_air_nom=4600;
  Modelica.SIunits.MassFlowRate M_w_nom=250/24/3600 "250 l / 24 h";
  Modelica.SIunits.HeatFlowRate Q_amb_nom=12000
    "Released power to the ambient air";
  Real U;

  Flows.Interfaces.Vapour.WaterMassPort_a massPort annotation (Placement(
        transformation(extent={{-10,30},{10,50}}), iconTransformation(extent={{
            -10,30},{10,50}})));

  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPort
    annotation (Placement(transformation(extent={{70,-10},{90,10}}),
        iconTransformation(extent={{70,-10},{90,10}})));
  Modelica.Blocks.Interfaces.BooleanInput on_off annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={0,-100}), iconTransformation(
        extent={{-6,-6},{6,6}},
        rotation=90,
        origin={2,-92})));
  Modelica.Blocks.Interfaces.RealInput CS_PID_RH(quantity="Real") annotation (
      Placement(transformation(
        origin={60,-100},
        extent={{-20,-20},{20,20}},
        rotation=90)));
equation
  //T=T_air-273.15;
  //MV_machine=-3.46042E+06 + 35389*T - 120.651*T^2 + 0.137133*T^3 "T in K";
  //-988.179 + 172.531*T - 8.27719*T^2 + 0.137139*T^3 "T in Celsius";
  //MV_machine=2.894e-3 "250l/24h for 4600m3/h";

  heatPort.Q_flow = -U*V_air/V_air_nom*Q_amb_nom;
  W_el = U*V_air/V_air_nom*W_el_nom;

  massPort.MV_flow = U*V_air/V_air_nom*M_w_nom "54.34 l / 24 h for 1000 m3/h";

  U= if on_off then CS_PID_RH else 0;

  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
            {100,100}}), graphics={Rectangle(
          extent={{-80,80},{80,-80}},
          lineColor={0,0,0},
          fillColor={215,215,215},
          fillPattern=FillPattern.VerticalCylinder), Rectangle(
          extent={{-60,60},{60,0}},
          lineColor={0,0,0},
          fillColor={215,215,215},
          fillPattern=FillPattern.CrossDiag)}), Diagram(coordinateSystem(
          preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics));
end Dehumidifier;
