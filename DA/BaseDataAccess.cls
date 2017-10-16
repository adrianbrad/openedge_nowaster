 
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

   
    method public void fetchData(INPUT-OUTPUT dataset-handle hdsDynamic, input src as handle):
        define variable iCount as integer no-undo.
        iCount = 1.
        if hdsDynamic:GET-BUFFER-HANDLE(icount) <> ? then
        do :
            hdsDynamic:GET-BUFFER-HANDLE(icount):attach-data-source (src).
        end.
            
        hdsDynamic:FILL().
       
        iCount = 1.
        if hdsDynamic:GET-BUFFER-HANDLE(icount) <> ? then
        do :
                hdsDynamic:GET-BUFFER-HANDLE(icount):detach-data-source ().
                iCount = iCount + 1.
        end.
    end method.

END CLASS.