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
    SqlConnection con;
    protected void Page_Load(object sender, EventArgs e)
    {
        //txtnorows.Attributes.Add("onkeypress","javascript:return hitEnter(event)");
        btnrows.Attributes.Add("onclick", "javascript:return addRows()");
        btnsubmit.Attributes.Add("onclick", "javascript:return validateBoxes()");

        try
        {
            con = new SqlConnection(Session["SqlProvider"].ToString());
        }
        catch (Exception ex)
        {
            Response.Redirect("~/GUI/ErrorPage.aspx");
        }
        con.Open();

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

            TextBox txt = (TextBox)e.Row.FindControl("txtnewcolbranch");
            HtmlInputButton btn=(HtmlInputButton)(e.Row.FindControl("btnnewcolbranch"));

            btn.Attributes.Add("onclick", "javascript:return partyList('" + txt.ClientID.ToString() + "')");
             
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
        for (int i = 0; i < grvcontrols.Rows.Count; i++)
        {
            TextBox txtnewcolbranch = (TextBox)grvcontrols.Rows[i].FindControl("txtnewcolbranch");
            TextBox txtmrsno = (TextBox)grvcontrols.Rows[i].FindControl("txtmrsno");



            string qry = "UPDATE webx_mr_hdr SET mrcollbrcd='" + txtnewcolbranch.Text + "' WHERE mrsno='" + txtmrsno.Text + "'";
            
            SqlCommand cmd = new SqlCommand(qry, con);
            cmd.ExecuteNonQuery();
            con.Close();

            Response.Redirect("Message.aspx?message=Data has been Updated Successfully.");
        }
    }

}
