package require PWI_Glyph

#
# Count the number of duplicate entries in the provided list. I got the idea
# for this here: https://wiki.tcl-lang.org/page/Unique+Element+List
#
proc CountDuplicates {list} {
  set duplicates 0
  set new {}
  foreach item $list {
    if {[lsearch $new $item] < 0} {
      lappend new $item
    } else {
      incr duplicates
    }
  }
  return $duplicates
}

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
         -description "Select connectors" \
       selection]) } {

    puts "Error: Unsuccessfully selected connectors... exiting"
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

#
# Loop over connectors and count the number of connectors that share end
# point(s).
#
foreach con $connectors {
  set beginNode [$con getNode Begin]
  set endNode [$con getNode End]
  lappend nodes $beginNode $endNode
}

#
# Count duplicate nodes, each duplicate is a connection and a duplicated point.
#
set nConnections [CountDuplicates $nodes]


#
# Calculate actual number of points.
#
set nPoints [expr { $nTotalPoints - $nConnections }]

#
# Report number of points and connections.
#
puts "Number of connections is $nConnections"
puts "Total number of points contained in the [llength $connectors] connectors is $nPoints"

# vim: set ft=tcl:
