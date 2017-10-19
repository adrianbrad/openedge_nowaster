 
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
    
    method public char getMostAlcoholUnitsWithAvailableMoney(input money as decimal, input availableDrinks as char, input iLocID as int):
        fetchData().
        def var locID as int no-undo.
        def var bevID as int no-undo.
        def var totalMoney as decimal no-undo.
        def var maxMoney as decimal no-undo.
        def var pointsSum as decimal no-undo.
        def var maxPoints as decimal no-undo.
        def var i as int no-undo.
        def var drinkOk as logical.
        def var drinksCount as int initial 0.
        def var maxDrinksCount as int.
        drinkOk = false.
        totalMoney = 0.
        for each ttMenuForLocation no-lock:
            if price = 0 then return "You have a beverage with a 0 price, please fix".
            
            if availableDrinks <> "" then
            do i = 1 to num-entries(availableDrinks):
                find first ttBeverages where ttBeverages.BEverageID = ttMenuForLocation.BEverageID.
                    if ttBEverages.TypeNum = int(entry(i, availableDrinks)) then do:
                        if iLocID <> ? then do:
                            if ttMenuForLocation.LocationID = iLocID then
                                drinkOk = true.
                        end.
                        else
                            drinkOk = true.
                            
                        leave.
                    end.
            end.  
            else do:
                if iLocID = ? then
                    drinkOk = true. 
                    
                else if iLocID = ttMenuForLocation.LocationID then 
                    drinkOk = true.
            end.        
            if drinkOk = true then do:
                do while totalMoney + price < money:
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
    
/*    method public char getBeveragePrice(input id as int):             */
/*                find first ttBeverages where BeverageID = id no-error.*/
/*            if available ttBeverages then                             */
/*            return ttBeverages.price.                                 */
/*        return ?.                                                     */
/*    end method.*/
    
    method public handle getDsHandle():
        return dataset dsMenuForLocations:handle.
    end method.
END CLASS.