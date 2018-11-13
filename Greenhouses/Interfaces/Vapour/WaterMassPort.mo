within Greenhouses.Interfaces.Vapour;
partial connector WaterMassPort
  "Water mass port for 1-dim. water vapour mass transfer"
  Modelica.SIunits.Pressure VP "Port vapour pressure";
  flow Modelica.SIunits.MassFlowRate MV_flow
    "Mass flow rate (positive if flowing from outside into the component)";
  annotation (Documentation(info="<html>

</html>"));
end WaterMassPort;
