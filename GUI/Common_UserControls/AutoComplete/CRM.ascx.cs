using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.IO;
/*
        REGISTER ALL KEYS
	    ADD HIDDENFIELDS FOR VALUES LIKE FIRST IN FOUCS,LAST IN FOCUS, FOCUS ID NO
 *      TEST ON FOCUSING
 *      ADD FILTERATION
 *      ON BLUR OF TEXT BOX DONT DO ANYTHING
 *      ON BLUR OF XAC YOU CAN HIDE PANEL
 *      NEED SEARCH ON SCROLL ON DIV; FIRE SCROLL EVENT ON KEYDOWN OF DIV
 * 
 *      GIVE EACH METHOD DIFFERENT NAME
 * 
 * 
 *      PUT A COUNTER ON BY DEFAULT 1, FOCUS OF CODE TARGET 1,ON SELCTION BY CLICK AND RETURN HIT 0,
 *      IF IN RESPONSE TEXT ASSIGNMENT IF 1 THEN ONLY SHOW DIV ELSE DON'T THIS WILL IMPROVE VISIBILITY
 
 */
public enum WebxEntity
{
    Customer = 0,
    BranchCode,
    City,
    Pincode,
    CustomerAddress,
    Vendor,
    Prospect,
    Acccode,
	LedgerCode,
    Employee,
    Vehicle,
    Driver
}
public partial class GUI_Operation_DocketEntry_XAC : System.Web.UI.UserControl
{
    string tname1, tname2, txtfilt, strfilt;
    TextBox txt1, txt2, txtf;
    Int16 minlen;
    WebxEntity _oWE = WebxEntity.Customer;
    public string CodeTarget { get { return tname1; } set { tname1 = value; } }
    public string NameTarget { get { return tname2; } set { tname2 = value; } }
    public WebxEntity WebxEntity { get { return _oWE; } set { _oWE = value; } }
    public string FilterTextBox { get { return txtfilt; } set { txtfilt = value; } }
    public string FilterString { get { return fltr_str.Value; } set { fltr_str.Value = value; } }
    public Int16 MinPrefixLength { get { return minlen; } set { minlen = value; } }
    private TextBox CodeTextBox { get { return txt1; } set { txt1 = value; } }
    private TextBox NameTextBox { get { return txt2; } set { txt2 = value; } }
    private TextBox FiltTextBox { get { return txtf; } set { txtf = value; } }

    protected void Page_Load(object sender, EventArgs e)
    {
        Exception ex_s;
        if (CodeTarget == "")
        {
            ex_s = new Exception("Property CodeTarget hasn't been initialized");
            throw ex_s;
        }
        try
        {
            CodeTextBox = (TextBox)this.Parent.FindControl(CodeTarget);
        }
        catch (Exception ex) { }
        try
        {
            NameTextBox = (TextBox)this.Parent.FindControl(NameTarget);
        }
        catch (Exception ex) { }
        try
        {
            FiltTextBox = (TextBox)this.Parent.FindControl(FilterTextBox);
        }
        catch (Exception ex) { }

        if (CodeTextBox == null)
        {
            ex_s = new Exception("Property CodeTarget has some inavalid value"); throw ex_s;
        }

        if (MinPrefixLength == 0)
        { ex_s = new Exception("Property MinPrefixLength has some inavalid value"); throw ex_s; }



        if (!IsPostBack)
            NewWebxComplete();


        string str2 = @"<script>function " + CodeTextBox.ClientID.ToString() + "_ItemClick(cval,nval,target1,target2){";
        str2 = str2 + @"target1.value=cval;if(target2)target2.value=nval;" + divXAC.ClientID + ".innerHTML='';" + divXAC.ClientID + ".style.display='none';}</script>";
        Page.RegisterStartupScript("REGSTR_" + this.ClientID.ToString() + "_2", str2);

        CodeTextBox.Attributes.Add("onkeyup", "javascript:var WEBX=new WEBX_" + this.ClientID.ToString() + "(); CodeKeyUp(event,WEBX," + init.ClientID + ");");
        CodeTextBox.Attributes.Add("onblur", "javascript:return CodeBlur(" + fs_st.ClientID + "," + divXAC.ClientID + "," + ino.ClientID + "," + CodeTextBox.ClientID + "," + init.ClientID + ")");
        CodeTextBox.Attributes.Add("onfocus", "javascript:return CodeFocus(" + fs_st.ClientID + "," + divXAC.ClientID + "," + ino.ClientID + "," + CodeTextBox.ClientID + "," + init.ClientID + ")");

        // XAC BINDS
        divXAC.Attributes.Add("onfocus", "javascript:return xacFocus(WEBX_" + this.ClientID.ToString() + ")");
        divXAC.Attributes.Add("onmouseover", "javascript:return xacMouseOver(" + fs_st.ClientID + "," + ms_fs.ClientID + ")");
        divXAC.Attributes.Add("onmouseout", "javascript:return xacMouseOut(" + fs_st.ClientID + "," + ms_fs.ClientID + ")");
        divXAC.Style["position"] = "absolute";
        divXAC.Attributes.Add("onkeydown", "javascript:var WEBX=new WEBX_" + this.ClientID.ToString() + "();xacKeyDown(event,WEBX);");
        divXAC.Attributes.Add("onblur", "javascript:return xacBlur(event,this," + ms_fs.ClientID + ");");
    }

