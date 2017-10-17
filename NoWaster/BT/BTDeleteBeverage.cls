 
 /*------------------------------------------------------------------------
    File        : BTDeleteBeverage
    Purpose     : 
    Syntax      : 
    Description : 
    Author(s)   : demo
    Created     : Tue Oct 17 11:18:32 EEST 2017
    Notes       : 
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.

BLOCK-LEVEL ON ERROR UNDO, THROW.

CLASS BT.BTDeleteBeverage:
    def private var BEbev as BE.BEBeverages no-undo.
    def private var BEmenu as BE.BEMenu no-undo.
     
    DEFINE PUBLIC STATIC PROPERTY Instance AS CLASS BT.BTDeleteBeverage NO-UNDO
    GET ():
         IF Instance = ? THEN Instance = NEW BT.BTDeleteBeverage( ).
        RETURN Instance.
    END GET.
    PRIVATE SET.
    
    constructor private BTDeleteBeverage():
        BEbev = new BE.BEBeverages().
        BEmenu = new BE.BEMenu().
    end constructor.
    
    method public logical execute(input beverageID as int).
        BEbev:fetchData("where beverageID = " + string(beverageID)).
        BEmenu:fetchData().
    return false.
    end method.
END CLASS.