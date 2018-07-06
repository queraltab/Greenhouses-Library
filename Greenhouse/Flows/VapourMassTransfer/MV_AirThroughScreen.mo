within Greenhouse.Flows.VapourMassTransfer;
model MV_AirThroughScreen
  "Vapour mass flow exchanged from the greenhouse main air zone (below the thermal screen) to the top air zone (above the screen)"
  extends Greenhouse.Flows.Interfaces.Vapour.Element1D;

  /*********************** Parameters ***********************/
  parameter Modelica.SIunits.Area A "floor surface";
  parameter Boolean input_f_AirTop=true
    "True if input the exchange rate, False to compute it in this model";
  parameter Real f_AirTop=0
    "Air exchange rate computed in model AirThroughScreen"                       annotation (Dialog(enable=(input_f_AirTop)));
  parameter Modelica.SIunits.Length W "length of the screen when closed (SC=1)"
                                                                                annotation (Dialog(enable=(not input_f_AirTop)));
  parameter Real K "Screen flow coefficient (check values in Info)" annotation (Dialog(enable=(not input_f_AirTop)));

  /*********************** Varying inputs ***********************/
  Real SC=0 "Screen closure 1:closed, 0:open" annotation (Dialog(group="Varying inputs"));
  Modelica.SIunits.Temperature T_a=300 "Temperature at port a (filled square)"
    annotation (Dialog(enable=(not input_f_AirTop),group="Varying inputs"));
  Modelica.SIunits.Temperature T_b=300 "Temperature at port b (empty square)"
    annotation (Dialog(enable=(not input_f_AirTop),group="Varying inputs"));

  /*********************** Variables ***********************/
  Real f_AirTopp;
  Modelica.SIunits.Density rho_air;
  Modelica.SIunits.Density rho_mean;
  Modelica.SIunits.Density rho_top;
  Modelica.SIunits.SpecificHeatCapacity c_p_air=1005;
  Real R=8314 "gas constant";
  Modelica.SIunits.MolarMass M_H = 18;
  Modelica.SIunits.TemperatureDifference dT;
  Real VEC_AirTop(unit="kg/(s.Pa.m2)") "Mass transfer coefficient";

equation
  // Air exchange rate
  if input_f_AirTop then
    f_AirTopp = f_AirTop;
    rho_air=999 "dumb";
    rho_top=999;
    rho_mean=999;
    dT=999;
  else
    rho_air = Modelica.Media.Air.ReferenceAir.Air_pT.density_pT(1e5,T_a);
    rho_top = Modelica.Media.Air.ReferenceAir.Air_pT.density_pT(1e5,T_b);
    rho_mean = (rho_air+rho_top)/2;
    dT=T_a-T_b;
    f_AirTopp = SC*K*abs(dT)^0.66 + (1-SC)/rho_mean*(0.5*rho_mean*W*(1-SC)*Modelica.Constants.g_n*abs(rho_air - rho_top))^0.5;
  end if;

  // Mass exchange coefficient VEC and mass exchange MV
  VEC_AirTop = M_H*f_AirTopp/R/287;
  MV_flow = A*VEC_AirTop*dP;

  annotation (Icon(graphics={
        Text(
          extent={{-180,-60},{180,-100}},
          lineColor={0,0,255},
          textString="%name"),
        Line(
          points={{-90,-30}},
          color={191,0,0},
          smooth=Smooth.Bezier),
        Line(
          points={{-90,0},{-80,0},{-70,-10},{-50,10},{-30,-10},{-10,10},{10,
              -10},{30,10},{50,-10},{70,10},{80,0},{90,0}},
          color={0,0,0},
          smooth=Smooth.Bezier),
        Polygon(
          points={{-42,38},{-52,0},{-52,-6},{-52,-12},{-46,-18},{-38,-20},{-32,-18},
              {-28,-10},{-28,-6},{-28,0},{-40,30},{-42,38}},
          smooth=Smooth.Bezier,
          fillPattern=FillPattern.Solid,
          fillColor={0,0,255},
          pattern=LinePattern.None),
        Polygon(
          points={{38,40},{28,2},{28,-4},{28,-10},{34,-16},{42,-18},{48,-16},{52,
              -8},{52,-4},{52,2},{40,32},{38,40}},
          smooth=Smooth.Bezier,
          fillPattern=FillPattern.Solid,
          fillColor={0,0,255},
          pattern=LinePattern.None),
        Polygon(
          points={{0,4},{-10,-34},{-10,-40},{-10,-46},{-4,-52},{4,-54},{10,
              -52},{14,-44},{14,-40},{14,-34},{2,-4},{0,4}},
          smooth=Smooth.Bezier,
          fillPattern=FillPattern.Solid,
          fillColor={0,0,255},
          pattern=LinePattern.None)}),
                                  Diagram(coordinateSystem(preserveAspectRatio=false,
          extent={{-100,-100},{100,100}}), graphics));
end MV_AirThroughScreen;
