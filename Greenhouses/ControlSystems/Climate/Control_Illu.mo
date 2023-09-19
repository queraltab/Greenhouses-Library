within Greenhouses.ControlSystems.Climate;
model Control_Illu "Controller for the artificial illumination"
  Modelica.Units.SI.HeatFlux R_t_PAR=0 annotation (Dialog(group="Varying inputs"));
  parameter Real R_illu(unit "W/m2")=100;

  Real E_acc(unit="W.s/m2") "Accumulated PAR light";
  Real E_acc_limit(unit="W.s/m2")
    "Accumulated PAR light limit above which lamps have to be switched off";
  Real R_PAR_tot(unit="W/m2");
  Real R_PAR_day(unit="W/m2");

  Modelica.StateGraph.InitialStep off(nOut=1, nIn=3) annotation (Placement(
        transformation(
        extent={{-9,-9},{9,9}},
        rotation=0,
        origin={-61,-11})));
  inner Modelica.StateGraph.StateGraphRoot stateGraphRoot
    annotation (Placement(transformation(extent={{-94,74},{-74,94}})));
  Modelica.Blocks.Interfaces.RealInput h "Hour of the day" annotation (
      Placement(transformation(
        origin={-110,0},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  Modelica.Blocks.Interfaces.RealOutput y "Control signal" annotation (
      Placement(transformation(extent={{100,-12},{124,12}}, rotation=0)));
  Modelica.StateGraph.Transition T1(condition=h >= 6 and h <= 22 and E_acc <
        E_acc_limit and R_t_PAR < 40)
    "We are in the light usage window and we do not exceed the accumulation limit"
    annotation (Placement(transformation(extent={{-33,-6},{-24,-16}},
                                                                   rotation=
           0)));
  Modelica.StateGraph.Transition T4(
    enableTimer=true,
    waitTime=120*60,
    condition=R_t_PAR > 120) "Minimum on time of 2h. Then if I>120, turn off"
    annotation (Placement(transformation(extent={{6,-74},{-6,-86}},rotation=
           0)));
  Modelica.StateGraph.Step on(nIn=1, nOut=2) annotation (Placement(
        transformation(extent={{48,-20},{66,-2}},rotation=0)));
  Modelica.StateGraph.Transition T2(
    condition=R_t_PAR < 40,
    enableTimer=true,
    waitTime=30*60) "Proving time"
    annotation (Placement(transformation(extent={{17,-6},{26,-16}},rotation=
           0)));
  Modelica.StateGraph.Step off_ProvingTime(nIn=1, nOut=2) annotation (Placement(
        transformation(extent={{-8,-16},{2,-6}},  rotation=0)));
  Modelica.StateGraph.Transition T5(
    enableTimer=true,
    waitTime=120*60,
    condition=h > 22 or h < 6) "Minimum on time of 2h. Then if I<120, turn off"
    annotation (Placement(transformation(extent={{6,-46},{-6,-58}},rotation=
           0)));
  Modelica.StateGraph.Transition T3(
    enableTimer=true,
    waitTime=30*60,
    condition=R_t_PAR >= 40 or (h < 6 and h > 22)) "Proving time"
    annotation (Placement(transformation(extent={{4,-24},{-5,-34}},rotation=
           0)));
  Modelica.StateGraph.InitialStep sameDay(nOut=1, nIn=1) annotation (Placement(
        transformation(
        extent={{-7,-7},{7,7}},
        rotation=0,
        origin={-33,73})));
  Modelica.StateGraph.Transition T6(condition=h <= 0)
    "We are in the light usage window and we do not exceed the accumulation limit"
    annotation (Placement(transformation(extent={{-13,78},{-4,68}},rotation=
           0)));
  Modelica.Blocks.Logical.Timer timer annotation (Placement(transformation(
          extent={{26,52},{34,60}}, rotation=0)));
  Modelica.StateGraph.TransitionWithSignal T7
    annotation (Placement(transformation(extent={{46,68},{56,78}},rotation=0)));
  Modelica.Blocks.Logical.GreaterEqualThreshold greaterEqual1(threshold=
        3600)
    annotation (Placement(transformation(extent={{40,52},{48,60}},   rotation=
             0)));
  Modelica.StateGraph.StepWithSignal newDay(nIn=1, nOut=1)
    annotation (Placement(transformation(extent={{10,66},{24,80}})));
equation
  E_acc_limit = 1.2*1000*3600 "1.2 kWh/m2";

  R_PAR_tot = if on.active then (R_t_PAR + 0.25*R_illu) else R_t_PAR;
  R_PAR_day = if newDay.active then R_PAR_tot else 0;

  der(E_acc) = 1/86400*(R_PAR_tot - R_PAR_day);

  y= if on.active then 1 else 0;

  connect(off.outPort[1],T1. inPort) annotation (Line(
      points={{-51.55,-11},{-30.3,-11}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(on.outPort[1], T4.inPort) annotation (Line(
      points={{66.45,-10.775},{84,-10.775},{84,-80},{2.4,-80}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(T1.outPort, off_ProvingTime.inPort[1]) annotation (Line(
      points={{-27.825,-11},{-8.5,-11}},
      color={0,0,0},
      smooth=Smooth.Bezier));
  connect(off_ProvingTime.outPort[1], T2.inPort) annotation (Line(
      points={{2.25,-10.875},{2.25,-11},{19.7,-11}},
      color={0,0,0},
      smooth=Smooth.Bezier));
  connect(T2.outPort, on.inPort[1]) annotation (Line(
      points={{22.175,-11},{34.0875,-11},{47.1,-11}},
      color={0,0,0},
      smooth=Smooth.Bezier));
  connect(T4.outPort, off.inPort[1]) annotation (Line(
      points={{-0.9,-80},{-84,-80},{-84,-10.4},{-70.9,-10.4}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(on.outPort[2], T5.inPort) annotation (Line(
      points={{66.45,-11.225},{72,-11.225},{72,-52},{2.4,-52}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(T5.outPort, off.inPort[2]) annotation (Line(
      points={{-0.9,-52},{-76,-52},{-76,-11},{-70.9,-11}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(T3.inPort, off_ProvingTime.outPort[2]) annotation (Line(
      points={{1.3,-29},{1.3,-30},{10,-30},{10,-12},{2.25,-12},{2.25,-11.125}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(T3.outPort, off.inPort[3]) annotation (Line(
      points={{-1.175,-29},{-38,-29},{-38,-30},{-74,-30},{-74,-11.6},{-70.9,-11.6}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(sameDay.outPort[1], T6.inPort) annotation (Line(
      points={{-25.65,73},{-10.3,73}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(timer.y, greaterEqual1.u) annotation (Line(
      points={{34.4,56},{39.2,56}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(greaterEqual1.y,T7. condition) annotation (Line(
      points={{48.4,56},{51,56},{51,67}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(T6.outPort, newDay.inPort[1]) annotation (Line(
      points={{-7.825,73},{9.3,73}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(newDay.active, timer.u) annotation (Line(
      points={{17,65.3},{18,65.3},{18,56},{25.2,56}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(newDay.outPort[1], T7.inPort) annotation (Line(
      points={{24.35,73},{36.175,73},{36.175,73},{49,73}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(T7.outPort, sameDay.inPort[1]) annotation (Line(
      points={{51.75,73},{58,73},{58,72},{64,72},{64,40},{-56,40},{-56,73},{-40.7,
          73}},
      color={0,0,0},
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
          extent={{-53,26},{50,-22}},
          lineColor={0,0,0},
          textString="Ctrl_illu")}));
end Control_Illu;
