 
 /*------------------------------------------------------------------------
    File        : BEBeverages
    Purpose     : 
    Syntax      : 
    Description : 
    Author(s)   : demo
    Created     : Mon Oct 16 18:51:03 EEST 2017
    Notes       : 
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.

BLOCK-LEVEL ON ERROR UNDO, THROW.

CLASS BE.BEBeverages: 
    
    {Datasets/dsBeverages.i}
    
    def private var DA as DA.DABeverages no-undo.
     
    constructor public BEBeverages():
        DA = new DA.DABeverages().
    end constructor.
    
    method public void fetchData():
        DA:fetchData(input-output dataset dsBeverages by-reference).       
        temp-table ttBeverages:TRACKING-CHANGES = true.
    end method.
    
    method public void storeData():        
        find first ttBeverages.
        ttBeverages.name = "updated".
        find next ttBeverages.
        ttBeverages.name = "update 2".
            
/*        def var hdsBev as handle no-undo.   */
/*        hdsBev = dataset dsBEverages:handle.*/
        DA:storeData(input dataset dsBeverages by-reference).
    end method.
    
    method public void updateBeverage():
    
    end method.
END CLASS.