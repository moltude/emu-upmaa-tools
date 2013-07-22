location-case.pl
=====

UPMAA standard is to use all upper-case for location codes. this is run nightly to enforce this standard by changing any
new location records with lower case characters to uppper case.  



rpt-image-resolution.pl
=====

since querying by image resolution is not easy because the fields are Strings and not Integers (so < > don't work) and it something that needs to be reported on this script will report on all images that are less than a specified resolution. For UPMAA the minimum size of a 'web publishable' image should be 800px. So we like to know when we are pushing images less than 800px to the collections site.

Sometimes it is okay to push the super small image because it is all that exists but more often then not it needs to be replaced.

