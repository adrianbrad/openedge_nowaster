
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
    DEFINE PRIVATE VARIABLE checkedListBox1 AS System.Windows.Forms.CheckedListBox NO-UNDO.
    DEFINE PRIVATE VARIABLE components AS System.ComponentModel.IContainer NO-UNDO.
    DEFINE PRIVATE VARIABLE label2 AS System.Windows.Forms.Label NO-UNDO.
    DEFINE PRIVATE VARIABLE label3 AS System.Windows.Forms.Label NO-UNDO.
    DEFINE PRIVATE VARIABLE label4 AS System.Windows.Forms.Label NO-UNDO.
    DEFINE PRIVATE VARIABLE label5 AS System.Windows.Forms.Label NO-UNDO.
    DEFINE PRIVATE VARIABLE label6 AS System.Windows.Forms.Label NO-UNDO.
    DEFINE PRIVATE VARIABLE label7 AS System.Windows.Forms.Label NO-UNDO.
    DEFINE PRIVATE VARIABLE listBox1 AS System.Windows.Forms.ListBox NO-UNDO.
    DEFINE PRIVATE VARIABLE listBox2 AS System.Windows.Forms.ListBox NO-UNDO.
    DEFINE PRIVATE VARIABLE listBox3 AS System.Windows.Forms.ListBox NO-UNDO.
    DEFINE PRIVATE VARIABLE numericUpDown1 AS System.Windows.Forms.NumericUpDown NO-UNDO.
    DEFINE PRIVATE VARIABLE label1 AS System.Windows.Forms.Label NO-UNDO.
    def private var locClick as logical no-undo initial false.
    DEFINE PRIVATE VARIABLE textBox1 AS System.Windows.Forms.TextBox NO-UNDO.
    DEFINE PRIVATE VARIABLE textBox2 AS System.Windows.Forms.TextBox NO-UNDO.
        
    CONSTRUCTOR PUBLIC NoWasterUI (  ):
        
        
        SUPER().
        InitializeComponent().
        initCheckBox().
        loadLocations().
        loadBeverages(?).
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
        def var i as int.
        def var whereString as char.
        if e:NewValue = System.Windows.Forms.CheckState:Checked then do:
            whereString = "where TypeNum = " + string(cast(checkedListBox1:Items[e:Index], UI.ListBoxData):id).
    		do i = 0 to checkedListBox1:CheckedItems:Count - 1:
                    whereString = whereString + " or TypeNum = " + string(cast(checkedListBox1:CheckedItems[i], UI.ListBoxData):id).
            end.
        end.
        else do:
            do i = 0 to checkedListBox1:CheckedItems:Count - 1:
                  if checkedListBox1:CheckedItems[i] <> checkedListBox1:items[e:Index] then do:
                      if whereString = "" then do:
                        whereString = "where TypeNum = " + string(cast(checkedListBox1:CheckedItems[i], UI.ListBoxData):id).
                      end.
                      else do:
                        whereString = whereString + " or TypeNum = " + string(cast(checkedListBox1:CheckedItems[i], UI.ListBoxData):id).
                      end.
                  end.
            end.           
        end.
        this-object:loadBeverages(whereString).
	END METHOD.


	/*------------------------------------------------------------------------------
	 Purpose:
	 Notes:
	------------------------------------------------------------------------------*/
	@VisualDesigner.

	/*------------------------------------------------------------------------------
	 Purpose:
	 Notes:
	------------------------------------------------------------------------------*/
	@VisualDesigner.
	METHOD PRIVATE VOID label7_Click( INPUT sender AS System.Object, INPUT e AS System.EventArgs ):
		
		RETURN.

	END METHOD.

	/*------------------------------------------------------------------------------
	 Purpose:
	 Notes:
	------------------------------------------------------------------------------*/
	@VisualDesigner.
	METHOD PRIVATE VOID listBox2_SelectedIndexChanged( INPUT sender AS System.Object, INPUT e AS System.EventArgs ):
		
	   showBeverageInformation(cast(listBox2:SelectedItem, UI.ListBoxData):id).

	END METHOD.

    method private void loadBeverages(input whereString as char):
        def var beBEv as BE.BEBeverages.
        beBEv = new BE.BEBeverages().
        
        if whereString = ? then
            beBEv:fetchData(?).
        else
            beBev:fetchData(whereString).
        def var hDSBev as handle no-undo.
        hDSBev = beBEv:getDShandle().
        
        listBox2:Items:Clear().
        populateList(input listBox2, input hDSBev:get-buffer-handle(1)).
    end method.
    
    method private void loadLocations():
        locClick = true.
        
        def var BELoc as BE.BElocations no-undo.
        BEloc = new BE.BELocations().
        BEloc:fetchData().
        def var hDSloc as handle no-undo.
        hDSloc = BEloc:getDShandle().
        
        listBox1:Items:Clear().
        populateList(input listBox1, input hDSloc:get-buffer-handle(1)).
        listBox1:Items:Add("All Locations").
    end method.
    
	

	/*------------------------------------------------------------------------------
	 Purpose:
	 Notes:
	------------------------------------------------------------------------------*/
	@VisualDesigner.
	METHOD PRIVATE VOID label3_Click( INPUT sender AS System.Object, INPUT e AS System.EventArgs ):
		
		RETURN.

	END METHOD.

	/*------------------------------------------------------------------------------
	 Purpose:
	 Notes:
	------------------------------------------------------------------------------*/
	@VisualDesigner.
	METHOD PRIVATE VOID listBox1_SelectedIndexChanged( INPUT sender AS System.Object, INPUT e AS System.EventArgs ):
		  if listBox1:SelectedItem <> ? and listBox1:SelectedItem:GetType():ToString() = "UI.ListBoxData" then
		      showMenu(cast(listBox1:SelectedItem, UI.ListBoxData):id).
    end method.
    
    method private void showBeverageInformation(input id as Int):
        def var beBev as BE.BEBeverages no-undo.
        def var beBdt as BE.BEDrinkType no-undo.
        beBdt = new BE.BEDrinkType().
        beBdt:fetchData(?).
        beBev = new BE.BEBeverages().
        beBev:fetchData("where BeverageID = " + string(id)).
        
        DEFINE VARIABLE qh AS HANDLE.
        CREATE QUERY qh.
        qh:SET-BUFFERS(beBev:getDShandle():get-buffer-handle(1)).
        qh:QUERY-PREPARE("FOR EACH "+ string(beBev:getDShandle():get-buffer-handle(1):Name)).
        qh:QUERY-OPEN.

        qh:GEt-first().
           textBox1:Text = "Size : " +(beBev:getDShandle():get-buffer-handle(1)::Size + " liters / Alc. by vol.: " + beBev:getDShandle():get-buffer-handle(1)::Alcohol) + " type: " + beBdt:getDrinkType(beBev:getDShandle():get-buffer-handle(1)::TypeNum).
        qh:QUERY-CLOSE().
        DELETE OBJECT qh.
    end method.
    
    method private void showMenu(input id as int).
        listBox3:Items:Clear().
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
        qh:QUERY-OPEN.
         
        REPEAT:
            qh:GET-NEXT().
            IF qh:QUERY-OFF-END THEN LEAVE.
            def var listBoxData as UI.ListBoxData no-undo.
            listBoxData = new UI.ListBoxData().
            listBoxData:id = bufferHandle:BUFFER-FIELD (2):buffer-value.
            
            listBoxData:name = beMenuForLoc:getBeverageName(bufferHandle:BUFFER-FIELD (2):buffer-value) + " / " + bufferHandle::Price.
            listBox3:Items:Add(listBoxData).
            listBox3:DisplayMember = "name".
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
            
            listBox:Items:Add(listBoxData).
            listBox:DisplayMember = "name".
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
        def var result as char no-undo.
        def var resultString as char.
        if listBox1:SelectedItem <> ? and listBox1:SelectedItem:GetType():ToString() = "UI.ListBoxData" then
            result = be4:getMostAlcoholUnitsWithAvailableMoney(NumericUpDown1:Value, availableDrinks, cast(listBOx1:SelectedItem, UI.ListBoxData):id).
        else
            result = be4:getMostAlcoholUnitsWithAvailableMoney(NumericUpDown1:Value, availableDrinks, ?).
        def var beLoc as BE.BELocations.
        def var beBev as BE.BEBeverages.
        beLoc = new BE.Belocations().
        beBev = new BE.BEBeverages().
        beLoc:fetchData().
        beBev:fetchData(?).
        if(num-entries(result) = 5) then do:
            do i=1 to num-entries(result):
                case i:
                    when 1 then do:
                        resultString = "You can drink in " + beLoc:getLocName(int(entry(i, result))).
                    end.

                    when 2 then do:
                        resultString = resultString + " " + (entry(i, result)).
                    end.

                    when 3 then do:
                        resultString = resultString + " " + be4:getBeverageName(int(entry(i, result))).
                    end.
                    when 4 then do:
                        resultString = resultString + " with " + (entry(i, result)) + " lei".
                    end.
                end case.
            end.
        end.
            else do:
               resultString = result.
            end.
        textBox2:Text = resultString.
	END METHOD.






	/*------------------------------------------------------------------------------
	 Purpose:
	 Notes:
	------------------------------------------------------------------------------*/
	@VisualDesigner.
	METHOD PRIVATE VOID checkedListBox1_SelectedIndexChanged( INPUT sender AS System.Object, INPUT e AS System.EventArgs ):
	    
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
        THIS-OBJECT:listBox2 = NEW System.Windows.Forms.ListBox().
        THIS-OBJECT:numericUpDown1 = NEW System.Windows.Forms.NumericUpDown().
        THIS-OBJECT:label3 = NEW System.Windows.Forms.Label().
        THIS-OBJECT:label4 = NEW System.Windows.Forms.Label().
        THIS-OBJECT:listBox3 = NEW System.Windows.Forms.ListBox().
        THIS-OBJECT:label5 = NEW System.Windows.Forms.Label().
        THIS-OBJECT:textBox1 = NEW System.Windows.Forms.TextBox().
        THIS-OBJECT:label6 = NEW System.Windows.Forms.Label().
        THIS-OBJECT:label7 = NEW System.Windows.Forms.Label().
        THIS-OBJECT:textBox2 = NEW System.Windows.Forms.TextBox().
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
        THIS-OBJECT:checkedListBox1:ItemCheck:Subscribe(THIS-OBJECT:checkedListBox1_ItemCheck).
        THIS-OBJECT:checkedListBox1:SelectedIndexChanged:Subscribe(THIS-OBJECT:checkedListBox1_SelectedIndexChanged).
        /*  */
        /* listBox1 */
        /*  */
        THIS-OBJECT:listBox1:FormattingEnabled = TRUE.
        THIS-OBJECT:listBox1:Location = NEW System.Drawing.Point(45, 180).
        THIS-OBJECT:listBox1:Name = "listBox1".
        THIS-OBJECT:listBox1:Size = NEW System.Drawing.Size(120, 95).
        THIS-OBJECT:listBox1:TabIndex = 34.
        THIS-OBJECT:listBox1:SelectedIndexChanged:Subscribe(THIS-OBJECT:listBox1_SelectedIndexChanged).
        /*  */
        /* listBox2 */
        /*  */
        THIS-OBJECT:listBox2:FormattingEnabled = TRUE.
        THIS-OBJECT:listBox2:Location = NEW System.Drawing.Point(205, 180).
        THIS-OBJECT:listBox2:Name = "listBox2".
        THIS-OBJECT:listBox2:Size = NEW System.Drawing.Size(120, 95).
        THIS-OBJECT:listBox2:TabIndex = 37.
        THIS-OBJECT:listBox2:SelectedIndexChanged:Subscribe(THIS-OBJECT:listBox2_SelectedIndexChanged).
        /*  */
        /* numericUpDown1 */
        /*  */
        THIS-OBJECT:numericUpDown1:DecimalPlaces = 2.
        THIS-OBJECT:numericUpDown1:Location = NEW System.Drawing.Point(79, 29).
        THIS-OBJECT:numericUpDown1:Name = "numericUpDown1".
        THIS-OBJECT:numericUpDown1:Size = NEW System.Drawing.Size(120, 20).
        THIS-OBJECT:numericUpDown1:TabIndex = 38.
        @VisualDesigner.FormMember (NeedsInitialize="false", InitializeArray="true", Type="System.Int32").
        DEFINE VARIABLE arrayvar0 AS INTEGER EXTENT 4 NO-UNDO.
        arrayvar0[1] = 50.
        arrayvar0[2] = 0.
        arrayvar0[3] = 0.
        arrayvar0[4] = 0.
        THIS-OBJECT:numericUpDown1:Value = Progress.Util.DecimalHelper:Create(arrayvar0).
        /*  */
        /* label3 */
        /*  */
        THIS-OBJECT:label3:Location = NEW System.Drawing.Point(79, 154).
        THIS-OBJECT:label3:Name = "label3".
        THIS-OBJECT:label3:Size = NEW System.Drawing.Size(54, 23).
        THIS-OBJECT:label3:TabIndex = 39.
        THIS-OBJECT:label3:Text = "Locations".
        THIS-OBJECT:label3:UseCompatibleTextRendering = TRUE.
        THIS-OBJECT:label3:Click:Subscribe(THIS-OBJECT:label3_Click).
        /*  */
        /* label4 */
        /*  */
        THIS-OBJECT:label4:Location = NEW System.Drawing.Point(229, 154).
        THIS-OBJECT:label4:Name = "label4".
        THIS-OBJECT:label4:Size = NEW System.Drawing.Size(66, 23).
        THIS-OBJECT:label4:TabIndex = 40.
        THIS-OBJECT:label4:Text = "Beverages".
        THIS-OBJECT:label4:UseCompatibleTextRendering = TRUE.
        /*  */
        /* listBox3 */
        /*  */
        THIS-OBJECT:listBox3:FormattingEnabled = TRUE.
        THIS-OBJECT:listBox3:Location = NEW System.Drawing.Point(45, 298).
        THIS-OBJECT:listBox3:Name = "listBox3".
        THIS-OBJECT:listBox3:Size = NEW System.Drawing.Size(120, 95).
        THIS-OBJECT:listBox3:TabIndex = 41.
        /*  */
        /* label5 */
        /*  */
        THIS-OBJECT:label5:Location = NEW System.Drawing.Point(88, 280).
        THIS-OBJECT:label5:Name = "label5".
        THIS-OBJECT:label5:Size = NEW System.Drawing.Size(35, 15).
        THIS-OBJECT:label5:TabIndex = 42.
        THIS-OBJECT:label5:Text = "Menu".
        THIS-OBJECT:label5:UseCompatibleTextRendering = TRUE.
        /*  */
        /* textBox1 */
        /*  */
        THIS-OBJECT:textBox1:Location = NEW System.Drawing.Point(336, 180).
        THIS-OBJECT:textBox1:Name = "textBox1".
        THIS-OBJECT:textBox1:ReadOnly = TRUE.
        THIS-OBJECT:textBox1:Size = NEW System.Drawing.Size(251, 20).
        THIS-OBJECT:textBox1:TabIndex = 43.
        THIS-OBJECT:textBox1:autoSize = true.
        /*  */
        /* label6 */
        /*  */
        THIS-OBJECT:label6:Location = NEW System.Drawing.Point(345, 154).
        THIS-OBJECT:label6:Name = "label6".
        THIS-OBJECT:label6:Size = NEW System.Drawing.Size(120, 23).
        THIS-OBJECT:label6:TabIndex = 44.
        THIS-OBJECT:label6:Text = "Beverage Information".
        THIS-OBJECT:label6:UseCompatibleTextRendering = TRUE.
        /*  */
        /* label7 */
        /*  */
        THIS-OBJECT:label7:Location = NEW System.Drawing.Point(45, 77).
        THIS-OBJECT:label7:Name = "label7".
        THIS-OBJECT:label7:Size = NEW System.Drawing.Size(143, 23).
        THIS-OBJECT:label7:TabIndex = 45.
        THIS-OBJECT:label7:Text = "NoWaster Recommends".
        THIS-OBJECT:label7:UseCompatibleTextRendering = TRUE.
        THIS-OBJECT:label7:Click:Subscribe(THIS-OBJECT:label7_Click).
        /*  */
        /* textBox2 */
        /*  */
        THIS-OBJECT:textBox2:Location = NEW System.Drawing.Point(45, 104).
        THIS-OBJECT:textBox2:Name = "textBox2".
        THIS-OBJECT:textBox2:ReadOnly = TRUE.
        THIS-OBJECT:textBox2:Size = NEW System.Drawing.Size(217, 20).
        THIS-OBJECT:textBox2:TabIndex = 46.
        /*  */
        /* NoWasterUI */
        /*  */
        THIS-OBJECT:ClientSize = NEW System.Drawing.Size(657, 405).
        THIS-OBJECT:Controls:Add(THIS-OBJECT:textBox2).
        THIS-OBJECT:Controls:Add(THIS-OBJECT:label7).
        THIS-OBJECT:Controls:Add(THIS-OBJECT:label6).
        THIS-OBJECT:Controls:Add(THIS-OBJECT:textBox1).
        THIS-OBJECT:Controls:Add(THIS-OBJECT:label5).
        THIS-OBJECT:Controls:Add(THIS-OBJECT:listBox3).
        THIS-OBJECT:Controls:Add(THIS-OBJECT:label4).
        THIS-OBJECT:Controls:Add(THIS-OBJECT:label3).
        THIS-OBJECT:Controls:Add(THIS-OBJECT:numericUpDown1).
        THIS-OBJECT:Controls:Add(THIS-OBJECT:listBox2).
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
        THIS-OBJECT:PerformLayout().
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