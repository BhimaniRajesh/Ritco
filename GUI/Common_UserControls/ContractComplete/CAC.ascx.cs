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

public enum ContractEntities
{
    City,
    Branch,
    Region
}

public partial class ContractComplete : System.Web.UI.UserControl
{
    string tname1, tname2, tname3, txtfilt, txtfilt2;
    TextBox txt1, txt2, txt3, txtf, txtf2;
    Int16 minlen;

    public string CodeTarget { get { return tname1; } set { tname1 = value; } }
    public string NameTarget { get { return tname2; } set { tname2 = value; } }
    public string Target3 { get { return tname3; } set { tname3 = value; } }
    public ContractEntities ContractEntity { get { return (ContractEntities)Enum.Parse(typeof(string), tp.Value); } set { tp.Value = Convert.ToString(value); } }
    //public string ContractEntity { get { return tp.Value; } set { tp.Value = value; } }
    public string FilterTextBox { get { return txtfilt; } set { txtfilt = value; } }
    public string FilterTextBox2 { get { return txtfilt2; } set { txtfilt2 = value; } }

    public string FilterString { get { return fltr_str.Value; } set { fltr_str.Value = value; } }
    public Int16 MinPrefixLength { get { return minlen; } set { minlen = value; } }
    private TextBox CodeTextBox { get { return txt1; } set { txt1 = value; } }
    private TextBox NameTextBox { get { return txt2; } set { txt2 = value; } }
    private TextBox Targ3 { get { return txt3; } set { txt3 = value; } }
    private TextBox FiltTextBox { get { return txtf; } set { txtf = value; } }
    private TextBox FiltTextBox2 { get { return txtf2; } set { txtf2 = value; } }

    protected void Page_Load(object sender, EventArgs e)
    {
        #region GetControls
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
            Targ3 = (TextBox)this.Parent.FindControl(Target3);
        }
        catch (Exception ex) { }

        try
        {
            FiltTextBox = (TextBox)this.Parent.FindControl(FilterTextBox);
        }
        catch (Exception ex) { }

        try
        {
            FiltTextBox2 = (TextBox)this.Parent.FindControl(FilterTextBox2);
        }
        catch (Exception ex) { }

        if (CodeTextBox == null)
        {
            ex_s = new Exception("Property CodeTarget has some inavalid value"); throw ex_s;
        }

        if (MinPrefixLength == 0)
        { ex_s = new Exception("Property MinPrefixLength has some inavalid value"); throw ex_s; }
        #endregion

        string idd = ((TextBox)this.Parent.FindControl(CodeTarget)).ClientID.ToString();
        string nmtxtid = NameTextBox == null ? "null" : NameTextBox.ClientID;
        string tg3id = Target3 == null ? "null" : Targ3.ClientID;

        string filt1id = FiltTextBox == null ? "null" : FiltTextBox.ClientID;
        string filt2id = FiltTextBox2 == null ? "null" : FiltTextBox2.ClientID;
        string fltr_strid = fltr_str.ClientID;
        string divxacid = divXAC.ClientID;
        string inoid = ino.ClientID;
        string minlen = MinPrefixLength.ToString();
        string c_idid = c_id.ClientID;
        string fs_stid = fs_st.ClientID;
        string ms_fsid = ms_fs.ClientID;
        string GetNewDACObj = "new GetDACObj('" + idd + "','" + nmtxtid + "','" + tg3id + "','" + tp.ClientID.ToString() + "','" + filt1id + "','" + filt2id + "','" + fltr_strid + "','" + divxacid + "','" + inoid + "'," + minlen + ",'" + c_idid + "','" + fs_stid + "','" + ms_fsid + "')";

        CodeTextBox.Attributes.Add("onkeyup", "javascript:return dacCodeKeyUp(event," + GetNewDACObj + "," + init.ClientID + ");");
        CodeTextBox.Attributes.Add("onkeypress", "javascript:return dacCodeKeyPress(event," + GetNewDACObj + "," + init.ClientID + ");");
        CodeTextBox.Attributes.Add("onblur", "javascript:return dacCodeBlur(" + fs_st.ClientID + "," + divXAC.ClientID + "," + ino.ClientID + "," + CodeTextBox.ClientID + ",'" + init.ClientID + "')");
        CodeTextBox.Attributes.Add("onfocus", "javascript:return dacCodeFocus('" + init.ClientID + "')");

        divXAC.Attributes.Add("onfocus", "javascript:return dacFocus(" + GetNewDACObj + ")");
        divXAC.Attributes.Add("onmouseover", "javascript:return dacMouseOver(" + fs_st.ClientID + "," + ms_fs.ClientID + ")");
        divXAC.Attributes.Add("onmouseout", "javascript:return dacMouseOut(" + fs_st.ClientID + "," + ms_fs.ClientID + ")");
        divXAC.Style["position"] = "absolute";
        divXAC.Attributes.Add("onkeydown", "javascript:return dacKeyDown(event," + GetNewDACObj + ");");
        divXAC.Attributes.Add("onblur", "javascript:return dacBlur(event,this," + ms_fs.ClientID + ");");

    }
}
