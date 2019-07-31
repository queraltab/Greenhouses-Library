within Greenhouses.Components.Greenhouse;
model HeatingPipe
  "Model of a heating distribution netwrok. Pipe model using a 1-D fluid flow model (finite volume discretization - incompressible fluid model)."
  /******************** Parameters ********************/
  parameter Integer N_p(min=1)=1 "number of cells in parallel";
  parameter Integer N(min=1)=2 "number of cells";
  //parameter Modelica.SIunits.Temperature T_inlet_min
  //  "Pipe Fluid Minimum Inlet Temperature";
  parameter Modelica.SIunits.Diameter d "pipe diameter";
  parameter Modelica.SIunits.Length l "length of heating pipes";
  parameter Modelica.SIunits.Area A "Greenhouse floor surface";
  parameter Boolean freePipe=true
    "true if pipe in free air, false if hindered pipe";
  parameter Modelica.SIunits.MassFlowRate Mdotnom=0.528
    "Nominal mass flow rate of the pipes";
  /******************** Variables ********************/
  Modelica.SIunits.Area A_PipeFloor "pipe external area";
  Real c;
  Real FF;
  //Modelica.SIunits.MassFlowRate Mdot;
  /******************** Connectors ********************/
  Flows.FluidFlow.Flow1DimInc flow1DimInc(
    redeclare package Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater,
    steadystate=true,
    redeclare model Flow1DimIncHeatTransferModel =
        Greenhouses.Flows.FluidFlow.HeatTransfer.Ideal,
    N=N,
    A=l*Modelica.Constants.pi*d,
    Nt=N_p,
    Mdotnom=Mdotnom,
    Unom=1000,
    Discretization=Greenhouses.Functions.Enumerations.Discretizations.upwind,
    V=Modelica.Constants.pi*((d - 0.004)/2)^2*l,
    pstart=200000,
    Tstart_inlet=353.15,
    Tstart_outlet=323.15)
    annotation (Placement(transformation(extent={{-10,-66},{14,-42}})));
public
  Interfaces.Heat.HeatPorts_a[N] heatPorts annotation (Placement(transformation(
          extent={{-10,-10},{10,10}}), iconTransformation(extent={{-40,30},{40,
            50}})));
  Modelica.Fluid.Interfaces.FluidPort_a
                           pipe_in(redeclare package Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater) annotation (Placement(
        transformation(extent={{-90,-10},{-70,10}}), iconTransformation(extent=
            {{-90,-10},{-70,10}})));
  Modelica.Fluid.Interfaces.FluidPort_b
                           pipe_out(redeclare package Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater) annotation (Placement(
        transformation(extent={{70,-10},{90,10}}), iconTransformation(extent={{
            70,-10},{90,10}})));
equation
  if freePipe then
    c=0.5;
  else
    c=0.49;
  end if;
  A_PipeFloor = N_p*Modelica.Constants.pi*d*l/A "change m-2pipe to m-2floor";
  FF = A_PipeFloor*c;
  connect(heatPorts, flow1DimInc.heatPorts_a) annotation (Line(
      points={{0,0},{2,0},{2,-49}},
      color={127,0,0},
      smooth=Smooth.None));
  connect(pipe_in, flow1DimInc.InFlow) annotation (Line(
      points={{-80,0},{-40,0},{-40,-54},{-8,-54}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(flow1DimInc.OutFlow, pipe_out) annotation (Line(
      points={{12,-54},{50,-54},{50,0},{80,0}},
      color={0,0,255},
      smooth=Smooth.None));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
            {100,100}}), graphics={Ellipse(
          extent={{-82,30},{-36,-30}},
          fillColor={135,135,135},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,0}),             Text(
          extent={{-110,-44},{110,-104}},
          lineColor={0,0,0},
          textString="%name"),
        Line(
          points={{-60,-40}},
          color={0,0,0},
          smooth=Smooth.None),
        Rectangle(
          extent={{-60,30},{80,-30}},
          fillColor={135,135,135},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
                                   Ellipse(
          extent={{56,30},{102,-30}},
          lineColor={0,0,0},
          fillColor={135,135,135},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-60,30},{78,30}},
          color={0,0,0},
          smooth=Smooth.None),
        Line(
          points={{-60,-30},{78,-30}},
          color={0,0,0},
          smooth=Smooth.None)}),            Diagram(coordinateSystem(
          preserveAspectRatio=false, extent={{-100,-100},{100,100}})),
    Documentation(info="<html>
    <p><big>The fluid in the heating pipes from the greenhouse heating ciruit is modeled by means of the discretized model for incompressible flow (<a href=\"modelica://Greenhouses.Flows.FluidFlow.Flow1DimInc\">Flow1DimInc</a>), in which a dynamic energy balance and static mass and momentum balances are applied on the fluid cells. Heat is transferred by long-wave radiation to the canopy, floor and cover, and by convection to the air. The heat transfer is set to be computed by an ideal model. However, the user can select other heat transfer models in the parameters of the fluid flow model.

<p><big>Greenhouse heating circuits are commonly made of several parallel heating loops. The user must set the physical characteristics of the circuit (i.e. the number of parallel loops, the pipes diameter, the installed length per loop and the nominal mass flow rate) and the number of nodes in which a loop is discretized. </p>
</html>"));
end HeatingPipe;
