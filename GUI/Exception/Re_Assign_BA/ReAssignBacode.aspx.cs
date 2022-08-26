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

public partial class GUI_Operations_Re_Assign_BA_ReAssignBacode : System.Web.UI.Page
{
    DataTable dt = new DataTable("table1");
    protected void Page_Load(object sender, EventArgs e)
    {
        btnrows.Attributes.Add("onclick", "javascript:return addRows()");
        btnsubmit.Attributes.Add("onclick", "javascript:return validateBoxes()");

        if (!IsPostBack)
        {
            for (int i = 0; i < 5; i++)
            {
                dt.Rows.Add();
            }

            grvcontrols.DataSource = dt;
            grvcontrols.DataBind();
        }
    }
    protected void btnrows_Click(object sender, EventArgs e)
    {
        Int16 maxrows = 0;
        if (txtnorows.Text.ToString().CompareTo("") != 0)
        {
            try
            {
                maxrows = Convert.ToInt16(txtnorows.Text);
            }
            catch (Exception ex)
            {
                txtnorows.Text = "";
                txtnorows.Focus();
            }
        }

        for (int i = 0; i < maxrows; i++)
        {
            dt.Rows.Add();
        }

        grvcontrols.DataSource = dt;
        grvcontrols.DataBind();

    }
    protected void grvcontrols_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            ((TextBox)e.Row.FindControl("txtbacode")).Attributes.Add("onblur", "BaBlur('" + ((TextBox)e.Row.FindControl("txtbacode")).ClientID.ToString() + "')");
            ((TextBox)e.Row.FindControl("txtdocno")).Attributes.Add("onblur", "Dockblur('" + ((TextBox)e.Row.FindControl("txtdocno")).ClientID.ToString() + "')");
            //((Button)e.Row.FindControl("btnbacode")).Attributes.Add("onclick", "popuplist('location','" + ((TextBox)e.Row.FindControl("btnbacode")).ClientID.ToString() + "','none')");
            Button b1 = (Button)e.Row.FindControl("btnbacode");
            TextBox t1 = (TextBox)e.Row.FindControl("txtbacode");
            b1.Attributes.Add("onclick", "popuplist('location','" + t1.ClientID.ToString() + "','none')");
        }
        else if (e.Row.RowType == DataControlRowType.Header)
        {
            //((Button)e.Row.FindControl("btnnewbacode")).Attributes.Add("onclick", "popuplist('location','btnnewbacode','" + grvcontrols.ID.ToString() + "')");
            ((Button)e.Row.FindControl("btnnewbacode")).Attributes.Add("onclick", "popuplist('location','txtbacode','" + grvcontrols.ID.ToString() + "')");
        }
    }
    protected void btnsubmit_Click(object sender, EventArgs e)
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        //  conn.Close();
        // conn.Close();
        conn.Open();

        SqlTransaction trn;
        trn = conn.BeginTransaction();
        foreach (GridViewRow gridrow in grvcontrols.Rows)
        {

            TextBox txtdocno = (TextBox)gridrow.FindControl("txtdocno");
            TextBox txtbacode = (TextBox)gridrow.FindControl("txtbacode");
            
            HiddenField hdnfld = (HiddenField)gridrow.FindControl("hdnfld");
            string hdnfldval = hdnfld.Value;
            string[] hdnvalarr = hdnfldval.Split(',');

            if (txtdocno.Text.CompareTo("") != 0)
            {
                try  //  try FOR ALL
                {

                    string SQl_ba = "UPDATE webx_master_docket SET Bacode='" + txtbacode.Text + "' WHERE dockno='" + txtdocno.Text + "'";
                    SqlHelper.ExecuteNonQuery(trn, CommandType.Text, SQl_ba);

                    string sql_sp = "exec usp_ReAssign_BACode '" + txtdocno.Text + "','" + hdnvalarr[0] + "','" + hdnvalarr[1] + "','" + txtbacode.Text + "','" + hdnvalarr[2] + "'";
                    SqlHelper.ExecuteNonQuery(trn, CommandType.Text, sql_sp);
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
            }
        }
        trn.Commit();
        conn.Close();
        Response.Redirect("Updatedone.aspx");
    }
}
