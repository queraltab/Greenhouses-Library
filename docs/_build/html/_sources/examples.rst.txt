.. _examples:

Examples
========

Greenhouse_1
------------

This example intends to illustrate the simulation of the climate in a greenhouse. The greenhouse model is built by connecting all the greenhouse components to the energy and mass flows presents in a greenhouse. As it can be distinguished, the greenhouse modeled in this example consists of two levels of heating circuits, roof windows (but not side vents), natural ventilation (no forced ventilation) and a movable thermal screen. It should be noted that, when the screen is drawn, the air of the greenhouse is divided in two zones, i.e. below and above the screen. These zones are modeled separately (models *air* and *air_Top*) and their climate is assumed to be homogeneous. The models parameters have been set to typical values for Venlo-type greenhouse construction design dedicated to tomato crop cultivation. The greenhouse floor area and the mean greenhouse height are set in two individual block sources.

The simulated greenhouse is located in Belgium and the simulation period is from the 10th of December to the 22nd of November. Two input data files are required:

- *Weather data*: The input weather data for the simulation period is extracted from a TMY for Brussels and can be found in 'Greenhouses/Resources/Data/10Dec-22Nov.txt'. The file contains data for the outside air temperature, air pressure, wind speed and global irradiation. The sky temperature, previously computed in a Python script, is also included in this file.
- *Climate control set-points*: The temperature and |CO2| set-points for the simulation period are calculated according to the strategy presented in :ref:`control` and can be found in 'Greenhouses/Resources/Data/SP_10Dec-22Nov.txt'.

These *.txt* files are accessed by means of *TMY_and_control* and *SP_new*, which are two *CombiTimeTables* models from the Modelica Standard Library. The path to the data files is introduced in the variable *fileName*, which in the example it is set to the folder 'C:/Greenhouses/Resources/Data'. Therefore, in order for the model to find the data input files, the user must place the library in the directory C:/ or change the path to the files (i.e. *fileName* in the models *TMY_and_control* and *SP_new*).

The goal of this example is to show the energy flows interacting in a greenhouse. Thus, no generation units are included. Instead, the heating pipes are connected to a water source and sink model. The model includes the following controls:

- *PID_Mdot*: A PI controller adjusts the output mass flow rate of the water source connected to the heating pipes by compaing the air temperature set-point and present value. 
- *PID_CO2*: A PI controller adjusts the output of the |CO2| external source by comparing the actual |CO2| concentration of the air to its set-point.
- *Ctrl_SC*: A state graph adjusts the screen closure (SC) according to the strategy presented in :ref:`control`. The real inputs must be connected to the air relative humidity, the outdoor temperature, the indoor air temperature set-point and the usable hours of the screen. The usable hours are 1h30 before dusk, 1h30 after dawn and during night. In the global he global outside irradiation
- *vents*: A PI controller adjusts the opening of the windows according to the strategy presented in :ref:`control`. The opening depends mainly on the indoor air relative humidity and temperature. 
- *OnOff*: controls the ON/OFF operation of the supplementary lighting according to the strategy presented in :ref:`control`. The control output, previously computed in a Python script, is input as a *.txt* file by means of the *TMY_and_control* model.


.. figure:: figures/example1.png
	:figclass: align-center

GlobalSystem_1
--------------
This example illustrates the energy flows of a greenhouse connected to a CHP unit and a thermal storage tank. The greenhouse is modeled by the ready-to-use greenhouse model included in *Greenhouse/Unit* sub-package, in which the parameters are already set to typical values for Venlo-type greenhouse construction design dedicated to tomato crop cultivation. Thus, no parameters are required to be set by the user. A heat-driven control decides when to run the CHP unit.

The limited electrical load of greenhouses implies an excess electricity generation when using CHP units, which have a power-to-heat ratio usually close to one. This excess electricity is fed to the grid and, in the absence of subsidies, remunerated at a price close to the wholesale price of electricity.


.. figure:: figures/example2.png
	:figclass: align-center

GlobalSystem_2
--------------
Because the retail price of electricity is significantly higher than wholesale price, prosumers have a clear advantage at maximizing their level of self-consumption :cite:`quoilin_quantifying_2016`. In order to evaluate the potential of such activity and to illustrate the use of the library, a third simulation is included. In this example, the particular case of maximizing the self-consumption level of the system simulated in *GlobalSystem_1* is evaluated. To that end, a heat pump is added to the system. A heat-driven control decides when to run the CHP and the heat pump.

.. figure:: figures/example3.png
	:figclass: align-center

A comparison of the results obtained by *GlobalSystem_1* and *GlobalSystem_2* is presented in :cite:`altes-buch_modeling_2018`. The total consumption of gas and the total thermal and electrical production over the simulation period is represented in the following sankey diagrams.

.. figure:: figures/results1.png
	:figclass: align-center
	:scale: 60%

.. figure:: figures/results2.png
	:figclass: align-center
	:scale: 60%


.. |CO2| replace:: CO\ :sub:`2`

