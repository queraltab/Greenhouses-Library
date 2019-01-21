within Greenhouses.Examples;
model Greenhouse_2
  "Simulation of a Venlo-type greenhouse for tomato crop cultivated from 10Dec-22Nov (weather data from TMY)"
  extends Modelica.Icons.Example;
  Modelica.SIunits.HeatFlux q_tot;

  Real E_th_tot_kWhm2(unit="kW.h/m2");
  Real E_th_tot(unit="kW.h");

  Real DM_Har(unit="mg/m2") "Accumulated harvested tomato dry matter";

  Real W_el_illu(unit="kW.h/m2");
  Real E_el_tot_kWhm2(unit="kW.h/m2");
  Real E_el_tot(unit="kW.h");

  Real DELTAT;
  Real error;

  Greenhouses.Components.Greenhouse.Cover cover(
    rho=2600,
    c_p=840,
    A=surface.k,
    steadystate=true,
    h_cov=1e-3,
    phi=0.43633231299858)
    annotation (Placement(transformation(extent={{22,112},{50,140}})));
  Greenhouses.Components.Greenhouse.Air air(
    A=surface.k,
    steadystate=true,
    steadystateVP=true,
    h_Air=h_Air.y)
    annotation (Placement(transformation(extent={{66,-58},{94,-30}})));
  Greenhouses.Components.Greenhouse.Canopy canopy(
    A=surface.k,
    steadystate=true,
    LAI=TYM.LAI)
    annotation (Placement(transformation(extent={{-78,-76},{-48,-48}})));
  Greenhouses.Flows.HeatTransfer.Radiation_T4 Q_rad_CanCov(
    A=surface.k,
    epsilon_a=1,
    epsilon_b=0.84,
    FFa=canopy.FF,
    FFb=1,
    FFab2=thScreen.FF_ij)
    annotation (Placement(transformation(extent={{-4,-82},{16,-62}})));
  Greenhouses.Components.Greenhouse.Floor floor(
    rho=1,
    c_p=2e6,
    A=surface.k,
    V=0.01*surface.k,
    steadystate=true)
    annotation (Placement(transformation(extent={{-182,-168},{-156,-142}})));

  Greenhouses.Flows.HeatTransfer.Radiation_T4 Q_rad_FlrCan(
    A=surface.k,
    epsilon_a=0.89,
    epsilon_b=1,
    FFa=1,
    FFb=canopy.FF,
    FFab1=pipe_low.FF) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-100,-84})));

  Greenhouses.Flows.HeatTransfer.CanopyFreeConvection Q_cnv_CanAir(A=surface.k,
      LAI=canopy.LAI)
    annotation (Placement(transformation(extent={{-4,-62},{16,-42}})));
  Greenhouses.Flows.HeatTransfer.FreeConvection Q_cnv_FlrAir(
    phi=0,
    A=surface.k,
    floor=true)
    annotation (Placement(transformation(extent={{50,-166},{70,-146}})));
  Greenhouses.Flows.HeatTransfer.Radiation_T4 Q_rad_CovSky(
    epsilon_a=0.84,
    epsilon_b=1,
    A=surface.k)
    annotation (Placement(transformation(extent={{76,146},{96,166}})));
  Modelica.Thermal.HeatTransfer.Celsius.PrescribedTemperature out
    annotation (Placement(transformation(extent={{188,116},{176,128}})));
  Greenhouses.Flows.HeatTransfer.OutsideAirConvection Q_cnv_CovOut(
    A=surface.k,
    u=u_wind.y,
    phi=0.43633231299858) annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={86,140})));
  Greenhouses.Components.Greenhouse.Illumination illu(
    A=surface.k,
    power_input=true,
    LAI=TYM.LAI,
    P_el=500,
    p_el=100)
    annotation (Placement(transformation(extent={{-182,24},{-162,44}})));
  Greenhouses.Flows.HeatTransfer.Radiation_T4 Q_rad_FlrCov(
    A=surface.k,
    epsilon_a=0.89,
    FFa=1,
    FFab1=pipe_low.FF,
    FFab2=canopy.FF,
    epsilon_b=0.84,
    FFb=1,
    FFab4=thScreen.FF_ij) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={6,-146})));

  Modelica.Blocks.Sources.Constant surface(k=1.4e4)
    annotation (Placement(transformation(extent={{-216,106},{-204,118}})));
  Greenhouses.Flows.Sources.Vapour.PrescribedPressure prescribedVPout
    annotation (Placement(transformation(extent={{188,74},{176,86}})));
  Greenhouses.Flows.VapourMassTransfer.MV_CanopyTranspiration MV_CanAir(
    A=surface.k,
    LAI=canopy.LAI,
    CO2_ppm=CO2_air.CO2_ppm,
    R_can=solar_model.R_t_Glob + illu.R_PAR + illu.R_NIR,
    T_can=canopy.T)
    annotation (Placement(transformation(extent={{-4,-100},{16,-80}})));
  Greenhouses.Flows.HeatTransfer.SoilConduction Q_cd_Soil(
    N_c=2,
    N_s=5,
    lambda_c=1.7,
    lambda_s=0.85,
    A=surface.k,
    steadystate=false)
    annotation (Placement(transformation(extent={{-126,-176},{-106,-156}})));

  Greenhouses.Flows.HeatTransfer.Radiation_T4 Q_rad_CanScr(
    A=surface.k,
    epsilon_a=1,
    epsilon_b=1,
    FFa=canopy.FF,
    FFb=thScreen.FF_i)
    annotation (Placement(transformation(extent={{-90,-74},{-110,-54}})));

  Greenhouses.Flows.HeatTransfer.Radiation_T4 Q_rad_FlrScr(
    A=surface.k,
    epsilon_b=1,
    FFab1=canopy.FF,
    epsilon_a=0.89,
    FFa=1,
    FFab3=pipe_low.FF,
    FFb=thScreen.FF_i)
    annotation (Placement(transformation(extent={{-156,-130},{-136,-110}})));

  Greenhouses.Components.Greenhouse.ThermalScreen thScreen(
    A=surface.k,
    SC=SC.y,
    steadystate=false)
    annotation (Placement(transformation(extent={{-134,50},{-104,82}})));
  Greenhouses.Flows.HeatTransfer.Radiation_T4 Q_rad_ScrCov(
    A=surface.k,
    FFb=1,
    epsilon_a=1,
    epsilon_b=0.84,
    FFa=thScreen.FF_i)
    annotation (Placement(transformation(extent={{-40,124},{-20,144}})));

  Greenhouses.Components.Greenhouse.Air_Top air_Top(
    steadystate=true,
    steadystateVP=true,
    h_Top=0.4,
    A=surface.k)
    annotation (Placement(transformation(extent={{-56,86},{-26,114}})));
  Greenhouses.Components.Greenhouse.Solar_model solar_model(
    A=surface.k,
    LAI=TYM.LAI,
    SC=SC.y)
    annotation (Placement(transformation(extent={{-200,130},{-178,152}})));
  Greenhouses.Components.Greenhouse.HeatingPipe pipe_low(
    d=0.051,
    freePipe=false,
    A=surface.k,
    flow1DimInc(steadystate=false, Discretization=Greenhouses.Functions.Enumerations.Discretizations.upwind),
    N=5,
    N_p=625,
    l=50,
    Mdotnom=0.0607*625)
          annotation (Placement(transformation(extent={{-34,-140},{-64,-110}})));
  Greenhouses.Flows.HeatTransfer.Radiation_N Q_rad_LowFlr(
    A=surface.k,
    epsilon_a=0.88,
    FFa=pipe_low.FF,
    epsilon_b=0.89,
    FFb=1,
    N=pipe_low.N) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-100,-134})));
  Greenhouses.Flows.HeatTransfer.Radiation_N Q_rad_LowCan(
    A=surface.k,
    epsilon_b=1,
    FFb=canopy.FF,
    epsilon_a=0.88,
    FFa=pipe_low.FF,
    N=pipe_low.N) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-50,-98})));
  Greenhouses.Flows.HeatTransfer.Radiation_N Q_rad_LowCov(
    A=surface.k,
    epsilon_a=0.88,
    FFa=pipe_low.FF,
    epsilon_b=0.84,
    FFb=1,
    FFab1=canopy.FF,
    FFab3=thScreen.FF_ij,
    N=pipe_low.N) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={6,-134})));
  Greenhouses.Flows.HeatTransfer.PipeFreeConvection_N Q_cnv_LowAir(
    A=surface.k,
    d=pipe_low.d,
    freePipe=false,
    N_p=pipe_low.N_p,
    l=pipe_low.l,
    N=pipe_low.N)
    annotation (Placement(transformation(extent={{-4,-124},{16,-104}})));
  Greenhouses.Flows.HeatTransfer.Radiation_N Q_rad_LowScr(
    A=surface.k,
    epsilon_a=0.88,
    FFa=pipe_low.FF,
    epsilon_b=1,
    FFb=thScreen.FF_i,
    FFab1=canopy.FF,
    N=pipe_low.N) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-100,-114})));
  Greenhouses.Flows.HeatAndVapourTransfer.Convection_Condensation Q_cnv_AirScr(
    phi=0,
    A=surface.k,
    floor=false,
    thermalScreen=true,
    Air_Cov=false,
    SC=SC.y) annotation (Placement(transformation(extent={{-72,32},{-92,12}})));
  Greenhouses.Flows.HeatAndVapourTransfer.Convection_Condensation Q_cnv_AirCov(
    A=surface.k,
    floor=false,
    thermalScreen=true,
    Air_Cov=true,
    topAir=false,
    SC=SC.y,
    phi=0.43633231299858)
    annotation (Placement(transformation(extent={{70,78},{50,58}})));
  Greenhouses.Flows.HeatAndVapourTransfer.Convection_Condensation Q_cnv_TopCov(
    A=surface.k,
    floor=false,
    thermalScreen=true,
    Air_Cov=true,
    topAir=true,
    SC=SC.y,
    phi=0.43633231299858)
    annotation (Placement(transformation(extent={{-14,108},{6,128}})));
  Greenhouses.Flows.HeatAndVapourTransfer.Ventilation Q_ven_AirOut(
    A=surface.k,
    thermalScreen=true,
    topAir=false,
    u=u_wind.y,
    U_vents=U_vents.y,
    SC=SC.y) annotation (Placement(transformation(extent={{140,84},{160,104}})));
  Greenhouses.Flows.HeatAndVapourTransfer.Ventilation Q_ven_TopOut(
    A=surface.k,
    thermalScreen=true,
    u=u_wind.y,
    forcedVentilation=false,
    U_vents=U_vents.y,
    topAir=true,
    SC=SC.y)
    annotation (Placement(transformation(extent={{140,102},{160,122}})));
  Greenhouses.Flows.HeatAndVapourTransfer.AirThroughScreen Q_ven_AirTop(
    A=surface.k,
    K=0.2e-3,
    SC=SC.y,
    W=9.6) annotation (Placement(transformation(extent={{4,42},{-16,22}})));
  Greenhouses.Flows.HeatAndVapourTransfer.Convection_Evaporation Q_cnv_ScrTop(
    A=surface.k,
    SC=SC.y,
    MV_AirScr=Q_cnv_AirScr.MV_flow)
    annotation (Placement(transformation(extent={{-94,88},{-74,108}})));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor Tair_sensor
    annotation (Placement(transformation(extent={{136,-74},{146,-64}})));
  Greenhouses.ControlSystems.PID PID_Mdot(
    PVstart=0.5,
    CSstart=0.5,
    steadyStateInit=false,
    CSmin=0,
    PVmin=13 + 273.15,
    PVmax=28 + 273.15,
    CSmax=38,
    Ti=900,
    Kp=0.9)
    annotation (Placement(transformation(extent={{190,-108},{170,-88}})));
  Modelica.Blocks.Sources.Constant Tsoil7(k=276.15)
    annotation (Placement(transformation(extent={{-54,-174},{-64,-164}})));
  Greenhouses.Flows.Sensors.RHSensor RH_out_sensor
    annotation (Placement(transformation(extent={{206,96},{218,108}})));
  Modelica.Blocks.Sources.RealExpression Tout(y=TMY_and_control.y[2])
    annotation (Placement(transformation(extent={{222,112},{202,132}})));
  Modelica.Blocks.Sources.RealExpression I_glob(y=TMY_and_control.y[5])
    annotation (Placement(transformation(extent={{-238,134},{-218,154}})));
  Modelica.Blocks.Sources.RealExpression u_wind(y=TMY_and_control.y[6])
    annotation (Placement(transformation(extent={{222,128},{202,148}})));
  Modelica.Blocks.Sources.RealExpression VPout(y=
        Greenhouses.Functions.WaterVapourPressure(
                                                 TMY_and_control.y[2],
        TMY_and_control.y[3]))
    annotation (Placement(transformation(extent={{226,70},{202,90}})));
  Modelica.Blocks.Sources.RealExpression OnOff(y=TMY_and_control.y[10])
    annotation (Placement(transformation(extent={{-220,32},{-200,52}})));

  Modelica.Thermal.HeatTransfer.Celsius.PrescribedTemperature sky
    annotation (Placement(transformation(extent={{188,150},{176,162}})));
  Modelica.Blocks.Sources.RealExpression Tsky(y=TMY_and_control.y[7])
    annotation (Placement(transformation(extent={{222,146},{202,166}})));
  Modelica.Blocks.Sources.RealExpression Tair_setpoint(y=SP_new.y[2] +
        273.15)
    annotation (Placement(transformation(extent={{234,-50},{214,-30}})));
  Greenhouses.Components.CropYield.TomatoYieldModel TYM(
    T_canK=canopy.T,
    LAI(start=1.06),
    C_Leaf(start=40e3),
    C_Stem(start=30e3),
    CO2_air=CO2_air.CO2_ppm,
    R_PAR_can=solar_model.R_PAR_Can_umol + illu.R_PAR_Can_umol,
    LAI_MAX=2.7)
    annotation (Placement(transformation(extent={{90,-154},{130,-114}})));
  Greenhouses.Flows.CO2MassTransfer.CO2_Air CO2_air(cap_CO2=h_Air.y)
    annotation (Placement(transformation(extent={{88,-10},{108,10}})));
  Greenhouses.Flows.CO2MassTransfer.CO2_Air CO2_top(cap_CO2=0.4)
    annotation (Placement(transformation(extent={{88,58},{108,78}})));
  Greenhouses.Flows.CO2MassTransfer.MC_ventilation2 MC_AirTop(f_vent=
        Q_ven_AirTop.f_AirTop) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={98,28})));
  Greenhouses.Flows.CO2MassTransfer.MC_ventilation2 MC_AirOut(f_vent=
        Q_ven_AirOut.f_vent_total)
    annotation (Placement(transformation(extent={{140,40},{160,60}})));
  Greenhouses.Flows.CO2MassTransfer.MC_ventilation2 MC_TopOut(f_vent=
        Q_ven_TopOut.f_vent_total)
    annotation (Placement(transformation(extent={{140,66},{160,86}})));
  Greenhouses.Flows.Sources.CO2.PrescribedConcentration CO2out
    annotation (Placement(transformation(extent={{188,46},{176,58}})));
  Modelica.Blocks.Sources.RealExpression CO2out_ppm_to_mgm3(y=340*1.94)
    annotation (Placement(transformation(extent={{222,42},{202,62}})));
  Greenhouses.Flows.CO2MassTransfer.MC_AirCan MC_AirCan(MC_AirCan=TYM.MC_AirCan_mgCO2m2s)
    annotation (Placement(transformation(extent={{88,-98},{108,-78}})));
  Greenhouses.Flows.Sources.CO2.PrescribedCO2Flow MC_ExtAir(phi_ExtCO2=27)
    annotation (Placement(transformation(extent={{152,-10},{132,10}})));
  Greenhouses.ControlSystems.PID PID_CO2(
    PVstart=0.5,
    CSstart=0.5,
    steadyStateInit=false,
    PVmin=708.1,
    PVmax=1649,
    CSmin=0,
    CSmax=1,
    Kp=0.4,
    Ti=0.5) annotation (Placement(transformation(extent={{194,-6},{176,12}})));
  Modelica.Blocks.Sources.RealExpression CO2_air_PV(y=CO2_air.CO2)
    annotation (Placement(transformation(extent={{234,-14},{214,6}})));
  Greenhouses.Flows.FluidFlow.Reservoirs.SourceMdot sourceMdot_1ry(
    redeclare package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater,
    Mdot_0=0.5,
    T_0=363.15)
    annotation (Placement(transformation(extent={{160,-114},{138,-92}})));

  Greenhouses.Flows.FluidFlow.Reservoirs.SinkP sinkP_2ry(redeclare package
      Medium = Modelica.Media.Water.ConstantPropertyLiquidWater, p0=1000000)
    annotation (Placement(transformation(extent={{-76,-104},{-86,-94}})));
  Modelica.Fluid.Sensors.Temperature T_su_1ry(redeclare package Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater)
    annotation (Placement(transformation(extent={{-40,-102},{-32,-96}})));
  Modelica.Fluid.Sensors.Temperature T_ex_1ry(redeclare package Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater)
    annotation (Placement(transformation(extent={{-68,-102},{-60,-96}})));
  Greenhouses.Flows.Sensors.RHSensor RH_air_sensor
    annotation (Placement(transformation(extent={{136,-32},{148,-20}})));
  Modelica.Blocks.Sources.CombiTimeTable TMY_and_control(
    tableOnFile=true,
    tableName="tab",
    columns=1:10,
    fileName=Modelica.Utilities.Files.loadResource("modelica://Greenhouses/Resources/Data/10Dec-22Nov.txt"))
    "Set-points for the climate"
    annotation (Placement(transformation(extent={{-152,152},{-132,172}})));

  Modelica.Blocks.Sources.RealExpression CO2_SP_var(y=SP_new.y[3]*1.94)
    annotation (Placement(transformation(extent={{234,2},{214,22}})));
  Modelica.Blocks.Sources.CombiTimeTable SC_usable(
    tableOnFile=true,
    tableName="tab",
    columns=1:2,
    fileName=Modelica.Utilities.Files.loadResource("modelica://Greenhouses/Resources/Data/SC_usable_10Dec-22Nov.txt"))
    annotation (Placement(transformation(extent={{206,-62},{192,-48}})));
  Greenhouses.ControlSystems.Climate.Control_ThScreen_2 SC(
    R_Glob_can=I_glob.y,
    R_Glob_can_min=35,
    T_air=air.T)
    annotation (Placement(transformation(extent={{178,-48},{152,-28}})));
  Modelica.Blocks.Sources.RealExpression Tout_Kelvin(y=TMY_and_control.y[2] + 273.15)
    annotation (Placement(transformation(extent={{234,-34},{214,-14}})));
  ControlSystems.Climate.Uvents_RH_T_Mdot             U_vents(
    T_air=air.T,
    T_air_sp=Tair_setpoint.y,
    Mdot=PID_Mdot.CS,
    RH_air_input=air.RH)
    annotation (Placement(transformation(extent={{80,108},{96,124}})));
  Modelica.Blocks.Sources.RealExpression h_Air(y=3.8 + (1 - SC.y)*0.4)
    "Height of main zone"
    annotation (Placement(transformation(extent={{-220,78},{-200,98}})));
  Modelica.Blocks.Sources.CombiTimeTable SP_new(
    tableOnFile=true,
    tableName="tab",
    columns=1:3,
    fileName=Modelica.Utilities.Files.loadResource("modelica://Greenhouses/Resources/Data/SP_10Dec-22Nov.txt"))
    "Climate set points 10Dec-22Nov: daily setpoints based on maximizing photosynthesis rate, minimum night temperature of 16, 24h mean temperature of 20"
    annotation (Placement(transformation(extent={{-118,152},{-98,172}})));
