within Greenhouses.Flows.HeatTransfer;
model Radiation_N "Lumped thermal element for radiation heat transfer"

  /*********************** Parameters ***********************/
  parameter Modelica.Units.SI.Area A "floor surface";
  parameter Real epsilon_a "emissivity coefficient of surface A";
  parameter Real epsilon_b "emissivity coefficient of surface B";
//   parameter Modelica.SIunits.Temperature T_inlet_min=333.15
//     "Pipe Minimum Inlet Temperature";

  /*********************** Varying inputs ***********************/
  Real FFa = 1 "View factor of element A"
    annotation (Dialog(group="Varying inputs"));
  Real FFb = 1 "View factor of element B"
    annotation (Dialog(group="Varying inputs"));
  Real FFab1 = 0 "View factor of intermediate element between A and B"
    annotation (Dialog(group="Varying inputs"));
  Real FFab2 = 0 "View factor of intermediate element between A and B"
    annotation (Dialog(group="Varying inputs"));
  Real FFab3 = 0 "View factor of intermediate element between A and B"
    annotation (Dialog(group="Varying inputs"));
  Real FFab4 = 0 "View factor of intermediate element between A and B"
    annotation (Dialog(group="Varying inputs"));

  Real dT4[N];
  Modelica.Units.SI.HeatFlowRate Q_flow;
  Real REC_ab(unit="W/(m2.K4)");

  // Discretization
  parameter Integer N(min=1)=2 "Number of discrete flow volumes";

  Greenhouses.Interfaces.Heat.HeatPorts_a[N] heatPorts_a annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-100,0}), iconTransformation(
        extent={{-40,-10},{40,10}},
        rotation=90,
        origin={-90,0})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b
             port_b annotation (Placement(transformation(extent={{90,-10},{110,10}},
                      rotation=0)));
equation
  for i in 1:N loop
    dT4[i]=heatPorts_a[i].T^4 - port_b.T^4;
  end for;

  REC_ab = epsilon_a*epsilon_b*FFa*FFb*(1-FFab1)*(1-FFab2)*(1-FFab3)*(1-FFab4)*Modelica.Constants.sigma;
  heatPorts_a.Q_flow = A/N*REC_ab*dT4;

  Q_flow = sum(heatPorts_a.Q_flow);

  port_b.Q_flow = -Q_flow;
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false,extent={{-100,-100},{100,100}}),
                        graphics={
        Text(
          extent={{-180,-28},{180,-60}},
          lineColor={190,0,0},
          textString="%name"),
        Line(
          points={{-90,-30}},
          color={191,0,0},
          smooth=Smooth.Bezier),
        Line(
          points={{-90,0},{-80,0},{-70,-10},{-50,10},{-30,-10},{-10,10},{10,-10},
              {30,10},{50,-10},{70,10},{80,0},{90,0}},
          color={191,0,0},
          smooth=Smooth.Bezier)}),
    Documentation(info="<html>
<p>This is a model describing the thermal radiation, i.e., electromagnetic radiation emitted between two bodies as a result of their temperatures. The following constitutive equation is used: </p>
<pre>    Q_flow = Gr*sigma*(port_a.T^4 - port_b.T^4);</pre>
<p>where Gr is the radiation conductance and sigma is the Stefan-Boltzmann constant (= Modelica.Constants.sigma). Gr may be determined by measurements and is assumed to be constant over the range of operations. </p>
<p>For simple cases, Gr may be analytically computed. The analytical equations use epsilon, the emission value of a body which is in the range 0..1. Epsilon=1, if the body absorbs all radiation (= black body). Epsilon=0, if the body reflects all radiation and does not absorb any. </p>
<pre>   Proposed values for epsilon of the greenhouse elements:
   glass cover            0.84
   pipes                   0.88
   canopy leaves            1.00
   concrete floor            0.89
   thermal screen            1.00

   Typical values for epsilon for other materials:
   aluminium, polished    0.04
   copper, polished       0.04
   gold, polished         0.02
   paper                  0.09
   rubber                 0.95
   silver, polished       0.02
   wood                   0.85..0.9</pre>
</html>"), Diagram(coordinateSystem(preserveAspectRatio=false,extent={{-100,-100},
            {100,100}}),graphics={
        Line(
          points={{-90,0},{-80,0},{-70,-10},{-50,10},{-30,-10},{-10,10},{10,-10},
              {30,10},{50,-10},{70,10},{80,0},{90,0}},
          color={191,0,0},
          smooth=Smooth.Bezier)}));
end Radiation_N;
