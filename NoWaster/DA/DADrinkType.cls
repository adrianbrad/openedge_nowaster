 
 /*------------------------------------------------------------------------
    File        : DADrinkType
    Purpose     : 
    Syntax      : 
    Description : 
    Author(s)   : demo
    Created     : Wed Oct 18 13:29:00 EEST 2017
    Notes       : 
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.
USING DA.BaseDataAccess.

BLOCK-LEVEL ON ERROR UNDO, THROW.

CLASS DA.DADrinkType INHERITS BaseDataAccess:
    {datasets/dsDrinkType.i &REFERENCE-ONLY=REFERENCE-ONLY}
    
    method public void fetchData(input-output dataset dsDrinkType, input whereClause as char):
        def var hDS as handle.
        define buffer bDT for DrinkType.
        define var lHasClause as logical.
        
        hds = dataset dsDrinkType:handle.
        
        case whereClause:
            
            when "" or when ? then do:
                define data-source src for DrinkType.
                lHasClause = false.
            end.
            
            otherwise do:
                define query qDT for bDT.                             
                define data-source src2 for query qDT
                bDT keys (TypeNum).
                query qDT:QUERY-PREPARE("for each bDT " + whereClause).
                lHasClause = true.
            end.
        end case.
        def var srcHandle as handle no-undo.
        if lHasClause then
            srcHandle = data-source src2:handle.
        else
            srcHandle = data-source src:handle.
            
        super:attachDataSource(input-output dataset-handle hDS by-reference, srcHandle, 1).
        super:fetchData(input-output dataset-handle hDS by-reference).
        super:detachDataSource(input-output dataset-handle hDS by-reference).
    end method. 

    method public void storeData(input dataset dsDrinkType):
        def var hdsDT as handle no-undo.
        hdsDT = dataset dsDrinkType:handle.
        define data-source src for Beverages.
        
        super:attachDataSource(input-output dataset-handle hdsDT by-reference, input data-source src:handle, 1).
        super:storeData(input dataset-handle hdsDT by-reference).
        super:detachDataSource(input-output dataset-handle hdsDT by-reference).
    end method.
    
END CLASS.