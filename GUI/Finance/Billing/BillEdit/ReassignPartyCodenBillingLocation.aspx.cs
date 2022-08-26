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

public partial class GUI_Finance_Billing_Bill_Edit_ReassignPartyCodenBillingLocation : System.Web.UI.Page
{

    DataTable dt = new DataTable("table1");
    protected void Page_Load(object sender, EventArgs e)
    {
        //txtnorows.Attributes.Add("onkeypress","javascript:return hitEnter(event)");
        btnrows.Attributes.Add("onclick","javascript:return addRows()");
        btnsubmit.Attributes.Add("onclick","javascript:return validateBoxes()");

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

   
    protected void grvcontrols_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            ((TextBox)e.Row.FindControl("txtbillnumber")).Attributes.Add("onblur", "docBlur('" + ((TextBox)e.Row.FindControl("txtbillnumber")).ClientID.ToString() + "')");
            ((TextBox)e.Row.FindControl("txtlocation")).Attributes.Add("onblur", "locBlur('" + ((TextBox)e.Row.FindControl("txtlocation")).ClientID.ToString() + "')");
            //((TextBox)e.Row.FindControl("txtpartycode")).Attributes.Add("onblur", "partyBlur('" + ((TextBox)e.Row.FindControl("txtbillnumber")).ClientID.ToString() + "')");
            
            // PUT HERE PARTY CODE TEXTBOX NAME
            //((Button)e.Row.FindControl("btnpartycode")).Attributes.Add("onclick", "popuplist('partycode','" + ((TextBox)e.Row.FindControl("txtpartycode")).ClientID.ToString() + "','none')");
            // PUT HERE LOCATION TEXT BOX NAME TO GO IN NEXT PAGE
            ((Button)e.Row.FindControl("btnlocation")).Attributes.Add("onclick", "popuplist('location','" + ((TextBox)e.Row.FindControl("txtlocation")).ClientID.ToString() + "','none')");
        }
        else if (e.Row.RowType == DataControlRowType.Header)
        {
            ((Button)e.Row.FindControl("btnallloc")).Attributes.Add("onclick", "popuplist('location','txtlocation','" + grvcontrols.ID.ToString() + "')");
            //((Button)e.Row.FindControl("btnheadpartycode")).Attributes.Add("onclick", "popuplist('partycode','txtpartycode','" + grvcontrols.ID.ToString() + "')");
        }
    }



    protected void btnrows_Click(object sender, EventArgs e)
    {
        Int16 maxrows=0;
        if(txtnorows.Text.ToString().CompareTo("")!=0)
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
            for (int i = 0; i < grvcontrols.Rows.Count; i++)
            {
                TextBox txtdocno = (TextBox)grvcontrols.Rows[i].FindControl("txtbillnumber");
                //TextBox txtpartycode = (TextBox)grvcontrols.Rows[i].FindControl("txtpartycode");
                TextBox txtlocation = (TextBox)grvcontrols.Rows[i].FindControl("txtlocation");

                //SqlConnection con = new SqlConnection(Session["SqlProvider"].ToString().Trim());
                //con.Open();

                //string qry = "UPDATE webx_docket SET party_code='" + txtpartycode.Text + "',fincmplbr='" + txtlocation.Text + "' WHERE DOCKNO='" + txtdocno.Text + "'";
                string qry = "UPDATE webx_master_docket SET fincmplbr='" + txtlocation.Text + "' WHERE DOCKNO='" + txtdocno.Text + "'";
                SqlCommand cmd = new SqlCommand(qry, con,trans);
                cmd.ExecuteNonQuery();

                //con.Close();
            }

            trans.Commit();
        }
        catch (Exception e1)
        {
            Response.Write("<br><br><br><center><font class='blackboldfnt' color='red'><b>Error : " + e1.Message + "</b></font></center>");
            string msg = e1.Message.ToString();
            msg = msg.Replace('\n', ' ');
            trans.Rollback();
            Response.Redirect("Message.aspx?" + e1.Message);
            Response.End();
        }

        con.Close();
        Response.Redirect("Message.aspx?message=Data has been Updated Successfully.");
    }


}
