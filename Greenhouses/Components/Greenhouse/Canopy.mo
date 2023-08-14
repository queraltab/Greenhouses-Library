within Greenhouses.Components.Greenhouse;
model Canopy
  /********************* Parameters ***********************/
  parameter Integer N_rad=2
    "Short-wave radiations are 2: if sun and illumination; 1 if just sun";
  parameter Modelica.SIunits.HeatCapacity Cap_leaf=1200
    "heat capacity of a square meter of canopy leaves";
  parameter Modelica.SIunits.Area A "floor surface";

  /******************* Initialization *********************/
  parameter Modelica.SIunits.Temperature T_start=298 annotation(Dialog(tab = "Initialization"));
  parameter Boolean steadystate=false
    "if true, sets the derivative of T to zero during Initialization"
    annotation (Dialog(group="Initialization options", tab="Initialization"));

  /******************** Varying inputs ********************/
  Real LAI = 1 "Leaf Area Index"
    annotation (Dialog(group="Varying inputs"));

  /********************** Variables ***********************/
  Modelica.SIunits.HeatFlowRate Q_flow
    "Heat flow rate from long-wave radiation and convection";
  Modelica.SIunits.Temperature T;
  Modelica.SIunits.Power P_Can
    "Total heat flow rate to the canopy from solar short-wave radiation";
  Modelica.SIunits.HeatFlowRate L_can "latent heat to the canopy";
  Real FF;

  /********************* Connectors *********************/
protected
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature preTem
    "Port temperature"
    annotation (Placement(transformation(extent={{-56,-62},{-76,-42}})));
  Modelica.Blocks.Sources.RealExpression portT(y=T) "Port temperature"
    annotation (Placement(transformation(extent={{-26,-62},{-46,-42}})));
public
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPort(
    T(start=T_start)) "Heat port for sensible heat input"
    annotation (Placement(transformation(extent={{-10,-84},{10,-64}}),
        iconTransformation(extent={{-10,-84},{10,-64}})));

  BasicComponents.SurfaceVP surfaceVP(T=heatPort.T)
    annotation (Placement(transformation(extent={{38,-100},{58,-80}})));
  Interfaces.Vapour.WaterMassPort_a massPort annotation (Placement(
        transformation(extent={{-10,-116},{10,-96}}), iconTransformation(extent=
           {{-10,-116},{10,-96}})));

  Interfaces.Heat.HeatFluxVectorInput R_Can_Glob[N_rad] annotation (Placement(
        transformation(extent={{-50,60},{-10,100}}), iconTransformation(extent=
            {{-50,60},{-10,100}})));
equation
    for i in 1:N_rad loop
      if cardinality(R_Can_Glob[i]) == 0 then
        R_Can_Glob[i]=0;
      end if;
    end for;
  P_Can = sum(R_Can_Glob)*A;

  // Long-wave radiation model
  FF = 1-exp(-0.94*LAI);

  L_can = massPort.MV_flow*2.45e6;

  heatPort.Q_flow = Q_flow;
  der(T) = 1/(Cap_leaf*LAI*A)*(Q_flow + P_Can + L_can);

  connect(portT.y,preTem. T)
    annotation (Line(points={{-47,-52},{-52,-52},{-54,-52}},
                                                 color={0,0,127}));
  connect(preTem.port,heatPort)
    annotation (Line(points={{-76,-52},{-88,-52},{-88,-74},{0,-74}},
                                                           color={191,0,0}));
  connect(surfaceVP.port, massPort) annotation (Line(
      points={{48,-90},{0,-90},{0,-106}},
      color={170,213,255},
      smooth=Smooth.None));
initial equation
  if steadystate then
    der(T)=0;
  end if;
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}})),     Icon(coordinateSystem(preserveAspectRatio=false,
          extent={{-100,-100},{100,100}}), graphics={
        Polygon(
          points={{-6,-34},{-46,-14},{-46,2},{-34,-4},{-44,14},{-52,22},{-52,30},{
              -42,28},{-48,36},{-52,44},{-56,56},{-44,54},{-32,38},{-30,44},{-26,48},
              {-18,40},{-16,18},{-12,20},{-12,28},{-6,28},{0,12},{-6,-34}},
          lineColor={0,0,0},
          smooth=Smooth.Bezier,
          fillColor={0,127,0},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-4,16},{36,36},{36,52},{24,46},{34,64},{42,72},{42,80},{32,78},
              {38,86},{42,94},{46,106},{34,104},{22,88},{20,94},{16,98},{8,90},{6,
              68},{2,70},{2,78},{-4,78},{-10,62},{-4,16}},
          lineColor={0,0,0},
          smooth=Smooth.Bezier,
          fillColor={0,127,0},
          fillPattern=FillPattern.Solid),
        Line(
          points={{0,-60},{0,38},{20,70}},
          color={0,0,0},
          smooth=Smooth.Bezier),
        Line(
          points={{0,-76},{0,-58},{0,-46},{-8,-24},{-26,14}},
          color={0,0,0},
          smooth=Smooth.Bezier),
        Polygon(
          points={{12,-50},{52,-30},{52,-14},{40,-20},{50,-2},{58,6},{58,14},{48,12},
              {54,20},{58,28},{62,40},{50,38},{38,22},{36,28},{32,32},{24,24},{22,
              2},{18,4},{18,12},{12,12},{6,-4},{12,-50}},
          lineColor={0,0,0},
          smooth=Smooth.Bezier,
          fillColor={0,127,0},
          fillPattern=FillPattern.Solid),
        Line(
          points={{0,-70},{0,-60},{16,-28},{32,0}},
          color={0,0,0},
          smooth=Smooth.Bezier),          Text(
          extent={{-106,-104},{114,-164}},
          lineColor={0,0,0},
          textString="%name"),
        Line(
          points={{-100,120}},
          color={0,0,0},
          smooth=Smooth.None)}),
    Documentation(info="<html>
<p><big>This model applies an energy balance on the canopy. The energy balance is done by taking into account:</p>
<ul>
<li><big>Sensible heat flows (i.e. all the flows connected to the heat port). These should be the long-wave radiation with the heating pipes, the cover, the floor and the thermal screen. Also, the sensible heat with the main air zone.</li>
<li><big>Latent heat flows associated with canopy transpiration. The latent heat flows are determined by multiplying the moisture mass flows at the vapor mass port to the latent heat of vaporization.</li>
<li><big>Short-wave radiation absorbed from the sun and/or supplementary lighting (i.e. the forced flow from the short-wave radiation input).</li>
</ul>
<p><big>Since the short-wave radiation can origin from two sources (the sun and supplementary illumination), the short-wave radiation input connector (i.e. <a href=\"modelica://Greenhouses.Interfaces.Heat.HeatFluxVectorInput\">HeatFluxVectorInput</a>) has the form of a vector. The parameter <i>N_rad</i> defines the dimension of the vector and needs to be set by the user. Therefore, if there is no supplementary lighting, the user must set <i>N_rad</i> to 1 (i.e. radiation only form the sun). However, if there is supplementary lighting, the user must set <i>N_rad</i> to 2 (i.e. radiatio from sun + lighting).</p>
<p><big>The magnitude of the energy exchanged by the canopy depends on the size of the leaves, which is increased by crop growth and decreased by leaf pruining. To take this into account, the leaf area index (LAI), defined as the leaf area per unit of ground area, is used. The LAI is computed in the crop yield model and input in this model.</p>
<p><big>The vapor pressure of water at the canopy is defined by the saturated vapor pressure for its temperature.</p>
</html>"));
end Canopy;
