 
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

    method public void fetchData(input-output dataset dsBeverages, input whereClause as char):
        def var hDS as handle.
        define buffer bBev for Beverages.
        define var lHasClause as logical.
        
        hds = dataset dsBeverages:handle.
        
        case whereClause:
            when "" or when ? then do:
                define data-source src for Beverages.
                lHasClause = false.
            end.
            
            otherwise do:
                define query qBev for bBev.                             
                define data-source src2 for query qBev
                bBev keys (BeverageID).
                query qBev:QUERY-PREPARE("for each bBev " + whereClause).
                lHasClause = true.
            end.
        end case.
        def var srcHandle as handle no-undo.
        if lHasClause then
            srcHandle = data-source src2:handle.
        else
            srcHandle = data-source src:handle.
            
        super:attachDataSource(input-output dataset-handle hDS by-reference, srcHandle, 1).
        
/*        dataset dsBeverages::ttBeverages:SET-CALLBACK('AFTER-ROW-FILL':U,'AfterRowFill':U).*/
        
        super:fetchData(input-output dataset-handle hDS by-reference).
        super:detachDataSource(input-output dataset-handle hDS by-reference).
    end method.
            
/*    method public void AfterRowFill(input dataset dsBeverages).                                                                                             */
/*                                                                                                                                                            */
/*        dataset dsBeverages::ttBeverages::UnitsOfAlcohol = dataset dsBeverages::ttBeverages::Size * (dataset dsBeverages::ttBeverages::Alcohol / 100) * 100.*/
/*    end method.                                                                                                                                             */
    
    method public void storeData(input dataset dsBeverages):
        def var hdsBev as handle no-undo.
        hdsBev = dataset dsBEverages:handle.
        define data-source src for Beverages.
        
        super:attachDataSource(input-output dataset-handle hdsBev by-reference, input data-source src:handle, 1).
        super:storeData(input dataset-handle hdsBev by-reference).
        super:detachDataSource(input-output dataset-handle hdsBev by-reference).
    end method.
    
END CLASS.