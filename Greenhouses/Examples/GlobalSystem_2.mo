within Greenhouses.Examples;
model GlobalSystem_2
  "Greenhouse connected to a CHP, a heat pump and thermal energy storage"
  extends Modelica.Icons.Example;
  Real Mdot_2ry(unit="kg/s",start=0.528);
  Real Mdot_air(unit="kg/s",start=0.528);
  Real E_gas_CHP(unit="kW.h");
  Real E_el_CHP(unit="kW.h");
  Real E_el_HP(unit="kW.h");
  Real E_th_CHP(unit="kW.h");
  Real E_th_HP(unit="kW.h");
  Real E_th_total(unit="kW.h");
  Real E_th_G(unit="kW.h");
  Real E_amb_TES(unit="kW.h");
  Real E_el_sell(unit="kW.h");
  Real E_el_buy(unit="kW.h");
  Real Pi_buy(unit="1/(kW.h)")=0.1415 "50euro/MWh";
  Real Pi_sell(unit="1/(kW.h)")=0.0472;
  Real Pi_gas(unit="1/(kW.h)")=0.0355;
  Real C_sell;
  Real C_buy;
  Real C_gas;
  Real E_gas_CHP_kWhm2(unit="kW.h/m2");
  Real E_el_CHP_kWhm2(unit="kW.h/m2");
  Real E_th_CHP_kWhm2(unit="kW.h/m2");
  Real E_th_HP_kWhm2(unit="kW.h/m2");
  Real E_el_HP_kWhm2(unit="kW.h/m2");
  Real E_th_total_kWhm2(unit="kW.h/m2");
  Real E_th_G_kWhm2(unit="kW.h/m2");
  Real E_amb_TES_kWhm2(unit="kW.h/m2");
  Real E_el_sell_kWhm2(unit="kW.h/m2");
  Real E_el_buy_kWhm2(unit="kW.h/m2");
  Real W_CHP_net(unit="W");
  Real W_sell(unit="W");
  Real W_buy(unit="W");
  Real W_residual(unit="W");
  Greenhouses.Components.HVAC.CHP CHP(
    redeclare package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater,
    Tmax=373.15,
    Th_nom=773.15)
    annotation (Placement(transformation(extent={{-20,-20},{10,10}})));
  Modelica.Fluid.Sensors.Temperature T_ex_CHP(redeclare package Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater)
    annotation (Placement(transformation(extent={{-32,2},{-24,8}})));
  Modelica.Fluid.Sensors.Temperature T_su_CHP(redeclare package Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater)
    annotation (Placement(transformation(extent={{-36,-14},{-28,-8}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow Qdot_nom_gas_CHP
    annotation (Placement(transformation(extent={{26,-4},{18,4}})));
  Modelica.Blocks.Sources.Constant set_Qdot_nom_gas_CHP(k=1750e3)
    annotation (Placement(transformation(extent={{40,-2},{36,2}})));
  Greenhouses.Components.HVAC.HeatStorageWaterHeater.Heat_storage_hx_R TES(
    h_T=0.6,
    U_amb=2,
    steadystate_hx=false,
    Unom_hx=1000,
    steadystate_tank=false,
    redeclare package MainFluid =
        Modelica.Media.Water.ConstantPropertyLiquidWater,
    h2=1,
    h1=0.01,
    N1=1,
    N2=15,
    Wdot_res=115500,
    redeclare package SecondaryFluid =
        Modelica.Media.Water.ConstantPropertyLiquidWater,
    V_hx=0.005*10,
    A_hx=700,
    Mdot_nom=5,
    V_tank=313,
    Tmax=373.15,
    Tstart_inlet_tank=303.15,
    Tstart_outlet_tank=323.15,
    Tstart_inlet_hx=333.15,
    Tstart_outlet_hx=313.15)
    annotation (Placement(transformation(extent={{-10,26},{-40,56}})));
  Modelica.Fluid.Sensors.Temperature T_ex_TES(redeclare package Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater)
    annotation (Placement(transformation(extent={{-44,30},{-52,36}})));
  Modelica.Fluid.Sensors.Temperature T_su_G(redeclare package Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater)
    annotation (Placement(transformation(extent={{-22,66},{-14,72}})));
  Modelica.Fluid.Sensors.Temperature T_ex_G(redeclare package Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater)
    annotation (Placement(transformation(extent={{-16,34},{-8,40}})));
  Greenhouses.Flows.FluidFlow.Pump_Mdot pump_2ry(redeclare package Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater)
    annotation (Placement(transformation(extent={{-60,-64},{-48,-52}})));
  Greenhouses.Flows.FluidFlow.Reservoirs.SinkP sinkP_2ry(redeclare package
      Medium = Modelica.Media.Water.ConstantPropertyLiquidWater, p0=1000000)
    annotation (Placement(transformation(extent={{-76,-48},{-88,-36}})));
  Greenhouses.Flows.FluidFlow.Pdrop pdrop_2ry(
    Mdot_max=0.5,
    redeclare package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater,
    DELTAp_max=1100)
    annotation (Placement(transformation(extent={{-88,-64},{-76,-52}})));
  Greenhouses.Components.Greenhouse.Unit.Greenhouse G
    annotation (Placement(transformation(extent={{46,26},{94,62}})));
  ControlSystems.HVAC.Control_2 controller(
    Mdot_max=86,
    T_max=343.15,
    T_min=313.15,
    Mdot_1ry=pump_1ry.flow_in)
    annotation (Placement(transformation(extent={{-74,-2},{-54,18}})));
  Greenhouses.Flows.FluidFlow.Pump_Mdot pump_1ry(redeclare package Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater, Mdot_0=0.528)
    annotation (Placement(transformation(extent={{24,44},{36,56}})));
  Greenhouses.Flows.FluidFlow.Pdrop pdrop_1ry(
    redeclare package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater,
    Mdot_max=0.5,
    DELTAp_max=1100)
    annotation (Placement(transformation(extent={{-6,48},{6,60}})));
  Greenhouses.Flows.FluidFlow.Reservoirs.SinkP sinkP_1ry(redeclare package
      Medium = Modelica.Media.Water.ConstantPropertyLiquidWater, p0=1000000)
    annotation (Placement(transformation(extent={{6,62},{-6,74}})));
  Modelica.Blocks.Sources.RealExpression set_Mdot_2ry(y=Mdot_2ry)
    annotation (Placement(transformation(extent={{-88,-36},{-74,-24}})));
  Modelica.Fluid.Sensors.Temperature T_su_HP(redeclare package Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater)
    annotation (Placement(transformation(extent={{-36,-52},{-28,-46}})));
  Modelica.Blocks.Sources.RealExpression T_out(y=BruTMY.y[2] + 273.15)
    annotation (Placement(transformation(extent={{32,-32},{22,-22}})));
  Greenhouses.Components.HVAC.HeatPump_ConsoClim HP(
    COP_n=3.5,
    Q_dot_cd_n=490e3,
    redeclare package Medium1 =
        Modelica.Media.Water.ConstantPropertyLiquidWater,
    redeclare package Medium2 = Modelica.Media.Air.SimpleAir,
    T_su_ev_n=280.15,
    T_ex_cd_n=308.15)
    annotation (Placement(transformation(extent={{0,-56},{-20,-36}})));
  Greenhouses.Flows.FluidFlow.Reservoirs.SinkP sinkP_air(redeclare package
      Medium = Modelica.Media.Air.SimpleAir, p0=100000)
    annotation (Placement(transformation(extent={{14,-58},{26,-46}})));
  Greenhouses.Flows.FluidFlow.Reservoirs.SourceMdot sourceMdot(redeclare
      package Medium = Modelica.Media.Air.SimpleAir, Mdot_0=1)
    annotation (Placement(transformation(extent={{26,-44},{14,-32}})));
  Modelica.Blocks.Sources.RealExpression set_Mdot_air(y=Mdot_air)
    annotation (Placement(transformation(extent={{42,-40},{28,-28}})));
  Modelica.Blocks.Sources.CombiTimeTable BruTMY(
    tableOnFile=true,
    tableName="tab",
    columns=1:10,
    fileName=Modelica.Utilities.Files.loadResource(
        "modelica://Greenhouses/Resources/Data/10Dec-22Nov.txt"))
    "TMY of Brussels for the period of 10Dec to 22Nov"
    annotation (Placement(transformation(extent={{-76,80},{-62,94}})));
equation
  Mdot_2ry = if time<1e4 then 10 else (if controller.CHP then 5 else 0);
  Mdot_air = if time<1e4 then 1 else (if controller.CHP then 1 else 0);
  der(E_gas_CHP*1e3*3600) = CHP.Qdot_gas;
  der(E_el_CHP*1e3*3600) = CHP.Wdot_el;
  der(E_th_CHP*1e3*3600) = CHP.prescribedHeatFlow.Q_flow;
  der(E_th_HP*1e3*3600) = HP.Q_dot_cd;
  der(E_el_HP*1e3*3600) = HP.W_dot_cp;
  E_th_total = E_th_CHP + E_th_HP;
  E_th_G = G.E_th_tot;
  der(E_amb_TES*1e3*3600) = sum(TES.cell1DimInc_hx.Q_tot);
  W_CHP_net = CHP.Wdot_el - HP.W_dot_cp;
  W_sell = max(0,W_CHP_net-G.illu.W_el);
  W_buy = max(0,G.illu.W_el-W_CHP_net);
  W_residual = G.illu.W_el-W_CHP_net
    "Positive: residual load (buy), negative: too much (sell)";
  der(E_el_sell*1e3*3600) = max(0,W_CHP_net-G.illu.W_el);
  der(E_el_buy*1e3*3600) = max(0,G.illu.W_el-W_CHP_net);
  C_sell = Pi_sell*E_el_sell;
  C_buy = Pi_buy*E_el_buy;
  C_gas = Pi_gas*E_gas_CHP;
  E_gas_CHP_kWhm2=E_gas_CHP/G.surface.k;
  E_el_CHP_kWhm2=E_el_CHP/G.surface.k;
  E_el_HP_kWhm2=E_el_HP/G.surface.k;
  E_th_CHP_kWhm2=E_th_CHP/G.surface.k;
  E_th_HP_kWhm2=E_th_HP/G.surface.k;
  E_th_total_kWhm2=E_th_total/G.surface.k;
  E_th_G_kWhm2=E_th_G/G.surface.k;
  E_amb_TES_kWhm2=E_amb_TES/G.surface.k;
  E_el_sell_kWhm2=E_el_sell/G.surface.k;
  E_el_buy_kWhm2=E_el_buy/G.surface.k;
  connect(T_ex_CHP.port, CHP.OutFlow) annotation (Line(
      points={{-28,2},{-28,-2.6},{-20,-2.6}},
      color={0,127,255},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(T_su_CHP.port, CHP.InFlow) annotation (Line(
      points={{-32,-14},{-26,-14},{-26,-17.3},{-20,-17.3}},
      color={0,127,255},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(Qdot_nom_gas_CHP.port, CHP.HeatSource) annotation (Line(
      points={{18,0},{18,1.15},{-0.05,1.15}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(set_Qdot_nom_gas_CHP.y, Qdot_nom_gas_CHP.Q_flow) annotation (Line(
      points={{35.8,0},{26,0}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(T_su_G.port, TES.MainFluid_ex) annotation (Line(
      points={{-18,66},{-18,64},{-25.2,64},{-25.2,53.9},{-25,53.9}},
      color={0,127,255},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(T_ex_G.port, TES.MainFluid_su) annotation (Line(
      points={{-12,34},{-12,29.15},{-19.45,29.15}},
      color={0,127,255},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(CHP.OutFlow, TES.SecondaryFluid_ex) annotation (Line(
      points={{-20,-2.6},{-36,-2.6},{-36,36},{-31,36},{-31,36.5}},
      color={0,0,255},
      smooth=Smooth.None,
      thickness=0.5));
  connect(pdrop_2ry.OutFlow, pump_2ry.inlet) annotation (Line(
      points={{-77.5,-58},{-74,-58},{-74,-57.7},{-58.32,-57.7}},
      color={0,0,255},
      smooth=Smooth.None,
      thickness=0.5));
  connect(sinkP_2ry.flangeB, pump_2ry.inlet) annotation (Line(
      points={{-76.96,-42},{-68,-42},{-68,-57.7},{-58.32,-57.7}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(T_ex_TES.port, TES.SecondaryFluid_su) annotation (Line(
      points={{-48,30},{-42,30},{-42,46.1},{-31,46.1}},
      color={0,127,255},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(pdrop_2ry.InFlow, TES.SecondaryFluid_su) annotation (Line(
      points={{-86.5,-58},{-94,-58},{-94,46},{-31,46},{-31,46.1}},
      color={0,0,255},
      smooth=Smooth.None,
      thickness=0.5));
  connect(TES.Temperature, controller.T_tank) annotation (Line(
      points={{-18.85,45.35},{-22,45.35},{-22,42},{-82,42},{-82,4},{-75,4}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(controller.CHP, CHP.on_off) annotation (Line(
      points={{-53.5,14},{-42,14},{-42,-22},{-4,-22},{-4,-18.8},{-4.7,-18.8}},
      color={255,0,255},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(pdrop_1ry.OutFlow, pump_1ry.inlet) annotation (Line(
      points={{4.5,54},{12,54},{12,50.3},{25.68,50.3}},
      color={0,0,255},
      smooth=Smooth.None,
      thickness=0.5));
  connect(sinkP_1ry.flangeB, pump_1ry.inlet) annotation (Line(
      points={{5.04,68},{12,68},{12,50.3},{25.68,50.3}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(G.flangeB, TES.MainFluid_su) annotation (Line(
      points={{53.4,29.2},{20.5,29.2},{20.5,29.15},{-19.45,29.15}},
      color={0,0,255},
      smooth=Smooth.None,
      thickness=0.5));
  connect(pump_1ry.outlet, G.flangeA) annotation (Line(
      points={{33.36,54.44},{33.36,53.7},{53.4,53.7},{53.4,39}},
      color={0,0,255},
      smooth=Smooth.None,
      thickness=0.5));
  connect(pdrop_1ry.InFlow, TES.MainFluid_ex) annotation (Line(
      points={{-4.5,54},{-8,54},{-8,53.9},{-25,53.9}},
      color={0,0,255},
      smooth=Smooth.None,
      thickness=0.5));
  connect(G.PID_Mdot_CS, pump_1ry.flow_in) annotation (Line(
      points={{86.6,34.6},{96,34.6},{96,68},{28,68},{28,54},{28.08,54},{28.08,
          54.8}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(T_ex_TES.T, controller.T_low_TES) annotation (Line(
      points={{-50.8,33},{-50.8,32},{-80,32},{-80,8},{-75,8}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(set_Mdot_2ry.y, pump_2ry.flow_in) annotation (Line(
      points={{-73.3,-30},{-56,-30},{-56,-53.2},{-55.92,-53.2}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(pump_2ry.outlet, HP.Supply_cd) annotation (Line(
      points={{-50.64,-53.56},{-34.32,-53.56},{-34.32,-53},{-19,-53}},
      color={0,0,255},
      smooth=Smooth.None,
      thickness=0.5));
  connect(T_su_HP.port, HP.Supply_cd) annotation (Line(
      points={{-32,-52},{-26,-52},{-26,-53},{-19,-53}},
      color={0,127,255},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(HP.Exhaust_cd, CHP.InFlow) annotation (Line(
      points={{-19,-39},{-19,-28.5},{-20,-28.5},{-20,-17.3}},
      color={0,0,255},
      smooth=Smooth.None,
      thickness=0.5));
  connect(sourceMdot.flangeB, HP.Supply_ev) annotation (Line(
      points={{14.6,-38},{6,-38},{6,-39},{-1,-39}},
      color={135,135,135},
      smooth=Smooth.None));
  connect(T_out.y, sourceMdot.in_T) annotation (Line(
      points={{21.5,-27},{20.75,-27},{20.75,-34.4},{20.12,-34.4}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(HP.Exhaust_ev, sinkP_air.flangeB) annotation (Line(
      points={{-1,-53},{6.5,-53},{6.5,-52},{14.96,-52}},
      color={135,135,135},
      smooth=Smooth.None));
  connect(CHP.Wdot_el, HP.W_dot_set) annotation (Line(
      points={{11.5,-12.5},{11.5,-12},{44,-12},{44,-64},{-10,-64},{-10,-57}},
      color={255,128,0},
      smooth=Smooth.None,
      thickness=0.5));
  connect(T_ex_CHP.T, controller.T_su_hx) annotation (Line(
      points={{-25.2,5},{-22,5},{-22,20},{-78,20},{-78,12},{-75,12}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(set_Mdot_air.y, sourceMdot.in_Mdot) annotation (Line(
      points={{27.3,-34},{26,-34},{26,-34.4},{23.6,-34.4}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(controller.CHP, HP.on_off) annotation (Line(
      points={{-53.5,14},{-42,14},{-42,-56.6},{-14,-56.6}},
      color={255,0,255},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics={
        Text(
          extent={{-64,60},{-28,50}},
          lineColor={0,0,0},
          pattern=LinePattern.Dash,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          textString="Thermal Energy
Storage"),
        Text(
          extent={{56,26},{82,20}},
          lineColor={0,0,0},
          pattern=LinePattern.Dash,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          textString="Greenhouse"),
        Text(
          extent={{-18,-22},{8,-28}},
          lineColor={0,0,0},
          pattern=LinePattern.Dash,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          textString="CHP"),
        Text(
          extent={{-30,-60},{-4,-66}},
          lineColor={0,0,0},
          pattern=LinePattern.Dash,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          textString="HP")}), Icon(graphics={
        Ellipse(lineColor = {75,138,73},
                fillColor={255,255,255},
                fillPattern = FillPattern.Solid,
                extent={{-100,-100},{100,100}}),
        Polygon(lineColor = {0,0,255},
                fillColor = {75,138,73},
                pattern = LinePattern.None,
                fillPattern = FillPattern.Solid,
                points={{-36,60},{64,0},{-36,-60},{-36,60}})}),
    Documentation(info="<html>
    <p><big>This is a second example aiming at illustrating the energy flows interacting between the greenhouse and generation and storage units. In the previous example <a href=\"modelica://Greenhouses.Examples.GlobalSystem_1\">GlobalSystem_1</a>, a considerable part of the produced electricity is sold back to the grid. This electricity, in the absence of subsidies, is remunerated at a price close to the wholesale price of electricity. Because the retail price of electricity is significantly higher than the wholesale price, prosumers have a clear advantage at maximizing their level of self-consumption. </p>
    <p><big>In order to evaluate the potential of such activity, we propose a new case study in which we maximize the self-consumption rate through the use of a heat pump. To that end, the heat pump model from the Greenhouses library is used and is connected in series with the CHP. The excess of electricity that initially was being fed back to the grid is now used to power the heat pump. The heat pump is sized so that its nominal electrical capacity is equal to the excess of electricity of the CHP in nominal conditions. A heat-driven control decides when to run the CHP. The heat pump is powered only by the CHP, and therefore never running independently. Electricity excess not consumed by the heat pump is sold to the grid. The greenhouse electrical demand not covered by the CHP is covered by the grid. The electricity and gas prices are the same than in <a href=\"modelica://Greenhouses.Examples.GlobalSystem_1\">GlobalSystem_1</a>. </p>
    <h4><big>Results</h4>
    <p><big>The results obtained from this simulation are discussed in the online documentation: <a href=\"https://greenhouses-library.readthedocs.io/en/latest\">https://greenhouses-library.readthedocs.io/en/latest</a>. A more detailed discussion including a comparison between this example and <a href=\"modelica://Greenhouses.Examples.GlobalSystem_1\">GlobalSystem_1</a> is presented in the following article:</p>
    <p><big>Altes-Buch Q., Quoilin S., Lemort V.. Modeling and control of CHP generation for greenhouse cultivation including thermal energy storage. In <i>Proceedings of the 31st international conference on efficiency, cost, optimization, simulation and environmental impact of energy systems</i>, Guimaraes, Portugal, June 2018.</p>
</html>"));
end GlobalSystem_2;
