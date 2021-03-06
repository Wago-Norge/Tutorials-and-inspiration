# -*- coding: utf-8 -*-
# This comment is required if there are any non-ASCII characters in the script file.

import os

# e!COCKPIT: Create a new project
project = e_projects.create_new_project()

# print the the compiler version of the project
print("The compiler version of the project is {0}".format(project.compiler_version))

# Save the project as sample.ecp on desktop
#desktop = os.path.join(os.path.join(os.environ['USERPROFILE']), 'Desktop\\e!Cpython\\MyProject.ecp')
desktop = os.path.join(os.path.join(os.environ['USERPROFILE']), 'C:\\scripting\\MyProject.ecp')
project.save_as(desktop)

# Save project if changes were made
project.save()


myDevice = e_device_catalog.find_device_type("0750-8202", "LATEST")  
# add three instances of the device type to the project
devices = project.add_device(myDevice[0], 3)

# e!COCKPIT: Set the IpAddress for three devices
for i in range(0,3):
	devices[i].ip_address = "192.168.1." +str(i+2) # start with IP 192.168.1.2

	
# Get my project related modules
moduleDI = e_device_catalog.find_device_type("0750-1405", "LATEST")
moduleDO = e_device_catalog.find_device_type("0750-1504", "LATEST")
moduleAI_TC = e_device_catalog.find_device_type("0750-0469/0003-0000", "LATEST")
moduleAI = e_device_catalog.find_device_type("0750-0467", "LATEST")
moduleAO = e_device_catalog.find_device_type("0750-0550", "LATEST")

# assign modules to every device
for j in range(0,3):
	modules = devices[j].add_module(moduleDI[0], 0, 1)
	modules = devices[j].add_module(moduleDO[0], 1, 1)
	modules = devices[j].add_module(moduleAI_TC[0], 2, 1)
	modules = devices[j].add_module(moduleAI[0], 3, 1)
	modules = devices[j].add_module(moduleAO[0], 4, 1)
	#											 	|--Quantity	--> Attention: Additional modules will be added at the end of every node
	#											 |--Slot Index	

print("The GUID is {0}".format(devices[0].device_guid))
# get the folder path where the script is
scriptDir = os.path.dirname(os.path.realpath(__file__))

# get the path of the project file
#projFile = os.path.join(scriptDir, "MyProject.ecp")

# e!COCKPIT: open the project
#proj = e_projects.open_project(projFile)

# e!COCKPIT: get the devie in the project by name


device0 = project.get_device("PFC200_2ETH_RS")
device1 = project.get_device("PFC200_2ETH_RS_1")
device2 = project.get_device("PFC200_2ETH_RS_2")

# get the path of the csv file
inputPath = os.path.join(scriptDir, "my_io_mapping.csv")

# import the io mapping of the module from the csv file
#for k in range(0,3):
device0.modules[0].import_io_mappings_from_csv(inputPath)
device1.modules[0].import_io_mappings_from_csv(inputPath)
device2.modules[0].import_io_mappings_from_csv(inputPath)	















