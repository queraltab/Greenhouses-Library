within Greenhouses.Interfaces.Heat;
connector ThermalPort "Distributed Heat Terminal"
  parameter Integer N(min=1)=2 "Number of nodes";
  Modelica.Units.SI.Temperature T[N] "Temperature at the nodes";
  flow Modelica.Units.SI.HeatFlux phi[N] "Heat flux at the nodes";
  annotation (Diagram(graphics), Icon(graphics={
                                Rectangle(
          extent={{-100,100},{102,-100}},
          lineColor={255,0,0},
          fillColor={255,0,0},
          fillPattern=FillPattern.Solid)}));
end ThermalPort;
