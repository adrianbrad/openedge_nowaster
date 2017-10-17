 
 /*------------------------------------------------------------------------
    File        : DAMenuForLocations
    Purpose     : 
    Syntax      : 
    Description : 
    Author(s)   : demo
    Created     : Tue Oct 17 15:53:12 EEST 2017
    Notes       : 
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.
USING DA.BaseDataAccess.

BLOCK-LEVEL ON ERROR UNDO, THROW.

CLASS DA.DAMenuForLocations INHERITS BaseDataAccess: 
    {datasets/dsMenuForLocations.i &REFERENCE-ONLY=REFERENCE-ONLY}  
    
    method public void fetchData(input-output dataset dsMenuForLocations):
        def var hDS as handle.
        define var hSrc as handle no-undo.
        define var hSrc2 as handle no-undo.
        
        hds = dataset dsMenuForLocations:handle.
        
        define data-source src for Beverages.
        
        hSrc = data-source src:handle.
        
        super:attachDataSource(input-output dataset-handle hDS by-reference, hSrc, 1).
        
        define data-source src2 for Menu.
        
        hSrc2 = data-source src2:handle.
        super:attachDataSource(input-output dataset-handle hDS by-reference, hSrc2, 2).
        hds::ttMenuForLocation:FILL-MODE = "no-fill".
        dataset dsMenuForLocations::ttMenu:SET-CALLBACK('AFTER-ROW-FILL':U,'AfterRowFill':U).
        
        super:fetchData(input-output dataset-handle hDS by-reference).
        super:detachDataSource(input-output dataset-handle hDS by-reference).
        
    end method.
    
    method public void AfterRowFill(input dataset dsMenuForLocations):
        create ttMenuForLocation.
        ttMenuForLocation.BeverageID = ttMenu.BeverageID.
        ttMenuForLocation.LocationID = ttMenu.LocationID.
        ttMenuForLocation.Name = ttBeverages.Name.
        ttMenuForLocation.Price = ttMenu.Price.
        ttMenuForLocation.Size = ttBeverages.Size.
        ttMenuForLocation.Alcohol = ttBeverages.Alcohol.
        ttmenuForLocation.UnitsOfAlcohol = ttBeverages.Size * (ttBeverages.Alcohol / 100) * 100.
    end method.
    
END CLASS.