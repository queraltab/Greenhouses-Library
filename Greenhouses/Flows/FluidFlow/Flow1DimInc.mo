within Greenhouses.Flows.FluidFlow;
model Flow1DimInc
  "1-D fluid flow model (finite volume discretization - incompressible fluid model). Based on the Cell component"
  import Greenhouse = Greenhouses;
  replaceable package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater constrainedby
    Modelica.Media.Interfaces.PartialMedium "Medium in the component"
      annotation (choicesAllMatching = true);
public
 record SummaryClass
    replaceable Arrays T_profile;
    record Arrays
    parameter Integer n;
      Modelica.Units.SI.Temperature[n] T_cell;
    end Arrays;
    parameter Integer n;
    Modelica.Units.SI.SpecificEnthalpy[n] h;
    Modelica.Units.SI.Temperature[n] T;
    Modelica.Units.SI.SpecificEnthalpy[n + 1] hnode;
    Modelica.Units.SI.Density[n] rho;
    Modelica.Units.SI.MassFlowRate Mdot;
    Modelica.Units.SI.Pressure p;
 end SummaryClass;
 SummaryClass Summary(T_profile(n=N, T_cell = Cells[:].T), n=N, h = Cells[:].h, hnode = hnode_, rho = Cells.rho, T = Cells.T, Mdot = InFlow.m_flow, p = Cells[1].p);
/************ Thermal and fluid ports ***********/
  Modelica.Fluid.Interfaces.FluidPort_a
                                      InFlow(redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{-100,-10},{-80,10}}),
        iconTransformation(extent={{-120,-20},{-80,20}})));
  Modelica.Fluid.Interfaces.FluidPort_b
                                      OutFlow(redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{80,-10},{100,10}}),
        iconTransformation(extent={{80,-20},{120,20}})));
/************ Geometric characteristics **************/
  parameter Integer Nt(min=1)=1 "Number of cells in parallel";
  constant Real pi = Modelica.Constants.pi "pi-greco";
  parameter Integer N(min=1)=10 "Number of cells";
  parameter Modelica.Units.SI.Area A=16.18
    "Lateral surface of the tube: heat exchange area";
  parameter Modelica.Units.SI.Volume V=0.03781 "Volume of the tube";
  parameter Modelica.Units.SI.MassFlowRate Mdotnom=0.2588 "Nominal fluid flow rate";
  parameter Modelica.Units.SI.CoefficientOfHeatTransfer Unom
    "if HTtype = Const: Heat transfer coefficient";
 /********************************* FLUID INITIAL VALUES ******************************/
  parameter Modelica.Units.SI.Pressure pstart "Fluid pressure start value"
    annotation (Dialog(tab="Initialization"));
  parameter Medium.Temperature Tstart_inlet "Inlet temperature start value"
     annotation (Dialog(tab="Initialization"));
  parameter Medium.Temperature Tstart_outlet "Outlet temperature start value"
     annotation (Dialog(tab="Initialization"));
  parameter Medium.SpecificEnthalpy hstart[N]=linspace(
        Medium.specificEnthalpy_pTX(pstart,Tstart_inlet,Medium.reference_X),Medium.specificEnthalpy_pTX(pstart,Tstart_outlet,Medium.reference_X),
        N) "Start value of enthalpy vector (initialized by default)"
    annotation (Dialog(tab="Initialization"));
/***************************************   NUMERICAL OPTIONS  ***************************************************/
  import Greenhouses.Functions.Enumerations.Discretizations;
  parameter Discretizations Discretization=Greenhouse.Functions.Enumerations.Discretizations.centr_diff
    "Selection of the spatial discretization scheme"  annotation (Dialog(tab="Numerical options"));
  parameter Boolean steadystate=true
    "if true, sets the derivative of h (working fluids enthalpy in each cell) to zero during Initialization"
    annotation (Dialog(group="Initialization options", tab="Initialization"));
  /******************************* HEAT TRANSFER MODEL **************************************/
replaceable model Flow1DimIncHeatTransferModel =
    Greenhouses.Flows.FluidFlow.HeatTransfer.MassFlowDependence
constrainedby
    Greenhouses.Flows.FluidFlow.HeatTransfer.BaseClasses.PartialHeatTransferZones
    "Fluid heat transfer model" annotation (choicesAllMatching = true);
