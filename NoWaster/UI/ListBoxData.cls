 
 /*------------------------------------------------------------------------
    File        : ListBoxData
    Purpose     : 
    Syntax      : 
    Description : 
    Author(s)   : demo
    Created     : Wed Oct 18 16:24:36 EEST 2017
    Notes       : 
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.

BLOCK-LEVEL ON ERROR UNDO, THROW.

CLASS UI.ListBoxData inherits System.Object: 
    def public property id as int no-undo
    get.
    set.
    def public property name as char no-undo
    get.
    set.
END CLASS.