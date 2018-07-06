within ;
package Greenhouse "The Greenhouse Modelica Library"







  annotation (uses(
    conversion(noneFromVersion=""), Modelica(version="3.2.1"),
    DymolaCommands(version="1.1")),  Icon(coordinateSystem(preserveAspectRatio=
            false, extent={{-100,-100},{100,100}}), graphics={Bitmap(extent={{
              -100,100},{100,-100}}, fileName=
            "modelica://Greenhouse/Icons/GreenhouseLibraryIcon.png")}),
    Documentation(info="<html>
    
    <h1>Welcome to the Greenhouse library!</h1>
    <p>The <b>Greenhouse</b> library is an <b>open-source</b> library for dynamic modelling of greenhouse indoor climate developed in the Modelica language. The library aims at providing an open modelling framework to simulate greenhouse climate and the energy interaction of greenhouses with generation (e.g. CHP and heat pumps) and storage units. </p>
    <p><img src=\"modelica://Greenhouse/Resources/Images/GreenhouseLibraryIcon.png\"/> </p>
    <p>The proposed library includes the modelling of greenhouse indoor climate, heating and ventilation systems, climate control systems and crop yield. The goal is to propose a modelling framework capable of simulating the complex interactions and energy flows relative to systems coupling the greenhouse, generation units and storage units. To that end, the library includes robust performance-based models of several generation units, e.g. CHP and heat pumps.</p>
<h2>LIBRARY STRUCTURE</h2>
<p>The library is composed by 5 top-level package which are listed below: </p>
<ul>
<li><b><a href=\"modelica://Greenhouse.Components\">Components</a> </b>is the central part of the library. It is organized in three sub-package: Greenhouse, HVAC and CropYield. It contains all the models available in the library from the simple greenhouse components (e.g. cover) to already-build greenhouse models ready to use; generation units models and a yield model for tomato crop. </li>
<li><b><a href=\"modelica://Greenhouse.Flows\">Flows</a> </b>contains models of the flows that are encountered in a greenhouse system. It is organized in eight sub-packages that model the heat, vapour mass and CO2 mass transfer, as well as fluid flow. It also contains a sub-package of interfaces, which defines the type of connectors used in the library.  </li>
<li><b><a href=\"modelica://Greenhouse.ControlSystems\">ControlSystems</a> </b>contains the control units. It is organized in two sub-packages: Climate control (e.g. thermal screen, artificial lighting, windows aperture) and HVAC control (e.g. operation of generation units). <li>
<li><b><a href=\"modelica://Greenhouse.Examples\">Examples</a> </b>contains models where the components of the library can be tested. It includes the simulation of a greenhouse, and two system-scale models that simulate the greenhouse connected to thermal energy storage, CHP and a heat pump. </li>
<li><b><a href=\"modelica://Greenhouse.Functions\">Functions</a> </b>are the empirical correlations used to characterized some of the models presents in the library. </li>
</ul>
</html>"),
  Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
      graphics={Bitmap(extent={{-100,100},{100,-100}}, fileName=
            "modelica://ThermoCycle/Resources/Images/ThermoCycleLibrary.png")}));
end Greenhouse;
