emu-upmaa-tools
=================================

a group of scirpts and tools that were may have been written to solve a one-off problem but i don't want to write again.

fyi, i'm learning perl so please excuse the sloppy/poor perl. 

rpt-image-resolution.pl
========
since querying by image resolution is not *easy* and it something that needs to be reported on this script will 
report on all images that are less than a specified resolution. For UPMAA the minimum size of a 'web publishable' image
should be 800px. So we like to know when we are pushing images less than 800px to the collections site. 

Sometimes it is okay to push the super small image because it is all that exists but more often then not it needs to be 
replaced. 
