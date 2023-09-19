within Greenhouses.Components.HVAC;
model HeatPump
  "Performance-based model of a heat pump in which we consider a constant secondary-law efficiency and a linear correlation between the nominal power and temperature"

  replaceable package Medium =
      Modelica.Media.Water.ConstantPropertyLiquidWater                          constrainedby
    Modelica.Media.Interfaces.PartialMedium "Medium in the component"
      annotation (choicesAllMatching = true);

  parameter Modelica.Units.SI.Volume V=0.005 "Internal volume";
  parameter Modelica.Units.SI.Area A=10 "Heat exchange area";
  parameter Real eta_II = 0.4 "Second law efficiency of the HP";
  parameter Modelica.Units.SI.Time tau=60 "Start-up time constant";
  parameter Modelica.Units.SI.Power Qdot_nom=10E3 "Nominal heating capacity";
  parameter Modelica.Units.SI.Temperature Th_nom=35 + 273.15
    "Nominal heat sink temperature";
  parameter Modelica.Units.SI.Temperature Tc_nom=273.15
    "Nominal heat source temperature";
  parameter Modelica.Units.SI.Mass M_wall=69
    "Mass of the metal wall between the two fluids";
  parameter Modelica.Units.SI.SpecificHeatCapacity c_wall=500
    "Specific heat capacity of metal wall";
  parameter Modelica.Units.SI.Temperature Th_start=35 + 273.15
    "Start value for the condenser temperature"
    annotation (Dialog(tab="Initialization"));
  parameter Modelica.Units.SI.Temperature Tmax=273.15 + 100
    "Maximum temperature at the outlet";
  Real COP;
  Real COP_nom;
  Modelica.Units.SI.Power Wdot;
  Modelica.Units.SI.Power Wdot_nom;
  Modelica.Units.SI.Power Qdot;
  Modelica.Units.SI.Temperature Th;
  Modelica.Units.SI.Power Wdot_in;

  Flows.FluidFlow.Cell1DimInc                        fluid(
    redeclare package Medium = Medium,
    Mdotnom=0.1,
    Vi=V,
    Ai=A,
    hstart=Medium.specificEnthalpy_pTX(1E5, Th_start, Medium.reference_X),
    Unom=1000,
    redeclare model HeatTransfer =
        Greenhouses.Flows.FluidFlow.HeatTransfer.Constant,
    pstart=10000000000,
    Discretization=Greenhouses.Functions.Enumerations.Discretizations.upwind_AllowFlowReversal)
                        annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=90,
        origin={-50,6})));

  Modelica.Fluid.Interfaces.FluidPort_a
                           InFlow(redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{-90,-48},{-70,-28}}),
        iconTransformation(extent={{-100,-76},{-80,-56}})));
  Modelica.Fluid.Interfaces.FluidPort_b
                           OutFlow(redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{-92,58},{-72,78}}),
        iconTransformation(extent={{-100,58},{-80,78}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a HeatSource
    annotation (Placement(transformation(extent={{80,-14},{100,6}}),
        iconTransformation(extent={{90,-4},{100,6}})));
  Interfaces.Heat.HeatPortConverter heatPortConverter(A=A, N=1)
    annotation (Placement(transformation(extent={{-14,-4},{-34,16}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow prescribedHeatFlow
    annotation (Placement(transformation(extent={{28,-4},{8,16}})));
  Modelica.Blocks.Interfaces.BooleanInput on_off annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={0,-100}), iconTransformation(
        extent={{-6,-6},{6,6}},
        rotation=90,
        origin={0,-96})));
  Modelica.Blocks.Continuous.FirstOrder firstOrder(T=tau)
    annotation (Placement(transformation(extent={{-6,42},{14,62}})));
equation
  Th = fluid.Wall_int.T;
  //Th = fluid.fluidState.T;   // this does not take the heat transfer into account
  COP_nom = eta_II * Th_nom/(Th_nom - Tc_nom);
  Wdot_nom = Qdot_nom/COP_nom;
  COP = eta_II* Th/ (Th - HeatSource.T);
  Qdot/Qdot_nom = HeatSource.T/Tc_nom;   // rough approximation
  Wdot = Qdot/COP;
  HeatSource.Q_flow = Qdot - Wdot;

  Wdot_in = firstOrder.y*firstOrder.u* Wdot;
  prescribedHeatFlow.Q_flow = firstOrder.y*firstOrder.u* Qdot;
  if cardinality(on_off)==0 then
    on_off = true "Pressure set by parameter";
  end if;
  assert(fluid.T < Tmax,"Maximum temperature reached at the heat pump outlet");
  firstOrder.u= if on_off then 1 else 0;

  connect(InFlow, fluid.OutFlow) annotation (Line(
      points={{-80,-38},{-50,-38},{-50,-4},{-49.9,-4}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(OutFlow, fluid.InFlow) annotation (Line(
      points={{-82,68},{-50,68},{-50,16}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(fluid.Wall_int, heatPortConverter.thermalPortL) annotation (Line(
      points={{-45,6},{-34,6}},
      color={255,0,0},
      smooth=Smooth.None));
  connect(heatPortConverter.heatPort, prescribedHeatFlow.port) annotation (Line(
      points={{-14,6},{8,6}},
      color={191,0,0},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}})),           Icon(coordinateSystem(
          preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics=
         {
        Polygon(
          points={{-10,20},{10,20},{-10,-20},{10,-20},{-10,20}},
          lineColor={0,0,0},
          smooth=Smooth.None,
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid,
          origin={0,80},
          rotation=-90),
        Polygon(
          points={{20,20},{-20,20},{-10,-20},{10,-20},{20,20}},
          lineColor={0,0,0},
          smooth=Smooth.None,
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid,
          origin={0,-80},
          rotation=-90),
        Rectangle(extent={{-96,40},{-70,-40}}, lineColor={0,0,0}),
        Rectangle(extent={{70,40},{96,-40}}, lineColor={0,0,0}),
        Line(
          points={{-20,80},{-76,80},{-76,40}},
          color={0,0,0},
          smooth=Smooth.None),
        Line(
          points={{-76,-40},{-76,-80},{-20,-80}},
          color={0,0,0},
          smooth=Smooth.None),
        Line(
          points={{20,-80},{76,-80},{76,-40}},
          color={0,0,0},
          smooth=Smooth.None),
        Line(
          points={{76,40},{76,80},{20,80}},
          color={0,0,0},
          smooth=Smooth.None),
        Rectangle(
          extent={{-92,60},{-88,40}},
          lineColor={0,128,255},
          fillPattern=FillPattern.Solid,
          fillColor={0,128,255}),
        Rectangle(
          extent={{-92,-40},{-88,-60}},
          lineColor={0,128,255},
          fillPattern=FillPattern.Solid,
          fillColor={0,128,255})}),
    Documentation(info="<html>
    <p><big>This heat pump model does not consider part-load operation (ON/OFF regulation is assumed). The heating power and the heat soure temperature are computed by assuming a linear correlation between their actual and nominal values. The electrical efficiency is computed assuming a constant second-law efficiency, parameter of the model.</p>
    <p><big>The primary fluid is modeled by means of 1-D incompressible fluid flow model (<a href=\"modelica://Greenhouses.Flows.FluidFlow.Cell1DimInc\">Cell1DimInc</a>), in which a dynamic energy balance and static mass and momentum balances are applied on the fluid. The heat transfer in the primary fluid is modeled with a constant heat transfer coefficient. However, it can be changed to other heat transfer models through the HeatTransfer parameter in the fluid model.</p>
    <p><big>Furthermore, the model includes a Boolean input connector <i>on_off</i>, which defines the operational state of the heat pump. In the equations, the Boolean input is translated to a variable value together with a first order block, which can take into account a start-up time constraint.</p>
</html>"));
end HeatPump;
