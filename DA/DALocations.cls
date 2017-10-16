 
 /*------------------------------------------------------------------------
    File        : DALocations
    Purpose     : 
    Syntax      : 
    Description : 
    Author(s)   : demo
    Created     : Mon Oct 16 17:28:14 EEST 2017
    Notes       : 
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.
USING DA.BaseDataAccess.

BLOCK-LEVEL ON ERROR UNDO, THROW.

CLASS DA.DALocations INHERITS BaseDataAccess: 
    
{datasets/dsLocations.i &REFERENCE-ONLY=REFERENCE-ONLY}
    
    method public void fetchData(input-output dataset dsLocations):
        def var hDS as handle.
        hds = dataset dsLocations:handle.
        define data-source src for Locations.
        super:fetchData(input-output dataset-handle hDS, input data-source src:handle).
    end method.

END CLASS.