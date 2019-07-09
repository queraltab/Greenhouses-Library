within Greenhouses.Components.HVAC;
model CHP
  //replaceable package Medium = Modelica.Media.Water.WaterIF97_ph;
  replaceable package Medium =
      Modelica.Media.Water.ConstantPropertyLiquidWater                          constrainedby
    Modelica.Media.Interfaces.PartialMedium "Medium in the component"
      annotation (choicesAllMatching = true);
  parameter Modelica.SIunits.Volume V=0.005 "Internal volume";
  parameter Modelica.SIunits.Area A = 10 "Heat exchange area";
  //parameter Real eta_II = 0.4 "Second law efficiency of the CHP";
  parameter Modelica.SIunits.MassFlowRate Mdotnom=10
    "Nominal mass flow rate of the working fluid";
  parameter Real eta_tot = 0.9 "Total efficiency of the CHP";
  parameter Modelica.SIunits.Time tau = 60 "Start-up time constant";
  parameter Modelica.SIunits.Temperature Th_start = 500+273.15
    "Start value for the condenser temperature"      annotation(Dialog(tab="Initialization"));
  parameter Modelica.SIunits.Temperature Tmax = 273.15 + 100
    "Maximum temperature at the outlet";
//   parameter Modelica.SIunits.Mass M_wall= 69
//     "Mass of the metal wall between the two fluids";
//   parameter Modelica.SIunits.SpecificHeatCapacity c_wall= 500
//     "Specific heat capacity of metal wall";
  Real eta_el "Electrical efficiency of the CHP";
  Real eta_th "Thermal efficiency of the CHP";
  Modelica.SIunits.Power Wdot;
  Modelica.SIunits.Power Qdot;
  parameter Modelica.SIunits.Temperature Th_nom=500+273.15;
  Modelica.SIunits.Temperature Tc;
  Real LHV=1000;
  Modelica.SIunits.MassFlowRate Mdot_nom_fuel;
  Modelica.SIunits.Temperature T_water_ex_CHP;
  Modelica.SIunits.Power Qdot_gas;
  Real eta_el_nom "Nominal electrical efficiency of the CHP";
  Real eta_th_nom "Nominal thermal efficiency of the CHP";
  Real eta_II_nom;
  Modelica.SIunits.Temperature Th;
  Modelica.SIunits.Temperature Tc_nom;
  Flows.FluidFlow.Cell1DimInc                        fluid(
    redeclare package Medium = Medium,
    Vi=V,
    Ai=A,
    hstart=Medium.specificEnthalpy_pT(1E5, Th_start),
    Unom=1000,
    Discretization=Greenhouses.Functions.Enumerations.Discretizations.upwind_AllowFlowReversal,
    Mdotnom=Mdotnom,
    pstart=10000000000,
    redeclare model HeatTransfer = Flows.FluidFlow.HeatTransfer.Constant)
                        annotation (Placement(transformation(
        extent={{-8,8},{8,-8}},
        rotation=90,
        origin={-50,6})));
  Modelica.Fluid.Interfaces.FluidPort_a
                           InFlow(redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{-90,-48},{-70,-28}}),
        iconTransformation(extent={{-110,-92},{-90,-72}})));
  Modelica.Fluid.Interfaces.FluidPort_b
                           OutFlow(redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{-92,58},{-72,78}}),
        iconTransformation(extent={{-110,6},{-90,26}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a HeatSource
    annotation (Placement(transformation(extent={{14,24},{34,44}}),
        iconTransformation(extent={{26,34},{40,48}})));
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
        origin={2,-92})));
  Modelica.Blocks.Continuous.FirstOrder firstOrder(T=tau)
    annotation (Placement(transformation(extent={{-10,40},{10,60}})));
  Modelica.Blocks.Interfaces.RealOutput Wdot_el annotation (Placement(
        transformation(extent={{100,-60},{120,-40}}), iconTransformation(
          extent={{100,-60},{120,-40}})));
  Modelica.Fluid.Sensors.Temperature T_ex_CHP(redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{-38,40},{-22,52}})));
