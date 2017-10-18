
 /*------------------------------------------------------------------------
    File        : NoWasterUI
    Purpose     : 
    Syntax      : 
    Description : 
    Author(s)   : demo
    Created     : Tue Oct 17 14:31:13 EEST 2017
    Notes       : 
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.
USING Progress.Windows.Form.

BLOCK-LEVEL ON ERROR UNDO, THROW.

CLASS UI.NoWasterUI INHERITS Form: 
    
    DEFINE PRIVATE VARIABLE button1 AS System.Windows.Forms.Button NO-UNDO.
    DEFINE PRIVATE VARIABLE button2 AS System.Windows.Forms.Button NO-UNDO.
    DEFINE PRIVATE VARIABLE button3 AS System.Windows.Forms.Button NO-UNDO.
    DEFINE PRIVATE VARIABLE checkedListBox1 AS System.Windows.Forms.CheckedListBox NO-UNDO.
    DEFINE PRIVATE VARIABLE components AS System.ComponentModel.IContainer NO-UNDO.
    DEFINE PRIVATE VARIABLE label2 AS System.Windows.Forms.Label NO-UNDO.
    DEFINE PRIVATE VARIABLE listBox1 AS System.Windows.Forms.ListBox NO-UNDO.
    DEFINE PRIVATE VARIABLE listBox2 AS System.Windows.Forms.ListBox NO-UNDO.
    DEFINE PRIVATE VARIABLE numericUpDown1 AS System.Windows.Forms.NumericUpDown NO-UNDO.
    DEFINE PRIVATE VARIABLE label1 AS System.Windows.Forms.Label NO-UNDO.
    def private var locClick as logical no-undo initial false.
        
    CONSTRUCTOR PUBLIC NoWasterUI (  ):
        
        
        SUPER().
        InitializeComponent().
        initCheckBox().
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
	METHOD PRIVATE VOID button2_Click( INPUT sender AS System.Object, INPUT e AS System.EventArgs ):
		locClick = true.
		
		def var BELoc as BE.BElocations no-undo.
		BEloc = new BE.BELocations().
		BEloc:fetchData().
		def var hDSloc as handle no-undo.
		hDSloc = BEloc:getDShandle().
		
		listBox1:Items:Clear().
		populateList(input listBox1, input hDSloc:get-buffer-handle(1)).
	END METHOD.
	
	/*------------------------------------------------------------------------------
	 Purpose:
	 Notes:
	------------------------------------------------------------------------------*/
	@VisualDesigner.
	METHOD PRIVATE VOID button3_Click( INPUT sender AS System.Object, INPUT e AS System.EventArgs ):
		locClick = false.
		
		def var beBEv as BE.BEBeverages.
        beBEv = new BE.BEBeverages().
        beBEv:fetchData(?).
        def var hDSloc as handle no-undo.
        hDSloc = beBEv:getDShandle().
        
        listBox1:Items:Clear().
        populateList(input listBox1, input hDSloc:get-buffer-handle(1)).

	END METHOD.

	/*------------------------------------------------------------------------------
	 Purpose:
	 Notes:
	------------------------------------------------------------------------------*/
	@VisualDesigner.
	METHOD PRIVATE VOID listBox1_SelectedIndexChanged( INPUT sender AS System.Object, INPUT e AS System.EventArgs ):
		if locClick = yes then
		  showMenu(cast(listBox1:SelectedItem, UI.ListBoxData):id).
	   else 
	      showBeverageInformation(cast(listBox1:SelectedItem, UI.ListBoxData):id).
    end method.
    
    method private void showBeverageInformation(input id as Int):
        listbox2:Items:clear().
        def var beBev as BE.BEBeverages no-undo.
        beBev = new BE.BEBeverages().
        beBev:fetchData("where BeverageID = " + string(id)).
        
        DEFINE VARIABLE qh AS HANDLE.
        CREATE QUERY qh.
        qh:SET-BUFFERS(beBev:getDShandle():get-buffer-handle(1)).
        qh:QUERY-PREPARE("FOR EACH "+ string(beBev:getDShandle():get-buffer-handle(1):Name)).
        qh:QUERY-OPEN.

        qh:GEt-first().
            listbox2:Items:Add(beBev:getDShandle():get-buffer-handle(1)::Size + " " + beBev:getDShandle():get-buffer-handle(1)::Alcohol).
        qh:QUERY-CLOSE().
        DELETE OBJECT qh.
    end method.
    
    method private void showMenu(input id as int).
        listBox2:Items:Clear().
        def var beMenuForLoc as BE.BEMenuForLocation no-undo.
        def var bufferHandle as handle no-undo.
        beMenuForLoc = new BE.BEMenuForLocation().
        beMenuForLoc:fetchData().
        
        DEFINE VARIABLE qh AS HANDLE.
        def var hTopBuffer as handle.
        
        bufferHandle =  beMenuForLoc:getDsHandle():GET-BUFFER-HANDLE (3).
        CREATE QUERY qh.
        qh:SET-BUFFERS(bufferHandle).
        qh:QUERY-PREPARE("FOR EACH " + bufferHandle:Name + " where LocationID = " + string(id)).
