within Greenhouses.ControlSystems.Climate;
model Control_ThScreen
  "Controller for the thermal screen closure including a crack for dehumidification (of 2% and 4%)"
  Modelica.SIunits.HeatFlux R_Glob_can=0 annotation(Dialog(group="Varying inputs"));
  Modelica.SIunits.HeatFlux R_Glob_can_min=32 annotation(Dialog(group="Varying inputs"));

  Integer op;
  Integer cl;
  Real opening_CD;
  Real opening_WD;
  Real closing_CD;
  Modelica.StateGraph.InitialStep closed(       nOut=3, nIn=3)
                                                        annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-70,0})));
  inner Modelica.StateGraph.StateGraphRoot stateGraphRoot
    annotation (Placement(transformation(extent={{-94,74},{-74,94}})));
  Modelica.Blocks.Interfaces.RealInput T_out(
    quantity="Temperature",
    displayUnit="degC",
    unit="K")           annotation (Placement(transformation(
        origin={-110,32},
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
    annotation (Placement(transformation(extent={{-31,14},{-22,4}},rotation=
           0)));
  Modelica.StateGraph.Transition T3(condition=R_Glob_can > R_Glob_can_min
         and T_out > (T_air_sp - 7))
    annotation (Placement(transformation(extent={{-31,-20},{-22,-30}},
                                                                   rotation=
           0)));
  Modelica.StateGraph.Transition T4(condition=SC_usable > 0 and T_out < (
        T_air_sp - 7),
    enableTimer=true,
    waitTime=3600*2)
    annotation (Placement(transformation(extent={{-31,-66},{-22,-76}},
                                                                   rotation=
           0)));
  Modelica.StateGraph.StepWithSignal opening_ColdDay(nIn=3)
    annotation (Placement(transformation(extent={{18,4},{28,14}})));
  Modelica.Blocks.Logical.Timer timer annotation (Placement(transformation(
            extent={{26,-12},{34,-4}}, rotation=0)));
  Modelica.StateGraph.TransitionWithSignal T6 annotation (Placement(
        transformation(extent={{48,4},{58,14}},  rotation=0)));
  Modelica.Blocks.Logical.GreaterEqualThreshold greaterEqual(threshold=52*
        60)
    annotation (Placement(transformation(extent={{40,-12},{48,-4}},  rotation=
             0)));
  Modelica.StateGraph.Step open(nOut=1, nIn=2) annotation (Placement(
        transformation(extent={{70,-18},{90,2}}, rotation=0)));
  Modelica.StateGraph.StepWithSignal opening_WarmDay(nIn=3)
    annotation (Placement(transformation(extent={{18,-30},{28,-20}})));
  Modelica.Blocks.Logical.Timer timer1
                                      annotation (Placement(transformation(
            extent={{26,-46},{34,-38}},rotation=0)));
  Modelica.StateGraph.TransitionWithSignal T7
    annotation (Placement(transformation(extent={{48,-30},{58,-20}},
                                                                  rotation=0)));
  Modelica.Blocks.Logical.GreaterEqualThreshold greaterEqual1(threshold=32*
        60)
    annotation (Placement(transformation(extent={{40,-46},{48,-38}}, rotation=
             0)));
  Modelica.StateGraph.StepWithSignal closing_ColdDay
    annotation (Placement(transformation(extent={{2,-76},{12,-66}})));
  Modelica.Blocks.Logical.Timer timer2
                                      annotation (Placement(transformation(
            extent={{10,-92},{18,-84}},rotation=0)));
  Modelica.StateGraph.TransitionWithSignal T1 annotation (Placement(
        transformation(extent={{32,-76},{42,-66}}, rotation=0)));
  Modelica.Blocks.Logical.GreaterEqualThreshold greaterEqual2(threshold=52*
        60)
    annotation (Placement(transformation(extent={{24,-92},{32,-84}}, rotation=
             0)));
  Utilities.SC_closing_value SC_OWD_value(warmDay=true, opening=true)
    annotation (Placement(transformation(extent={{12,-42},{0,-30}})));
  Utilities.SC_closing_value SC_OCD_value(opening=true, warmDay=false)
    annotation (Placement(transformation(extent={{12,-8},{0,4}})));
  Utilities.SC_closing_value SC_CCD_value(warmDay=false, opening=false)
    annotation (Placement(transformation(extent={{-2,-88},{-14,-76}})));
  Modelica.StateGraph.Transition T5(condition=RH_air > 0.83)
    annotation (Placement(transformation(extent={{-47,60},{-38,50}},
                                                                   rotation=
           0)));
  Modelica.StateGraph.StepWithSignal crack(        nIn=1, nOut=4)
    annotation (Placement(transformation(extent={{-14,50},{-4,60}})));
  Utilities.SC_crack SC_crack(SC_value=0.98)
    annotation (Placement(transformation(extent={{-20,36},{-32,48}})));
  Modelica.Blocks.Interfaces.RealInput RH_air(quantity="Humidity")
                        annotation (Placement(transformation(
        origin={-110,90},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  Modelica.StateGraph.Transition T2b(condition=R_Glob_can > R_Glob_can_min
         and T_out <= (T_air_sp - 7)) annotation (Placement(transformation(
          extent={{21,60},{30,50}}, rotation=0)));
  Modelica.StateGraph.Transition T3b(condition=R_Glob_can > R_Glob_can_min
         and T_out > (T_air_sp - 7)) annotation (Placement(transformation(
          extent={{6,36},{-3,26}}, rotation=0)));
  Modelica.StateGraph.Transition T8(condition=RH_air < 0.7)
    annotation (Placement(transformation(extent={{-4,80},{-13,70}},rotation=
           0)));
  Modelica.StateGraph.Transition T9(
    condition=RH_air > 0.85,
    enableTimer=true,
    waitTime=15*60)
    annotation (Placement(transformation(extent={{21,86},{30,76}}, rotation=
           0)));
  Utilities.SC_crack SC_crack2(SC_value=0.96)
    annotation (Placement(transformation(extent={{48,62},{36,74}})));
  Modelica.StateGraph.StepWithSignal crack2(       nIn=1, nOut=3)
    annotation (Placement(transformation(extent={{54,76},{64,86}})));
  Modelica.StateGraph.Transition T8b(
                                    condition=RH_air < 0.7)
    annotation (Placement(transformation(extent={{-4,96},{-13,86}},rotation=
           0)));
  Modelica.StateGraph.Transition T2c(condition=R_Glob_can > R_Glob_can_min and
        T_out <= (T_air_sp - 7)) annotation (Placement(transformation(extent={{79,
            86},{88,76}}, rotation=0)));
  Modelica.StateGraph.Transition T3c(condition=R_Glob_can > R_Glob_can_min and
        T_out > (T_air_sp - 7)) annotation (Placement(transformation(extent={{66,
            56},{57,46}}, rotation=0)));
equation
//   opening_CD = if opening_ColdDay.active then SC_OCD_value.y else 0;
//   opening_WD = if opening_WarmDay.active then SC_OWD_value.y else 0;
//   closing_CD = if closing_ColdDay.active then SC_CCD_value.y else 0;
  opening_CD = SC_OCD_value.y;
  opening_WD = SC_OWD_value.y;
  closing_CD = SC_CCD_value.y;
  op = if open.active then 0 else 0;
  cl = if closed.active then 1 else 0;
  y=opening_CD+opening_WD+closing_CD+op+cl+SC_crack.y+SC_crack2.y;

  connect(opening_ColdDay.active, timer.u) annotation (Line(
      points={{23,3.5},{23,-8.25},{25.2,-8.25},{25.2,-8}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(timer.y, greaterEqual.u) annotation (Line(
      points={{34.4,-8},{39.2,-8}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(greaterEqual.y, T6.condition) annotation (Line(
      points={{48.4,-8},{53,-8},{53,3}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(opening_ColdDay.outPort[1], T6.inPort) annotation (Line(
      points={{28.25,9},{51,9}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(opening_WarmDay.active, timer1.u) annotation (Line(
      points={{23,-30.5},{23,-42.25},{25.2,-42.25},{25.2,-42}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(timer1.y, greaterEqual1.u) annotation (Line(
      points={{34.4,-42},{39.2,-42}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(greaterEqual1.y, T7.condition) annotation (Line(
      points={{48.4,-42},{53,-42},{53,-31}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(opening_WarmDay.outPort[1], T7.inPort) annotation (Line(
      points={{28.25,-25},{51,-25}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(T6.outPort, open.inPort[1]) annotation (Line(
      points={{53.75,9},{60,9},{60,-7.5},{69,-7.5}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(T7.outPort, open.inPort[2]) annotation (Line(
      points={{53.75,-25},{60,-25},{60,-8.5},{69,-8.5}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(T2.outPort, opening_ColdDay.inPort[1]) annotation (Line(
      points={{-25.825,9},{4,9},{4,9.33333},{17.5,9.33333}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(T3.outPort, opening_WarmDay.inPort[1]) annotation (Line(
      points={{-25.825,-25},{4,-25},{4,-24.6667},{17.5,-24.6667}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(closing_ColdDay.active, timer2.u) annotation (Line(
      points={{7,-76.5},{7,-88.25},{9.2,-88.25},{9.2,-88}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(timer2.y, greaterEqual2.u) annotation (Line(
      points={{18.4,-88},{23.2,-88}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(greaterEqual2.y, T1.condition) annotation (Line(
      points={{32.4,-88},{37,-88},{37,-77}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(closing_ColdDay.outPort[1], T1.inPort) annotation (Line(
      points={{12.25,-71},{35,-71}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(T4.outPort, closing_ColdDay.inPort[1]) annotation (Line(
      points={{-25.825,-71},{1.5,-71}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(closed.outPort[1], T2.inPort) annotation (Line(
      points={{-59.5,0.333333},{-44,0.333333},{-44,9},{-28.3,9}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(closed.outPort[2], T3.inPort) annotation (Line(
      points={{-59.5,0},{-44,0},{-44,-25},{-28.3,-25}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(open.outPort[1], T4.inPort) annotation (Line(
      points={{90.5,-8},{94,-8},{94,-54},{-40,-54},{-40,-71},{-28.3,-71}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(T1.outPort, closed.inPort[1]) annotation (Line(
      points={{37.75,-71},{46,-71},{46,-98},{-86,-98},{-86,0.666667},{-81,
          0.666667}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(closing_ColdDay.active, SC_CCD_value.u) annotation (Line(
      points={{7,-76.5},{6.5,-76.5},{6.5,-82},{-0.8,-82}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(opening_ColdDay.active, SC_OCD_value.u) annotation (Line(
      points={{23,3.5},{23,-1.25},{13.2,-1.25},{13.2,-2}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(opening_WarmDay.active, SC_OWD_value.u) annotation (Line(
      points={{23,-30.5},{23,-36.25},{13.2,-36.25},{13.2,-36}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(closed.outPort[3], T5.inPort) annotation (Line(
      points={{-59.5,-0.333333},{-60,-0.333333},{-60,55},{-44.3,55}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(T5.outPort, crack.inPort[1]) annotation (Line(
      points={{-41.825,55},{-14.5,55}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(crack.active, SC_crack.u) annotation (Line(
      points={{-9,49.5},{-9.5,49.5},{-9.5,42},{-18.8,42}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(crack.outPort[1], T2b.inPort) annotation (Line(
      points={{-3.75,55.1875},{7.125,55.1875},{7.125,55},{23.7,55}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(T2b.outPort, opening_ColdDay.inPort[2]) annotation (Line(
      points={{26.175,55},{26.175,54},{38,54},{38,24},{12,24},{12,10},{17.5,10},
          {17.5,9}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(crack.outPort[2], T3b.inPort) annotation (Line(
      points={{-3.75,55.0625},{-3.75,54},{12,54},{12,30},{3.3,30},{3.3,31}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(T3b.outPort, opening_WarmDay.inPort[2]) annotation (Line(
      points={{0.825,31},{0.825,30},{-12,30},{-12,-24},{17.5,-24},{17.5,-25}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(crack.outPort[3], T8.inPort) annotation (Line(
      points={{-3.75,54.9375},{-3.75,56},{8,56},{8,76},{-6.7,76},{-6.7,75}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(T8.outPort, closed.inPort[2]) annotation (Line(
      points={{-9.175,75},{-9.175,74},{-64,74},{-64,44},{-84,44},{-84,0},{-81,0},
          {-81,-5.55112e-017}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(crack.outPort[4], T9.inPort) annotation (Line(
      points={{-3.75,54.8125},{9.125,54.8125},{9.125,81},{23.7,81}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(crack2.active, SC_crack2.u) annotation (Line(
      points={{59,75.5},{58.5,75.5},{58.5,68},{49.2,68}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(T9.outPort, crack2.inPort[1]) annotation (Line(
      points={{26.175,81},{53.5,81}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(crack2.outPort[1], T2c.inPort) annotation (Line(
      points={{64.25,81.1667},{73.125,81.1667},{73.125,81},{81.7,81}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(T2c.outPort, opening_ColdDay.inPort[3]) annotation (Line(
      points={{84.175,81},{84.175,80},{88,80},{88,22},{12,22},{12,8.66667},{
          17.5,8.66667}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(crack2.outPort[2], T3c.inPort) annotation (Line(
      points={{64.25,81},{64.25,66.5},{63.3,66.5},{63.3,51}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(T3c.outPort, opening_WarmDay.inPort[3]) annotation (Line(
      points={{60.825,51},{60.825,52},{50,52},{50,28},{-8,28},{-8,-24},{17.5,
          -24},{17.5,-25.3333}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(crack2.outPort[3], T8b.inPort) annotation (Line(
      points={{64.25,80.8333},{66,80.8333},{66,92},{30,92},{30,91},{-6.7,91}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(T8b.outPort, closed.inPort[3]) annotation (Line(
      points={{-9.175,91},{-9.175,92},{-66,92},{-66,46},{-86,46},{-86,0},{-81,0},
          {-81,-0.666667}},
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
          extent={{-81,40},{80,-28}},
          lineColor={0,0,0},
          textString="Ctrl_SC")}));
end Control_ThScreen;
