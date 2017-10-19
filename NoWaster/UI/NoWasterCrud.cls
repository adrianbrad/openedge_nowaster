 
 /*------------------------------------------------------------------------
    File        : NoWasterCrud
    Purpose     : 
    Syntax      : 
    Description : 
    Author(s)   : demo
    Created     : Thu Oct 19 18:23:58 EEST 2017
    Notes       : 
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.
USING Progress.Windows.Form.

BLOCK-LEVEL ON ERROR UNDO, THROW.

CLASS UI.NoWasterCrud INHERITS Form: 
    
    DEFINE PRIVATE VARIABLE checkedListBox1 AS System.Windows.Forms.CheckedListBox NO-UNDO.
    DEFINE PRIVATE VARIABLE components AS System.ComponentModel.IContainer NO-UNDO.
    DEFINE PRIVATE VARIABLE label2 AS System.Windows.Forms.Label NO-UNDO.
    DEFINE PRIVATE VARIABLE listBox1 AS System.Windows.Forms.ListBox NO-UNDO.
    DEFINE PRIVATE VARIABLE label1 AS System.Windows.Forms.Label NO-UNDO.
    DEFINE PRIVATE VARIABLE numericUpDown1 AS System.Windows.Forms.NumericUpDown NO-UNDO.
    def private var canUpdate as logical no-undo initial false.
        
    CONSTRUCTOR PUBLIC NoWasterCrud (  ):
        
        
        SUPER().
        InitializeComponent().
        loadLocations().
        THIS-OBJECT:ComponentsCollection:ADD(THIS-OBJECT:components).
        CATCH e AS Progress.Lang.Error:
            UNDO, THROW e.
        END CATCH.

    END CONSTRUCTOR.
    
	/*------------------------------------------------------------------------------
	 Purpose:
	 Notes:
	------------------------------------------------------------------------------*/
	@VisualDesigner.
	METHOD PRIVATE VOID checkedListBox1_ItemCheck( INPUT sender AS System.Object, INPUT e AS System.Windows.Forms.ItemCheckEventArgs ):
		if e:NewValue = System.Windows.Forms.CheckState:Checked and canUpdate = true then do:
		      def var beMenu as BE.BEmenu no-undo.
		      beMenu = new BE.BEmenu().
		      beMenu:fetchData().
		      beMenu:addMenu(cast(listBox1:SelectedItem, UI.ListBoxData):id, cast(checkedListBox1:Items[e:Index], UI.ListBoxData):id, numericUpDown1:Value).
		      
        end.
        else if e:NewValue <> System.Windows.Forms.CheckState:Checked and canUpdate = true then do:
              def var beMenu2 as BE.BEmenu no-undo.
              beMenu2 = new BE.BEmenu().
              beMenu2:fetchData().
              beMEnu2:deleteMenu(cast(listBox1:SelectedItem, UI.ListBoxData):id, cast(checkedListBox1:Items[e:Index], UI.ListBoxData):id).
        end.
	END METHOD.

	/*------------------------------------------------------------------------------
	 Purpose:
	 Notes:
	------------------------------------------------------------------------------*/
	@VisualDesigner.
	METHOD PRIVATE VOID checkedListBox1_SelectedIndexChanged( INPUT sender AS System.Object, INPUT e AS System.EventArgs ):
		      
		      if canUpdate then do:
		         def var beMenu2 as BE.BEmenu no-undo.
                beMenu2 = new BE.BEmenu().
                beMenu2:fetchData().