/*        qh:QUERY-PREPARE("FOR EACH " + bufferHandle:Name).*/
        qh:QUERY-OPEN.
         
        REPEAT:
            qh:GET-NEXT().
            IF qh:QUERY-OFF-END THEN LEAVE.
            def var listBoxData as UI.ListBoxData no-undo.
            listBoxData = new UI.ListBoxData().
            listBoxData:id = bufferHandle:BUFFER-FIELD (2):buffer-value.
            
            listBoxData:name = beMenuForLoc:getBeverageName(bufferHandle:BUFFER-FIELD (2):buffer-value) + " / " + bufferHandle::Price.
            listBox2:Items:Add(listBoxData).
            listBox2:DisplayMember = "name".
            END.
        
        qh:QUERY-CLOSE().
        DELETE OBJECT qh.
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
            IF qh:QUERY-OFF-END THEN LEAVE.
            def var listBoxData as UI.ListBoxData no-undo.
            listBoxData = new UI.ListBoxData().
            listBoxData:id = bufferHandle:BUFFER-FIELD (1):buffer-value.
            listBoxData:name = bufferHandle:BUFFER-FIELD (2):buffer-value.
            
            listBox1:Items:Add(listBoxData).
            listBox1:DisplayMember = "name".
            END.
        
        qh:QUERY-CLOSE().
        DELETE OBJECT qh.
	end method.

    method private void initCheckBox():
        def var calcResultS as system.object.               
        def var bedt as BE.BEDrinkType no-undo.
        bedt = new BE.BedrinkType().
        bedt:fetchData(?).
        def var tbBuf as handle.
        tbBuf = bedt:getDShandle()::ttDrinkType:handle.
        DEFINE VARIABLE qh AS HANDLE.
        
        CREATE QUERY qh.
        qh:SET-BUFFERS(tbBuf).
        qh:QUERY-PREPARE("FOR EACH ttDrinkType").
        qh:QUERY-OPEN.
        
        def var listBoxData as UI.ListBoxData.
        REPEAT:
            qh:GET-NEXT().
            IF qh:QUERY-OFF-END THEN LEAVE.
            listBoxData = new UI.ListBoxData().
            listBoxData:id = tbBuf::TypeNum.
            listBoxData:name = tbBuf::TypeName.
            checkedListBox1:Items:Add(listBoxData).
            checkedListBox1:DisplayMember = "name".
        END.
        
        qh:QUERY-CLOSE().
        DELETE OBJECT qh.
        
    end method.
	/*------------------------------------------------------------------------------
	 Purpose:
	 Notes:
	------------------------------------------------------------------------------*/
	@VisualDesigner.
	METHOD PRIVATE VOID button1_Click( INPUT sender AS System.Object, INPUT e AS System.EventArgs ):
        def var be4 as BE.BEMenuForLocation.
    
        be4 = new BE.BEMenuForLocation().
        def var i as int no-undo.
        def var availableDrinks as char no-undo.
        
        do i=0 to checkedListBox1:CheckedItems:Count - 1:
            if availableDrinks = "" then
            availableDrinks = string(cast(checkedListBox1:CheckedItems[i], UI.ListBoxData):id).
            else
            availableDrinks = availableDrinks + "," + string(cast(checkedListBox1:CheckedItems[i], UI.ListBoxData):id).
        end.
        
        be4:getMostAlcoholUnitsWithAvailableMoney(NumericUpDown1:Value, availableDrinks).

	END METHOD.






	/*------------------------------------------------------------------------------
	 Purpose:
	 Notes:
	------------------------------------------------------------------------------*/
	@VisualDesigner.
	METHOD PRIVATE VOID checkedListBox1_SelectedIndexChanged( INPUT sender AS System.Object, INPUT e AS System.EventArgs ):
		
		RETURN.

	END METHOD.

    METHOD PRIVATE VOID InitializeComponent(  ):
        
        /* NOTE: The following method is automatically generated.
        
        We strongly suggest that the contents of this method only be modified using the
        Visual Designer to avoid any incompatible modifications.
        
        Modifying the contents of this method using a code editor will invalidate any support for this file. */
        THIS-OBJECT:label1 = NEW System.Windows.Forms.Label().
        THIS-OBJECT:button1 = NEW System.Windows.Forms.Button().
        THIS-OBJECT:label2 = NEW System.Windows.Forms.Label().
        THIS-OBJECT:checkedListBox1 = NEW System.Windows.Forms.CheckedListBox().
        THIS-OBJECT:listBox1 = NEW System.Windows.Forms.ListBox().
        THIS-OBJECT:button2 = NEW System.Windows.Forms.Button().
        THIS-OBJECT:button3 = NEW System.Windows.Forms.Button().
        THIS-OBJECT:listBox2 = NEW System.Windows.Forms.ListBox().
        THIS-OBJECT:numericUpDown1 = NEW System.Windows.Forms.NumericUpDown().
        CAST(THIS-OBJECT:numericUpDown1, System.ComponentModel.ISupportInitialize):BeginInit().
        THIS-OBJECT:SuspendLayout().
        /*  */
        /* label1 */
        /*  */
        THIS-OBJECT:label1:Location = NEW System.Drawing.Point(28, 26).
        THIS-OBJECT:label1:Name = "label1".
        THIS-OBJECT:label1:Size = NEW System.Drawing.Size(51, 23).
        THIS-OBJECT:label1:TabIndex = 1.
        THIS-OBJECT:label1:Text = "Money in RON".
        THIS-OBJECT:label1:UseCompatibleTextRendering = TRUE.
        THIS-OBJECT:label1:Click:Subscribe(THIS-OBJECT:label1_Click).
        /*  */
        /* button1 */
        /*  */
        THIS-OBJECT:button1:Location = NEW System.Drawing.Point(205, 26).
        THIS-OBJECT:button1:Name = "button1".
        THIS-OBJECT:button1:Size = NEW System.Drawing.Size(109, 75).
        THIS-OBJECT:button1:TabIndex = 2.
        THIS-OBJECT:button1:Text = "NoWasterize Money".
        THIS-OBJECT:button1:UseCompatibleTextRendering = TRUE.
        THIS-OBJECT:button1:UseVisualStyleBackColor = TRUE.
        THIS-OBJECT:button1:Click:Subscribe(THIS-OBJECT:button1_Click).
        /*  */
        /* label2 */
        /*  */
        THIS-OBJECT:label2:Location = NEW System.Drawing.Point(356, 9).
        THIS-OBJECT:label2:Name = "label2".
        THIS-OBJECT:label2:Size = NEW System.Drawing.Size(100, 23).
        THIS-OBJECT:label2:TabIndex = 3.
        THIS-OBJECT:label2:Text = "Type of drink".
        THIS-OBJECT:label2:UseCompatibleTextRendering = TRUE.
        THIS-OBJECT:label2:Click:Subscribe(THIS-OBJECT:label2_Click).
        /*  */
        /* checkedListBox1 */
        /*  */
        THIS-OBJECT:checkedListBox1:FormattingEnabled = TRUE.
        THIS-OBJECT:checkedListBox1:Location = NEW System.Drawing.Point(336, 26).
        THIS-OBJECT:checkedListBox1:Name = "checkedListBox1".
        THIS-OBJECT:checkedListBox1:Size = NEW System.Drawing.Size(120, 94).
        THIS-OBJECT:checkedListBox1:TabIndex = 33.
        THIS-OBJECT:checkedListBox1:UseCompatibleTextRendering = TRUE.
        THIS-OBJECT:checkedListBox1:SelectedIndexChanged:Subscribe(THIS-OBJECT:checkedListBox1_SelectedIndexChanged).
        /*  */
        /* listBox1 */
        /*  */
        THIS-OBJECT:listBox1:FormattingEnabled = TRUE.
        THIS-OBJECT:listBox1:Location = NEW System.Drawing.Point(286, 194).
        THIS-OBJECT:listBox1:Name = "listBox1".
        THIS-OBJECT:listBox1:Size = NEW System.Drawing.Size(120, 95).
        THIS-OBJECT:listBox1:TabIndex = 34.
        THIS-OBJECT:listBox1:SelectedIndexChanged:Subscribe(THIS-OBJECT:listBox1_SelectedIndexChanged).
        /*  */
        /* button2 */
        /*  */
        THIS-OBJECT:button2:Location = NEW System.Drawing.Point(193, 194).
        THIS-OBJECT:button2:Name = "button2".
        THIS-OBJECT:button2:Size = NEW System.Drawing.Size(75, 38).
        THIS-OBJECT:button2:TabIndex = 35.
        THIS-OBJECT:button2:Text = "Show Locations".
        THIS-OBJECT:button2:UseCompatibleTextRendering = TRUE.
        THIS-OBJECT:button2:UseVisualStyleBackColor = TRUE.
        THIS-OBJECT:button2:Click:Subscribe(THIS-OBJECT:button2_Click).
        /*  */
        /* button3 */
        /*  */
        THIS-OBJECT:button3:Location = NEW System.Drawing.Point(193, 252).
        THIS-OBJECT:button3:Name = "button3".
        THIS-OBJECT:button3:Size = NEW System.Drawing.Size(75, 37).
        THIS-OBJECT:button3:TabIndex = 36.
        THIS-OBJECT:button3:Text = "Show Beverages".
        THIS-OBJECT:button3:UseCompatibleTextRendering = TRUE.
        THIS-OBJECT:button3:UseVisualStyleBackColor = TRUE.
        THIS-OBJECT:button3:Click:Subscribe(THIS-OBJECT:button3_Click).
        /*  */
        /* listBox2 */
        /*  */
        THIS-OBJECT:listBox2:FormattingEnabled = TRUE.
        THIS-OBJECT:listBox2:Location = NEW System.Drawing.Point(433, 194).
        THIS-OBJECT:listBox2:Name = "listBox2".
        THIS-OBJECT:listBox2:Size = NEW System.Drawing.Size(120, 95).
        THIS-OBJECT:listBox2:TabIndex = 37.
        /*  */
        /* numericUpDown1 */
        /*  */
        THIS-OBJECT:numericUpDown1:DecimalPlaces = 2.
        THIS-OBJECT:numericUpDown1:Location = NEW System.Drawing.Point(79, 29).
        THIS-OBJECT:numericUpDown1:Name = "numericUpDown1".
        THIS-OBJECT:numericUpDown1:Size = NEW System.Drawing.Size(120, 20).
        THIS-OBJECT:numericUpDown1:TabIndex = 38.
        /*  */
        /* NoWasterUI */
        /*  */
        THIS-OBJECT:ClientSize = NEW System.Drawing.Size(657, 405).
        THIS-OBJECT:Controls:Add(THIS-OBJECT:numericUpDown1).
        THIS-OBJECT:Controls:Add(THIS-OBJECT:listBox2).
        THIS-OBJECT:Controls:Add(THIS-OBJECT:button3).
        THIS-OBJECT:Controls:Add(THIS-OBJECT:button2).
        THIS-OBJECT:Controls:Add(THIS-OBJECT:listBox1).
        THIS-OBJECT:Controls:Add(THIS-OBJECT:checkedListBox1).
        THIS-OBJECT:Controls:Add(THIS-OBJECT:label2).
        THIS-OBJECT:Controls:Add(THIS-OBJECT:button1).
        THIS-OBJECT:Controls:Add(THIS-OBJECT:label1).
        THIS-OBJECT:Name = "NoWasterUI".
        THIS-OBJECT:Text = "NoWaster".
        THIS-OBJECT:Load:Subscribe(THIS-OBJECT:NoWasterUI_Load).
        CAST(THIS-OBJECT:numericUpDown1, System.ComponentModel.ISupportInitialize):EndInit().
        THIS-OBJECT:ResumeLayout(FALSE).
        CATCH e AS Progress.Lang.Error:
            UNDO, THROW e.
        END CATCH.
    END METHOD.


	/*------------------------------------------------------------------------------
	 Purpose:
	 Notes:
	------------------------------------------------------------------------------*/
	@VisualDesigner.
	METHOD PRIVATE VOID label1_Click( INPUT sender AS System.Object, INPUT e AS System.EventArgs ):
		
		RETURN.

	END METHOD.

	/*------------------------------------------------------------------------------
	 Purpose:
	 Notes:
	------------------------------------------------------------------------------*/
	@VisualDesigner.
	METHOD PRIVATE VOID label2_Click( INPUT sender AS System.Object, INPUT e AS System.EventArgs ):
		
		RETURN.

	END METHOD.





	/*------------------------------------------------------------------------------
	 Purpose:
	 Notes:
	------------------------------------------------------------------------------*/
	@VisualDesigner.
	METHOD PRIVATE VOID NoWasterUI_Load( INPUT sender AS System.Object, INPUT e AS System.EventArgs ):
		
		RETURN.

	END METHOD.


    DESTRUCTOR PUBLIC NoWasterUI ( ):

    END DESTRUCTOR.

END CLASS.