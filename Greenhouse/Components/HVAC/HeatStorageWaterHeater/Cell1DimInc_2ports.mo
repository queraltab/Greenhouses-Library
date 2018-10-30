within Greenhouses.Components.HVAC.HeatStorageWaterHeater;
model Cell1DimInc_2ports
  "1-D incompressible fluid flow model with three thermal ports (two with a heat transfer model)"
  replaceable package Medium = Media.StandardWater constrainedby
    Modelica.Media.Interfaces.PartialMedium
    "Medium model - Incompressible Fluid" annotation (choicesAllMatching=true);

  /************ Thermal and fluid ports ***********/
  Flows.Interfaces.Fluid.FlangeA       InFlow(redeclare package Medium =
        Medium) annotation (Placement(transformation(extent={{-100,-10},{-80,
            10}}), iconTransformation(extent={{-120,-20},{-80,20}})));
  Flows.Interfaces.Fluid.FlangeB       OutFlow(redeclare package Medium =
        Medium) annotation (Placement(transformation(extent={{80,-10},{100,10}}),
        iconTransformation(extent={{80,-18},{120,20}})));
  Flows.Interfaces.Heat.ThermalPortL               Wall_int annotation (
      Placement(transformation(extent={{-28,40},{32,60}}), iconTransformation(
          extent={{-40,40},{40,60}})));

  /************ Geometric characteristics **************/
  constant Real pi=Modelica.Constants.pi "pi-greco";
  parameter Modelica.SIunits.Volume Vi "Volume of a single cell";
  parameter Modelica.SIunits.Area Ai "Lateral surface of a single cell";
  parameter Modelica.SIunits.MassFlowRate Mdotnom "Nominal fluid flow rate";
  parameter Modelica.SIunits.CoefficientOfHeatTransfer Unom;
  parameter Modelica.SIunits.CoefficientOfHeatTransfer Unom_hx
    "Nominal Heat transfer coefficient ";

  parameter Modelica.SIunits.Area A_hx;

  /************ FLUID INITIAL VALUES ***************/
  parameter Modelica.SIunits.Pressure pstart "Fluid pressure start value"
    annotation (Dialog(tab="Initialization"));
  parameter Medium.SpecificEnthalpy hstart=1E5 "Start value of enthalpy"
    annotation (Dialog(tab="Initialization"));

  /****************** NUMERICAL OPTIONS  ***********************/
  parameter Boolean steadystate=true
    "if true, sets the derivative of h (working fluids enthalpy in each cell) to zero during Initialization"
    annotation (Dialog(group="Initialization options", tab="Initialization"));

  /********************************* HEAT TRANSFER MODEL ********************************/
  /* Heat transfer Model */
  replaceable model HeatTransfer =
      Flows.FluidFlow.HeatTransfer.MassFlowDependence
    constrainedby
    Flows.FluidFlow.HeatTransfer.BaseClasses.PartialHeatTransferZones
    "Convective heat transfer" annotation (choicesAllMatching=true);
  parameter Boolean FlowReversal = false
    "Allow flow reversal (might complexify the final system of equations)";

  Flows.FluidFlow.HeatTransfer.MassFlowDependence
               heatTransfer(
    redeclare final package Medium = Medium,
    final n=1,
    final Mdotnom=Mdotnom,
    final Unom_l=Unom,
    final Unom_tp=Unom,
    final Unom_v=Unom,
    final M_dot=M_dot,
    final x=0,
    final FluidState={fluidState})
    annotation (Placement(transformation(extent={{-30,-12},{-10,8}})));

  Flows.FluidFlow.HeatTransfer.MassFlowDependence
               heatTransfer1(
    redeclare final package Medium = Medium,
    final n=1,
    final Mdotnom=Mdotnom,
    final Unom_l=Unom_hx,
    final Unom_tp=Unom_hx,
    final Unom_v=Unom_hx,
    final M_dot=M_dot,
    final x=0,
    final FluidState={fluidState})
    annotation (Placement(transformation(extent={{2,8},{22,-12}})));
  Flows.Interfaces.Heat.ThermalPortL               HXInt annotation (
      Placement(transformation(extent={{20,-60},{40,-40}}),
        iconTransformation(extent={{20,-60},{40,-40}})));

  /***************  VARIABLES ******************/
  Medium.ThermodynamicState fluidState;
  Medium.AbsolutePressure p(start=pstart);
  Modelica.SIunits.MassFlowRate M_dot(start=Mdotnom);
  Medium.SpecificEnthalpy h(start=hstart, stateSelect=StateSelect.always)
    "Fluid specific enthalpy at the cells";
  Medium.Temperature T "Fluid temperature";
  //Modelica.SIunits.Temperature T_wall "Internal wall temperature";
  Medium.Density rho "Fluid cell density";
  Modelica.SIunits.SpecificEnthalpy hnode_su(start=hstart)
    "Enthalpy state variable at inlet node";
  Modelica.SIunits.SpecificEnthalpy hnode_ex(start=hstart)
    "Enthalpy state variable at outlet node";
  Modelica.SIunits.HeatFlux qdot "heat flux at each cell";
  //   Modelica.SIunits.CoefficientOfHeatTransfer U
  //     "Heat transfer coefficient between wall and working fluid";
  Modelica.SIunits.Power Q_tot "Total heat flux exchanged by the thermal port";
  Modelica.SIunits.Mass M_tot "Total mass of the fluid in the component";

  Modelica.SIunits.HeatFlux qdot_hx;

  /***********************************  EQUATIONS ************************************/

  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a direct_heat_port
    annotation (Placement(transformation(extent={{-40,-60},{-20,-40}}),
        iconTransformation(extent={{-40,-60},{-20,-40}})));
