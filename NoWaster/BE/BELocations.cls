 
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
        temp-table ttLocations:TRACKING-CHANGES = true.
    end method.
    
    method public void storeData():        
        DA:storeData(input dataset dsLocations by-reference).
    end method.
    
    method public logical updateLocation(input ID as int, input newID as int, input name as char, input address as char):
        find first ttLocations where ttLocations.LocationID = ID no-error.
            if available ttLocations then
            do:
                if validateID(newID) then
                    ttLocations.LocationID = newID.
                
                if name <> "" and name <> ? then
                    ttLocations.Name = name.
                    
                if address <> "" and address <> ? then
                    ttLocations.address = address.

                return true.
            end.
            else
                return false.
    end method.
    
    method public logical deleteLocation(input ID as int):
        find first ttLocations where ttLocations.LocationID = ID no-error.
            if available ttLocations then
            do:
                delete ttLocations.
                return true.
            end.
            else
                return false.
    end method.
    
    method private logical validateID(input id as int):
        
        return false.
    end method.
    
    method public handle getDShandle():
        return dataset DSLocations:handle.
    end method.
    
    method public char getLocName(input id as int):
        find first ttLocations where ttLocations.LocationID = id.
            return ttLocations.Name.
    end method.
    
END CLASS.