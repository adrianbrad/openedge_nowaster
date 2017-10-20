{Datasets/TempTables/ttMenuForLocation.i {&*}}
{Datasets/TempTables/ttMenu.i {&*}}
{Datasets/TempTables/ttBeverages.i {&*}}

define dataset dsMenuForLocations {&REFERENCE-ONLY} for ttBeverages, ttMenu, ttMenuForLocation
    data-relation drMfLMenu for ttBeverages, ttMenu
    relation-fields (BeverageID, BeverageID).