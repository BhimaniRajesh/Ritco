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


public partial class GUI_Fleet_Operations_Issue_FuelTripEdit : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        txtTripsheetNo.Attributes.Add("OnBlur", "javascript:checkTripsheetno(this)");
        if (!IsPostBack)
        {

        }
    }
    protected void btngo_Click(object sender, EventArgs e)
    {
        BindGrid();
        btnShow.Visible = true;
    }
    protected void gvFuelTripEdit_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvFuelTripEdit.PageIndex = e.NewPageIndex;
        BindGrid();
    }

    protected void Clicked_Checkbox(Object sender, EventArgs args)
    {
        foreach (GridViewRow gridrow in gvFuelTripEdit.Rows)
        {
            CheckBox chkBx = (CheckBox)gridrow.FindControl("chkSelect");
            TextBox txtNewTripsheetNo = (TextBox)gridrow.FindControl("txtNewTripsheetNo");

            if (chkBx != null && chkBx.Checked)
            {
                txtNewTripsheetNo.Visible = true;
            }

            if (chkBx != null && chkBx.Checked==false)
            {
                txtNewTripsheetNo.Visible = false;
            }
        }
    }

    public void BindGrid()
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
        string sql = "USP_FUEL_BILL_TRIP_EDIT";
        SqlCommand sqlcmd = new SqlCommand(sql, conn);
        sqlcmd.CommandType = CommandType.StoredProcedure;
        SqlDataAdapter da = new SqlDataAdapter(sqlcmd);
        da.SelectCommand.Parameters.Add("@TRIPSHEETNO", SqlDbType.VarChar).Value = txtTripsheetNo.Text.ToString().Trim();

        DataSet ds = new DataSet();
        da.Fill(ds);
        gvFuelTripEdit.DataSource = ds;
        gvFuelTripEdit.DataBind();
        conn.Close();

        if (gvFuelTripEdit.Rows.Count != 0)
        {
            foreach (GridViewRow r in gvFuelTripEdit.Rows)
            {
                TextBox txtNewTripsheetNo = (TextBox)r.FindControl("txtNewTripsheetNo");
                txtNewTripsheetNo.Attributes.Add("OnBlur", "javascript:CheckTrip(" + txtNewTripsheetNo.ClientID.ToString() + ");");
            }
        }
    }

    protected void btnShow_Click(object sender, EventArgs e)
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();

        try
        {
            foreach (GridViewRow gridrow in gvFuelTripEdit.Rows)
            {
                 CheckBox chkBx = (CheckBox)gridrow.FindControl("chkSelect");

                 if (chkBx != null && chkBx.Checked)
                 {
                     SqlCommand sql_insert = new SqlCommand("USP_UPDATE_FUEL_BILL", conn);
                     sql_insert.CommandType = CommandType.StoredProcedure;

                     sql_insert.Parameters.Add("@TRIPSHEETNO", SqlDbType.VarChar).Value = gvFuelTripEdit.Rows[gridrow.RowIndex].Cells[1].Text.ToString();
                     sql_insert.Parameters.Add("@NEWTRIPSHEETNO", SqlDbType.VarChar).Value = ((TextBox)gridrow.FindControl("txtNewTripsheetNo")).Text.ToString();
                     sql_insert.Parameters.Add("@Vendor_Billno", SqlDbType.VarChar).Value = gvFuelTripEdit.Rows[gridrow.RowIndex].Cells[15].Text.ToString().Trim();
                     sql_insert.Parameters.Add("@EXE_AMT", SqlDbType.VarChar).Value = gvFuelTripEdit.Rows[gridrow.RowIndex].Cells[13].Text.ToString().Trim();
                     sql_insert.Parameters.Add("@Last_Km_Read", SqlDbType.VarChar).Value = gvFuelTripEdit.Rows[gridrow.RowIndex].Cells[6].Text.ToString().Trim();
                     sql_insert.Parameters.Add("@Amount", SqlDbType.VarChar).Value = gvFuelTripEdit.Rows[gridrow.RowIndex].Cells[12].Text.ToString().Trim();
                     sql_insert.ExecuteNonQuery();
                 }

            }
            lblerror.Text = "Tripsheet Has Been Updated Successfully";
        }
        catch (Exception Exc)
        {
            Response.Redirect("~/GUI/CommonErrorPage.aspx?heading=Error in data retrival.&detail1=" + Exc.Message.Replace('\n', '_'));
        }
        finally
        {
            conn.Close();
        }
    }
}
