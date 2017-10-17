 
 /*------------------------------------------------------------------------
    File        : BEMenu
    Purpose     : 
    Syntax      : 
    Description : 
    Author(s)   : demo
    Created     : Mon Oct 16 19:00:56 EEST 2017
    Notes       : 
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.

BLOCK-LEVEL ON ERROR UNDO, THROW.

CLASS BE.BEMenu: 
    
    {datasets/dsMenu.i}
    
    def private var DA as DA.DAMenu no-undo.
    
    constructor public BEMenu():
        DA = new DA.DAMenu().
    end constructor.
    
    method public void fetchData():
        da:fetchData(input-output dataset dsMenu by-reference).
        for each ttMenu by locationID:
            disp ttMenu.BeverageID.
            disp ttMEnu.price.
            end.
    end method.

END CLASS.