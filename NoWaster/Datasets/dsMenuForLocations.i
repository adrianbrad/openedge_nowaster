{Datasets/TempTables/ttMenuForLocation.i {&*}}
{Datasets/TempTables/ttMenu.i {&*}}
{Datasets/TempTables/ttBeverages.i {&*}}

define dataset dsMenuForLocations {&REFERENCE-ONLY} for ttBeverages, ttMenu, ttMenuForLocation
    data-relation drMfLMenu for ttBeverages, ttMenu
    relation-fields (BeverageID, BeverageID).
/*    data-relation drMenuBEverages for ttBverages, ttBeverages*/
/*    relation-fields (BeverageID, BeverageID).                */

/*define dataset dsMenuForLocations {&REFERENCE-ONLY} for ttMenu, ttBeverages.*/
/*    data-relation drMenuBEverages for ttMenu, ttBeverages*/
/*    relation-fields (BeverageID, BeverageID).            */