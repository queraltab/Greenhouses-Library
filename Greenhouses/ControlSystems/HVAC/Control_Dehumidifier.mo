within Greenhouses.ControlSystems.HVAC;
model Control_Dehumidifier "Controller for the dehumidifier"
  parameter Modelica.Units.SI.Temperature T_max=273.15 + 60 "Fill level of tank 1";
  parameter Modelica.Units.SI.Temperature T_min=273.15 + 50
    "Lowest level of tank 1 and 2";
  parameter Modelica.Units.SI.Time waitTime=2 "Wait time, between operations";

  Modelica.StateGraph.InitialStep All_off(nIn=1, nOut=1)
                                          annotation (Placement(transformation(
          extent={{-72,30},{-52,50}}, rotation=0)));
  Modelica.Blocks.Interfaces.BooleanOutput Dehum annotation (Placement(
        transformation(extent={{100,55},{110,65}}, rotation=0)));
  Modelica.Blocks.Sources.BooleanExpression Set_Dehum(y=runDehum.active)
    annotation (Placement(transformation(extent={{20,73},{80,92}}, rotation=
           0)));
  inner Modelica.StateGraph.StateGraphRoot stateGraphRoot
    annotation (Placement(transformation(extent={{-94,74},{-74,94}})));
  Modelica.StateGraph.Step runDehum(nIn=1, nOut=1) annotation (Placement(
        transformation(extent={{-30,0},{-10,20}}, rotation=0)));
  Modelica.StateGraph.Transition T2(condition=T_air > 295.15)
    annotation (Placement(transformation(extent={{13,6},{33,-14}}, rotation=
           0)));
  Modelica.StateGraph.Transition T1(condition=T_air < 293.15)
    annotation (Placement(transformation(extent={{-75,0},{-55,-20}},
                                                                   rotation=
           0)));
  Modelica.Blocks.Interfaces.RealInput T_air(
    quantity="Temperature",
    unit="K",
    displayUnit="degC") annotation (Placement(transformation(
        origin={-110,60},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  Modelica.Blocks.Interfaces.RealInput air_RH(
    quantity="ThermodynamicTemperature",
    unit="K",
    displayUnit="degC") annotation (Placement(transformation(
        origin={-110,-60},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  Modelica.Blocks.Interfaces.RealInput T_air_sp(
    quantity="Temperature",
    unit="K",
    displayUnit="degC") annotation (Placement(transformation(
        origin={-110,0},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  Modelica.Blocks.Sources.RealExpression RH_setpoint(y=0.85)
    annotation (Placement(transformation(extent={{-46,-56},{-26,-36}})));
  PID                                             PID_HR(
    CSstart=0.5,
    steadyStateInit=false,
    CSmin=0,
    PVmin=0,
    PVmax=1,
    CSmax=1,
    PVstart=0.85,
    Kp=-0.9,
    Ti=100) annotation (Placement(transformation(extent={{-8,-70},{12,-50}})));
  Modelica.Blocks.Interfaces.RealOutput CS "Control signal" annotation (
      Placement(transformation(extent={{100,-12},{124,12}},rotation=0)));
equation

  connect(Set_Dehum.y, Dehum) annotation (Line(points={{83,82.5},{90,82.5},
          {90,60},{105,60}}, color={255,0,255}));
  connect(runDehum.outPort[1], T2.inPort) annotation (Line(
      points={{-9.5,10},{-2,10},{-2,-4},{19,-4}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(T2.outPort, All_off.inPort[1]) annotation (Line(
      points={{24.5,-4},{52,-4},{52,68},{-92,68},{-92,40},{-73,40}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(All_off.outPort[1],T1. inPort) annotation (Line(
      points={{-51.5,40},{-48,40},{-48,26},{-82,26},{-82,-10},{-69,-10}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(T1.outPort, runDehum.inPort[1]) annotation (Line(
      points={{-63.5,-10},{-48,-10},{-48,10},{-31,10}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(RH_setpoint.y, PID_HR.SP) annotation (Line(
      points={{-25,-46},{-18,-46},{-18,-56},{-8,-56}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(air_RH, PID_HR.PV) annotation (Line(
      points={{-110,-60},{-60,-60},{-60,-64},{-8,-64}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(PID_HR.CS, CS) annotation (Line(
      points={{12.6,-60},{58,-60},{58,0},{112,0}},
      color={0,0,127},
      smooth=Smooth.None));
  annotation (
    Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}}), graphics={Rectangle(extent={{-100,100},{100,-100}},
            lineColor={0,0,0})}),
    Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}}), graphics={
        Rectangle(
          extent={{-100,80},{100,-80}},
          lineColor={0,0,255},
          radius=10,
          lineThickness=0.5),
        Text(
          extent={{-81,40},{80,-28}},
          lineColor={0,0,0},
          textString="Ctrl_dehum")}));
end Control_Dehumidifier;
