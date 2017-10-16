 
 /*------------------------------------------------------------------------
    File        : BELocations
    Purpose     : 
    Syntax      : 
    Description : 
    Author(s)   : demo
    Created     : Mon Oct 16 17:44:13 EEST 2017
    Notes       : 
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.

BLOCK-LEVEL ON ERROR UNDO, THROW.

CLASS BE.BELocations: 
    {datasets/dsLocations.i}
    
    def private var DA as DA.DALocations no-undo.
    
    constructor public BELocations():
        DA = new DA.DALocations().
    end constructor.
    
    method public void fetchData():
        da:fetchData(input-output dataset dsLocations by-reference).
        for each ttLocations:
            disp ttLocations.name.
        end.
    end method.
    
/*    method public void getLocations(output table ttLoc):*/
/*        return ttLocations.                             */
/*    end method.                                         */

END CLASS.