 
 /*------------------------------------------------------------------------
    File        : BEDrinkType
    Purpose     : 
    Syntax      : 
    Description : 
    Author(s)   : demo
    Created     : Wed Oct 18 13:37:42 EEST 2017
    Notes       : 
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.

BLOCK-LEVEL ON ERROR UNDO, THROW.

CLASS BE.BEDrinkType:
    {datasets/dsDrinkType.i}
    def private var DA as DA.DADrinkType no-undo.
     
    constructor public BEDrinkType():
        DA = new DA.DADrinkType().
    end constructor.
    
    method public void fetchData(input whereClause as char):
        DA:fetchData(input-output dataset dsDrinkType by-reference, input whereClause).       
        temp-table ttDrinkType:TRACKING-CHANGES = true.
    end method.
    
    method public void storeData():        
        DA:storeData(input dataset dsDrinkType by-reference).
    end method.
    
    method public logical updateDrinkType(input ID as int, input newID as int, input name as char, input alcohol as decimal, input description as char):
        find first ttDrinkType where ttDrinkType.TypeNum = ID no-error.
            if available ttDrinkType then
            do:
/*                if validateID(newID) then                              */
/*                    ttDrinkType.DrinkTypeID = newID.                   */
/*                                                                       */
/*                if name <> "" and name <> ? then                       */
/*                    ttDrinkType.Name = name.                           */
/*                                                                       */
/*                if alcohol > -1 and alcohol < 100 and alcohol <> ? then*/
/*                    ttDrinkType.Alcohol = alcohol.                     */
/*                                                                       */
/*                ttDrinkType.Description = description.                 */
/*                return true.                                           */
            end.
            else
                return false.
    end method.
    
    method public logical deleteDrinkType(input ID as int):
        find first ttDrinkType where ttDrinkType.TypeNum = ID no-error.
            if available ttDrinkType then
            do:
                delete ttDrinkType.
                return true.
            end.
            else
                return false.
    end method.
    
    method private logical validateID(input ID as int):
    
        return false.
    end method.
    
    method public handle getDShandle():
        return dataset dsDrinkType:handle.
    end method.
END CLASS.