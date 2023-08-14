within Greenhouses.Components.Greenhouse;
model Floor
  /******************** Parameters ********************/
  parameter Integer N_rad=2
    "Short-wave radiations are 2: if sun and illumination; 1 if just sun";
  parameter Modelica.SIunits.Density rho;
  parameter Modelica.SIunits.SpecificHeatCapacity c_p;
  parameter Modelica.SIunits.Volume V;
  parameter Modelica.SIunits.Area A "floor surface";

  /******************** Initialization ********************/
  parameter Modelica.SIunits.Temperature T_start=298 annotation(Dialog(tab = "Initialization"));
  parameter Boolean steadystate=false
    "if true, sets the derivative of T to zero during Initialization"     annotation (Dialog(group="Initialization options", tab="Initialization"));

  /******************** Variables ********************/
  Modelica.SIunits.HeatFlowRate Q_flow "Heat flow rate from port_a -> port_b";
  Modelica.SIunits.Temperature T;
  Modelica.SIunits.Power P_Flr "total short-wave power to the floor";

  /******************** Connectors ********************/
protected
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature preTem
    "Port temperature"
    annotation (Placement(transformation(extent={{44,12},{24,32}})));
  Modelica.Blocks.Sources.RealExpression portT(y=T) "Port temperature"
    annotation (Placement(transformation(extent={{72,12},{52,32}})));
public
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPort
    "Heat port for sensible heat input"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}}),
        iconTransformation(extent={{-10,-10},{10,10}})));

  Interfaces.Heat.HeatFluxVectorInput R_Flr_Glob[N_rad] annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=-90,
        origin={-60,40})));
equation
  if max({cardinality(R_Flr_Glob[i]) for i in 1:size(R_Flr_Glob, 1)}) == 0 then
    for i in 1:N_rad loop
      R_Flr_Glob[i]=0;
    end for;
  end if;
  P_Flr = sum(R_Flr_Glob)*A;

  // Balance on the floor
  heatPort.Q_flow = Q_flow;
  der(T) = 1/(rho*c_p*V)*(Q_flow + P_Flr);

  connect(portT.y,preTem. T)
    annotation (Line(points={{51,22},{46,22}},   color={0,0,127}));
  connect(preTem.port,heatPort)
    annotation (Line(points={{24,22},{12,22},{12,0},{0,0}},color={191,0,0}));

initial equation
  if steadystate then
    der(T)=0;
  end if;
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}),
                         graphics), Icon(coordinateSystem(preserveAspectRatio=false,
          extent={{-100,-100},{100,100}}), graphics={
        Rectangle(
          extent={{-20,80},{20,-80}},
          lineColor={0,0,0},
          fillColor={192,192,192},
          fillPattern=FillPattern.Backward,
          origin={0,0},
          rotation=90),                   Text(
          extent={{-100,-34},{120,-94}},
          lineColor={0,0,0},
          textString="%name")}),
    Documentation(info="<html>
<p><big>This model applies an energy balance on the floor. The energy balance is done by taking into account:</p>
<ul>
<li><big>Sensible heat flows (i.e. all the flows connected to the heat port). Long-wave radiation is exchanged between the floor and the heating pipes, the canopy, the thermal screen and the cover. Sensible heat is exchanged with the air by convection and with the first soil layer by conduction.</li>
<li><big>Short-wave radiation absorbed from the sun and/or supplementary lighting (i.e. the forced flow from the short-wave radiation input).</li>
</ul>
<p><big>Because the properties of the floor are parameters of the model, the user has the possibility to adapt the model for any type of floor material (e.g. concrete, soil, etc.).</p>
<p><big>Since the short-wave radiation can origin from two sources (the sun and supplementary illumination), the short-wave radiation input connector (i.e. <a href=\"modelica://Greenhouses.Interfaces.Heat.HeatFluxVectorInput\">HeatFluxVectorInput</a>) has the form of a vector. The parameter <i>N_rad</i> defines the dimension of the vector and needs to be set by the user. Therefore, if there is no supplementary lighting, the user must set <i>N_rad</i> to 1 (i.e. radiation only form the sun). However, if there is supplementary lighting, the user must set <i>N_rad</i> to 2 (i.e. radiatio from sun + lighting).</p>
<p><big>There is no moisture model.</p>
</html>"));
end Floor;
