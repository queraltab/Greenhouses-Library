within Greenhouses.Functions;
function DerivativeSaturatedVapourPressure
  "Slope of the tangent at the saturated vapour pressure at any temperature"

  input Real TSat(unit="degC",displayUnit="degC",
                                          nominal=20) "Saturation temperature";
  output Modelica.SIunits.PressureCoefficient dpSat_dT(
                                          displayUnit="Pa/K",
                                          nominal=1000)
    "Slope of saturation pressure";

algorithm
  dpSat_dT := 47.82*exp(0.0545*TSat);

end DerivativeSaturatedVapourPressure;