/*                    if beMenu2:getPrice(cast(listBox1:SelectedItem, UI.ListBoxData):id, cast(checkedListBox1:SelectedItem, UI.ListBoxData):id) = ? or beMenu2:getPrice(cast(listBox1:SelectedItem, UI.ListBoxData):id, cast(checkedListBox1:SelectedItem, UI.ListBoxData):id) = 0 then*/
/*                        numericUpDown1:value = 1.                                                                                                                                                                                                                                     */
/*                    else                                                                                                                                                                                                                                                              */
                        numericUpDown1:value = beMenu2:getPrice(cast(listBox1:SelectedItem, UI.ListBoxData):id, cast(checkedListBox1:SelectedItem, UI.ListBoxData):id).
             end.
	END METHOD.

	/*------------------------------------------------------------------------------
	 Purpose:
	 Notes:
	------------------------------------------------------------------------------*/
	@VisualDesigner.
	METHOD PRIVATE VOID listBox1_SelectedIndexChanged( INPUT sender AS System.Object, INPUT e AS System.EventArgs ):
		canUpdate = false.
		showMenu(cast(listBox1:SelectedItem, UI.ListBoxData):id).
        
	END METHOD.

    method private void loadLocations():
        canUpdate = false.
        def var BELoc as BE.BElocations no-undo.
        BEloc = new BE.BELocations().
        BEloc:fetchData().
        def var hDSloc as handle no-undo.
        hDSloc = BEloc:getDShandle().
        
        listBox1:Items:Clear().
        populateList(input listBox1, input hDSloc:get-buffer-handle(1)).
    end method.
    
	/*------------------------------------------------------------------------------
	 Purpose:
	 Notes:
	------------------------------------------------------------------------------*/
	@VisualDesigner.
	METHOD PRIVATE VOID numericUpDown1_ValueChanged( INPUT sender AS System.Object, INPUT e AS System.EventArgs ):
        if checkedListBox1:SelectedIndex <> -1 then
		if checkedListBox1:GetItemCheckState(checkedListBox1:SelectedIndex) = System.Windows.Forms.CheckState:Checked then do:
		            def var BEMenu as BE.BEMenu no-undo.
                    BEMenu = new BE.BEMenu().
                    BEMenu:fetchData().
		            BEMenu:addMenu( cast(listBox1:SelectedItem, UI.ListBoxData):id,  cast(checkedListBox1:SelectedItem, UI.ListBoxData):id, numericUpDown1:Value).
        end.
	END METHOD.

    method private void populateList(input listBox as System.Windows.Forms.ListBox, input bufferHandle as handle ):
        DEFINE VARIABLE qh AS HANDLE.
        def var hTopBuffer as handle.
        
