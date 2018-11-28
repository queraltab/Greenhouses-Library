within Greenhouses.ControlSystems.Climate;
model Control_ThScreen_2
  "Controller for the thermal screen closure and crack for humidity and temperature"
  Modelica.SIunits.HeatFlux R_Glob_can=0 annotation(Dialog(group="Varying inputs"));
  Modelica.SIunits.HeatFlux R_Glob_can_min=32 annotation(Dialog(group="Varying inputs"));
  Modelica.SIunits.Temperature T_air=293.15 annotation(Dialog(group="Varying inputs"));

  Integer op;
  Integer cl;
  Real opening_CD;
  Real opening_WD;
  Real closing_CD;
  Modelica.StateGraph.InitialStep closed(nIn=1, nOut=2) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-70,20})));
  inner Modelica.StateGraph.StateGraphRoot stateGraphRoot
    annotation (Placement(transformation(extent={{-94,74},{-74,94}})));
  Modelica.Blocks.Interfaces.RealInput T_out(
    quantity="Temperature",
    displayUnit="degC",
    unit="K")           annotation (Placement(transformation(
        origin={-110,30},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  Modelica.Blocks.Interfaces.RealInput SC_usable
                        annotation (Placement(transformation(
        origin={-110,-90},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  Modelica.Blocks.Interfaces.RealInput T_air_sp(
    quantity="Temperature",
    unit="K",
    displayUnit="degC") annotation (Placement(transformation(
        origin={-110,-30},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  Modelica.Blocks.Interfaces.RealOutput y "Control signal" annotation (
      Placement(transformation(extent={{100,-12},{124,12}}, rotation=0)));
  Modelica.StateGraph.Transition T2(condition=R_Glob_can > R_Glob_can_min
         and T_out <= (T_air_sp - 7))
    annotation (Placement(transformation(extent={{-31,42},{-22,32}},
                                                                   rotation=
           0)));
  Modelica.StateGraph.Transition T3(condition=R_Glob_can > R_Glob_can_min
         and T_out > (T_air_sp - 7))
    annotation (Placement(transformation(extent={{-31,8},{-22,-2}},rotation=
           0)));
  Modelica.StateGraph.Transition T4(
    enableTimer=true,
    waitTime=3600*2,
    condition=SC_usable > 0 and T_out < T_out_sp.y)
    annotation (Placement(transformation(extent={{-31,-46},{-22,-56}},
                                                                   rotation=
           0)));
  Modelica.StateGraph.StepWithSignal opening_ColdDay
    annotation (Placement(transformation(extent={{2,32},{12,42}})));
  Modelica.Blocks.Logical.Timer timer annotation (Placement(transformation(
            extent={{10,16},{18,24}},  rotation=0)));
  Modelica.StateGraph.TransitionWithSignal T6 annotation (Placement(
        transformation(extent={{32,32},{42,42}}, rotation=0)));
  Modelica.Blocks.Logical.GreaterEqualThreshold greaterEqual(threshold=52*60)
    annotation (Placement(transformation(extent={{24,16},{32,24}},   rotation=
             0)));
  Modelica.StateGraph.Step open(nOut=1, nIn=2) annotation (Placement(
        transformation(extent={{52,10},{72,30}}, rotation=0)));
  Modelica.StateGraph.StepWithSignal opening_WarmDay
    annotation (Placement(transformation(extent={{2,-2},{12,8}})));
  Modelica.Blocks.Logical.Timer timer1
                                      annotation (Placement(transformation(
            extent={{10,-18},{18,-10}},rotation=0)));
  Modelica.StateGraph.TransitionWithSignal T7
    annotation (Placement(transformation(extent={{32,-2},{42,8}}, rotation=0)));
  Modelica.Blocks.Logical.GreaterEqualThreshold greaterEqual1(threshold=32*60)
    annotation (Placement(transformation(extent={{24,-18},{32,-10}}, rotation=
             0)));
  Modelica.StateGraph.StepWithSignal closing_ColdDay
    annotation (Placement(transformation(extent={{2,-56},{12,-46}})));
  Modelica.Blocks.Logical.Timer timer2
                                      annotation (Placement(transformation(
            extent={{10,-72},{18,-64}},rotation=0)));
  Modelica.StateGraph.TransitionWithSignal T1 annotation (Placement(
        transformation(extent={{32,-56},{42,-46}}, rotation=0)));
  Modelica.Blocks.Logical.GreaterEqualThreshold greaterEqual2(threshold=52*60)
    annotation (Placement(transformation(extent={{24,-72},{32,-64}}, rotation=
             0)));
  Greenhouses.ControlSystems.Climate.Utilities.SC_closing_value SC_OWD_value(warmDay=
        true, opening=true)
    annotation (Placement(transformation(extent={{-4,-14},{-16,-2}})));
  Greenhouses.ControlSystems.Climate.Utilities.SC_closing_value SC_OCD_value(opening=
        true, warmDay=false)
    annotation (Placement(transformation(extent={{-4,20},{-16,32}})));
  Greenhouses.ControlSystems.Climate.Utilities.SC_closing_value SC_CCD_value(warmDay=
        false, opening=false)
    annotation (Placement(transformation(extent={{-2,-68},{-14,-56}})));
  Modelica.Blocks.Interfaces.RealInput RH_air(quantity="Humidity")
                        annotation (Placement(transformation(
        origin={-110,90},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  Greenhouses.ControlSystems.PID PID_crack(
    Kp=0.5,
    Ti=600,
    PVmin=0.4,
    PVmax=1,
    CSmin=0.96,
    CSmax=1,
    PVstart=0.5,
    CSstart=0.5,
    steadyStateInit=false)
    annotation (Placement(transformation(extent={{-10,80},{0,92}})));
  Modelica.Blocks.Sources.Constant RH_air_SP(k=0.85)
    annotation (Placement(transformation(extent={{-44,86},{-34,96}})));
  Modelica.Blocks.Sources.RealExpression T_out_sp(y=sp1.y + sp2.y)
    annotation (Placement(transformation(extent={{36,72},{56,92}})));
  Modelica.Blocks.Sources.Step sp1(
    height=-2,
    startTime=3196800,
    offset=12 + 273.15)
    annotation (Placement(transformation(extent={{32,60},{42,70}})));
  Modelica.Blocks.Sources.Step sp2(
    height=-2,
    offset=0,
    startTime=6480000)
    annotation (Placement(transformation(extent={{48,60},{58,70}})));
  Greenhouses.ControlSystems.PID PID_crack_T(
    Kp=0.5,
    Ti=600,
    CSmax=1,
    PVstart=0.5,
    CSstart=0.5,
    steadyStateInit=false,
    PVmin=12,
    PVmax=28,
    CSmin=0.98) annotation (Placement(transformation(extent={{-12,60},{2,72}})));
  Modelica.Blocks.Sources.RealExpression T_air_sp_crack(y=T_air_sp + 1.5)
    annotation (Placement(transformation(extent={{-48,58},{-28,78}})));
equation
  PID_crack_T.PV=T_air;
//   opening_CD = if opening_ColdDay.active then SC_OCD_value.y else 0;
//   opening_WD = if opening_WarmDay.active then SC_OWD_value.y else 0;
//   closing_CD = if closing_ColdDay.active then SC_CCD_value.y else 0;
  opening_CD = SC_OCD_value.y;
  opening_WD = SC_OWD_value.y;
  closing_CD = SC_CCD_value.y;
  op = if open.active then 0 else 0;
  cl = if closed.active then 1 else 0;
  y=opening_CD+opening_WD+closing_CD+op+cl*min(PID_crack.CS,PID_crack_T.CS);

  connect(opening_ColdDay.active, timer.u) annotation (Line(
      points={{7,31.5},{7,19.75},{9.2,19.75},{9.2,20}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(timer.y, greaterEqual.u) annotation (Line(
      points={{18.4,20},{23.2,20}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(greaterEqual.y, T6.condition) annotation (Line(
      points={{32.4,20},{37,20},{37,31}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(opening_ColdDay.outPort[1], T6.inPort) annotation (Line(
      points={{12.25,37},{35,37}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(opening_WarmDay.active, timer1.u) annotation (Line(
      points={{7,-2.5},{7,-14.25},{9.2,-14.25},{9.2,-14}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(timer1.y, greaterEqual1.u) annotation (Line(
      points={{18.4,-14},{23.2,-14}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(greaterEqual1.y, T7.condition) annotation (Line(
      points={{32.4,-14},{37,-14},{37,-3}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(opening_WarmDay.outPort[1], T7.inPort) annotation (Line(
      points={{12.25,3},{35,3}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(T6.outPort, open.inPort[1]) annotation (Line(
      points={{37.75,37},{44,37},{44,20.5},{51,20.5}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(T7.outPort, open.inPort[2]) annotation (Line(
      points={{37.75,3},{44,3},{44,19.5},{51,19.5}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(T2.outPort, opening_ColdDay.inPort[1]) annotation (Line(
      points={{-25.825,37},{1.5,37}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(T3.outPort, opening_WarmDay.inPort[1]) annotation (Line(
      points={{-25.825,3},{1.5,3}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(closing_ColdDay.active, timer2.u) annotation (Line(
      points={{7,-56.5},{7,-68.25},{9.2,-68.25},{9.2,-68}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(timer2.y, greaterEqual2.u) annotation (Line(
      points={{18.4,-68},{23.2,-68}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(greaterEqual2.y, T1.condition) annotation (Line(
      points={{32.4,-68},{37,-68},{37,-57}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(closing_ColdDay.outPort[1], T1.inPort) annotation (Line(
      points={{12.25,-51},{35,-51}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(T4.outPort, closing_ColdDay.inPort[1]) annotation (Line(
      points={{-25.825,-51},{1.5,-51}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(closed.outPort[1], T2.inPort) annotation (Line(
      points={{-59.5,20.25},{-44,20.25},{-44,37},{-28.3,37}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(closed.outPort[2], T3.inPort) annotation (Line(
      points={{-59.5,19.75},{-44,19.75},{-44,3},{-28.3,3}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(open.outPort[1], T4.inPort) annotation (Line(
      points={{72.5,20},{78,20},{78,-30},{-40,-30},{-40,-51},{-28.3,-51}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(T1.outPort, closed.inPort[1]) annotation (Line(
      points={{37.75,-51},{46,-51},{46,-78},{-86,-78},{-86,20},{-81,20}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(closing_ColdDay.active, SC_CCD_value.u) annotation (Line(
      points={{7,-56.5},{6.5,-56.5},{6.5,-62},{-0.8,-62}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(opening_ColdDay.active, SC_OCD_value.u) annotation (Line(
      points={{7,31.5},{7,26.75},{-2.8,26.75},{-2.8,26}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(opening_WarmDay.active, SC_OWD_value.u) annotation (Line(
      points={{7,-2.5},{7,-8.25},{-2.8,-8.25},{-2.8,-8}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(RH_air, PID_crack.PV) annotation (Line(
      points={{-110,90},{-60,90},{-60,83.6},{-10,83.6}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(RH_air_SP.y, PID_crack.SP) annotation (Line(
      points={{-33.5,91},{-19.75,91},{-19.75,88.4},{-10,88.4}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(T_air_sp_crack.y, PID_crack_T.SP) annotation (Line(
      points={{-27,68},{-20,68},{-20,68.4},{-12,68.4}},
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
          textString="Ctrl_SC")}),
    Documentation(info="<html>
<p><big>Controller for the screen closure. The control, which is based on a state graph, opens and closes the screen depending on of the outside radiation and temperature. The screen is opened faster in warm days than cold days. The screen is closed in the same manner for cold and warm days. However, the set-point for closing the screen, which depends on the outside temperature, is different in cold than in warm months. Two PI systems are included to open a gap to control humidity and temperature at night. For humidity control, a gap of maximum 4&percnt; of the total screen width is allowed. The relative humidity set-point is set at 85&percnt;. For temperature control, a gap of maximum 2&percnt; is allowed when temperature exceeds the set-point by 1.5&ordm;C.</p>
</html>"));
end Control_ThScreen_2;