equation
  /* Fluid Properties */
  fluidState = Medium.setState_ph(p, h);
  T = Medium.temperature(fluidState);
  rho = Medium.density(fluidState);
  /* ENERGY BALANCE */
  Vi*rho*der(h) + M_dot*(hnode_ex - hnode_su) - A_hx*qdot_hx = Ai*qdot + direct_heat_port.Q_flow
    "Energy balance";

  Q_tot = Ai*qdot "Total heat flow through the thermal port";
  M_tot = Vi*rho;

  qdot = heatTransfer.q_dot[1];

  qdot_hx = heatTransfer1.q_dot[1];

  if FlowReversal then
    hnode_ex = if M_dot >= 0 then h else inStream(OutFlow.h_outflow);
    hnode_su = if M_dot <= 0 then h else inStream(InFlow.h_outflow);
    InFlow.h_outflow = hnode_su;
  else
    hnode_su = inStream(InFlow.h_outflow);
    hnode_ex = h;
    InFlow.h_outflow = hstart;
  end if;

  //* BOUNDARY CONDITIONS *//
  /* Enthalpies */
  OutFlow.h_outflow = hnode_ex;
  /* pressures */
  p = OutFlow.p;
  InFlow.p = p;
  /*Mass Flow*/
  M_dot = InFlow.m_flow;
  OutFlow.m_flow = -M_dot;
  InFlow.Xi_outflow = inStream(OutFlow.Xi_outflow);
  OutFlow.Xi_outflow = inStream(InFlow.Xi_outflow);

  direct_heat_port.T = T;

initial equation
  if steadystate then
    der(h) = 0;
  end if;

equation
  connect(HXInt, heatTransfer1.thermalPortL[1]) annotation (Line(
      points={{30,-50},{11.8,-50},{11.8,-8.6}},
      color={255,0,0},
      smooth=Smooth.None));
  connect(Wall_int, heatTransfer.thermalPortL[1]) annotation (Line(
      points={{2,50},{-8,50},{-8,4.6},{-20.2,4.6}},
      color={255,0,0},
      smooth=Smooth.None));
  annotation (
    Diagram(coordinateSystem(preserveAspectRatio=false,extent={{-100,-100},{
            100,100}}), graphics),
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
                    graphics={Rectangle(
          extent={{-80,40},{84,-40}},
          lineColor={255,0,0},
          fillColor={0,255,255},
          fillPattern=FillPattern.Solid)}),
    Documentation(info="<HTML>
          
         <p><big>This model describes the flow of an incompressible fluid through a single cell. An overall flow model can be obtained by interconnecting several cells in series (see <a href=\"modelica://ThermoCycle.Components.FluidFlow.Pipes.Flow1DimInc\">Flow1DimInc</a>).
          <p><big><b>Enthalpy</b> is selected as state variable. 
          <p><big>Two types of variables can be distinguished: cell variables and node variables. Node variables are characterized by the su (supply) and ex (exhaust) subscripts, and correspond to the inlet and outlet nodes at each cell. The relation between the cell and node values depends on the discretization scheme selected. 
 <p><big>The assumptions for this model are:
         <ul><li> Velocity is considered uniform on the cross section. 1-D lumped parameter model
         <li> The model is based on dynamic energy balance and on a static  mass and  momentum balances
         <li> Constant pressure is assumed in the cell
         <li> Axial thermal energy transfer is neglected
         <li> Thermal energy transfer through the lateral surface is ensured by the <em>wall_int</em> connector. The actual heat flow is computed by the thermal energy model
         </ul>

 <p><big>The model is characterized by two flow connector and one lumped thermal port connector. During normal operation the fluid enters the model from the <em>InFlow</em> connector and exits from the <em>OutFlow</em> connector. In case of flow reversal the fluid direction is inversed.
 
 <p><big> The thermal energy transfer  through the lateral surface is computed by the <em><a href=\"modelica://ThermoCycle.Components.HeatFlow.HeatTransfer.ConvectiveHeatTransfer\">ConvectiveHeatTransfer</a></em> model which is inerithed in the <em>Cell1DimInc</em> model.
 
        
        <p><b><big>Modelling options</b></p>
        <p><big> In the <b>General</b> tab the following options are available:
        <ul><li>Medium: the user has the possibility to easly switch Medium.
        <li> HeatTransfer: the user can choose the thermal energy model he prefers </ul> 
        <p><big> In the <b>Initialization</b> tab the following options are available:
        <ul><li> steadystate: If it sets to true, the derivative of enthalpy is sets to zero during <em>Initialization</em> 
         </ul>
        <p><b><big>Numerical options</b></p>
<p><big> In this tab several options are available to make the model more robust:
<ul><li> Discretization: 2 main discretization options are available: UpWind and central difference method. The authors raccomand the <em>UpWind Scheme - AllowsFlowReversal</em> in case flow reversal is expected.
</ul>
 <p><big> 
        </HTML>"));
end Cell1DimInc_2ports;
