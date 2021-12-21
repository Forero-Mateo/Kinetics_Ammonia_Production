# Undergrad Kinetics: Ammonia Production
Project consisted of five person team. All MATLAB scripting was done by me.

## Project Overview
This was a project for the senior level course Kinetics and Reactor Design to model and design an autothermic reactor for ammonia production. Three different reactor models were created to demonstrate how each scenario could impact conversion and design parameters. Model design required building design equations, solving systems of ODEs, solving systems of linear equations (e.g energy balance, net rate equations, gas heat capacities), and parameter optimization. All model design was done using MATLAB

### Reactor Types
1. No Pressure Drop Reactor: This model held the assumption that the gas did not lose pressure as it traveled down the reactor. All Packed Bed Reactors (PBRs) will inherently cause a pressure drop as the fluid travels down the length of the reactor. In the case of ammonia production, pressure is tied direvctly to reaction rate and in turn, total conversion. 

2. Pressure Drop Reactor: This model removed the assumption that there was not pressure drop and implemented the frictional loss of pressure. The catalyst used for this reaction has a porosity value that will determine it's surface area but also the total pressure drop experienced. The Ergun Equation (differetial) was solved and was added to the optimization of each of the parameters. 

3. Pressure Drop with Interbed Cooling: This model considered the possibility of cooling the product gas to keep the temperature at its ideal conversion value. The design was considered as two smaller reactor beds with a heat exchanger in the middle which added an additional aspect of optimization, in where to add the heat exchanger. 

### Parameter optimization:
Optimization was done using a simple version of grid search to select the best combination of parameters. Parameters were not independent so their combinations had to be tested and % conversion was used as the cost function. To minimize computing time, domain knowledge was used to sequentially optimize each parameter and a reasonable guess was applied to the parameters before being optimized. The following are the parameters optimized.
1. Inlet temperature
2. Reactor length
3. Number of feed pipes
