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

public partial class GUI_Octroi_New_OctroiDocketDetails : System.Web.UI.UserControl
{
    DataTable dt = new DataTable("table1");
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            for (int i = 0; i < 1; i++)
            {
                dt.Rows.Add();
            }
            grvcontrols.DataSource = dt;
            grvcontrols.DataBind();
        }
    }
    protected void btnAdd_Click(object sender, EventArgs e)
    {
        Int16 maxrows = 0;
        if (txtRows.Text.ToString().CompareTo("") != 0)
        {
            try
            {
                maxrows = Convert.ToInt16(txtRows.Text);
            }
            catch (Exception ex)
            {
                txtRows.Text = "";
                txtRows.Focus();
            }
        }
        else
        {
            maxrows = 5;
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

    }
}
