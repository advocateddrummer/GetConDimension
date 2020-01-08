# GetConnectorDimension

This script reports the number of points contained in the connectors selected
by the user.

**(NOTE: this was created to report the actual number of points contained in a
group of _connected_ connectors. It makes the assumption that the connectors are
connected and _subtracts_ the number of connectors minus one from the final point
count.**

Also NOTE: It turns out that the exact objective of this script is achievable
by selecting the target connectors and using the "Grid Cell Count" function
provided by Pointwise (_Grid->Cell Count_).
