within Greenhouses.Components.Greenhouse;
model ThermalScreen

  /******************** Parameters ********************/
  parameter Modelica.SIunits.Density rho=0.2e3;
  parameter Modelica.SIunits.SpecificHeatCapacity c_p=1.8e3;
  parameter Modelica.SIunits.Length h=0.35e-3 "thickness of the thermal screen";
  parameter Modelica.SIunits.Area A "floor surface";
  parameter Real tau_FIR=0.15
    "FIR transmission coefficient of the thermal screen";

  /******************** Varying inputs ********************/
  Real SC=0 "Screen closure 1:closed, 0:open" annotation (Dialog(group="Varying inputs"));

  /******************** Initialization ********************/
  parameter Modelica.SIunits.Temperature T_start=298 annotation(Dialog(tab = "Initialization"));
  parameter Boolean steadystate=false
    "if true, sets the derivative of T to zero during Initialization"
    annotation (Dialog(group="Initialization options", tab="Initialization"));

  /******************** Variables ********************/
  Modelica.SIunits.HeatFlowRate Q_flow "Heat flow rate from port_a -> port_b";
  Modelica.SIunits.Temperature T;
  Real FF_i;
  Real FF_ij;
  Modelica.SIunits.HeatFlowRate L_scr "latent heat to the screen";

  /******************** Connectors ********************/
protected
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature preTem
    "Port temperature"
    annotation (Placement(transformation(extent={{-44,10},{-64,30}})));
  Modelica.Blocks.Sources.RealExpression portT(y=T) "Port temperature"
    annotation (Placement(transformation(extent={{-16,10},{-36,30}})));
public
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPort(
    T(start=T_start)) "Heat port for sensible heat input"
    annotation (Placement(transformation(extent={{-34,-10},{-14,10}}),
        iconTransformation(extent={{-34,-10},{-14,10}})));

  BasicComponents.SurfaceVP surfaceVP(T=T)
    annotation (Placement(transformation(extent={{20,20},{40,40}})));
  Interfaces.Vapour.WaterMassPort_a massPort
    annotation (Placement(transformation(extent={{14,-10},{34,10}})));
equation
  FF_i = SC;
  FF_ij = SC*(1-tau_FIR);

  //Latent heat
  L_scr = massPort.MV_flow*2.45e6;

  // Balance on the layer
  heatPort.Q_flow = Q_flow;
  der(T) = 1/(rho*c_p*h*A)*(Q_flow + L_scr);

  connect(portT.y,preTem. T)
    annotation (Line(points={{-37,20},{-42,20}}, color={0,0,127}));
  connect(preTem.port,heatPort)
    annotation (Line(points={{-64,20},{-68,20},{-68,0},{-24,0}},
                                                           color={191,0,0}));
  connect(surfaceVP.port,massPort)  annotation (Line(
      points={{30,30},{30,0},{24,0}},
      color={170,213,255},
      smooth=Smooth.None));

initial equation
  if steadystate then
    der(T)=0;
  end if;
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}),
                         graphics), Icon(coordinateSystem(preserveAspectRatio=false,
          extent={{-100,-100},{100,100}}), graphics={
                                          Text(
          extent={{-180,-34},{180,-90}},
          lineColor={0,0,0},
          textString="%name"),
        Line(
          points={{-90,0},{-80,0},{-70,-10},{-50,10},{-30,-10},{-10,10},{10,-10},
              {30,10},{50,-10},{70,10},{80,0},{90,0}},
          color={0,0,0},
          smooth=Smooth.Bezier)}),
    Documentation(info="<html>
<p>The present model assumes that the thermal screen is capable of transporting water from the lower side to the upper side through the fabric. </p>
<p>However, the storage of moisture in the screen is neglected. This implies that the vapour that condenses at the screen is either evaporated at</p>
<p>the upper side or drips from the screen. Another implication of the neglection of storage is that the rate of evaporation at the upper side of the</p>
<p>screen is lower or equal to the rate of condensation at the lower side.</p>
</html>"));
end ThermalScreen;
