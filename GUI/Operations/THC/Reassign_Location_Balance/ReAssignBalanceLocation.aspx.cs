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
using System.ComponentModel;
using System.Drawing;
using System.Web.SessionState;
using System.Security;
using Microsoft.ApplicationBlocks.Data;

public partial class GUI_Operations_THC_Reassign_Location_Balance_ReAssignBalanceLocation : System.Web.UI.Page
{

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
            conn.Open();

            string RO = Request.QueryString.Get("RO");
            string LO = Request.QueryString.Get("LO");
            string fromdt = Request.QueryString.Get("fromdt");
            string todt = Request.QueryString.Get("todt");
            string doclist = Request.QueryString.Get("doclist");

            string sql_st = "exec usp_THCBalanceLocationList '" + fromdt + "','" + todt + "','" + RO + "','" + LO + "','" + doclist + "'";
            //Response.Write(sql_st);
            //Response.End();
            SqlCommand sqlcmd12 = new SqlCommand(sql_st, conn);
            SqlDataAdapter da = new SqlDataAdapter(sqlcmd12);
            DataSet ds = new DataSet();
            da.Fill(ds);
            GridTHCList.DataSource = ds;
            GridTHCList.DataBind();

            conn.Close();
        }
        

    }
    protected void GridTHCList_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            HiddenField hdnFromModule = (HiddenField)e.Row.FindControl("hdnFromModule");
            HiddenField hdnIsBTHProposal = (HiddenField)e.Row.FindControl("hdnIsBTHProposal");
            Button b1 = (Button)e.Row.FindControl("btnbacode");
            TextBox t1 = (TextBox)e.Row.FindControl("txtbacode");
            b1.Attributes.Add("onclick", "popuplist('location','" + t1.ClientID.ToString() + "','none')");

            if (hdnFromModule.Value.ToUpper() == "NEWMVC" && hdnIsBTHProposal.Value == "1") {

                t1.Enabled = false;
                b1.Enabled = false;
            }
        }
        else if (e.Row.RowType == DataControlRowType.Header)
        {
            ((Button)e.Row.FindControl("btnnewbacode")).Attributes.Add("onclick", "popuplist('location','txtbacode','" + GridTHCList.ID.ToString() + "')");
        }

    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {

        // foreach (GridViewRow gridrow in GridTHCList.Rows)
        // {
            // TextBox txtdocno = (TextBox)gridrow.FindControl("txtdocno");
            // TextBox txtbacode = (TextBox)gridrow.FindControl("txtbacode");
            // HiddenField hdnTHCNo = (HiddenField)gridrow.FindControl("hdnTHCNo");
            // if (txtbacode.Text != "")
            // {
                // string sqlLocation = "Select * from Webx_Location where Loccode= '" + txtbacode.Text + "'";
                // DataSet DsLocation = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, sqlLocation);

                // if (DsLocation.Tables[0].Rows.Count == 0)
                // {
                    // Response.Redirect("~/GUI/ErrorPage.aspx?PageHead=" + "Invalid New Balance Location  " + "&ErrorMsg=Please Enter Valid Location From Master ", false);
                    // return;
                // }
            // }

        // }

     
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        string SQl_ba = "";
        conn.Open();
        SqlCommand cmd = new SqlCommand();
        SqlTransaction trn;
        trn = conn.BeginTransaction();
        try 
        {
            foreach (GridViewRow gridrow in GridTHCList.Rows)
            {
                TextBox txtdocno = (TextBox)gridrow.FindControl("txtdocno");
                TextBox txtbacode = (TextBox)gridrow.FindControl("txtbacode");
                HiddenField hdnTHCNo = (HiddenField)gridrow.FindControl("hdnTHCNo");
                if (txtbacode.Text != "")
                {
                    
                    SQl_ba = "UPDATE webx_thc_summary SET balamtbrcd='" + txtbacode.Text + "' WHERE thcno='" + hdnTHCNo.Value + "'";
                    cmd = new SqlCommand(SQl_ba, conn, trn);
                    cmd.ExecuteNonQuery();
                }

            }
            trn.Commit();
        }
        catch (Exception e1)
        {
            Response.Write("<br><br><br><font class='blackboldfnt' >Error : " + e1.Message + "</font>");
            string msg = e1.Message.ToString();
            msg = msg.Replace('\n', ' ');
            trn.Rollback();
            conn.Close();
            Response.Redirect("Message.aspx?" + e1.Message);
        }
        conn.Close();
        Response.Redirect("Updatedone.aspx");
    }
    
}
