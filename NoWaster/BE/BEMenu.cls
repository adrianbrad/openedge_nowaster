 
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
        temp-table ttMenu:TRACKING-CHANGES = true.
    end method.
    
    method public void storeData():        
        DA:storeData(input dataset dsMenu by-reference).
    end method.
    
    method public logical deleteMenu(input locID as int, input bevID as int):
        find first ttMenu where ttMenu.locationID = locID and ttMenu.beverageID = bevID no-error.
            if available ttMenu then
            do:
                delete ttMenu.
                 storeData().
                return true.
            end.
            else
                return false.
    end method.
    
   method public logical addMenu(input locationID as int, input beverageID as int, input price as decimal):
        find first ttMenu where ttMenu.locationID = locationID and ttMenu.beverageID = beverageID no-error.
            if available ttMenu then
                ttMenu.Price = price.
            else do:
                create ttMenu.
                    assign
                        ttMenu.locationID = locationID
                        ttMenu.beverageID = beverageID.
            end.
        storeData().
    end method.
    
    method public decimal getPrice(input locationID as int, input beverageID as int):
        find first ttMenu where ttMenu.locationID = locationID and ttMenu.beverageID = beverageID no-error.
            if available ttMenu then
                return ttMenu.Price.
    end method.
    
    method private logical validateID(input id as int):
        
        return false.
    end method.
    
    method public handle getDShandle():
        return dataset dsMenu:handle.
    end method.
END CLASS.