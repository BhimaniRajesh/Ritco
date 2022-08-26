using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;
using Microsoft.ApplicationBlocks.Data;
using System.Data.SqlClient;

public partial class GUI_Fleet_TripRuleMaster_BackDateControl_Back_Date_Control : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            try
            {
                string strqry = "select Srno,Module_code,Module_Name,Rule_Y_N,BackDate_Days,Min_Date=convert(varchar,Min_Date,103),Empcd from Webx_Fleet_Date_Rules with(nolock)";

                DataSet ds = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, strqry);

                grvDateRule.DataSource = ds;
                grvDateRule.DataBind();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {

        foreach (GridViewRow gridrow in grvDateRule.Rows)
        {
            Label lbl_ModuleName = (Label)gridrow.FindControl("lbl_ModuleName");
            HiddenField Hnd_Srno = (HiddenField)gridrow.FindControl("Hnd_Srno");
            HiddenField Rule_Y_N = (HiddenField)gridrow.FindControl("Rule_Y_N");
            CheckBox chkAllowBackDate = (CheckBox)gridrow.FindControl("chkAllowBackDate");
            TextBox txtBackDate = (TextBox)gridrow.FindControl("txtBackDate");
            TextBox txtForwardDate = (TextBox)gridrow.FindControl("txtForwardDate");
            TextBox txtMinDate = (TextBox)gridrow.FindControl("txtMinDate");
            TextBox txtEmpcd = (TextBox)gridrow.FindControl("txtEmpcd");

            string daterule;
            if (chkAllowBackDate.Checked == true)
            {
                daterule = "Y";
            }
            else
            {
                daterule = "N";
            }

            SqlConnection con = new SqlConnection(Session["SqlProvider"].ToString().Trim());
            con.Open();

            SqlTransaction trans;
            trans = con.BeginTransaction();

            try
            {
                string strqry = "update dbo.Webx_Fleet_Date_Rules "
                    + "set Rule_Y_N='" + daterule + "',"
                    + "BackDate_Days=" + txtBackDate.Text + ","
                    + "Min_Date='" + WebXConvert.ToDateTime(txtMinDate.Text, "en-GB").ToString("dd MMM yyyy") + "',"
                    + "Empcd='" + txtEmpcd.Text + "'where Srno=" + Hnd_Srno.Value + " ";

                SqlHelper.ExecuteNonQuery(trans, CommandType.Text, strqry);

                trans.Commit();
            }
            catch (Exception e1)
            {
                Response.Write("<br><br><br><center><font class='blackboldfnt' color='red'><b>Error : " + e1.Message + "</b></font></center>");
                string msg = e1.Message.ToString();
                msg = msg.Replace('\n', ' ');
                trans.Rollback();
                Response.Redirect("Message.aspx?" + msg);
                Response.End();
            }

            con.Close();
            //Response.Redirect("Master_Done.aspx",false);
            Response.Redirect("Back_Date_Control.aspx", false);

        }
    }
    protected void grvDateRule_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            TextBox txtMinDate = (TextBox)e.Row.FindControl("txtMinDate");
            HyperLink hypCAL = (HyperLink)e.Row.FindControl("hypCAL");
            TextBox txtEmpcd = (TextBox)e.Row.FindControl("txtEmpcd");
            Button btnEmpCode = (Button)e.Row.FindControl("btnEmpCode");
            btnEmpCode.Attributes.Add("onclick", "openEmployee('" + txtEmpcd.ClientID.ToString() + "')");
            //((Button)e.Row.FindControl("btnBalancePoFromLoc")).Attributes.Add("onclick", "popuplist('LocCode','" + ((TextBox)e.Row.FindControl("txtPartPOFrom1")).ClientID.ToString() + "','none')");
            hypCAL.Attributes.Add("onclick", "cal.select(" + txtMinDate.ClientID + ",'" + hypCAL.ClientID + "','dd/MM/yyyy'); return false;");
            CheckBox chkAllowBackDate = (CheckBox)e.Row.FindControl("chkAllowBackDate");
            HiddenField hdnAllowBackDate = (HiddenField)e.Row.FindControl("hdnAllowBackDate");
            if (hdnAllowBackDate.Value == "Y")
            {
                chkAllowBackDate.Checked = true;
            }
            else
            {
                chkAllowBackDate.Checked = false;
            }
        }
    }
}
