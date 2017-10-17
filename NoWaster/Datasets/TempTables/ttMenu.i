define temp-table ttMenu no-undo {&REFERENCE-ONLY} BEFORE-TABLE btMenu
    field LocationID as int
    field BeverageID as int
    field Price as int.
    
/*    index idxLocIDBevID is primary unique LocationID BeverageID.*/
    