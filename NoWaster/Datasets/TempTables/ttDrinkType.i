define temp-table ttDrinkType no-undo {&REFERENCE-ONLY} BEFORE-TABLE btDrinkType
    field typeNum as int
    field TypeName as char
    index idxTypeNum is primary unique typeNum.
    