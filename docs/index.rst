.. Greenhouses documentation master file, created by
   sphinx-quickstart on Thu Sep 20 13:40:34 2018.
   You can adapt this file completely to your liking, but it should at least
   contain the root `toctree` directive.

Welcome to Greenhouses's documentation!
=======================================

:Organization:  `University of Liège`_
:Date: |today|


**Greenhouses** is an open-source library for dynamic modelling of greenhouse climate developed in the Modelica language. The library aims at providing a modeling framework capable of simulating not only the energy flows of a greenhouse climate but also the complex interactions and energy flows relative to systems coupling the greenhouse e.g. generation and storage units. A number of platforms are currently available for greenhouse climate simulation, but none of them is open-source. Moreover, no platform is currently available for simulating the energy integration of greenhouses with other systems. The goal of Greenhouses is to fill this gap.

For greenhouse-scale simulation, the proposed library includes the modeling of greenhouse construction elements, indoor climate, heating systems, ventilation systems and crop yield. To the end of performing system-scale simulations, the library includes robust performance-based models of several generation units (e.g. CHP and heat pumps) as well as a model of thermal energy storage. The library also includes several pre-programmed control systems for climate control (heating circuit, window's aperture, supplementary lighting, etc.) and operation control of the HVAC units.

Explore the Examples package to get a feeling of the modeling possibility that the Greenhouses library offers!

Downloading Greenhouses
-----------------------
Greenhouses can be downloaded from its github repository (using the Clone or Download button on the right side of the screen):
https://github.com/queraltab/Greenhouses-Library

License
-------
The Greenhouses package is free software licensed under the Modelica License 2. It can be redistributed and/or modified under the terms of this license.


Main developers
----------------
* Queralt Altes-Buch (University of Liège, Belgium)

Contents
--------
.. toctree::
   :maxdepth: 2

   overview
   components
   flows
   control
   examples
   
Indices and tables
------------------

* :ref:`genindex`
* :ref:`modindex`
* :ref:`search`


References
----------

.. bibliography:: docs-references.bib

.. _University of Liège: https://www.uliege.be
