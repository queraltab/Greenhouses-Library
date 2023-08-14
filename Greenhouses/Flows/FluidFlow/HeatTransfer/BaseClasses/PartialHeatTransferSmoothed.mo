within Greenhouses.Flows.FluidFlow.HeatTransfer.BaseClasses;
partial model PartialHeatTransferSmoothed
  "A partial heat transfer model that provides smooth transitions between the HTC for liquid, two-phase and vapour"
  extends
    Greenhouses.Flows.FluidFlow.HeatTransfer.BaseClasses.PartialHeatTransferZones;

  parameter Real smoothingRange(
    min=0,
    max=1) = 0.2 "Vapour quality smoothing range";
  parameter Real massFlowExp(
    min=0,
    max=1) = 0.8 "Mass flow correction term, disable with 0.0";
  parameter Integer forcePhase=0 "Ignore all other phases" annotation (choices(
      choice=0 "Disabled",
      choice=1 "Liquid",
      choice=2 "Two-phase",
      choice=3 "Gaseous"));

  Modelica.Units.SI.CoefficientOfHeatTransfer[n] U;
  Modelica.Units.SI.CoefficientOfHeatTransfer U_nom_LTP;
  Modelica.Units.SI.CoefficientOfHeatTransfer U_nom_TPV;
  Modelica.Units.SI.CoefficientOfHeatTransfer U_nom;

  Real LTP(min=0, max=1);
  Real TPV(min=0, max=1);
  Real LV(min=0, max=1);
  Real massFlowFactor(min=0);
  Real x_L;
  Real x_LTP;
  Real x_TPV;
  Real x_V "Vapor quality";

  Real divisor=10;

equation
  x_L = 0 - smoothingRange/divisor;
  x_LTP = 0 + smoothingRange/divisor;
  x_TPV = 1 - smoothingRange/divisor;
  x_V = 1 + smoothingRange/divisor;
  if forcePhase == 0 then
    LTP = Greenhouses.Functions.transition_factor_alt(
      switch=0,
      trans=smoothingRange,
      position=x);
    TPV = Greenhouses.Functions.transition_factor_alt(
      switch=1,
      trans=smoothingRange,
      position=x);
    // Not really needed, but might be more robust
    LV = Greenhouses.Functions.transition_factor(
      start=0,
      stop=1,
      position=x);
  elseif forcePhase == 1 then
    // liquid only
    LTP = 0;
    TPV = 1;
    LV = 0;
  elseif forcePhase == 2 then
    // two-phase only
    LTP = 1;
    TPV = 0;
    LV = Greenhouses.Functions.transition_factor(
      start=0,
      stop=1,
      position=x);
  elseif forcePhase == 3 then
    // gas only
    LTP = 0;
    TPV = 1;
    LV = 1;
  else
    assert(1 == 0, "Error in phase determination");
    LTP = 0.5;
    TPV = 0.5;
    LV = 0.5;
  end if;

  U_nom_LTP = (1 - LTP)*Unom_l + LTP*Unom_tp;
  U_nom_TPV = (1 - TPV)*Unom_tp + TPV*Unom_v;
  U_nom = (1 - LV)*U_nom_LTP + LV*U_nom_TPV;
  // Do the mass flow correction
  massFlowFactor = noEvent(abs(M_dot/Mdotnom)^massFlowExp);

  annotation (Documentation(info="<html>
<p>The partial model <b>PartialHeatTransferSmoothed</b> extends the partial model <a href=\"modelica://ThermoCycle.Components.HeatFlow.HeatTransfer.BaseClasses.PartialHeatTransferZones\">PartialHeatTransferZones</a> and smoothes the value of the heat transfer coefficient between the liquid, two-phase and vapour nominal values using the <a href=\"modelica://ThermoCycle.Functions.transition_factor\">transition factor</a> based on the vapour quality value of the fluid flow. </p>
<p>However, the switching can also be disabled by forcing the model to look at one phase only using the forcePhase parameter.</p>
</html>"));
end PartialHeatTransferSmoothed;
