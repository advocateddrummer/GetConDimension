package require PWI_Glyph

#
# This may be slightly more concise, but it turns out that the exact objective
# of this script is achievable by selecting the target connectors and using the
# "Grid Cell Count" function provided by Pointwise (Grid->Cell Count).
#
# Use selected connector or prompt user for selection if nothing is selected at
# run time.
#
set mask [pw::Display createSelectionMask -requireConnector {}]

if { !([pw::Display getSelectedEntities -selectionmask $mask selection]) } {
  # No connector was selected at runtime; prompt for one now.

  if { !([pw::Display selectEntities \
         -selectionmask $mask \
         -description "Select initial connector" \
       selection]) } {

    puts "Error: Unsuccessfully selected connector... exiting"
    exit
  }
}

#
# Loop over connectors and sum their dimensions
#
set connectors $selection(Connectors)
set nTotalPoints 0
foreach con $connectors {
  set nTotalPoints [expr { $nTotalPoints + [$con getDimension] }]
}

set nPoints [expr { $nTotalPoints - [expr { [llength $connectors] - 1 }] }]

#
# Report number of points; ***this makes the huge assumption that all
# connectors are connected and it subtracts the common points***. When I have
# time I'll fix this up to automatically detect and handle this case.
puts "Total number of points contained in the [llength $connectors] connectors is $nPoints"

# vim: set ft=tcl:
