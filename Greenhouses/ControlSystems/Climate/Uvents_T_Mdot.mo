within Greenhouses.ControlSystems.Climate;
model Uvents_T_Mdot
  "PI for the window's opening. The control is based on the maximum air temperature allowed in the greenhouse."
  Modelica.Units.SI.Temperature T_air=293.15 annotation (Dialog(group="Varying inputs"));
  Modelica.Units.SI.Temperature T_air_sp=293.15
    annotation (Dialog(group="Varying inputs"));

  Modelica.Units.SI.MassFlowRate Mdot=0.528 annotation (Dialog(group="Varying inputs"));

  Modelica.Units.SI.Temperature Tmax_tomato=299.15;
  parameter Real U_max=1;
  Modelica.Blocks.Interfaces.RealOutput y
    annotation (Placement(transformation(extent={{100,-10},{120,10}}),
        iconTransformation(extent={{100,-10},{120,10}})));
  PID                                             PIDT(
    PVstart=0.5,
    CSstart=0.5,
    CSmin=0,
    steadyStateInit=false,
    Ti=500,
    Kp=-0.5,
    PVmax=30 + 273.15,
    PVmin=12 + 273.15,
    CSmax=U_max)
    annotation (Placement(transformation(extent={{-8,14},{12,34}})));
  PID                                             PIDT_noH(
    PVstart=0.5,
    CSstart=0.5,
    CSmin=0,
    steadyStateInit=false,
    Ti=500,
    Kp=-0.5,
    PVmin=12 + 273.15,
    PVmax=30 + 273.15,
    CSmax=U_max)
             annotation (Placement(transformation(extent={{-8,-46},{12,-26}})));
  Modelica.Blocks.Sources.RealExpression Tair_setpoint(y=Tmax_tomato)
    annotation (Placement(transformation(extent={{-48,28},{-28,48}})));
  Modelica.Blocks.Sources.RealExpression Tair_setpoint1(y=T_air_sp + 2)
    annotation (Placement(transformation(extent={{-48,-32},{-28,-12}})));
equation

  PIDT.PV=T_air;
  PIDT_noH.PV=T_air;

  y = 1/(1+exp(-200*(Mdot-0.05)))*PIDT.CS + 1/(1+exp(200*(Mdot-0.05)))*PIDT_noH.CS;

  connect(Tair_setpoint1.y, PIDT_noH.SP) annotation (Line(
      points={{-27,-22},{-16,-22},{-16,-32},{-8,-32}},
      color={0,0,127},
      smooth=Smooth.Bezier));
  connect(Tair_setpoint.y, PIDT.SP) annotation (Line(
      points={{-27,38},{-18,38},{-18,28},{-8,28}},
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
end Uvents_T_Mdot;
