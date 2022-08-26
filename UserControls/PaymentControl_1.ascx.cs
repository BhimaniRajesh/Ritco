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

public partial class UserControls_PaymentControl_1 : System.Web.UI.UserControl
{
    string connStr;
    protected void Page_Load(object sender, EventArgs e)
    {
        
        if (!Page.IsPostBack)
        {
            connStr = Session["SqlProvider"].ToString().Trim();
            string sql = "";
            if (Session["HeadOfficeCode"].ToString() == Session["brcd"].ToString())
                sql = "select Accdesc + '~ ' + Company_Acccode as accdesc,Acccode from webx_acctinfo where  ( acccategory='CASH' OR  acccategory='BANK' ) order by accdesc asc";

            else
                sql = "select Accdesc + '~ ' + Company_Acccode as accdesc,Acccode from webx_acctinfo where  ( acccategory='CASH' OR ((bkloccode like '%" + Session["brcd"].ToString() + "%' or bkloccode='ALL') AND acccategory='BANK')) order by accdesc asc";

            DataSet ds = SqlHelper.ExecuteDataset(connStr, CommandType.Text, sql);
            //DropDownList dlst = (DropDownList)e.FindControl("dlstAcccode");
            dlstAcccode.DataSource = ds.Tables[0].DefaultView;
            dlstAcccode.DataTextField = "accdesc";
            dlstAcccode.DataValueField = "acccode";
            dlstAcccode.DataBind();
            dlstAcccode.Items.Insert(0, new ListItem("Select", ""));

            TextBox chqno1=(TextBox)txtChqNo;
            TextBox txtChqDate1=(TextBox)txtChqDate;
            DropDownList dlstAcccode1=(DropDownList)dlstAcccode;
            DropDownList dlstTransType1=(DropDownList)dlstTransType;
            TextBox txtAmount1=(TextBox)txtAmount;

            string strjs = "<script language='javascript'> function fcheckpayment(sender,args)" +
            "{" +
            "    transtype=document.getElementById('" + dlstTransType1.ClientID + "');" +
            "    acccode=document.getElementById('" + dlstAcccode1.ClientID + "');" +
            "    chqno1 = document.getElementById('" + chqno1.ClientID + "');" +
            "    chqdt1 = document.getElementById('" + txtChqDate1.ClientID + "');" +
            "    if((transtype.value=='CASH')&&(acccode.value.indexOf('CASH')<=0))" +
            "    {" +
            "        chqno1.value='';" +
            "        chqdt1.value='';" +
            "        alert('Please select Cash Account!!!');" +
            "        acccode.focus();" +
            "        args.IsValid = false;" +
            "        return;  " +
            "   } " +
            "   if(transtype.value=='BANK') " +
            "{" +
            "    if(acccode.value.indexOf('BANK')<=0) " +
            "   {" +
            "       alert('Please select Bank Account!!!');" +
            "       acccode.focus(); " +
            "       args.IsValid = false;" +
            "       return;  " +
            "    }" +
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
                    CustomValidator2.ErrorMessage = "Duplicate Cheque No & Date found!!!";
                    CustomValidator2.IsValid = false;
                }
            }
            rdr.Close();
        }
        catch (Exception e1)
        {   
            CustomValidator2.ErrorMessage="Please Enter Valid Date!!!";
            CustomValidator2.IsValid = false;

        }
        finally
        {

        }
       
    }
    protected void dlstTransType_onChange(object sender, EventArgs e)
    {
        connStr = Session["SqlProvider"].ToString().Trim();
        string cashbank = dlstTransType.SelectedItem.Text;
        string sql = "";
        if (Session["HeadOfficeCode"].ToString() == Session["brcd"].ToString())
            if (cashbank == "Cash")
            {
                sql = "select Accdesc + '~ ' + Company_Acccode as accdesc,Acccode from webx_acctinfo where  acccategory='" + dlstTransType.SelectedItem.Value + "' order by accdesc asc";
            }
            else
            {
                sql = "select Accdesc + '~ ' + Company_Acccode as accdesc,Acccode from webx_acctinfo where  acccategory='" + dlstTransType.SelectedItem.Value + "'and bkloccode Like '%" + Session["brcd"].ToString() + "%' order by accdesc asc";
            }
        else if(cashbank == "Bank")
            sql = "select Accdesc + '~ ' + Company_Acccode as accdesc,Acccode from webx_acctinfo where  (bkloccode like '%" + Session["brcd"].ToString() + "%' or bkloccode='ALL') and acccategory='" + cashbank + "' order by accdesc asc";
        else
            sql = "select Accdesc + '~ ' + Company_Acccode as accdesc,Acccode from webx_acctinfo where  (acccategory like '%" + "" + "%' or bkloccode='ALL') and acccategory='" + cashbank + "' order by accdesc asc";
        DataSet ds = SqlHelper.ExecuteDataset(connStr, CommandType.Text, sql);
        dlstAcccode.DataSource = ds;
        dlstAcccode.DataTextField = "accdesc";
        dlstAcccode.DataValueField = "acccode";
        dlstAcccode.DataBind();
        dlstAcccode.Items.Insert(0, new ListItem("Select", ""));
    }
}
