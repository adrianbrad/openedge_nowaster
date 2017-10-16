 
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
        for each ttBeverages:
            disp ttBeverages.Name.
        end.
    end method.
END CLASS.