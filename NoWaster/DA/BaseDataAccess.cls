 
 /*------------------------------------------------------------------------
    File        : BaseDataAccess
    Purpose     : 
    Syntax      : 
    Description : 
    Author(s)   : demo
    Created     : Mon Oct 16 17:13:49 EEST 2017
    Notes       : 
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.

BLOCK-LEVEL ON ERROR UNDO, THROW.

CLASS DA.BaseDataAccess ABSTRACT: 

   
    method public void fetchData(INPUT-OUTPUT dataset-handle hdsDynamic):
        hdsDynamic:FILL().
    end method.
    
    method public void storeData(input dataset-handle hdsDataset):
        define variable hTopBuff    as handle no-undo.
        define variable iBuff       as integer no-undo.  
        
        do iBuff = 1 to hdsDataset:num-top-buffers:
            hTopBuff = hdsDataset:get-top-buffer(iBuff).
            traverseBuffers (hTopBuff).
        end.
    end method.

    method private void traverseBuffers(phBuffer as handle):
        define variable iChildRel as integer no-undo.
        saveBuffer(phBuffer).
        do iChildRel = 1 TO phBuffer:num-child-relations:
            traverseBuffers(phBuffer:get-child-relation(iChildRel):child-buffer).
        end.
     end method.
     
    Method private void saveBuffer (phBuffer AS HANDLE):
        define variable hBeforeBuff    as handle no-undo.
        define variable hBeforeQry     as handle no-undo.
     
        create query hBeforeQry.

        hBeforeBuff = phBuffer:before-buffer.
    
        if valid-handle(hBeforeBuff) then
        do:
    
            hBeforeQry:set-buffers(hBeforeBuff).
            hBeforeQry:query-prepare("for each " + hBeforeBuff:NAME).
            hBeforeQry:query-open().
            hBeforeQry:get-first().
            
            do while not hBeforeQry:query-off-end:
                do on error undo, leave:
                    hBeforeBuff:save-row-changes() no-error.
                end.
            hBeforeQry:get-next().
            end.
        end.     
        delete object hBeforeQry.
    end method.
    
    method protected void attachDataSource(INPUT-OUTPUT dataset-handle hdsDynamic, input src as handle, input numOfBuffer as int):
        disp hdsDynamic:get-buffer-handle(1):name.
        hdsDynamic:get-buffer-handle(numOfBuffer):attach-data-source (src).
    end method.
    
    method protected void detachDataSource(input-output dataset-handle hdsDynamic):
         define variable iCount as integer no-undo.
        iCount = 1.
        if hdsDynamic:get-buffer-handle(icount) <> ? then
        do :
            hdsDynamic:get-buffer-handle(icount):detach-data-source ().
        end.           
    end method.


end class.