equation
  HeatSource.T = Th;
  //HeatSource.Q_flow = Mdot_nom_fuel*LHV;
  HeatSource.Q_flow * eta_tot = Qdot+Wdot;
  eta_th_nom = 0.5;
  eta_el_nom = 0.4;
  eta_II_nom = eta_el_nom / (1-Tc_nom/Th_nom);
  Th_nom=Th;
  Tc_nom=90+273.17;
  eta_th + eta_el = eta_tot;
  eta_el = eta_II_nom*(1-Tc/Th);
  Wdot = eta_el*Mdot_nom_fuel*LHV;
  Qdot = eta_th*Mdot_nom_fuel*LHV;
  Tc = T_water_ex_CHP;
  //T_water_ex_CHP = fluid.Wall_int.T;
  T_water_ex_CHP=T_ex_CHP.T;
  Wdot_el= firstOrder.y*firstOrder.u* Wdot;
  prescribedHeatFlow.Q_flow = firstOrder.y*firstOrder.u* Qdot;
  Qdot_gas = firstOrder.y*firstOrder.u* HeatSource.Q_flow;
  if cardinality(on_off)==0 then
    on_off = true "Pressure set by parameter";
  end if;
  assert(fluid.T < Tmax,"Maximum temperature reached at the heat pump outlet");
  firstOrder.u= if on_off then 1 else 0;
  connect(fluid.Wall_int, heatPortConverter.thermalPortL) annotation (Line(
      points={{-46,6},{-34,6}},
      color={255,0,0},
      smooth=Smooth.None));
  connect(heatPortConverter.heatPort, prescribedHeatFlow.port) annotation (Line(
      points={{-14,6},{8,6}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(InFlow, fluid.InFlow) annotation (Line(points={{-80,-38},{-50,-38},{-50,
          -2}}, color={0,127,255}));
  connect(fluid.OutFlow, OutFlow) annotation (Line(points={{-49.92,14},{-50,14},
          {-50,68},{-82,68}}, color={0,127,255}));
  connect(T_ex_CHP.port, OutFlow) annotation (Line(points={{-30,40},{-40,40},{-40,
          32},{-50,32},{-50,68},{-82,68}}, color={0,127,255}));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}})),           Icon(coordinateSystem(
          preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics={Bitmap(
            extent={{-100,-100},{100,100}}, fileName=
              "modelica://Greenhouses/Resources/Images/chp.png")}),
    experiment(StopTime=3600),
    __Dymola_experimentSetupOutput,
    Documentation(info="<html>
    <p><big>The CHP model does not consider part-load operation (ON/OFF regulation is assumed). Thus, constant natural gas consumption and total efficiency are assumed. The electrical efficiency is computed assuming a constant second-law efficiency, whose value is computed using the nominal operating conditions.</p>
    <p><big>The gas source is assumed to be at a constant temperature of 500ºC. The primary side fluid is modeled by means of 1-D incompressible fluid flow model (<a href=\"modelica://Greenhouses.Flows.FluidFlow.Cell1DimInc\">Cell1DimInc</a>), in which a dynamic energy balance and static mass and momentum balances are applied on the fluid. The heat transfer in the primary fluid is modeled with a constant heat transfer coefficient. However, it can be changed to other heat transfer models through the HeatTransfer parameter in the fluid model.</p>
    <p><big>Furthermore, the model includes a Boolean input connector <i>on_off</i>, which defines the operational state of the CHP. In the equations, the Boolean input is translated to a variable value together with a first order block, which can take into account a start-up time constraint. The model also includes a real output connector <i>Wdot_el</i>, which outputs the value of the generated electrical power. This connector is useful, for example, in the case where a heat pump is powered by the CHP.</p>
</html>"));
end CHP;