/*        hTopBuffer = hDS:GET-BUFFER-HANDLE (1).*/
        
        CREATE QUERY qh.
        qh:SET-BUFFERS(bufferHandle).
        qh:QUERY-PREPARE("FOR EACH " + bufferHandle:Name).
        qh:QUERY-OPEN.
         
        REPEAT:
            qh:GET-NEXT().
            IF qh:QUERY-OFF-END THEN leave.
            def var listBoxData as UI.ListBoxData no-undo.
            listBoxData = new UI.ListBoxData().
            listBoxData:id = bufferHandle:BUFFER-FIELD (1):buffer-value.
            listBoxData:name = bufferHandle:BUFFER-FIELD (2):buffer-value.
            
            listBox:Items:Add(listBoxData).
            listBox:DisplayMember = "name".
            END.
        
        qh:QUERY-CLOSE().
        DELETE OBJECT qh.
    end method.
    
    method private void showMenu(input id as int).
        checkedListBox1:Items:Clear().
        
        def var BEMenu as BE.BEMenu no-undo.
        def var BEBev as BE.BEBeverages no-undo.
        BEBev = new BE.BEBeverages().
        BEMenu = new BE.BEMenu().
        BEBev:fetchData(?).
        BEMenu:fetchData().
        
        def var tbBuf as handle.
        tbBuf = BEBev:getDShandle()::ttBeverages.
        DEFINE VARIABLE qh AS HANDLE.
        
        CREATE QUERY qh.
        qh:SET-BUFFERS(tbBuf).
        qh:QUERY-PREPARE("FOR EACH ttBeverages").
        qh:QUERY-OPEN.
        
        def var listBoxData as UI.ListBoxData.
        REPEAT:
            qh:GET-NEXT().
            IF qh:QUERY-OFF-END THEN LEAVE.
            listBoxData = new UI.ListBoxData().
            listBoxData:id = tbBuf::BeverageID.
            listBoxData:name = tbBuf::Name.
            checkedListBox1:Items:Add(listBoxData).
            checkedListBox1:DisplayMember = "name".
        END.
        
        qh:QUERY-CLOSE ().
        def var i as int.
        tbBuf = BEMenu:getDShandle()::ttMenu.
        qh:SET-BUFFERS(tbBuf).
        do i = 0 to checkedListBox1:Items:Count - 1:
            qh:QUERY-PREPARE("FOR EACH ttMenu where BeverageID = " + string(cast(checkedListBox1:Items[i], UI.ListBoxData):id) + " and LocationID = " + string(id)).
            qh:QUERY-OPEN.

            if qh:GET-FIRST () then
                checkedListBox1:SetItemCheckState(i, System.Windows.Forms.CheckState:Checked).
        end.
        
                
        FINALLY:
               canUpdate = true.    
        END FINALLY.
        
    END METHOD.

    METHOD PRIVATE VOID InitializeComponent(  ):
        
        /* NOTE: The following method is automatically generated.
        
        We strongly suggest that the contents of this method only be modified using the
        Visual Designer to avoid any incompatible modifications.
        
        Modifying the contents of this method using a code editor will invalidate any support for this file. */
        THIS-OBJECT:listBox1 = NEW System.Windows.Forms.ListBox().
        THIS-OBJECT:label1 = NEW System.Windows.Forms.Label().
        THIS-OBJECT:checkedListBox1 = NEW System.Windows.Forms.CheckedListBox().
        THIS-OBJECT:numericUpDown1 = NEW System.Windows.Forms.NumericUpDown().
        THIS-OBJECT:label2 = NEW System.Windows.Forms.Label().
        CAST(THIS-OBJECT:numericUpDown1, System.ComponentModel.ISupportInitialize):BeginInit().
        THIS-OBJECT:SuspendLayout().
        /*  */
        /* listBox1 */
        /*  */
        THIS-OBJECT:listBox1:FormattingEnabled = TRUE.
        THIS-OBJECT:listBox1:Location = NEW System.Drawing.Point(12, 100).
        THIS-OBJECT:listBox1:Name = "listBox1".
        THIS-OBJECT:listBox1:Size = NEW System.Drawing.Size(120, 95).
        THIS-OBJECT:listBox1:TabIndex = 0.
        THIS-OBJECT:listBox1:SelectedIndexChanged:Subscribe(THIS-OBJECT:listBox1_SelectedIndexChanged).
        /*  */
        /* label1 */
        /*  */
        THIS-OBJECT:label1:Location = NEW System.Drawing.Point(43, 74).
        THIS-OBJECT:label1:Name = "label1".
        THIS-OBJECT:label1:Size = NEW System.Drawing.Size(59, 23).
        THIS-OBJECT:label1:TabIndex = 1.
        THIS-OBJECT:label1:Text = "Locations".
        THIS-OBJECT:label1:UseCompatibleTextRendering = TRUE.
        /*  */
        /* checkedListBox1 */
        /*  */
        THIS-OBJECT:checkedListBox1:FormattingEnabled = TRUE.
        THIS-OBJECT:checkedListBox1:Location = NEW System.Drawing.Point(160, 12).
        THIS-OBJECT:checkedListBox1:Name = "checkedListBox1".
        THIS-OBJECT:checkedListBox1:Size = NEW System.Drawing.Size(120, 199).
        THIS-OBJECT:checkedListBox1:TabIndex = 2.
        THIS-OBJECT:checkedListBox1:UseCompatibleTextRendering = TRUE.
        THIS-OBJECT:checkedListBox1:ItemCheck:Subscribe(THIS-OBJECT:checkedListBox1_ItemCheck).
        THIS-OBJECT:checkedListBox1:SelectedIndexChanged:Subscribe(THIS-OBJECT:checkedListBox1_SelectedIndexChanged).
        /*  */
        /* numericUpDown1 */
        /*  */
        THIS-OBJECT:numericUpDown1:DecimalPlaces = 2.
        THIS-OBJECT:numericUpDown1:Location = NEW System.Drawing.Point(160, 234).
        THIS-OBJECT:numericUpDown1:Name = "numericUpDown1".
        THIS-OBJECT:numericUpDown1:Size = NEW System.Drawing.Size(120, 20).
        THIS-OBJECT:numericUpDown1:TabIndex = 3.
        THIS-OBJECT:numericUpDown1:ValueChanged:Subscribe(THIS-OBJECT:numericUpDown1_ValueChanged).
        /*  */
        /* label2 */
        /*  */
        THIS-OBJECT:label2:Location = NEW System.Drawing.Point(199, 214).
        THIS-OBJECT:label2:Name = "label2".
        THIS-OBJECT:label2:Size = NEW System.Drawing.Size(36, 17).
        THIS-OBJECT:label2:TabIndex = 4.
        THIS-OBJECT:label2:Text = "Price".
        THIS-OBJECT:label2:UseCompatibleTextRendering = TRUE.
        /*  */
        /* NoWasterCrud */
        /*  */
        THIS-OBJECT:ClientSize = NEW System.Drawing.Size(292, 266).
        THIS-OBJECT:Controls:Add(THIS-OBJECT:label2).
        THIS-OBJECT:Controls:Add(THIS-OBJECT:numericUpDown1).
        THIS-OBJECT:Controls:Add(THIS-OBJECT:checkedListBox1).
        THIS-OBJECT:Controls:Add(THIS-OBJECT:label1).
        THIS-OBJECT:Controls:Add(THIS-OBJECT:listBox1).
        THIS-OBJECT:Name = "NoWasterCrud".
        THIS-OBJECT:Text = "NoWasterCrud".
        CAST(THIS-OBJECT:numericUpDown1, System.ComponentModel.ISupportInitialize):EndInit().
        THIS-OBJECT:ResumeLayout(FALSE).
        CATCH e AS Progress.Lang.Error:
            UNDO, THROW e.
        END CATCH.
    END METHOD.


    DESTRUCTOR PUBLIC NoWasterCrud ( ):

    END DESTRUCTOR.

END CLASS.