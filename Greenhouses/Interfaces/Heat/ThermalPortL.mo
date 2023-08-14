within Greenhouses.Interfaces.Heat;
connector ThermalPortL "Distributed Heat Terminal"
  Modelica.Units.SI.Temperature T "Temperature";
  flow Modelica.Units.SI.HeatFlux phi "Heat flux";
  annotation (Diagram(graphics), Icon(graphics={
                                Rectangle(
          extent={{-100,100},{102,-100}},
          lineColor={255,0,0},
          fillColor={255,0,0},
          fillPattern=FillPattern.Solid)}));
end ThermalPortL;