equation
  q_tot = -pipe_low.flow1DimInc.Q_tot/surface.y;
  max(q_tot,0) = der(E_th_tot_kWhm2*1e3*3600);
  E_th_tot = E_th_tot_kWhm2*surface.k;

  DM_Har = TYM.DM_Har;

  der(W_el_illu*1000*3600)=illu.W_el/surface.k;
  E_el_tot_kWhm2 = W_el_illu;
  E_el_tot = E_el_tot_kWhm2*surface.k;

  //Error Temperature
  DELTAT=abs(air.T-Tair_setpoint.y);
  DELTAT = der(error);

  connect(canopy.heatPort, Q_rad_CanCov.port_a) annotation (Line(
      points={{-63,-72.36},{-36,-72.36},{-36,-72},{-4,-72}},
      color={191,0,0},
      smooth=Smooth.Bezier));
  connect(Q_rad_CanCov.port_b, cover.heatPort) annotation (Line(
      points={{16,-72},{36,-72},{36,-55.1777},{36,126}},
      color={191,0,0},
      smooth=Smooth.Bezier));

  connect(canopy.heatPort, Q_cnv_CanAir.port_a) annotation (Line(
      points={{-63,-72.36},{-63,-72.36},{-30,-72.36},{-30,-52},{-4,-52}},
      color={255,128,0},
      smooth=Smooth.Bezier));
  connect(Q_cnv_CanAir.port_b, air.heatPort) annotation (Line(
      points={{16,-52},{16,-52},{18,-52},{67.102,-52},{78,-52},{78,-44},{76.92,-44}},
      color={255,128,0},
      smooth=Smooth.Bezier));

  connect(floor.heatPort, Q_cnv_FlrAir.port_a) annotation (Line(
      points={{-169,-155},{-169,-156},{50,-156}},
      color={255,128,0},
      smooth=Smooth.Bezier));
  connect(Q_cnv_FlrAir.port_b, air.heatPort) annotation (Line(
      points={{70,-156},{78,-156},{78,-136.801},{78,-86},{78,-44},{76.92,-44}},
      color={255,128,0},
      smooth=Smooth.Bezier));

  connect(cover.heatPort, Q_rad_CovSky.port_a) annotation (Line(
      points={{36,126},{36,126},{36,156},{76,156}},
      color={191,0,0},
      smooth=Smooth.Bezier));
  connect(canopy.heatPort, Q_rad_FlrCan.port_b) annotation (Line(
      points={{-63,-72.36},{-82,-72.36},{-82,-84},{-90,-84}},
      color={191,0,0},
      smooth=Smooth.Bezier));

  connect(Q_rad_FlrCov.port_b, cover.heatPort) annotation (Line(
      points={{16,-146},{36,-146},{36,-131.871},{36,126}},
      color={191,0,0},
      smooth=Smooth.Bezier));

  connect(floor.heatPort, Q_rad_FlrCan.port_a) annotation (Line(
      points={{-169,-155},{-169,-155},{-169,-91.2773},{-169,-84},{-155.575,-84},
          {-110,-84}},
      color={191,0,0},
      smooth=Smooth.Bezier));
  connect(floor.heatPort, Q_rad_FlrCov.port_a) annotation (Line(
      points={{-169,-155},{-113.937,-155},{-106,-155},{-106,-146},{-89.4648,-146},
          {-4,-146}},
      color={191,0,0},
      smooth=Smooth.Bezier));
  connect(MV_CanAir.port_b, air.massPort) annotation (Line(
      points={{16,-90},{16,-90},{67.3066,-90},{84,-90},{84,-68},{84,-44},{83.08,
          -44}},
      color={0,0,255},
      smooth=Smooth.Bezier));

  connect(floor.heatPort, Q_cd_Soil.port_a) annotation (Line(
      points={{-169,-155},{-146,-155},{-146,-160},{-135.57,-160},{-116,-160},{-116,
          -158.4}},
      color={0,127,0},
      smooth=Smooth.Bezier));
  connect(Q_rad_CanScr.port_a, canopy.heatPort) annotation (Line(
      points={{-90,-64},{-78,-64},{-78,-72.36},{-63,-72.36}},
      color={191,0,0},
      smooth=Smooth.Bezier));
  connect(Q_rad_CanScr.port_b, thScreen.heatPort) annotation (Line(
      points={{-110,-64},{-110,-64},{-122,-64},{-122,-38},{-122,66},{-122.6,66}},
      color={191,0,0},
      smooth=Smooth.Bezier));

  connect(Q_rad_FlrScr.port_b, thScreen.heatPort) annotation (Line(
      points={{-136,-120},{-122,-120},{-122,-112.625},{-122,66},{-122.6,66}},
      color={191,0,0},
      smooth=Smooth.Bezier));
  connect(thScreen.heatPort, Q_rad_ScrCov.port_a) annotation (Line(
      points={{-122.6,66},{-122,66},{-122,110},{-70,110},{-70,134},{-40,134},{-40,
          134}},
      color={191,0,0},
      smooth=Smooth.Bezier));
  connect(Q_rad_ScrCov.port_b, cover.heatPort) annotation (Line(
      points={{-20,134},{-20,134},{2,134},{2,126},{10,126},{36,126}},
      color={191,0,0},
      smooth=Smooth.Bezier));

  connect(floor.heatPort, Q_rad_FlrScr.port_a) annotation (Line(
      points={{-169,-155},{-169,-120},{-156,-120}},
      color={191,0,0},
      smooth=Smooth.Bezier));

  connect(solar_model.R_SunCov_Glob, cover.R_SunCov_Glob) annotation (Line(
      points={{-176.9,146.5},{-22.8761,146.5},{8.8647,146.5},{26,146.5},{26,134},
          {26,132},{26.2,132},{26.2,131.6}},
      color={255,207,14},
      smooth=Smooth.Bezier));
  connect(solar_model.R_SunFlr_Glob, floor.R_Flr_Glob[1]) annotation (Line(
      points={{-176.9,130},{-178,130},{-178,-130.064},{-178,-149.8},{-176.8,-149.8}},
      color={255,207,14},
      smooth=Smooth.Bezier));
  connect(illu.R_IluFlr_Glob, floor.R_Flr_Glob[2]) annotation (Line(
      points={{-178,27},{-178,-130.011},{-178,-149.8},{-176.8,-149.8}},
      color={255,207,14},
      smooth=Smooth.Bezier));
  connect(illu.R_IluAir_Glob, air.R_Air_Glob[2]) annotation (Line(
      points={{-166,27},{-166,27},{-166,10},{-156.015,10},{51.5469,10},{72,10},{
          72,-6},{72,-35.6},{73,-35.6}},
      color={191,0,0},
      smooth=Smooth.Bezier));
  connect(pipe_low.heatPorts, Q_rad_LowCov.heatPorts_a) annotation (Line(
      points={{-49,-119},{-30,-119},{-30,-134},{-3,-134}},
      color={191,0,0},
      smooth=Smooth.Bezier));
  connect(Q_rad_LowCan.heatPorts_a, pipe_low.heatPorts) annotation (Line(
      points={{-50,-107},{-50,-116.5},{-49,-116.5},{-49,-119}},
      color={191,0,0},
      smooth=Smooth.Bezier));
  connect(canopy.heatPort, Q_rad_LowCan.port_b) annotation (Line(
      points={{-63,-72.36},{-63,-72.18},{-50,-72.18},{-50,-88}},
      color={191,0,0},
      smooth=Smooth.Bezier));
  connect(Q_rad_LowFlr.heatPorts_a, pipe_low.heatPorts) annotation (Line(
      points={{-91,-134},{-72,-134},{-72,-119},{-49,-119}},
      color={191,0,0},
      smooth=Smooth.Bezier));
  connect(pipe_low.heatPorts, Q_cnv_LowAir.heatPorts_a) annotation (Line(
      points={{-49,-119},{-30,-119},{-30,-114},{-3,-114}},
      color={255,128,0},
      smooth=Smooth.Bezier));
  connect(Q_cnv_LowAir.port_b, air.heatPort) annotation (Line(
      points={{16,-114},{16,-114},{62.3184,-114},{78,-114},{78,-76},{78,-44},{76.92,
          -44}},
      color={255,128,0},
      smooth=Smooth.Bezier));
  connect(Q_rad_LowCov.port_b, cover.heatPort) annotation (Line(
      points={{16,-134},{36,-134},{36,-110.816},{36,126}},
      color={191,0,0},
      smooth=Smooth.Bezier));
  connect(pipe_low.heatPorts, Q_rad_LowScr.heatPorts_a) annotation (Line(
      points={{-49,-119},{-71.5,-119},{-71.5,-114},{-91,-114}},
      color={191,0,0},
      smooth=Smooth.Bezier));
  connect(Q_rad_LowScr.port_b, thScreen.heatPort) annotation (Line(
      points={{-110,-114},{-122,-114},{-122,-98.531},{-122,66},{-122.6,66}},
      color={191,0,0},
      smooth=Smooth.Bezier));

  connect(solar_model.R_SunAir_Glob, air.R_Air_Glob[1]) annotation (Line(
      points={{-176.9,141},{-162,141},{-156,141},{-156,129.25},{-156,82},{-156,26.0195},
          {-156,14},{-142,14},{-146.408,14},{58,14},{72,14},{72,-12},{72,-35.6},
          {73,-35.6}},
      color={191,0,0},
      smooth=Smooth.Bezier));

  connect(Q_cnv_AirScr.HeatPort_a, air.heatPort) annotation (Line(
      points={{-72,20},{-72,20},{52.2539,20},{78,20},{78,-4},{78,-44},{76.92,-44}},
      color={255,128,0},
      smooth=Smooth.Bezier));

  connect(Q_cnv_AirScr.MassPort_a, air.massPort) annotation (Line(
      points={{-72,24},{-72,24},{66.7559,24},{84,24},{84,-4},{84,-44},{83.08,-44}},
      color={0,0,255},
      smooth=Smooth.Bezier));
  connect(Q_cnv_AirScr.MassPort_b, thScreen.massPort) annotation (Line(
      points={{-92,24},{-92,24},{-116,24},{-116,66},{-115.4,66}},
      color={0,0,255},
      smooth=Smooth.Bezier));
  connect(Q_cnv_AirScr.HeatPort_b, thScreen.heatPort) annotation (Line(
      points={{-92,20},{-122,20},{-122,66},{-122.6,66}},
      color={255,128,0},
      smooth=Smooth.Bezier));
  connect(Q_cnv_AirCov.HeatPort_a, air.heatPort) annotation (Line(
      points={{70,66},{78,66},{78,51.6055},{78,-44},{76.92,-44}},
      color={255,128,0},
      smooth=Smooth.Bezier));
  connect(Q_cnv_AirCov.HeatPort_b, cover.heatPort) annotation (Line(
      points={{50,66},{36,66},{36,126}},
      color={255,128,0},
      smooth=Smooth.Bezier));
  connect(Q_cnv_AirCov.MassPort_b, cover.massPort) annotation (Line(
      points={{50,70},{42,70},{42,126},{41.6,126}},
      color={0,0,255},
      smooth=Smooth.Bezier));
  connect(Q_cnv_AirCov.MassPort_a, air.massPort) annotation (Line(
      points={{70,70},{84,70},{84,56.6406},{84,-44},{83.08,-44}},
      color={0,0,255},
      smooth=Smooth.Bezier));
  connect(air_Top.heatPort, Q_cnv_TopCov.HeatPort_a) annotation (Line(
      points={{-44.3,100},{-44,100},{-44,120},{-14,120}},
      color={255,128,0},
      smooth=Smooth.Bezier));
  connect(air_Top.massPort, Q_cnv_TopCov.MassPort_a) annotation (Line(
      points={{-37.7,100},{-26,100},{-26,116},{-14,116}},
      color={0,0,255},
      smooth=Smooth.Bezier));
  connect(Q_cnv_TopCov.MassPort_b, cover.massPort) annotation (Line(
      points={{6,116},{42,116},{42,126},{41.6,126}},
      color={0,0,255},
      smooth=Smooth.Bezier));
  connect(Q_cnv_TopCov.HeatPort_b, cover.heatPort) annotation (Line(
      points={{6,120},{22,120},{36,120},{36,126}},
      color={255,128,0},
      smooth=Smooth.Bezier));
  connect(Q_ven_AirOut.HeatPort_a, air.heatPort) annotation (Line(
      points={{140,96},{140,96},{87.928,96},{78,96},{78,83.8125},{78,-44},{76.92,
          -44}},
      color={255,128,0},
      smooth=Smooth.Bezier));
  connect(Q_ven_AirOut.HeatPort_b, out.port) annotation (Line(
      points={{160,96},{168,96},{168,106},{168,122},{176,122}},
      color={255,128,0},
      smooth=Smooth.Bezier));
  connect(Q_ven_AirOut.MassPort_b, prescribedVPout.port) annotation (Line(
      points={{160,92},{166,92},{166,80},{176,80}},
      color={0,0,255},
      smooth=Smooth.Bezier));
  connect(Q_ven_AirOut.MassPort_a, air.massPort) annotation (Line(
      points={{140,92},{140,92},{84,92},{84,78.834},{84,-44},{83.08,-44}},
      color={0,0,255},
      smooth=Smooth.Bezier));

  connect(Q_ven_TopOut.HeatPort_b, out.port) annotation (Line(
      points={{160,114},{168,114},{168,122},{176,122}},
      color={255,128,0},
      smooth=Smooth.Bezier));
  connect(Q_ven_TopOut.MassPort_b, prescribedVPout.port) annotation (Line(
      points={{160,110},{166,110},{166,80},{176,80}},
      color={0,0,255},
      smooth=Smooth.Bezier));
  connect(air_Top.massPort, Q_ven_TopOut.MassPort_a) annotation (Line(
      points={{-37.7,100},{119.909,100},{128,100},{128,110},{140,110}},
      color={0,0,255},
      smooth=Smooth.Bezier));
  connect(air_Top.heatPort, Q_ven_TopOut.HeatPort_a) annotation (Line(
      points={{-44.3,100},{-44.3,104},{-19.7386,104},{110,104},{126,104},{126,114},
          {140,114}},
      color={255,128,0},
      smooth=Smooth.Bezier));
  connect(Q_ven_AirTop.MassPort_a, air.massPort) annotation (Line(
      points={{4,34},{4,34},{72.8301,34},{84,34},{84,18.2324},{84,-44},{83.08,-44}},
      color={0,0,255},
      smooth=Smooth.Bezier));
  connect(Q_ven_AirTop.MassPort_b, air_Top.massPort) annotation (Line(
      points={{-16,34},{-26,34},{-26,68},{-26,100},{-37.7,100}},
      color={0,0,255},
      smooth=Smooth.Bezier));
  connect(Q_ven_AirTop.HeatPort_a, air.heatPort) annotation (Line(
      points={{4,30},{4,30},{69.4844,30},{78,30},{78,16.0527},{78,-44},{76.92,-44}},
      color={255,128,0},
      smooth=Smooth.Bezier));
  connect(Q_ven_AirTop.HeatPort_b, air_Top.heatPort) annotation (Line(
      points={{-16,30},{-34.9766,30},{-44,30},{-44,42.6543},{-44,100},{-44.3,100}},
      color={255,128,0},
      smooth=Smooth.Bezier));

  connect(canopy.massPort, MV_CanAir.port_a) annotation (Line(
      points={{-63,-76.84},{-63,-76.84},{-30,-76.84},{-30,-84},{-30,-90},{-4,-90}},
      color={0,0,255},
      smooth=Smooth.Bezier));

  connect(canopy.R_Can_Glob[2], illu.R_IluCan_Glob) annotation (Line(
      points={{-67.5,-50.8},{-67.5,-49.4},{-161.083,-49.4},{-172.75,-49.4},{-172.75,
          -27.0172},{-172.75,27},{-172,27}},
      color={255,207,14},
      smooth=Smooth.Bezier));
  connect(canopy.R_Can_Glob[1], solar_model.R_SunCan_Glob) annotation (Line(
      points={{-67.5,-50.8},{-67.5,-50},{-142.703,-50},{-160,-50},{-160,-31.2969},
          {-160,118},{-160,136},{-176.9,136},{-176.9,135.5}},
      color={255,207,14},
      smooth=Smooth.Bezier));
  connect(floor.heatPort, Q_rad_LowFlr.port_b) annotation (Line(
      points={{-169,-155},{-168,-155},{-168,-156},{-168,-146},{-168,-134},{-153.387,
          -134},{-110,-134}},
      color={191,0,0},
      smooth=Smooth.Bezier));
  connect(thScreen.heatPort, Q_cnv_ScrTop.HeatPort_a) annotation (Line(
      points={{-122.6,66},{-122,66},{-122,100},{-94,100}},
      color={255,128,0},
      smooth=Smooth.Bezier));
  connect(Q_cnv_ScrTop.HeatPort_b, air_Top.heatPort) annotation (Line(
      points={{-74,100},{-44.3,100}},
      color={255,128,0},
      smooth=Smooth.Bezier));
  connect(thScreen.massPort, Q_cnv_ScrTop.MassPort_a) annotation (Line(
      points={{-115.4,66},{-115.4,82},{-116,82},{-116,96},{-94,96}},
      color={0,0,255},
      smooth=Smooth.Bezier));
  connect(Q_cnv_ScrTop.MassPort_b, air_Top.massPort) annotation (Line(
      points={{-74,96},{-56,96},{-38,96},{-38,100},{-37.7,100}},
      color={0,0,255},
      smooth=Smooth.Bezier));
  connect(air.heatPort, Tair_sensor.port) annotation (Line(
      points={{76.92,-44},{78,-44},{78,-69},{136,-69}},
      color={191,0,0},
      smooth=Smooth.Bezier,
      pattern=LinePattern.Dash));

  connect(Tsoil7.y, Q_cd_Soil.T_layer_Nplus1) annotation (Line(
      points={{-64.5,-169},{-76.25,-169},{-76.25,-174},{-106,-174}},
      color={0,0,127},
      smooth=Smooth.Bezier));
  connect(prescribedVPout.port, RH_out_sensor.massPort) annotation (Line(
      points={{176,80},{196,80},{196,99.6},{206,99.6}},
      color={0,0,255},
      smooth=Smooth.Bezier,
      pattern=LinePattern.Dash));
  connect(out.port, RH_out_sensor.heatPort) annotation (Line(
      points={{176,122},{194,122},{194,104.4},{206,104.4}},
      color={191,0,0},
      smooth=Smooth.Bezier,
      pattern=LinePattern.Dash));
  connect(Tout.y, out.T) annotation (Line(
      points={{201,122},{201,122},{189.2,122}},
      color={0,0,127},
      smooth=Smooth.Bezier,
      pattern=LinePattern.Dash));
  connect(I_glob.y, solar_model.I_glob) annotation (Line(
      points={{-217,144},{-210,144},{-210,141},{-202.2,141}},
      color={0,0,127},
      smooth=Smooth.Bezier,
      pattern=LinePattern.Dash));

  connect(VPout.y, prescribedVPout.VP) annotation (Line(
      points={{200.8,80},{200.8,80},{189.2,80}},
      color={0,0,127},
      smooth=Smooth.Bezier,
      pattern=LinePattern.Dash));
  connect(OnOff.y, illu.switch) annotation (Line(
      points={{-199,42},{-192,42},{-192,40.4},{-174.2,40.4}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(cover.heatPort, Q_cnv_CovOut.port_a) annotation (Line(
      points={{36,126},{36,126},{36,140},{76,140}},
      color={255,128,0},
      smooth=Smooth.Bezier));
  connect(Q_cnv_CovOut.port_b, out.port) annotation (Line(
      points={{96,140},{136,140},{136,122},{176,122}},
      color={255,128,0},
      smooth=Smooth.Bezier));
  connect(Tsky.y, sky.T) annotation (Line(
      points={{201,156},{189.2,156}},
      color={0,0,127},
      smooth=Smooth.Bezier,
      pattern=LinePattern.Dash));
  connect(sky.port, Q_rad_CovSky.port_b) annotation (Line(
      points={{176,156},{138,156},{96,156}},
      color={191,0,0},
      smooth=Smooth.Bezier));
  connect(Tair_sensor.T, PID_Mdot.PV) annotation (Line(
      points={{146,-69},{146,-69},{206,-69},{206,-102},{190,-102}},
      color={0,0,127},
      smooth=Smooth.Bezier,
      pattern=LinePattern.Dash));
  connect(Tair_setpoint.y, PID_Mdot.SP) annotation (Line(
      points={{213,-40},{213,-94},{190,-94}},
      color={0,0,127},
      smooth=Smooth.Bezier,
      pattern=LinePattern.Dash));
  connect(CO2out_ppm_to_mgm3.y,CO2out. CO2) annotation (Line(
      points={{201,52},{206,52},{189.2,52}},
      color={0,0,127},
      smooth=Smooth.Bezier,
      pattern=LinePattern.Dash));
  connect(CO2_air.port, MC_AirOut.port_a) annotation (Line(
      points={{98,0},{112,0},{112,13.166},{112,42},{112,68.793},{112,80},{120,80},
          {132,80},{132,70},{132,50},{140,50}},
      color={95,95,95},
      smooth=Smooth.Bezier));
  connect(MC_AirOut.port_b, CO2out.port) annotation (Line(
      points={{160,50},{176,50},{176,52}},
      color={95,95,95},
      smooth=Smooth.Bezier));
  connect(CO2_air.port, MC_AirTop.port_a) annotation (Line(
      points={{98,0},{98,18}},
      color={95,95,95},
      smooth=Smooth.Bezier));
  connect(MC_AirTop.port_b, CO2_top.port) annotation (Line(
      points={{98,38},{98,68}},
      color={95,95,95},
      smooth=Smooth.Bezier));
  connect(CO2_top.port, MC_TopOut.port_a) annotation (Line(
      points={{98,68},{100,68},{100,88},{117.598,88},{134,88},{134,76},{140,76}},
      color={95,95,95},
      smooth=Smooth.Bezier));
  connect(MC_TopOut.port_b, CO2out.port) annotation (Line(
      points={{160,76},{160,72},{170,72},{170,52},{176,52}},
      color={95,95,95},
      smooth=Smooth.Bezier));
  connect(CO2_air.port, MC_AirCan.port) annotation (Line(
      points={{98,0},{98,-79}},
      color={95,95,95},
      smooth=Smooth.Bezier));
  connect(MC_ExtAir.port, CO2_air.port) annotation (Line(
      points={{132,0},{98,0}},
      color={95,95,95},
      smooth=Smooth.None));
  connect(CO2_air_PV.y, PID_CO2.PV) annotation (Line(
      points={{213,-4},{204,-4},{204,0},{196,0},{194,0},{194,-0.6}},
      color={0,0,127},
      smooth=Smooth.Bezier,
      pattern=LinePattern.Dash));

  connect(sourceMdot_1ry.flangeB, pipe_low.pipe_in) annotation (Line(
      points={{139.1,-103},{139.1,-104},{114,-104},{-15.4707,-104},{-37,-104},{-37,
          -125}},
      color={0,128,255},
      smooth=Smooth.Bezier));
  connect(PID_Mdot.CS, sourceMdot_1ry.in_Mdot) annotation (Line(
      points={{169.4,-98},{152,-98},{152,-96.4},{155.6,-96.4}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(T_su_1ry.port, pipe_low.pipe_in) annotation (Line(
      points={{-36,-102},{-36,-116},{-37,-116},{-37,-125}},
      color={0,127,255},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(T_ex_1ry.port, pipe_low.pipe_out) annotation (Line(
      points={{-64,-102},{-64,-125},{-61,-125}},
      color={0,127,255},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));

  connect(air.heatPort, RH_air_sensor.heatPort) annotation (Line(
      points={{76.92,-44},{90,-44},{90,-23.6},{136,-23.6}},
      color={191,0,0},
      smooth=Smooth.Bezier,
      pattern=LinePattern.Dash));
  connect(air.massPort, RH_air_sensor.massPort) annotation (Line(
      points={{83.08,-44},{91.54,-44},{91.54,-28.4},{136,-28.4}},
      color={0,0,255},
      smooth=Smooth.Bezier,
      pattern=LinePattern.Dash));
  connect(CO2_SP_var.y, PID_CO2.SP) annotation (Line(
      points={{213,12},{202,12},{202,6.6},{194,6.6}},
      color={0,0,127},
      smooth=Smooth.Bezier,
      pattern=LinePattern.Dash));
  connect(SC_usable.y[2], SC.SC_usable) annotation (Line(
      points={{191.3,-55},{186,-55},{186,-48},{182,-48},{182,-47},{179.3,-47}},
      color={0,0,127},
      smooth=Smooth.Bezier,
      pattern=LinePattern.Dash));
  connect(Tair_setpoint.y, SC.T_air_sp) annotation (Line(
      points={{213,-40},{204,-40},{180,-40},{179.3,-40},{179.3,-41}},
      color={0,0,127},
      smooth=Smooth.Bezier,
      pattern=LinePattern.Dash));
  connect(Tout_Kelvin.y, SC.T_out) annotation (Line(
      points={{213,-24},{213,-24},{200,-24},{200,-35},{179.3,-35}},
      color={0,0,127},
      smooth=Smooth.Bezier,
      pattern=LinePattern.Dash));
  connect(RH_air_sensor.RH, SC.RH_air) annotation (Line(
      points={{148,-26},{148,-26},{186,-26},{186,-29},{179.3,-29}},
      color={0,0,127},
      smooth=Smooth.Bezier,
      pattern=LinePattern.Dash));
  connect(PID_CO2.CS, MC_ExtAir.U_MCext) annotation (Line(
      points={{175.46,3},{169.73,3},{169.73,0.2},{154.2,0.2}},
      color={0,0,127},
      smooth=Smooth.Bezier));
  connect(sinkP_2ry.flangeB, pipe_low.pipe_out) annotation (Line(
      points={{-76.8,-99},{-76.8,-111.5},{-61,-111.5},{-61,-125}},
      color={0,0,255},
      smooth=Smooth.None));
  annotation (
      Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-240,-180},{240,
            180}}), graphics={
        Polygon(
          points={{-190,-158},{130,-158},{130,66},{-30,166},{-190,66},{-190,-158}},
          lineColor={135,135,135},
          smooth=Smooth.None,
          lineThickness=1),
        Line(
          points={{-70,124}},
          color={135,135,135},
          thickness=1,
          smooth=Smooth.None),
        Line(
          points={{50,116},{114,76}},
          color={255,255,255},
          thickness=1,
          smooth=Smooth.None),
        Line(
          points={{50,116},{122,116}},
          color={135,135,135},
          thickness=1,
          smooth=Smooth.None),
        Line(
          points={{146,-138},{166,-138}},
          color={255,128,0},
          smooth=Smooth.Bezier),
        Line(
          points={{146,-146},{166,-146}},
          color={191,0,0},
          smooth=Smooth.Bezier),
        Line(
          points={{146,-154},{166,-154}},
          color={255,207,14},
          smooth=Smooth.Bezier),
        Text(
          extent={{170,-136},{230,-172}},
          lineColor={0,0,0},
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid,
          horizontalAlignment=TextAlignment.Left,
          textString="Convection
Long-wave radiation
Short-wave radiation
Conduction
Vapour transfer"),
        Line(
          points={{146,-162},{166,-162}},
          color={0,127,0},
          smooth=Smooth.Bezier),
        Line(
          points={{146,-170},{166,-170}},
          color={0,0,255},
          smooth=Smooth.Bezier),
        Line(
          points={{-190,52},{130,52}},
          color={135,135,135},
          smooth=Smooth.None,
          thickness=0.5),
        Line(
          points={{-190,44},{130,44}},
          color={135,135,135},
          smooth=Smooth.None,
          thickness=0.5),
        Line(
          points={{-190,52},{-180,44},{-170,52},{-160,44},{-150,52},{-140,44},{-130,
              52},{-120,44},{-110,52},{-100,44},{-90,52},{-80,44},{-70,52},{-60,
              44},{-50,52},{-40,44},{-30,52},{-20,44},{-10,52},{0,44},{10,52},{20,
              44},{30,52},{40,44},{50,52},{60,44},{70,52},{80,44},{90,52},{100,44},
              {110,52},{120,44},{130,52}},
          color={135,135,135},
          thickness=0.5,
          smooth=Smooth.None),
        Line(
          points={{-190,62},{-186,66},{-182,58},{-178,66},{-174,58},{-170,66},{-166,
              58},{-162,66},{-158,58},{-154,66},{-150,58},{-146,66},{-142,58},{-138,
              66},{-134,58},{-130,66},{-126,58},{-122,66},{-118,58},{-114,66},{-110,
              58},{-106,66},{-102,58},{-98,66},{-94,58},{-90,66},{-86,58},{-82,66},
              {-78,58},{-74,66},{-70,58},{-66,66},{-62,58},{-58,66},{-54,58},{-50,
              66},{-46,58},{-42,66},{-38,58},{-34,66},{-30,58},{-26,66},{-22,58},
              {-18,66},{-14,58},{-10,66},{-6,58},{-2,66},{2,58},{6,66},{10,58},{
              14,66},{18,58},{22,66},{26,58},{28,62},{32,62}},
          color={95,95,95},
          thickness=0.5,
          smooth=Smooth.Bezier),
        Rectangle(
          extent={{32,64},{34,60}},
          lineColor={95,95,95},
          lineThickness=0.5,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid)}),
                                 Icon(coordinateSystem(preserveAspectRatio=false,
          extent={{-100,-100},{100,100}})),
    Documentation(info="<html>
<p><b></font><font style=\"font-size: 12pt; \">Simulation of greenhouse climate</b></p>
<p></font><font style=\"font-size: 10pt; \">This example intends to illustrate the simulation of a greenhouse climate. The greenhouse is built by interconnecting all of the energy and mass <a href=\"modelica://Greenhouses.Flows\">Flows</a> presents in a greenhouse to their related <a href=\"modelica://Greenhouses.Components.Greenhouse\">Components</a>. As it can be distinguished, the greenhouse modeled in this example consists of one level of heating circuit, roof windows (but not side vents), natural ventilation (no forced ventilation) and a movable thermal screen. It should be noted that, when the screen is drawn, the air of the greenhouse is divided in two zones, i.e. below and above the screen. These zones are modeled separately (models air and air_Top) and their climate is assumed to be homogeneous. The models parameters have been set to typical values for Venlo-type greenhouse construction design dedicated to tomato crop cultivation. The greenhouse floor area and the mean greenhouse height are set in two individual block sources.</p>
<p><big>The simulated greenhouse is located in Belgium and the simulation period is from December 10th to November 22nd. Two data files are required: </p>
<ul>
<li><big><i>Weather data</i>: The input weather data for the simulation period is extracted from a TMY for Brussels and can be found in <a href=\"modelica://Greenhouses/Resources/Data/10Dec-22Nov.txt\">&lsquo;Greenhouses/Resources/Data/10Dec-22Nov.txt&rsquo;</a>. The file contains data for the outside air temperature, air pressure, wind speed and global irradiation. The sky temperature, previously computed in a Python script, is also included in this file. </li>
<li><big><i>Climate control set-points</i>: The temperature and CO2 set-points for the simulation period are calculated according to the strategy presented in the online documentation and can be found in <a href=\"modelica://Greenhouses/Resources/Data/SP_10Dec-22Nov.txt\">&lsquo;Greenhouses/Resources/Data/SP_10Dec-22Nov.txt&rsquo;</a>.</li>
</ul>
<p><big> These '.txt' files are accessed by means of <i>TMY_and_control</i> and <i>SP_new</i>, which are two CombiTimeTables models from the Modelica Standard Library.</p>
<p><big>The goal of this example is to show the energy flows interacting in a greenhouse. Thus, no generation units are included. Instead, the heating pipes are connected to a water source and sink model. The model includes the following controls:</p>
<ul>
<li><big><i>PID_Mdot</i>: A PI controller adjusts the output mass flow rate of the water source connected to the heating pipes by comparing the air temperature set-point and present value.</li>
<li><big><i>PID_CO2</i>: A PI controller adjusts the output of the CO2 external source by comparing the actual CO2 concentration of the air to its set-point.</li>
<li><big><i>Ctrl_SC</i>: A state graph adjusts the screen closure (SC) according to the strategy presented in <a href=\"modelica://Greenhouses.ControlSystems.Climate.Control_ThScreen_2\">Control_ThScreen_2</a>. The real inputs must be connected to the air relative humidity, the outdoor temperature, the indoor air temperature set-point and the usable hours of the screen. The usable hours are 1h30 before dusk, 1h30 after dawn and during night.</li>
<li><big><i>vents</i>: A PI controller adjusts the opening of the windows according to the strategy presented in <a href=\"modelica://Greenhouses.ControlSystems.Climate.Uvents_RH_T_Mdot\">Uvents_RH_T_Mdot</a>. The opening depends mainly on the indoor air relative humidity and temperature.</li>
<li><big><i>OnOff</i>: controls the ON/OFF operation of the supplementary lighting according to the strategy presented in Control Systems. The control output, previously computed in a Python script, is input as a .txt file by means of the TMY_and_control CombiTimeTable.</li>
</ul>
</html>"));
end Greenhouse_2;
