within Greenhouses.Functions;
function WaterVapourPressure
  "Water vapour pressure of a gas computed by the relative humidity and the saturation water vapour pressure at the gas temperature"
  input Real TSat(unit="degC",displayUnit="degC",
                                          nominal=20) "Saturation temperature";
  input Real RH(nominal=70) "(0...100) %, Relative humidity";
  output Modelica.Units.SI.Pressure VP "Water vapour pressure";

algorithm
  VP := RH/100*Greenhouses.Functions.SaturatedVapourPressure(TSat);

end WaterVapourPressure;
