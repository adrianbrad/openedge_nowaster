 
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
    
    method public void fetchData(input whereClause as char):
        DA:fetchData(input-output dataset dsBeverages by-reference, input whereClause).       
        temp-table ttBeverages:TRACKING-CHANGES = true.
    end method.
    
    method public void storeData():        
        DA:storeData(input dataset dsBeverages by-reference).
    end method.
    
    method public handle getBeverages():
        for each ttBeverages:
            disp ttBeverages.BeverageID.
/*                 ttBEverages.UnitsOfAlcohol.*/
                 end.
    end method.
    
    method public logical updateBeverage(input ID as int, input newID as int, input name as char, input alcohol as decimal, input description as char):
        find first ttBeverages where ttBeverages.BeverageID = ID no-error.
            if available ttBeverages then
            do:
                if validateID(newID) then
                    ttBeverages.BeverageID = newID.
                
                if name <> "" and name <> ? then
                    ttBeverages.Name = name.
                    
                if alcohol > -1 and alcohol < 100 and alcohol <> ? then
                    ttBeverages.Alcohol = alcohol.
                    
                ttBeverages.Description = description.
                return true.
            end.
            else
                return false.
    end method.
    
    method public logical deleteBeverage(input ID as int):
        find first ttBeverages where ttBeverages.beverageID = ID no-error.
            if available ttBeverages then
            do:
                delete ttBeverages.
                return true.
            end.
            else
                return false.
    end method.
    
    method private logical validateID(input ID as int):
    
        return false.
    end method.
    
    method public handle getDShandle():
        return dataset DSBeverages:handle.
    end method.
    
END CLASS.