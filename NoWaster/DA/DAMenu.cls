 
 /*------------------------------------------------------------------------
    File        : DAMenu
    Purpose     : 
    Syntax      : 
    Description : 
    Author(s)   : demo
    Created     : Mon Oct 16 18:55:47 EEST 2017
    Notes       : 
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.
USING DA.BaseDataAccess.

BLOCK-LEVEL ON ERROR UNDO, THROW.

CLASS DA.DAMenu INHERITS BaseDataAccess:
     
{datasets/dsMenu.i &REFERENCE-ONLY=REFERENCE-ONLY}    

    method public void fetchData(input-output dataset dsMenu):
        def var hDS as handle.
        hds = dataset dsMenu:handle.
        define data-source src for Menu.
        super:attachDataSource(input-output dataset-handle hDS by-reference, input data-source src:handle, 1).
        super:fetchData(input-output dataset-handle hDS by-reference).
        super:detachDataSource(input-output dataset-handle hDS by-reference).
    end method.
    
    method public void storeData(input dataset dsMenu):
        def var hdsBev as handle no-undo.
        hdsBev = dataset dsMenu:handle.
        define data-source src for Menu.
        
        super:attachDataSource(input-output dataset-handle hdsBev by-reference, input data-source src:handle, 1).
        super:storeData(input dataset-handle hdsBev by-reference).
        super:detachDataSource(input-output dataset-handle hdsBev by-reference).
    end method.
    
END CLASS.