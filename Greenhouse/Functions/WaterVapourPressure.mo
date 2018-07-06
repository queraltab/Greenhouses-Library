within Greenhouse.Functions;
function WaterVapourPressure
  "Water vapour pressure of a gas computed by the relative humidity and the saturation water vapour pressure at the gas temperature"
  input Real TSat(unit="degC",displayUnit="degC",
                                          nominal=20) "Saturation temperature";
  input Real RH(nominal=70) "%, Relative humidity";
  output Modelica.SIunits.Pressure VP "Water vapour pressure";

algorithm
  VP := RH/100*Greenhouse.Functions.SaturatedVapourPressure(TSat);

end WaterVapourPressure;
