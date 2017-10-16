 
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
        
        super:attachDataSource(input-output dataset-handle hDS by-reference, input data-source src:handle).
        super:fetchData(input-output dataset-handle hDS by-reference).
        super:detachDataSource(input-output dataset-handle hDS by-reference).
    end method.
    
    method public void storeData(input dataset dsBeverages):
        def var hdsBev as handle no-undo.
        hdsBev = dataset dsBEverages:handle.
        define data-source src for Beverages.
        
        super:attachDataSource(input-output dataset-handle hdsBev by-reference, input data-source src:handle).
        super:storeData(input dataset-handle hdsBev by-reference).
        super:detachDataSource(input-output dataset-handle hdsBev by-reference).
    end method.
    
END CLASS.