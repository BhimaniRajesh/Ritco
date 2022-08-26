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
using System.Data.SqlClient;

public partial class GUI_Finance_Billing_BillEdit_ReAssignBillSumissionnCollection : System.Web.UI.Page
{
    DataTable dt = new DataTable("table1");
    protected void Page_Load(object sender, EventArgs e)
    {   
        if (!IsPostBack)
        {
            for (int i = 0; i < 5; i++)
            {
                dt.Rows.Add();
            }

            grvcontrols.DataSource = dt;
            grvcontrols.DataBind();

            btnrows.Attributes.Add("onclick", "javascript:return addRows()");
            btnsubmit.Attributes.Add("onclick", "javascript:return validateBoxes()");
        }
    }
    protected void grvcontrols_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            ((TextBox)e.Row.FindControl("txtbillno")).Attributes.Add("onblur", "billBlur('" + ((TextBox)e.Row.FindControl("txtbillno")).ClientID.ToString() + "')");
            ((TextBox)e.Row.FindControl("txtsubloc")).Attributes.Add("onblur", "locBlur('" + ((TextBox)e.Row.FindControl("txtsubloc")).ClientID.ToString() + "')");
            ((TextBox)e.Row.FindControl("txtcolloc")).Attributes.Add("onblur", "locBlur('" + ((TextBox)e.Row.FindControl("txtcolloc")).ClientID.ToString() + "')");

            ((Button)e.Row.FindControl("btnsubloc")).Attributes.Add("onclick", "javascript:return popuplist('location','" + ((TextBox)e.Row.FindControl("txtsubloc")).ClientID.ToString() + "','none')");
            ((Button)e.Row.FindControl("btncolloc")).Attributes.Add("onclick", "javascript:return popuplist('location','" + ((TextBox)e.Row.FindControl("txtcolloc")).ClientID.ToString() + "','none')");
        }
        else if (e.Row.RowType == DataControlRowType.Header)
        {
            //((Button)e.Row.FindControl("btnheadsubloc")).Attributes.Add("onclick", "popuplist('location','txtsubloc','" + grvcontrols.ID.ToString() + "')");
            //((Button)e.Row.FindControl("btnheadcolloc")).Attributes.Add("onclick", "popuplist('location','txtcolloc','" + grvcontrols.ID.ToString() + "')");
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

    protected void btnsubmit_Click(object sender, EventArgs e)
    {
        SqlConnection con = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        con.Open();

        SqlTransaction trans;
        trans = con.BeginTransaction();

        try 
        {
            string qry = "";
            SqlCommand cmd;
            for (int i = 0; i < grvcontrols.Rows.Count; i++)
            {
                TextBox txtbillno = (TextBox)grvcontrols.Rows[i].FindControl("txtbillno");
                TextBox txtsubloc = (TextBox)grvcontrols.Rows[i].FindControl("txtsubloc");
                TextBox txtcolloc = (TextBox)grvcontrols.Rows[i].FindControl("txtcolloc");
                HiddenField hdnbillstatus = (HiddenField)grvcontrols.Rows[i].FindControl("hdnbillstatus");
                
                if (hdnbillstatus.Value.CompareTo("Bill Generated") == 0)
                {
                    if (txtsubloc.Text != "" && txtcolloc.Text != "")
                    {
                        qry = "UPDATE webx_billmst SET billsubbrcd='" + txtsubloc.Text + "',billcolbrcd='" + txtcolloc.Text + "' WHERE billno='" + txtbillno.Text + "'";
                        cmd = new SqlCommand(qry, con, trans);
                        cmd.ExecuteNonQuery();
                    }
                    else if (txtsubloc.Text != "" && txtcolloc.Text == "")
                    {
                        qry = "UPDATE webx_billmst SET billsubbrcd='" + txtsubloc.Text + "' WHERE billno='" + txtbillno.Text + "'";
                        cmd = new SqlCommand(qry, con, trans);
                        cmd.ExecuteNonQuery();
                    }
                    else if (txtsubloc.Text == "" && txtcolloc.Text != "")
                    {
                        qry = "UPDATE webx_billmst SET billcolbrcd='" + txtcolloc.Text + "' WHERE billno='" + txtbillno.Text + "'";
                        cmd = new SqlCommand(qry, con, trans);
                        cmd.ExecuteNonQuery();
                    }

                }
                else if (hdnbillstatus.Value.CompareTo("Bill Submitted") == 0)
                {
                    if (txtcolloc.Text != "")
                    {
                        qry = "UPDATE webx_billmst SET billcolbrcd='" + txtcolloc.Text + "' WHERE billno='" + txtbillno.Text + "'";
                        cmd = new SqlCommand(qry, con, trans);
                        cmd.ExecuteNonQuery();
                    }
                }
            }
            trans.Commit();
        }
        catch (Exception e1)
        {
            Response.Write("<br><br><br><center><font class='blackboldfnt' color='red'><b>Error : " + e1.Message + "</b></font></center>");
            string msg = e1.Message.ToString();
            msg = msg.Replace('\n', ' ');
            trans.Rollback();
            Response.End();
        }

        con.Close();
        Response.Redirect("Message.aspx?message=Data has been Updated Successfully.");
    }

}
