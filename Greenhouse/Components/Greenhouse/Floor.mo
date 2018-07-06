within Greenhouse.Components.Greenhouse;
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

  Flows.Interfaces.Heat.HeatFluxVectorInput R_Flr_Glob[N_rad] annotation (
      Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=-90,
        origin={-60,40})));
equation
  if cardinality(R_Flr_Glob)==0 then
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
          textString="%name")}));
end Floor;
