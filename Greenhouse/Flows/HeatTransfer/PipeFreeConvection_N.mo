within Greenhouse.Flows.HeatTransfer;
model PipeFreeConvection_N
  "Heating pipe heat exchange by free or hindered convection with air"

  /*********************** Parameters ***********************/
  parameter Integer N_p(min=1)=1 "number of pipes in parallel";
  parameter Integer nNodes(min=1)=2 "number of nodes for pipe side";
  parameter Modelica.SIunits.Area A "floor surface";
  parameter Modelica.SIunits.Length d
    "characteristic dimension of the pipe (pipe diameter)";
  parameter Modelica.SIunits.Length l "length of heating pipes";
  parameter Boolean freePipe=true
    "true if pipe in free air, false if hindered pipe";

  /*********************** Variables ***********************/
  Modelica.SIunits.CoefficientOfHeatTransfer HEC_ab[nNodes];
  Real alpha[nNodes];
  Modelica.SIunits.HeatFlowRate Q_flow;
  Modelica.SIunits.TemperatureDifference dT[nNodes] "port_a.T - port_b.T";

  Greenhouse.Flows.Interfaces.Heat.HeatPorts_a[nNodes] heatPorts_a annotation (
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
  for i in 1:nNodes loop
    dT[i] = heatPorts_a[i].T-port_b.T;
    if freePipe then
      alpha[i] = 1.28*d^(-0.25)*max(1e-9,abs(dT[i]))^0.25;
    else
      alpha[i] = 1.99*max(1e-9,abs(dT[i]))^0.32;
    end if;
    HEC_ab[i] = alpha[i]*Modelica.Constants.pi*d*l*N_p/A
      "*A_pipe/A to change units from m-2pipe to m-2floor";
    heatPorts_a[i].Q_flow = A/nNodes*HEC_ab[i]*dT[i];
  end for;

  Q_flow = sum(heatPorts_a.Q_flow);
  port_b.Q_flow = -Q_flow;

  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
            {100,100}}), graphics={Ellipse(
          extent={{-80,40},{0,-40}},
          lineColor={0,0,0},
          fillColor={135,135,135},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-16,38},{-6,48},{-6,58},{14,58},{14,78},{34,78},{34,88},{40,94}},
          color={0,0,255},
          smooth=Smooth.Bezier,
          arrow={Arrow.None,Arrow.Filled}),
        Line(
          points={{2,0},{14,0},{24,10},{44,-10},{64,10},{76,-2},{76,-2},{86,-2}},
          color={0,0,255},
          smooth=Smooth.Bezier,
          arrow={Arrow.None,Arrow.Filled}),
        Line(
          points={{-10,-34},{0,-44},{0,-54},{20,-54},{20,-74},{40,-74},{40,-84},{46,
              -90}},
          color={0,0,255},
          smooth=Smooth.Bezier,
          arrow={Arrow.None,Arrow.Filled}),
        Text(
          extent={{-180,-84},{180,-120}},
          textString="%name",
          lineColor={0,0,255})}), Diagram(coordinateSystem(preserveAspectRatio=false,
          extent={{-100,-100},{100,100}}), graphics));
end PipeFreeConvection_N;
