within Greenhouses.ControlSystems.HVAC;
model Control_1 "Controller for the CHP and heat pump and TES"
  parameter Modelica.SIunits.Temperature T_max=273.15+60 "Fill level of tank 1";
  parameter Modelica.SIunits.Temperature T_min = 273.15+50
    "Lowest level of tank 1 and 2";
  parameter Modelica.SIunits.Time waitTime=2 "Wait time, between operations";
  parameter Modelica.SIunits.MassFlowRate Mdot_max=38 "Maximum mass flow rate in the greenhouse heating circuit";
  Modelica.SIunits.Temperature T_high_tank = 90+273.15 annotation(Dialog(group="Varying inputs"));

  Modelica.StateGraph.InitialStep All_off(nIn=1, nOut=1)
                                          annotation (Placement(transformation(
          extent={{-72,30},{-52,50}}, rotation=0)));
  Modelica.Blocks.Interfaces.BooleanOutput CHP annotation (Placement(
        transformation(extent={{100,55},{110,65}}, rotation=0)));
  Modelica.Blocks.Interfaces.BooleanOutput ElectricalHeater annotation (
      Placement(transformation(extent={{100,-65},{110,-55}}, rotation=0)));
  Modelica.Blocks.Sources.BooleanExpression Set_CHP(y=runCHP.active)
    annotation (Placement(transformation(extent={{20,73},{80,92}}, rotation=0)));
  Modelica.Blocks.Sources.BooleanExpression Set_ElectricalHeater(y=not1.y
         and time > 1E3)
    annotation (Placement(transformation(extent={{-40,-103},{80,-83}}, rotation=
           0)));
  inner Modelica.StateGraph.StateGraphRoot stateGraphRoot
    annotation (Placement(transformation(extent={{-94,74},{-74,94}})));
  Modelica.Blocks.Interfaces.RealInput T_tank(quantity="ThermodynamicTemperature",unit="K",displayUnit="degC")
    annotation (Placement(transformation(
        origin={-110,-40},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  Modelica.StateGraph.Step runCHP(nIn=1, nOut=1) annotation (Placement(
        transformation(extent={{-32,-14},{-12,6}}, rotation=0)));
  Modelica.StateGraph.Transition T2(condition=T_tank > T_max or Mdot_1ry <= 0.1
        *Mdot_max or T_high_tank > T_max)
    annotation (Placement(transformation(extent={{3,6},{23,-14}},  rotation=
           0)));
  Modelica.Blocks.Logical.Hysteresis hysteresis(
    pre_y_start=false,
    uLow=T_min - 5,
    uHigh=T_max - 5)
    annotation (Placement(transformation(extent={{-80,-68},{-60,-48}})));
  Modelica.Blocks.Logical.Not not1
    annotation (Placement(transformation(extent={{-46,-68},{-26,-48}})));
  Modelica.StateGraph.Transition T1(condition=T_tank < T_min and T_high_tank <
        T_max and Mdot_1ry > 0.1*Mdot_max or T_tank < T_max - 10 and Mdot_1ry
         > Mdot_max)
    annotation (Placement(transformation(extent={{-73,6},{-53,-14}},
                                                                   rotation=
           0)));
  Modelica.Blocks.Interfaces.RealInput Mdot_1ry(
    quantity="ThermodynamicMassFlowRate",
    unit="kg/s",
    displayUnit="kg/s") annotation (Placement(transformation(
        origin={-110,40},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  Modelica.Blocks.Interfaces.BooleanOutput HP annotation (Placement(
        transformation(extent={{100,-5},{110,5}}, rotation=0)));
  Modelica.Blocks.Sources.BooleanExpression Set_HP(y=runCHP.active and
        T_low_TES < 333.15) annotation (Placement(transformation(extent={{
            18,-45},{78,-26}}, rotation=0)));
  Modelica.Blocks.Interfaces.RealInput T_low_TES(
    quantity="ThermodynamicTemperature",
    unit="K",
    displayUnit="degC") annotation (Placement(transformation(
        origin={-110,0},
        extent={{-10,-10},{10,10}},
        rotation=0)));
equation

  connect(Set_CHP.y, CHP) annotation (Line(points={{83,82.5},{90,82.5},{90,60},{
          105,60}}, color={255,0,255}));
  connect(runCHP.outPort[1], T2.inPort) annotation (Line(
      points={{-11.5,-4},{9,-4}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(T2.outPort, All_off.inPort[1]) annotation (Line(
      points={{14.5,-4},{66,-4},{66,66},{-92,66},{-92,40},{-73,40}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(T_tank, hysteresis.u) annotation (Line(
      points={{-110,-40},{-94,-40},{-94,-58},{-82,-58}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(hysteresis.y, not1.u) annotation (Line(
      points={{-59,-58},{-48,-58}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(All_off.outPort[1],T1. inPort) annotation (Line(
      points={{-51.5,40},{-50,40},{-50,26},{-88,26},{-88,-4},{-67,-4}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(T1.outPort, runCHP.inPort[1]) annotation (Line(
      points={{-61.5,-4},{-33,-4}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(Set_ElectricalHeater.y, ElectricalHeater) annotation (Line(
      points={{86,-93},{92,-93},{92,-94},{96,-94},{96,-60},{105,-60}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(Set_HP.y, HP) annotation (Line(
      points={{81,-35.5},{81,-17.75},{105,-17.75},{105,0}},
      color={255,0,255},
      smooth=Smooth.None));
  annotation (
    Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}}), graphics={Rectangle(extent={{-100,100},{100,-100}},
            lineColor={0,0,0})}),
    Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}}), graphics={
        Text(
          extent={{-99,-32},{-14,-47}},
          lineColor={0,0,0},
          textString="T_tank"),
        Text(
          extent={{18,68},{107,54}},
          lineColor={0,0,0},
          textString="CHP"),
        Text(
          extent={{12,-51},{112,-67}},
          lineColor={0,0,0},
          textString="Resistor"),
        Rectangle(
          extent={{-100,80},{100,-80}},
          lineColor={0,0,255},
          radius=10,
          lineThickness=0.5),
        Text(
          extent={{-99,8},{10,-8}},
          lineColor={0,0,0},
          textString="T_low_tank"),
        Text(
          extent={{-99,48},{10,32}},
          lineColor={0,0,0},
          textString="Mdot_1ry"),
        Text(
          extent={{18,6},{107,-8}},
          lineColor={0,0,0},
          textString="HP")}));
end Control_1;
