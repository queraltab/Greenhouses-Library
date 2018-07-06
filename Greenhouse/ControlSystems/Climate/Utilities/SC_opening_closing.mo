within Greenhouse.ControlSystems.Climate.Utilities;
model SC_opening_closing "Screen closing/opening control for warm/cold days"
  Modelica.SIunits.Time entryTime=0 annotation(Dialog(group="Varying inputs"));
  parameter Boolean warmDay=true "True if warm day, False if cold day";
  parameter Boolean opening=true "True if opening, False if closing";
  Modelica.Blocks.Sources.Constant start_closed(k=1)
    annotation (Placement(transformation(extent={{-80,60},{-60,80}})));
  Greenhouse.ControlSystems.Climate.Utilities.Ramp o1(
    duration=60,
    startTime=entryTime + 0,
    height=-0.01)
    annotation (Placement(transformation(extent={{-80,40},{-70,50}})));
  Greenhouse.ControlSystems.Climate.Utilities.Ramp o2(
    duration=60,
    startTime=entryTime + 4*60,
    height=-0.02)
    annotation (Placement(transformation(extent={{-60,40},{-50,50}})));
  Greenhouse.ControlSystems.Climate.Utilities.Ramp o3(
    duration=60,
    startTime=entryTime + 8*60,
    height=-0.03)
    annotation (Placement(transformation(extent={{-40,40},{-30,50}})));
  Greenhouse.ControlSystems.Climate.Utilities.Ramp o4(
    duration=60,
    startTime=entryTime + 12*60,
    height=-0.04)
    annotation (Placement(transformation(extent={{-20,40},{-10,50}})));
  Greenhouse.ControlSystems.Climate.Utilities.Ramp o5(
    duration=60,
    startTime=entryTime + 16*60,
    height=-0.04)
    annotation (Placement(transformation(extent={{0,40},{10,50}})));
  Greenhouse.ControlSystems.Climate.Utilities.Ramp o6(
    duration=60,
    startTime=entryTime + 20*60,
    height=-0.05)
    annotation (Placement(transformation(extent={{20,40},{30,50}})));
  Greenhouse.ControlSystems.Climate.Utilities.Ramp o7(
    duration=60,
    startTime=entryTime + 24*60,
    height=-0.05)
    annotation (Placement(transformation(extent={{40,40},{50,50}})));
  Greenhouse.ControlSystems.Climate.Utilities.Ramp o8(
    duration=60,
    startTime=entryTime + 28*60,
    height=-0.06)
    annotation (Placement(transformation(extent={{60,40},{70,50}})));
  Greenhouse.ControlSystems.Climate.Utilities.Ramp o9(
    duration=60,
    startTime=entryTime + 32*60,
    height=-0.7)
    annotation (Placement(transformation(extent={{80,40},{90,50}})));
  Modelica.Blocks.Sources.RealExpression open_warmDays(y=start_closed.y + o1.y +
        o2.y + o3.y + o4.y + o5.y + o6.y + o7.y + o8.y + o9.y)
    annotation (Placement(transformation(extent={{-80,8},{8,32}})));
  Modelica.Blocks.Sources.RealExpression close_warmDays(y=start_open.y - o9.y -
        o8.y - o7.y - o6.y - o5.y - o4.y - o3.y - o2.y - o1.y)
    annotation (Placement(transformation(extent={{-80,-8},{14,16}})));
  Greenhouse.ControlSystems.Climate.Utilities.Ramp c1(
    duration=60,
    startTime=entryTime + 0,
    height=-0.01)
    annotation (Placement(transformation(extent={{-80,-26},{-74,-20}})));
  Greenhouse.ControlSystems.Climate.Utilities.Ramp c2(
    duration=60,
    startTime=entryTime + 4*60,
    height=-0.01)
    annotation (Placement(transformation(extent={{-70,-26},{-64,-20}})));
  Greenhouse.ControlSystems.Climate.Utilities.Ramp c3(
    duration=60,
    startTime=entryTime + 8*60,
    height=-0.01)
    annotation (Placement(transformation(extent={{-60,-26},{-54,-20}})));
  Greenhouse.ControlSystems.Climate.Utilities.Ramp c4(
    duration=60,
    startTime=entryTime + 12*60,
    height=-0.01)
    annotation (Placement(transformation(extent={{-50,-26},{-44,-20}})));
  Greenhouse.ControlSystems.Climate.Utilities.Ramp c5(
    duration=60,
    startTime=entryTime + 16*60,
    height=-0.02)
    annotation (Placement(transformation(extent={{-40,-26},{-34,-20}})));
  Greenhouse.ControlSystems.Climate.Utilities.Ramp c6(
    duration=60,
    startTime=entryTime + 20*60,
    height=-0.02)
    annotation (Placement(transformation(extent={{-30,-26},{-24,-20}})));
  Greenhouse.ControlSystems.Climate.Utilities.Ramp c7(
    duration=60,
    startTime=entryTime + 24*60,
    height=-0.02)
    annotation (Placement(transformation(extent={{-20,-26},{-14,-20}})));
  Greenhouse.ControlSystems.Climate.Utilities.Ramp c8(
    duration=60,
    startTime=entryTime + 28*60,
    height=-0.03)
    annotation (Placement(transformation(extent={{-10,-26},{-4,-20}})));
  Greenhouse.ControlSystems.Climate.Utilities.Ramp c9(
    duration=60,
    startTime=entryTime + 32*60,
    height=-0.03)
    annotation (Placement(transformation(extent={{0,-26},{6,-20}})));
  Greenhouse.ControlSystems.Climate.Utilities.Ramp c10(
    duration=60,
    height=-0.04,
    startTime=entryTime + 36*60)
    annotation (Placement(transformation(extent={{10,-26},{16,-20}})));
  Greenhouse.ControlSystems.Climate.Utilities.Ramp c11(
    duration=60,
    height=-0.04,
    startTime=entryTime + 40*60)
    annotation (Placement(transformation(extent={{20,-26},{26,-20}})));
  Greenhouse.ControlSystems.Climate.Utilities.Ramp c12(
    duration=60,
    height=-0.04,
    startTime=entryTime + 44*60)
    annotation (Placement(transformation(extent={{30,-26},{36,-20}})));
  Greenhouse.ControlSystems.Climate.Utilities.Ramp c13(
    duration=60,
    height=-0.04,
    startTime=entryTime + 48*60)
    annotation (Placement(transformation(extent={{40,-26},{46,-20}})));
  Greenhouse.ControlSystems.Climate.Utilities.Ramp c14(
    duration=60,
    height=-0.68,
    startTime=entryTime + 52*60)
    annotation (Placement(transformation(extent={{50,-26},{56,-20}})));
  Modelica.Blocks.Sources.Constant start_open(k=0)
    annotation (Placement(transformation(extent={{-40,60},{-20,80}})));
  Modelica.Blocks.Sources.RealExpression open_coldDays(y=start_closed.y +
        c1.y + c2.y + c3.y + c4.y + c5.y + c6.y + c7.y + c8.y + c9.y + c10.y
         + c11.y + c12.y + c13.y + c14.y)
    annotation (Placement(transformation(extent={{-80,-52},{50,-28}})));
  Modelica.Blocks.Sources.RealExpression close_coldDays(y=start_open.y -
        c15.y - c16.y - c17.y - c18.y - c19.y - c20.y - c21.y - c22.y - c23.y
         - c24.y - c25.y - c26.y - c27.y - c28.y)
    annotation (Placement(transformation(extent={{-80,-96},{46,-72}})));
  Modelica.Blocks.Interfaces.RealOutput y "Connector of Real output signal"
    annotation (Placement(transformation(extent={{100,-10},{120,10}}, rotation=0)));
  Greenhouse.ControlSystems.Climate.Utilities.Ramp c15(
    duration=60,
    startTime=entryTime + 0,
    height=-0.68)
    annotation (Placement(transformation(extent={{-80,-68},{-74,-62}})));
  Greenhouse.ControlSystems.Climate.Utilities.Ramp c16(
    duration=60,
    startTime=entryTime + 4*60,
    height=-0.04)
    annotation (Placement(transformation(extent={{-70,-68},{-64,-62}})));
  Greenhouse.ControlSystems.Climate.Utilities.Ramp c17(
    duration=60,
    startTime=entryTime + 8*60,
    height=-0.04)
    annotation (Placement(transformation(extent={{-60,-68},{-54,-62}})));
  Greenhouse.ControlSystems.Climate.Utilities.Ramp c18(
    duration=60,
    startTime=entryTime + 12*60,
    height=-0.04)
    annotation (Placement(transformation(extent={{-50,-68},{-44,-62}})));
  Greenhouse.ControlSystems.Climate.Utilities.Ramp c19(
    duration=60,
    startTime=entryTime + 16*60,
    height=-0.04)
    annotation (Placement(transformation(extent={{-40,-68},{-34,-62}})));
  Greenhouse.ControlSystems.Climate.Utilities.Ramp c20(
    duration=60,
    startTime=entryTime + 20*60,
    height=-0.03)
    annotation (Placement(transformation(extent={{-30,-68},{-24,-62}})));
  Greenhouse.ControlSystems.Climate.Utilities.Ramp c21(
    duration=60,
    startTime=entryTime + 24*60,
    height=-0.03)
    annotation (Placement(transformation(extent={{-20,-68},{-14,-62}})));
  Greenhouse.ControlSystems.Climate.Utilities.Ramp c22(
    duration=60,
    startTime=entryTime + 28*60,
    height=-0.02)
    annotation (Placement(transformation(extent={{-10,-68},{-4,-62}})));
  Greenhouse.ControlSystems.Climate.Utilities.Ramp c23(
    duration=60,
    startTime=entryTime + 32*60,
    height=-0.02)
    annotation (Placement(transformation(extent={{0,-68},{6,-62}})));
  Greenhouse.ControlSystems.Climate.Utilities.Ramp c24(
    duration=60,
    startTime=entryTime + 36*60,
    height=-0.02)
    annotation (Placement(transformation(extent={{10,-68},{16,-62}})));
  Greenhouse.ControlSystems.Climate.Utilities.Ramp c25(
    duration=60,
    startTime=entryTime + 40*60,
    height=-0.01)
    annotation (Placement(transformation(extent={{20,-68},{26,-62}})));
  Greenhouse.ControlSystems.Climate.Utilities.Ramp c26(
    duration=60,
    startTime=entryTime + 44*60,
    height=-0.01)
    annotation (Placement(transformation(extent={{30,-68},{36,-62}})));
  Greenhouse.ControlSystems.Climate.Utilities.Ramp c27(
    duration=60,
    startTime=entryTime + 48*60,
    height=-0.01)
    annotation (Placement(transformation(extent={{40,-68},{46,-62}})));
  Greenhouse.ControlSystems.Climate.Utilities.Ramp c28(
    duration=60,
    startTime=entryTime + 52*60,
    height=-0.01)
    annotation (Placement(transformation(extent={{50,-68},{56,-62}})));
equation
  if warmDay then
    if opening then
      y=open_warmDays.y;
    else
      y=close_warmDays.y;
    end if;
  else
    if opening then
      y=open_coldDays.y;
    else
      y=close_coldDays.y;
    end if;
  end if;

  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
            {100,100}}), graphics={Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
      Line(
        points={{-66,-46},{-40,-46},{-40,-4},{-14,-4},{-14,20},{6,20},{6,60},{30,
              60},{30,16},{50,16},{50,-4},{56,-4},{56,-4},{74,-4}},
        color={0,0,0})}), Diagram(coordinateSystem(preserveAspectRatio=
            false, extent={{-100,-100},{100,100}}), graphics));
end SC_opening_closing;
