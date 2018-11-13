within Greenhouses.ControlSystems.Climate;
model Uvents_RH_T_Mdot
  "Controller for window's opening. The control is based on keeping humidity and temperature below the allowed limit."
  import Greenhouse = Greenhouses;
  Real RH_air_input=0.75
    "If connector not used, input here the relative humidity of the air"                      annotation(Dialog(group="Varying inputs"));
  Modelica.SIunits.Temperature T_air=293.15 annotation(Dialog(group="Varying inputs"));
  Modelica.SIunits.Temperature T_air_sp=293.15 annotation(Dialog(group="Varying inputs"));

  Modelica.SIunits.MassFlowRate Mdot=0.528 annotation(Dialog(group="Varying inputs"));

  Modelica.SIunits.Temperature Tmax_tomato=299.15;
  parameter Real U_max=1;
  Modelica.Blocks.Interfaces.RealOutput y
    annotation (Placement(transformation(extent={{100,-10},{120,10}}),
        iconTransformation(extent={{100,-10},{120,10}})));
  Modelica.Blocks.Interfaces.RealInput RH_air
    annotation (Placement(transformation(extent={{-120,40},{-80,80}})));
  Greenhouse.ControlSystems.PID                   PID(
    PVstart=0.5,
    CSstart=0.5,
    PVmax=1,
    CSmin=0,
    steadyStateInit=false,
    Ti=650,
    PVmin=0.1,
    CSmax=U_max,
    Kp=-0.1)
    annotation (Placement(transformation(extent={{-20,54},{0,74}})));
  Modelica.Blocks.Sources.Constant RH_max(k=0.85)
    annotation (Placement(transformation(extent={{-60,74},{-40,94}})));
  Greenhouse.ControlSystems.PID                   PIDT(
    PVstart=0.5,
    CSstart=0.5,
    CSmin=0,
    steadyStateInit=false,
    Ti=500,
    Kp=-0.5,
    PVmax=30 + 273.15,
    PVmin=12 + 273.15,
    CSmax=U_max)
    annotation (Placement(transformation(extent={{-20,-20},{0,0}})));
  Greenhouse.ControlSystems.PID                   PIDT_noH(
    PVstart=0.5,
    CSstart=0.5,
    CSmin=0,
    steadyStateInit=false,
    Ti=500,
    Kp=-0.5,
    PVmin=12 + 273.15,
    PVmax=30 + 273.15,
    CSmax=U_max)
             annotation (Placement(transformation(extent={{-20,-80},{0,-60}})));
  Modelica.Blocks.Sources.RealExpression Tair_setpoint(y=Tmax_tomato)
    annotation (Placement(transformation(extent={{-60,-6},{-40,14}})));
  Modelica.Blocks.Sources.RealExpression Tair_setpoint1(y=T_air_sp + 2)
    annotation (Placement(transformation(extent={{-60,-66},{-40,-46}})));
equation
  if cardinality(RH_air)==0 then
    RH_air=RH_air_input;
  end if;

  PID.PV=RH_air;
  PIDT.PV=T_air;
  PIDT_noH.PV=T_air;

  y = 1/(1+exp(-200*(Mdot-0.05)))*max(PID.CS,PIDT.CS) + 1/(1+exp(200*(Mdot-0.05)))*max(PID.CS,PIDT_noH.CS);

  connect(RH_max.y, PID.SP) annotation (Line(
      points={{-39,84},{-30,84},{-30,68},{-20,68}},
      color={0,0,127},
      smooth=Smooth.Bezier));
  connect(Tair_setpoint1.y, PIDT_noH.SP) annotation (Line(
      points={{-39,-56},{-28,-56},{-28,-66},{-20,-66}},
      color={0,0,127},
      smooth=Smooth.Bezier));
  connect(Tair_setpoint.y, PIDT.SP) annotation (Line(
      points={{-39,4},{-30,4},{-30,-6},{-20,-6}},
      color={0,0,127},
      smooth=Smooth.Bezier));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
            {100,100}}), graphics={Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={0,0,127},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid), Text(
          extent={{-100,32},{100,-40}},
          lineColor={0,0,127},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          textString="vents")}),      Diagram(coordinateSystem(
          preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics));
end Uvents_RH_T_Mdot;
