within Greenhouses.Components.Greenhouse;
model ThermalScreen

  /******************** Parameters ********************/
  parameter Modelica.Units.SI.Density rho=0.2e3;
  parameter Modelica.Units.SI.SpecificHeatCapacity c_p=1.8e3;
  parameter Modelica.Units.SI.Length h=0.35e-3 "thickness of the thermal screen";
  parameter Modelica.Units.SI.Area A "floor surface";
  parameter Real tau_FIR=0.15
    "FIR transmission coefficient of the thermal screen";

  /******************** Varying inputs ********************/
  Real SC=0 "Screen closure 1:closed, 0:open" annotation (Dialog(group="Varying inputs"));

  /******************** Initialization ********************/
  parameter Modelica.Units.SI.Temperature T_start=298
    annotation (Dialog(tab="Initialization"));
  parameter Boolean steadystate=false
    "if true, sets the derivative of T to zero during Initialization"
    annotation (Dialog(group="Initialization options", tab="Initialization"));

  /******************** Variables ********************/
  Modelica.Units.SI.HeatFlowRate Q_flow "Heat flow rate from port_a -> port_b";
  Modelica.Units.SI.Temperature T;
  Real FF_i;
  Real FF_ij;
  Modelica.Units.SI.HeatFlowRate L_scr "latent heat to the screen";

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
    <p><big>This model applies an energy balance on the thermal screen. The energy balance is done by taking into account:</p>
<ul>
<li><big>Sensible heat flows (i.e. all the flows connected to the heat port). Long-wave radiation is exchanged with the heating pipes, the canopy, the floor and the cover. Sensible heat is exchanged with the air through convection.</li>
<li><big>Latent heat flows associated with condensation or evaporation of moisture. The present model assumes that the thermal screen is capable of transporting water from the lower side to the upper side through the fabric. However, the storage of moisture in the screen is neglected. This implies that the vapor that condensates at the screen is either evaporated at the upper side of drips from the screen. Therefore, the rate of evaporation is lower or equal to the rate of condensation. The latent heat flows are determined by multiplying the moisture flows at the vapor mass port to the latent heat of vaporization</li>
</ul>
<p><big>Because the properties of the screen are parameters of the model, the user has the possibility to adapt the model for any type of screen material (e.g. aluminized, non aluminized etc.). </p>
<p><big>The screen thickness, commonly less than 1 mm, implies a very low heat capacity. Moreover, the screen is mostly drawn at night (i.e. when there is no short-wave irradiation), in order to mitigate heat losses. Because of the latter, in this model the absorbed heat from short-wave radiation is neglected. </p>
<p><big>The vapor pressure of water at the screen is defined by the saturated vapor pressure for its temperature.</p>

</html>"));
end ThermalScreen;
