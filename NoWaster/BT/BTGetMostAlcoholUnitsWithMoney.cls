 
 /*------------------------------------------------------------------------
    File        : BTGetMostAlcoholUnitsWithMoney
    Purpose     : 
    Syntax      : 
    Description : 
    Author(s)   : demo
    Created     : Tue Oct 17 15:19:15 EEST 2017
    Notes       : 
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.

BLOCK-LEVEL ON ERROR UNDO, THROW.

CLASS BT.BTGetMostAlcoholUnitsWithMoney: 
    def var BEBev as BE.BEBeverages no-undo.
    def var BELoc as BE.BELocations no-undo.
    def var BEMenu as BE.BEMenu no-undo.
    
    constructor public BTGetMostALcoholUnitsWithMoney():
        BEBev = new BE.BEBeverages().
        disp BEBev:getDShandle()::ttBeverages::Name.
    end constructor.
END CLASS.