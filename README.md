# subchannelMesh

create a hybrid mesh for subchannel analysis of sodium cooled fast reactor using gmsh

## How to use it

1. Edit the chanGeometry.geo file to provide the geometric input
2. Edit the subChannelScript.geo file to insert correct value of "m" (height of the assembly) // this will be moved to chanGeometry.geo in next version
3. Execute gmsh subChannelScript.geo - this will open the gmsh graphical interface with the mesh
4. Define physical surfaces or volumes as needed 
5. Export the mesh in the format you want
