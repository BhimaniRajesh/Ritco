using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using Microsoft.ApplicationBlocks.Data;

public partial class UserControls_ReceiptControl : System.Web.UI.UserControl
{
    string connStr;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            connStr = Session["SqlProvider"].ToString().Trim();
           

            TextBox chqno1 = (TextBox)txtChqNo;
            TextBox txtChqDate1 = (TextBox)txtChqDate;
            DropDownList dlstTransType1 = (DropDownList)dlstTransType;
            TextBox txtAmount1 = (TextBox)txtAmount;

            string strjs = "<script language='javascript'> function fcheckpayment(sender,args)" +
            "{" +
            "    transtype=document.getElementById('" + dlstTransType1.ClientID + "');" +
            "    chqno1 = document.getElementById('" + chqno1.ClientID + "');" +
            "    chqdt1 = document.getElementById('" + txtChqDate1.ClientID + "');" +
            "    if((transtype.value=='CASH'))" +
            "    {" +
            "        chqno1.value='';" +
            "        chqdt1.value='';" +
            "   } " +
            "   if(transtype.value=='BANK') " +
            "{" +
            "    if(chqno1.value=='')" +
            "    { " +
            "        alert('Please enter Cheque No/DD No!!!');" +
            "        chqno1.focus();" +
            "        args.IsValid = false;" +
            "        return;  " +
            "    }" +
            "    if(chqdt1.value=='')" +
            "    {" +
            "        alert('Please enter Cheque /DD Date');" +
            "        chqdt1.focus();" +
            "        args.IsValid = false;" +
            "        return;  " +
            "    }" +
            "}" +
            "          args.IsValid = true;" +
            "}" +
            "</script>";
            Page.RegisterClientScriptBlock("jsScript", strjs);

        }
    }
    protected void txtChqDate_TextChanged(object sender, EventArgs e)
    {
        MyFunctions fn = new MyFunctions();
        string chqno = txtChqNo.Text;
        string chqdate = fn.Mydate1(txtChqDate.Text);
        connStr = Session["SqlProvider"].ToString().Trim();
        SqlParameter[] arParms = new SqlParameter[2];
        arParms[0] = new SqlParameter("@chqno", SqlDbType.VarChar, 6);
        arParms[0].Value = chqno;

        arParms[1] = new SqlParameter("@chqdate", SqlDbType.VarChar, 12);
        arParms[1].Value = chqdate;

        try
        {
            SqlDataReader rdr = SqlHelper.ExecuteReader(connStr, CommandType.StoredProcedure, "usp_duplicate_cheque", arParms);
            if (rdr.Read())
            {
                if (rdr[0].ToString() == "1")
                {
                    //CustomValidator2.ErrorMessage = "Duplicate Cheque No & Date found!!!";
                    //CustomValidator2.IsValid = false;
                }
            }
            rdr.Close();
        }
        catch (Exception e1)
        {
            //CustomValidator2.ErrorMessage = "Please Enter Valid Date!!!";
            //CustomValidator2.IsValid = false;

        }
        finally
        {

        }

    }
}
