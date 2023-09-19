within Greenhouses.Flows.FluidFlow;
model Pdrop "Linear pressure drop"
  extends Greenhouses.Icons.Water.PressDrop;
  replaceable package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater constrainedby
    Modelica.Media.Interfaces.PartialMedium "Medium in the component"
      annotation (choicesAllMatching = true);
   /* Define the type of pressure drop */
  import Greenhouses.Functions.Enumerations.PressureDrops;
  parameter PressureDrops DPtype=PressureDrops.UD;
  parameter Modelica.Units.SI.Pressure p_su_start=1e5 "Inlet pressure start value"
    annotation (Dialog(tab="Initialization"));
  parameter Modelica.Units.SI.Pressure DELTAp_start=10000
    "Start value for the pressure drop" annotation (Dialog(tab="Initialization"));
  parameter Modelica.Units.SI.MassFlowRate Mdot_start=0.1
    "Mass flow rate initial value" annotation (Dialog(tab="Initialization"));
  parameter Modelica.Units.SI.MassFlowRate Mdot_max=0.1 "flow rate at DELTAp_max";
  parameter Modelica.Units.SI.Pressure DELTAp_max=20E5 "Pressure drop at Mdot_max";
  /* Variables */
  Modelica.Units.SI.MassFlowRate Mdot(start=Mdot_start);
  Modelica.Units.SI.Pressure DELTAp(start=DELTAp_start);
  Modelica.Fluid.Interfaces.FluidPort_a InFlow(
                                              redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{-100,-10},{-80,10}})));
  Modelica.Fluid.Interfaces.FluidPort_b OutFlow(
                                               redeclare package Medium =
        Medium)
    annotation (Placement(transformation(extent={{80,-10},{100,10}})));
equation
  InFlow.m_flow + OutFlow.m_flow = 0 "Mass balance";
    if (DPtype == PressureDrops.ORCnextHP) then
    DELTAp = Greenhouses.Functions.TestRig.PressureDropCorrelation_HP(M_flow=
      Mdot);
    DELTAp = InFlow.p - OutFlow.p;
    elseif (DPtype == PressureDrops.ORCnextLP) then
    DELTAp = Greenhouses.Functions.TestRig.PressureDropCorrelation_LP(M_flow=
      Mdot);
    DELTAp = InFlow.p - OutFlow.p;
    else
     DELTAp = InFlow.p - OutFlow.p;
     Mdot = Mdot_max*DELTAp/DELTAp_max;
     end if;
  /* BOUNDARY CONDITIONS */
  Mdot = InFlow.m_flow;
  InFlow.h_outflow = inStream(OutFlow.h_outflow);
  inStream(InFlow.h_outflow) = OutFlow.h_outflow;
initial equation

  annotation (
    Icon(coordinateSystem(preserveAspectRatio=true,  extent={{-120,-120},{
            120,120}}),
                    graphics={Text(extent={{-100,-40},{100,-74}}, textString=
              "%name")}),
    Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-120,-120},
            {120,120}})),
    Documentation(info="<HTML>
    <p>This very simple model assumes a non-compressible flow for computing the pressure drop</p>
    <p>This model is an adapted version of the model Pdrop from ThermoCycle Library. In order to make it compatible with the Greenhouses library, the fluid ports have been replaced by the Modelica Standard Library fluidPort. </p>
</HTML>",
        uses(Modelica(version="3.2"))));
end Pdrop;
