within Greenhouses.Functions;
function SaturatedVapourPressure "Saturated vapour pressure at any temperature"

  input Real TSat(unit="degC",displayUnit="degC",
                                          nominal=20) "Saturation temperature";
  output Modelica.SIunits.Pressure pSat(displayUnit="Pa",
                                          nominal=1e5) "Saturation pressure";

algorithm
  pSat := -274.36 + 877.52*exp(0.0545*TSat);

end SaturatedVapourPressure;
