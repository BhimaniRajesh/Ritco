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

public partial class GUI_Operations_THC_Reassign_Location_ReAssignBalanceLocation : System.Web.UI.Page
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
            Button b1 = (Button)e.Row.FindControl("btnbacode");
            TextBox t1 = (TextBox)e.Row.FindControl("txtbacode");
            b1.Attributes.Add("onclick", "popuplist('location','" + t1.ClientID.ToString() + "','none')");
        }
        else if (e.Row.RowType == DataControlRowType.Header)
        {
            ((Button)e.Row.FindControl("btnnewbacode")).Attributes.Add("onclick", "popuplist('location','txtbacode','" + grvcontrols.ID.ToString() + "')");
        }
    }
    protected void btnsubmit_Click(object sender, EventArgs e)
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

        conn.Open();
        SqlCommand cmd = new SqlCommand();
        SqlTransaction trn;
        trn = conn.BeginTransaction();
        try  //  try FOR ALL
        {
            foreach (GridViewRow gridrow in grvcontrols.Rows)
            {
                TextBox txtdocno = (TextBox)gridrow.FindControl("txtdocno");
                TextBox txtbacode = (TextBox)gridrow.FindControl("txtbacode");
                //hdnfld
                HiddenField hdnfld = (HiddenField)gridrow.FindControl("hdnfld");
                string hdnfldval = hdnfld.Value;
                string[] hdnvalarr = hdnfldval.Split(',');

                if (txtdocno.Text != "")
                {
                    string SQl_ba = "UPDATE webx_thc_summary SET balamtbrcd='" + txtbacode.Text + "' WHERE thcno='" + txtdocno.Text + "'";
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
