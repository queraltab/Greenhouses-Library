within ;
package Greenhouses "The Greenhouses Modelica Library"


  annotation (uses(Modelica(version="4.0.0")),
                                     Icon(coordinateSystem(preserveAspectRatio=
            false, extent={{-100,-100},{100,100}}), graphics={Bitmap(extent={{
            -100,-100},{100,100}}, fileName=
            "modelica://Greenhouses/Resources/Images/GreenhousesLibraryIcon.jpg")}),
    Documentation(info="<html>
<p><b></font><font style=\"font-size: 17pt; \">Welcome to the Greenhouses library!</b> </p>
<p>The <b>Greenhouses</b> library is an <b>open-source</b> library for dynamic modelling of greenhouse indoor climate developed in the Modelica language. The library aims at providing an open modelling framework to simulate greenhouse climate and the energy interaction of greenhouses with generation (e.g. CHP and heat pumps) and storage units. </p>
<p><img src=\"modelica://Greenhouses/Resources/Images/GreenhousesLibraryIcon.jpg\"/></p>
<p>The proposed library includes the modelling of greenhouse indoor climate, heating and ventilation systems, climate control systems and crop yield. The goal is to propose a modelling framework capable of simulating the complex interactions and energy flows relative to systems coupling the greenhouse, generation units and storage units. To that end, the library includes robust performance-based models of several generation units, e.g. CHP and heat pumps.</p>
<p><b></font><font style=\"font-size: 12pt; \">LIBRARY STRUCTURE</b></p>
<p>The library is composed by 5 top-level package which are listed below: </p>
<ul>
<li><b><a href=\"modelica://Greenhouses.Components\">Components</a> </b>is the central part of the library. It is organized in three sub-package: Greenhouse, HVAC and CropYield. It contains all the models available in the library from the simple greenhouse components (e.g. cover) to already-build greenhouse models ready to use; generation units models and a yield model for tomato crop. </li>
<li><b><a href=\"modelica://Greenhouses.Flows\">Flows</a> </b>contains models of the flows that are encountered in a greenhouse system. It is organized in eight sub-packages that model the heat, vapour mass and CO2 mass transfer, as well as fluid flow. </li>
<li><b><a href=\"modelica://Greenhouses.ControlSystems\">ControlSystems</a> </b>contains the control units. It is organized in two sub-packages: Climate control (e.g. thermal screen, artificial lighting, windows aperture) and HVAC control (e.g. operation of generation units). </li>
<li><b><a href=\"modelica://Greenhouses.Examples\">Examples</a> </b>contains models where the components of the library can be tested. It includes the simulation of a greenhouse, and two system-scale models that simulate the greenhouse connected to thermal energy storage, CHP and a heat pump. </li>
<li><b><a href=\"modelica://Greenhouses.Interfaces\">Interfaces</a> </b>contains all the type of connectors used in the library, for heat transfer, vapor transfer, CO2 transfer and fluid flow. </li>
<li><b><a href=\"modelica://Greenhouses.Functions\">Functions</a> </b>are the empirical correlations used to characterized some of the models presents in the library. </li>
</ul>
<p><br><br>
Licensed by Thermodynamics Laboratory (University of Liege) under the Modelica License 2<br>
Copyright &copy; 2017-2018, Thermodynamics Laboratory (University of Liege).
</p>

<p>
<i>This Modelica package is <u>free</u> software and the use is completely at <u>your own risk</u>; it can be redistributed and/or modified under the terms of the Modelica License 2. For license conditions (including the disclaimer of warranty) see <a href=\"modelica://Modelica.UsersGuide.ModelicaLicense2\">Modelica.UsersGuide.ModelicaLicense2</a> or visit <a href=\"http://www.modelica.org/licenses/ModelicaLicense2\"> http://www.modelica.org/licenses/ModelicaLicense2</a>.</i>
</p>
</html>"),
  Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
      graphics={Bitmap(extent={{-100,100},{100,-100}}, fileName=
            "modelica://Greenhouses/Resources/Images/GreenhousesLibraryIcon.jpg")}),
  version="1",
  conversion(noneFromVersion=""));
end Greenhouses;
