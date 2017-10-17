 
 /*------------------------------------------------------------------------
    File        : BEMenuForLocation
    Purpose     : 
    Syntax      : 
    Description : 
    Author(s)   : demo
    Created     : Tue Oct 17 15:33:01 EEST 2017
    Notes       : 
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.

BLOCK-LEVEL ON ERROR UNDO, THROW.

CLASS BE.BEMenuForLocation: 
    {datasets/dsMenuForLocations.i}
    def var DA as DA.DAMenuForLocations no-undo.
    
    constructor public BEMenuForLocation():
        DA = new DA.DAMenuForLocations().
    end constructor.
    
    method public void fetchData():
        DA:fetchData(input-output dataset dsMenuForLocations by-reference).
        dataset dsMenuForLocations:WRITE-JSON ("file","C:\Users\demo\Desktop\mfl.json",yes).
    end method.
    
    method public char getMostAlcoholUnitsWithAvailableMoney(input money as decimal):
        
    end method.
END CLASS.