within Greenhouse.Flows.Interfaces.CO2;
partial connector CO2Port "CO2 port for 1-dim. CO2 transfer"
  Real CO2(unit="mg/m3") "Partial CO2 pressure";
  flow Real MC_flow(unit="mg/(m2.s)")
    "CO2 flow rate (positive if flowing from outside into the component)";
  annotation (Documentation(info="<html>

</html>"));
end CO2Port;
