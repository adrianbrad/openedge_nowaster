 
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
    end method.
    
    method public char getMostAlcoholUnitsWithAvailableMoney(input money as decimal, input availableDrinksType as char, input iLocID as int, input iBevID as int):
        fetchData().
        def var locID               as int no-undo.
        def var bevID               as int no-undo.
        def var totalMoney          as decimal no-undo initial 0.
        def var maxMoney            as decimal no-undo.
        def var pointsSum           as decimal no-undo.
        def var maxPoints           as decimal no-undo.
        def var i                   as  int no-undo.
        def var drinkOk             as logical no-undo initial false.
        def var drinksCount         as int no-undo initial 0.
        def var maxDrinksCount      as int no-undo.

        
        for each ttMenuForLocation no-lock:
            if price = 0 then return "You have a beverage with a 0 price, please fix".
            if availableDrinksType <> "" then
            do i = 1 to num-entries(availableDrinksType):
                find first ttBeverages where ttBeverages.BEverageID = ttMenuForLocation.BEverageID no-error.
                        if ttBEverages.TypeNum = int(entry(i, availableDrinksType)) then
                            if (iLocID <> ? and ttMenuForLocation.LocationID = iLocID) or iLocID = ? then
                                    drinkOk = true.
                                    leave.
            end.  
            else do:
                if (iLocID = ? and iBevID = ?) or (iLocID = ttMenuForLocation.LocationID and iBevID = ?) or
                (iBevID = ttMenuForLocation.BeverageID and iLocID = ttMenuForLocation.LocationID) then
                    drinkOk = true. 
            end.        
            
            if drinkOk = true then do:
                do while totalMoney + price <= money:
                    totalMoney = totalMoney + ttMenuForLocation.Price.
                    pointsSum = pointsSum + UnitsOfAlcohol.
                    drinksCount = drinksCount + 1.
                end.
                if pointsSum > maxPoints or pointsSum = maxPoints and totalMoney < maxMoney then do:
                    maxPoints = pointsSum.
                    maxMoney = totalMoney.
                    locID = locationID.
                    bevID = ttMenuForLocation.beverageID.
                    maxDrinksCount = drinksCount.
                end.
                drinksCount = 0.
                pointsSum = 0.
                totalMoney = 0.
                drinkOk = false.
             end.
        end.
            return string(locID) + "," +  string(maxDrinksCount) + "," +  string(bevID) + "," + string(maxMoney) + "," +  string(maxPoints).
    end method.
    
    method public char getBeverageName(input id as int):
        find first ttBeverages where BeverageID = id no-error.
            if available ttBeverages then
            return ttBeverages.name.
        return ?.
    end method.

    
    method public handle getDsHandle():
        return dataset dsMenuForLocations:handle.
    end method.
END CLASS.