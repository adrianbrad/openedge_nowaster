define temp-table ttLocations no-undo {&REFERENCE-ONLY} BEFORE-TABLE btLocations
    field LocationID as int label "ID"
    field Name as char
    field Address as char
    index idxLocationID is primary unique LocationID.
    