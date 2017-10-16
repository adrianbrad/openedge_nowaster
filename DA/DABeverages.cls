 
 /*------------------------------------------------------------------------
    File        : DABeverages
    Purpose     : 
    Syntax      : 
    Description : 
    Author(s)   : demo
    Created     : Mon Oct 16 18:46:45 EEST 2017
    Notes       : 
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.
USING DA.BaseDataAccess.

BLOCK-LEVEL ON ERROR UNDO, THROW.

CLASS DA.DABeverages INHERITS BaseDataAccess: 
    
{datasets/dsBeverages.i &REFERENCE-ONLY=REFERENCE-ONLY}    

    method public void fetchData(input-output dataset dsBeverages):
        def var hDS as handle.
        hds = dataset dsBeverages:handle.
        define data-source src for Beverages.
        super:fetchData(input-output dataset-handle hDS, input data-source src:handle).
    end method.
    
END CLASS.