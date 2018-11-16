within Greenhouses.Components.Greenhouse;
model Cover
  /******************** Parameters ********************/
  parameter Modelica.SIunits.Density rho=2600 "Cover density (glass)";
  parameter Modelica.SIunits.SpecificHeatCapacity c_p=840
    "Cover specific thermal capacity";
  parameter Modelica.SIunits.Length h_cov=1e-3 "Thickness of the cover";
  parameter Modelica.SIunits.Angle phi "Roof slope";
  parameter Modelica.SIunits.Area A "Greenhouse floor surface";

  /******************** Initialization ********************/
  parameter Modelica.SIunits.Temperature T_start=298 annotation(Dialog(tab = "Initialization"));
  parameter Boolean steadystate=false
    "if true, sets the derivative of T to zero during Initialization"
    annotation (Dialog(group="Initialization options", tab="Initialization"));

  /******************** Variables ********************/
  Modelica.SIunits.HeatFlowRate Q_flow "Heat flow rate from port_a -> port_b";
  Modelica.SIunits.Temperature T;
  Modelica.SIunits.Power P_SunCov "Absorbed power by the surface";
  Modelica.SIunits.HeatFlowRate L_cov "latent heat to the cover";
  Modelica.SIunits.Volume V;

  /******************** Connectors ********************/
protected
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature preTem
    "Port temperature"
    annotation (Placement(transformation(extent={{-6,40},{-26,60}})));
  Modelica.Blocks.Sources.RealExpression portT(y=T) "Port temperature"
    annotation (Placement(transformation(extent={{22,40},{2,60}})));
public
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPort(
    T(start=T_start)) "Heat port for sensible heat input"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}}),
        iconTransformation(extent={{-10,-10},{10,10}})));

  BasicComponents.SurfaceVP surfaceVP(T=heatPort.T)
    annotation (Placement(transformation(extent={{30,20},{50,40}})));
  Interfaces.Vapour.WaterMassPort_a massPort
    annotation (Placement(transformation(extent={{30,-10},{50,10}})));
  Interfaces.Heat.HeatFluxInput R_SunCov_Glob annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=-90,
        origin={-70,40})));
equation
  if cardinality(R_SunCov_Glob)==0 then
    R_SunCov_Glob=0;
  end if;
  V=h_cov*A/cos(phi);

  P_SunCov = R_SunCov_Glob*A;

  //Latent heat
  L_cov = massPort.MV_flow*2.45e6;

  // Balance on the cover
  heatPort.Q_flow = Q_flow;
  der(T) = 1/(rho*c_p*V)*(Q_flow + P_SunCov + L_cov);

  connect(portT.y,preTem. T)
    annotation (Line(points={{1,50},{-4,50}},    color={0,0,127}));
  connect(preTem.port,heatPort)
    annotation (Line(points={{-26,50},{-36,50},{-36,0},{0,0}},
                                                           color={191,0,0}));
  connect(surfaceVP.port, massPort) annotation (Line(
      points={{40,30},{40,0}},
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
        Rectangle(
          extent={{-20,80},{20,-80}},
          lineColor={0,117,227},
          fillColor={170,213,255},
          fillPattern=FillPattern.Backward,
          origin={0,0},
          rotation=90),                   Text(
          extent={{-50,-34},{170,-94}},
          lineColor={0,0,0},
          textString="%name")}),
    Documentation(info="<html>
<p><big>This model applies an energy balance on the cover. The energy balance is done by taking into account:</p>
<ul>
<li><big>Sensible heat flows (i.e. all the flows connected to the heat port). These should be the sensible heat caused by convection is mainly exhanged with the air (top air zone when the screen is drawn, main air zone in the absence of a thermal screen) and the outside air; and long-wave radiation is exchanged with the heating pipes, the canopy, the floor, the thermal screen and the sky.</li>
<li><big>Latent heat flows associated with condensation of moisture. In fact, depending on the water vapor pressure difference, condensation may take place at the inner side of the cover. Evaporation of moisture from the cover to the air is neglected because in greenhouses, condensate on the cover is commonly drained. The latent heat flows are determined by multiplying the moisture flows at the vapor mass port to the latent heat of vaporization</li>
<li><big>Short-wave radiation absorbed from the sun (i.e. the forced flow from the short-wave radiation input).</li>
</ul>
<p><big>Because the properties of the cover are parameters of the model, the user has the possibility to adapt the model for any type of cover (single-glass, double-glass, plastic, etc.). </p>
<p><big>Since glass thickness is commonly small (i.e. 4mm), conduction through the cover is neglected. The vapor pressure of water at the cover is defined by the saturated vapor pressure for its temperature.</p>
</html>"));
end Cover;
