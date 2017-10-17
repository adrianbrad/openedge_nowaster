 
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
    DEFINE PRIVATE VARIABLE checkBox3 AS System.Windows.Forms.CheckBox NO-UNDO.
    DEFINE PRIVATE VARIABLE checkBox2 AS System.Windows.Forms.CheckBox NO-UNDO.
    DEFINE PRIVATE VARIABLE checkBox1 AS System.Windows.Forms.CheckBox NO-UNDO.
    DEFINE PRIVATE VARIABLE components AS System.ComponentModel.IContainer NO-UNDO.
    DEFINE PRIVATE VARIABLE label2 AS System.Windows.Forms.Label NO-UNDO.
    DEFINE PRIVATE VARIABLE textBox1 AS System.Windows.Forms.TextBox NO-UNDO.
    DEFINE PRIVATE VARIABLE label1 AS System.Windows.Forms.Label NO-UNDO.

        
    CONSTRUCTOR PUBLIC NoWasterUI (  ):
        
        
        SUPER().
        InitializeComponent().
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
	METHOD PRIVATE VOID button1_Click( INPUT sender AS System.Object, INPUT e AS System.EventArgs ):
		
		RETURN.

	END METHOD.

	/*------------------------------------------------------------------------------
	 Purpose:
	 Notes:
	------------------------------------------------------------------------------*/
	@VisualDesigner.
	METHOD PRIVATE VOID checkBox1_CheckedChanged( INPUT sender AS System.Object, INPUT e AS System.EventArgs ):
		
		RETURN.

	END METHOD.

	/*------------------------------------------------------------------------------
	 Purpose:
	 Notes:
	------------------------------------------------------------------------------*/
	@VisualDesigner.
	METHOD PRIVATE VOID checkBox2_CheckedChanged( INPUT sender AS System.Object, INPUT e AS System.EventArgs ):
		
		RETURN.

	END METHOD.

	/*------------------------------------------------------------------------------
	 Purpose:
	 Notes:
	------------------------------------------------------------------------------*/
	@VisualDesigner.
	METHOD PRIVATE VOID checkBox3_CheckedChanged( INPUT sender AS System.Object, INPUT e AS System.EventArgs ):
		
		RETURN.

	END METHOD.

    METHOD PRIVATE VOID InitializeComponent(  ):
        
        /* NOTE: The following method is automatically generated.
        
        We strongly suggest that the contents of this method only be modified using the
        Visual Designer to avoid any incompatible modifications.
        
        Modifying the contents of this method using a code editor will invalidate any support for this file. */
        THIS-OBJECT:textBox1 = NEW System.Windows.Forms.TextBox().
        THIS-OBJECT:label1 = NEW System.Windows.Forms.Label().
        THIS-OBJECT:button1 = NEW System.Windows.Forms.Button().
        THIS-OBJECT:label2 = NEW System.Windows.Forms.Label().
        THIS-OBJECT:checkBox1 = NEW System.Windows.Forms.CheckBox().
        THIS-OBJECT:checkBox2 = NEW System.Windows.Forms.CheckBox().
        THIS-OBJECT:checkBox3 = NEW System.Windows.Forms.CheckBox().
        THIS-OBJECT:SuspendLayout().
        /*  */
        /* textBox1 */
        /*  */
        THIS-OBJECT:textBox1:Location = NEW System.Drawing.Point(85, 29).
        THIS-OBJECT:textBox1:Name = "textBox1".
        THIS-OBJECT:textBox1:Size = NEW System.Drawing.Size(100, 20).
        THIS-OBJECT:textBox1:TabIndex = 0.
        THIS-OBJECT:textBox1:TextChanged:Subscribe(THIS-OBJECT:textBox1_TextChanged).
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
        THIS-OBJECT:button1:Location = NEW System.Drawing.Point(178, 139).
        THIS-OBJECT:button1:Name = "button1".
        THIS-OBJECT:button1:Size = NEW System.Drawing.Size(89, 43).
        THIS-OBJECT:button1:TabIndex = 2.
        THIS-OBJECT:button1:Text = "NoWasterize Money".
        THIS-OBJECT:button1:UseCompatibleTextRendering = TRUE.
        THIS-OBJECT:button1:UseVisualStyleBackColor = TRUE.
        THIS-OBJECT:button1:Click:Subscribe(THIS-OBJECT:button1_Click).
        /*  */
        /* label2 */
        /*  */
        THIS-OBJECT:label2:Location = NEW System.Drawing.Point(232, 26).
        THIS-OBJECT:label2:Name = "label2".
        THIS-OBJECT:label2:Size = NEW System.Drawing.Size(100, 23).
        THIS-OBJECT:label2:TabIndex = 3.
        THIS-OBJECT:label2:Text = "Type of drink".
        THIS-OBJECT:label2:UseCompatibleTextRendering = TRUE.
        THIS-OBJECT:label2:Click:Subscribe(THIS-OBJECT:label2_Click).
        /*  */
        /* checkBox1 */
        /*  */
        THIS-OBJECT:checkBox1:Location = NEW System.Drawing.Point(338, 21).
        THIS-OBJECT:checkBox1:Name = "checkBox1".
        THIS-OBJECT:checkBox1:Size = NEW System.Drawing.Size(104, 24).
        THIS-OBJECT:checkBox1:TabIndex = 4.
        THIS-OBJECT:checkBox1:Text = "Drink Type 1".
        THIS-OBJECT:checkBox1:UseCompatibleTextRendering = TRUE.
        THIS-OBJECT:checkBox1:UseVisualStyleBackColor = TRUE.
        THIS-OBJECT:checkBox1:CheckedChanged:Subscribe(THIS-OBJECT:checkBox1_CheckedChanged).
        /*  */
        /* checkBox2 */
        /*  */
        THIS-OBJECT:checkBox2:Location = NEW System.Drawing.Point(338, 62).
        THIS-OBJECT:checkBox2:Name = "checkBox2".
        THIS-OBJECT:checkBox2:Size = NEW System.Drawing.Size(104, 24).
        THIS-OBJECT:checkBox2:TabIndex = 5.
        THIS-OBJECT:checkBox2:Text = "Drink Type 2".
        THIS-OBJECT:checkBox2:UseCompatibleTextRendering = TRUE.
        THIS-OBJECT:checkBox2:UseVisualStyleBackColor = TRUE.
        THIS-OBJECT:checkBox2:CheckedChanged:Subscribe(THIS-OBJECT:checkBox2_CheckedChanged).
        /*  */
        /* checkBox3 */
        /*  */
        THIS-OBJECT:checkBox3:Location = NEW System.Drawing.Point(338, 109).
        THIS-OBJECT:checkBox3:Name = "checkBox3".
        THIS-OBJECT:checkBox3:Size = NEW System.Drawing.Size(104, 24).
        THIS-OBJECT:checkBox3:TabIndex = 6.
        THIS-OBJECT:checkBox3:Text = "Drink Type 3".
        THIS-OBJECT:checkBox3:UseCompatibleTextRendering = TRUE.
        THIS-OBJECT:checkBox3:UseVisualStyleBackColor = TRUE.
        THIS-OBJECT:checkBox3:CheckedChanged:Subscribe(THIS-OBJECT:checkBox3_CheckedChanged).
        /*  */
        /* NoWasterUI */
        /*  */
        THIS-OBJECT:ClientSize = NEW System.Drawing.Size(546, 356).
        THIS-OBJECT:Controls:Add(THIS-OBJECT:checkBox3).
        THIS-OBJECT:Controls:Add(THIS-OBJECT:checkBox2).
        THIS-OBJECT:Controls:Add(THIS-OBJECT:checkBox1).
        THIS-OBJECT:Controls:Add(THIS-OBJECT:label2).
        THIS-OBJECT:Controls:Add(THIS-OBJECT:button1).
        THIS-OBJECT:Controls:Add(THIS-OBJECT:label1).
        THIS-OBJECT:Controls:Add(THIS-OBJECT:textBox1).
        THIS-OBJECT:Name = "NoWasterUI".
        THIS-OBJECT:Text = "NoWasterUI".
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
	METHOD PRIVATE VOID textBox1_TextChanged( INPUT sender AS System.Object, INPUT e AS System.EventArgs ):
		
		RETURN.

	END METHOD.

    DESTRUCTOR PUBLIC NoWasterUI ( ):

    END DESTRUCTOR.

END CLASS.