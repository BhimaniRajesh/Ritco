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

public partial class GUI_Finance_Accounts_ReAssignVoucherDate : System.Web.UI.Page
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


    protected void grvcontrols_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            string s = "cal.select(" + ((TextBox)e.Row.FindControl("txtnewdate")).ClientID.ToString() + ",'" + ((LinkButton)e.Row.FindControl("lnkdate")).ClientID.ToString() + "','dd/MM/yyyy'); return false;";
            ((TextBox)e.Row.FindControl("txtvoucherno")).Attributes.Add("onblur", "voucherBlur('" + ((TextBox)e.Row.FindControl("txtvoucherno")).ClientID.ToString() + "')");
            ((LinkButton)e.Row.FindControl("lnkdate")).Attributes.Add("onclick", s);
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
            TextBox txtvoucherno = (TextBox)grvcontrols.Rows[i].FindControl("txtvoucherno");
            TextBox txtnewdate = (TextBox)grvcontrols.Rows[i].FindControl("txtnewdate");

            SqlConnection con = new SqlConnection(Session["SqlProvider"].ToString().Trim());
            con.Open();


/**********************************************************************************************************
                      YEAR SUFFIX IS NEED BECAUSE ACCTRANS TABLE IS CHANGED EVERY YEAR
 *                    IT IS A FINANCIAL YEAR STARTING FORM 1 APRIL
 * *******************************************************************************************************/
            
            
            string yearsuffix = "";
            DateTime dt = new DateTime();
            dt = System.DateTime.Now;
            if (dt.Month < 4)
                yearsuffix = Convert.ToString((dt.Year - 1)).Substring(2, 2) + "_" + Convert.ToString((dt.Year)).Substring(2, 2);
            else
                yearsuffix = Convert.ToString((dt.Year)).Substring(2, 2) + "_" + Convert.ToString((dt.Year + 1)).Substring(2, 2);
            

            string qry = "";
               qry = "UPDATE webx_acctrans_" + yearsuffix + " WITH(ROWLOCK) SET transdate='" + txtnewdate.Text + "'";

            SqlCommand cmd = new SqlCommand(qry, con);
            cmd.ExecuteNonQuery();
            con.Close();
            Response.Redirect("Message.aspx?message=Data has been Updated Successfully.");
        }
    }

}