/***************  VARIABLES ******************/
  Modelica.Units.SI.Power Q_tot "Total heat flux exchanged by the thermal port";
  Modelica.Units.SI.Mass M_tot "Total mass of the fluid in the component";
  /********************************** CELLS *****************************************/
 Greenhouses.Flows.FluidFlow.Cell1DimInc Cells[N](
    redeclare package Medium = Medium,
    redeclare each final model HeatTransfer = Flow1DimIncHeatTransferModel,
    each Vi=V/N,
    each Ai=A/N,
    each Nt=Nt,
    each Mdotnom=Mdotnom,
    each Unom=Unom,
    each pstart=pstart,
    each Discretization=Discretization,
    hstart=hstart,
    each steadystate=steadystate)
    annotation (Placement(transformation(extent={{-26,-62},{28,-18}})));
  Greenhouses.Interfaces.Heat.ThermalPortConverter thermalPortConverter(N=N)
    annotation (Placement(transformation(extent={{-8,-4},{10,22}})));
protected
  Modelica.Units.SI.SpecificEnthalpy hnode_[N + 1];
  /*************************************** EQUATION *************************************/
public
  Greenhouse.Interfaces.Heat.HeatPortConverter_ThermoCycle_Modelica
    heatPort_ThermoCycle_Modelica(
    N=N,
    A=A,
    Nt=Nt) annotation (Placement(transformation(extent={{-8,44},{12,64}})));
public
  Greenhouse.Interfaces.Heat.HeatPorts_a[N] heatPorts_a annotation (Placement(
        transformation(extent={{-8,72},{12,92}}), iconTransformation(extent={{-40,
            40},{40,60}})));
equation
  // Connect wall and refrigerant cells with eachother
  for i in 1:N-1 loop
    connect(Cells[i].OutFlow, Cells[i+1].InFlow);
  end for;
  hnode_[1:N] = Cells.hnode_su;
  hnode_[N+1] = Cells[N].hnode_ex;
  Q_tot = A/N*sum(Cells.qdot)*Nt "Total heat flow through the thermal port";
  M_tot = V/N*sum(Cells.rho);
  connect(InFlow, Cells[1].InFlow) annotation (Line(
      points={{-90,0},{-60,0},{-60,-40},{-26,-40}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(thermalPortConverter.single, Cells.Wall_int) annotation (Line(
      points={{1,3.67},{2,-16},{1,-29}},
      color={255,0,0},
      smooth=Smooth.None));
  connect(Cells[N].OutFlow, OutFlow) annotation (Line(
      points={{28,-39.78},{50,-39.78},{50,0},{90,0}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(heatPort_ThermoCycle_Modelica.thermocyclePort, thermalPortConverter.multi)
    annotation (Line(
      points={{2,51},{2,13.55},{1,13.55}},
      color={255,0,0},
      smooth=Smooth.None));
  connect(heatPort_ThermoCycle_Modelica.heatPorts, heatPorts_a) annotation (
      Line(
      points={{2,57},{2,82}},
      color={127,0,0},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false,extent={{-120,-120},
            {120,120}})),        Icon(coordinateSystem(preserveAspectRatio=false,
                  extent={{-120,-120},{120,120}}),
                                      graphics={Rectangle(
          extent={{-92,40},{88,-40}},
          lineColor={0,0,255},
          fillColor={170,213,255},
          fillPattern=FillPattern.Solid)}),Documentation(info="<html>
          <p>This model is a variation of the Flow1DimInc model from the ThermoCycle Library. In order to make it compatible with the Greenhouses library, the following changes have been added:</p>
          <ul><li>The fluid ports have been replaced by the Modelica Standard Library fluidPort.
          <li>The heat port has been replaced by the Modelica Standard Library heatPort.
          </ul>
<p>This model describes the flow of incompressible fluid through a discretized one dimensional tube. It is obtained by connecting in series <b>N</b> <a href=\"modelica://ThermoCycle.Components.FluidFlow.Pipes.Cell1DimInc\">Cell1DimInc</a>. </p>
<p>The model is characterized by a SummaryClass that provide a quick access to the following variables once the model is simulated: </p>
<ul>
<li>Enthalpy at each node </li>
<li>Enthalpy at the center of each cell </li>
<li>Density at the center of each cell </li>
<li>Massflow at each node </li>
<li>Temperature at the center of each cell </li>
<li>Pressure in the tube </li>
</ul>
</html>"));
end Flow1DimInc;
