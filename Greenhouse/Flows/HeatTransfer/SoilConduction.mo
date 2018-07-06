within Greenhouse.Flows.HeatTransfer;
model SoilConduction
  import Greenhouse;
  parameter Modelica.SIunits.Area A "floor surface";
  parameter Integer N_c(min=0)=2 "number of concrete layers";
  parameter Integer N_s(min=1)=5 "number of soil layers";
  parameter Modelica.SIunits.ThermalConductivity lambda_c=1.7
    "Thermal conductivity of concrete";
  parameter Modelica.SIunits.ThermalConductivity lambda_s=0.85
    "Thermal conductivity of soil";
  parameter Boolean steadystate=false
    "if true, sets the derivative of T of each layer to zero during Initialization"
    annotation (Dialog(group="Initialization options", tab="Initialization"));
  Modelica.SIunits.ThermalConductance G_s[N_s];
  Modelica.SIunits.ThermalConductance G_c[N_c-1];
  Modelica.SIunits.ThermalConductance G_cc;
  Modelica.SIunits.Length th_s[N_s] "thickness of the soil layers";
  Modelica.SIunits.Length th_c[N_c-1] "thickness of the concrete layers";
  Integer N_cc;

  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port_a
    annotation (Placement(transformation(extent={{-10,66},{10,86}}),
        iconTransformation(extent={{-10,66},{10,86}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature soil
    annotation (Placement(transformation(extent={{84,-50},{64,-30}})));
  Greenhouse.Flows.HeatTransfer.ThermalConductor TC_ss(G=lambda_s/(th_s[N_s]/2)
        *A) annotation (Placement(transformation(extent={{46,-46},{58,-34}})));
  Modelica.Blocks.Interfaces.RealInput T_layer_Nplus1
    annotation (Placement(transformation(extent={{120,-100},{80,-60}}),
        iconTransformation(extent={{120,-100},{80,-60}})));
  Greenhouse.Flows.HeatTransfer.ThermalConductor TC_cc(G=G_cc)
    annotation (Placement(transformation(extent={{-34,38},{-22,50}})));
  Greenhouse.Flows.HeatTransfer.ThermalConductor TC_c[N_c - 1](G=G_c)
    annotation (Placement(transformation(extent={{-84,64},{-64,84}})));
  Greenhouse.Components.Greenhouse.BasicComponents.Layer Layer_c[N_c - 1](
    each rho=1,
    each c_p=2e6,
    each A=A,
    V=A*th_c,
    steadystate=steadystate)
    annotation (Placement(transformation(extent={{-60,64},{-40,84}})));
  Greenhouse.Flows.HeatTransfer.ThermalConductor TC_s[N_s](G=G_s)
    annotation (Placement(transformation(extent={{-4,14},{16,34}})));
  Greenhouse.Components.Greenhouse.BasicComponents.Layer Layer_s[N_s](
    each rho=1,
    each c_p=1.73e6,
    each A=A,
    V=A*th_s,
    steadystate=steadystate)
    annotation (Placement(transformation(extent={{22,14},{42,34}})));
equation
  // Connect port_a depending on if there is concrete layers or not
  if N_c==0 then
    connect(port_a, TC_s[1].port_a);

  else
    if N_c==1 then
      connect(port_a, TC_cc.port_a);

    else
      connect(port_a, TC_c[1].port_a);

    end if;
  end if;

  N_cc = N_c-1;
  // Connect the layers with each other
  //Concrete
  if N_c>1 then
    connect(TC_c[1].port_b, Layer_c[1].heatPort);
    for j in 1:N_c-2 loop
      connect(Layer_c[j].heatPort, TC_c[j+1].port_a);
      connect(TC_c[j+1].port_b, Layer_c[j+1].heatPort);
    end for;
  end if;
  //Soil
  connect(TC_s[1].port_b, Layer_s[1].heatPort);
  for i in 1:N_s-1 loop
    connect(Layer_s[i].heatPort, TC_s[i+1].port_a);
    connect(TC_s[i+1].port_b, Layer_s[i+1].heatPort);
  end for;

  if N_c==0 then
    // Just soil layers
    th_s[1]=0.02;
    G_s[1]=lambda_s/(th_s[1]/4*3)*A;
    G_cc=0;

  else
    // Concrete layers + soil layers
    th_s[1]=0.02*2^(N_c-1);
    G_s[1]=lambda_s/(th_s[1]/2)*A;

    if N_c==1 then
      G_cc = lambda_c/0.005*A;

    else
      G_cc = lambda_c/(th_c[N_c - 1]/2)*A;
      th_c[1] = 0.02;
      G_c[1] = lambda_c/(th_c[1]/4*3)*A;
      if N_c>2 then
        for j in 2:(N_c-1) loop
          th_c[j] = th_c[1]*2^(j-1);
          G_c[j] = lambda_c/(th_c[j]/4*3)*A;
        end for;
      end if;
    end if;
  end if;

  if N_s>1 then
    for i in 2:N_s loop
      th_s[i] = th_s[1]*2^(i-1);
      G_s[i] = lambda_s/(th_s[i]/4*3)*A;
    end for;
  end if;

  connect(TC_ss.port_b, soil.port) annotation (Line(
      points={{58,-40},{64,-40}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(T_layer_Nplus1, soil.T) annotation (Line(
      points={{100,-80},{100,-40},{86,-40}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(Layer_c[N_c - 1].heatPort, TC_cc.port_a) annotation (Line(
      points={{-50,74},{-42,74},{-42,44},{-34,44}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(TC_cc.port_b, TC_s[1].port_a) annotation (Line(
      points={{-22,44},{-16,44},{-16,24},{-4,24}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(Layer_s[N_s].heatPort, TC_ss.port_a) annotation (Line(
      points={{32,24},{38,24},{38,-40},{46,-40}},
      color={191,0,0},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics), Icon(coordinateSystem(
          preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
        graphics={
        Rectangle(
          extent={{-100,60},{100,40}},
          lineColor={0,0,0},
          fillColor={192,192,192},
          fillPattern=FillPattern.Backward),
        Rectangle(
          extent={{-100,40},{100,0}},
          lineColor={90,32,3},
          fillColor={191,84,7},
          fillPattern=FillPattern.Backward),
        Rectangle(
          extent={{-100,0},{100,-80}},
          lineColor={90,32,3},
          fillColor={191,84,7},
          fillPattern=FillPattern.Backward),
        Rectangle(
          extent={{-100,70},{100,60}},
          lineColor={0,0,0},
          fillColor={192,192,192},
          fillPattern=FillPattern.Backward),
        Text(
          extent={{104,10},{142,-18}},
          lineColor={90,32,3},
          lineThickness=0.5,
          fillColor={191,84,7},
          fillPattern=FillPattern.Backward,
          textString="N_s"),
        Text(
          extent={{104,70},{142,42}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={191,84,7},
          fillPattern=FillPattern.Backward,
          textString="N_c"),              Text(
          extent={{-110,-78},{110,-138}},
          lineColor={0,0,0},
          textString="%name")}));
end SoilConduction;
