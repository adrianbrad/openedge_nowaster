define temp-table ttBeverages no-undo {&REFERENCE-ONLY} BEFORE-TABLE btBeverages
    field BeverageID as int label "ID"
    field Name as char
    field Description as char
    field Size as decimal
    field Alcohol as decimal
    index idxBeverageID is primary unique BeverageID.
    