    public void NewWebxComplete()
    {
        string str2 = @"<script>function WEBX_" + this.ClientID.ToString() + "(){";
        string idd = ((TextBox)this.Parent.FindControl(CodeTarget)).ClientID.ToString();
        str2 = str2 + " var WEBX_" + this.ClientID.ToString() + " = new Object(); WEBX_" + this.ClientID.ToString() + ".WebxComplete = new Object();";
        str2 = str2 + "WEBX_" + this.ClientID.ToString() + ".WebxComplete.Target1=new Object();WEBX_" + this.ClientID.ToString() + ".WebxComplete.Target1=document.getElementById('" + idd + "');";
        str2 = str2 + "WEBX_" + this.ClientID.ToString() + ".WebxComplete.Target2=document.getElementById('" + (NameTextBox == null ? "null;" : NameTextBox.ClientID) + "');";
        str2 = str2 + "WEBX_" + this.ClientID.ToString() + ".WebxComplete.Type='" + WebxEntity + "';";
        str2 = str2 + "WEBX_" + this.ClientID.ToString() + ".WebxComplete.filt1=" + (FiltTextBox == null ? "null;" : ("document.getElementById('" + FiltTextBox.ClientID + "');"));
        str2 = str2 + "WEBX_" + this.ClientID.ToString() + ".WebxComplete.filt2=document.getElementById('" + fltr_str.ClientID + "');";
        str2 = str2 + "WEBX_" + this.ClientID.ToString() + ".WebxComplete.div=" + divXAC.ClientID + ";";
        str2 = str2 + "WEBX_" + this.ClientID.ToString() + ".WebxComplete.ino=document.getElementById('" + ino.ClientID + "');";
        str2 = str2 + "WEBX_" + this.ClientID.ToString() + ".WebxComplete.preflen=" + MinPrefixLength + ";";
        str2 = str2 + "WEBX_" + this.ClientID.ToString() + ".WebxComplete.currid=document.getElementById('" + c_id.ClientID + "');";
        str2 = str2 + "WEBX_" + this.ClientID.ToString() + ".WebxComplete.fs_st=document.getElementById('" + fs_st.ClientID + "');";
        str2 = str2 + "WEBX_" + this.ClientID.ToString() + ".WebxComplete.ms_fs=document.getElementById('" + ms_fs.ClientID + "');";
        str2 = str2 + "if(WEBX_" + this.ClientID.ToString() + ".WebxComplete.Target1)WEBX_" + this.ClientID.ToString() + ".WebxComplete.Target1.autocomplete='off';";
        str2 = str2 + "if(WEBX_" + this.ClientID.ToString() + ".WebxComplete.Target2)WEBX_" + this.ClientID.ToString() + ".WebxComplete.Target2.autocomplete='off';";
        str2 = str2 + "return WEBX_" + this.ClientID.ToString() + ";";
        str2 = str2 + "}</script>";
        Page.RegisterStartupScript("REGSTR_" + this.ClientID.ToString() + "_1", str2);
    }
}
