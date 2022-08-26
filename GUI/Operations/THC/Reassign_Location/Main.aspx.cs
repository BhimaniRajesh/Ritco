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

public partial class GUI_Operations_THC_Reassign_Location_Main : System.Web.UI.Page
{
    public DataSet1 _dataSet = new DataSet1();
    int _lastEditedPage;
    SqlConnection conn;
    public static string edit_yn = "", editcodeid = "", sql;
    public string sqlChange;
    protected void Page_Load(object sender, EventArgs e)
    {
        conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();

        if (!IsPostBack)
        {
            roww.Text = "1";
            Inetialized();
            //Validation();
        }
        conn.Close();
    }

    
    protected void roww_TextChanged(object sender, EventArgs e)
    {
        _dataSet.WorkExperianceData.Clear();
        int rowno;
        if ((roww.Text == "") || (roww.Text == "0"))
        {
            roww.Text = "1";
        }
        rowno = Convert.ToInt32(roww.Text);
        for (int i = 0; i < rowno; i++)
        {
            _dataSet.WorkExperianceData.AddWorkExperianceDataRow("", "", "", "", "", "", "", "", "", "", "");
            BindGrid();
        }

    }
    private void BindGrid()
    {
        btnSubmit.Visible = true;
        GridVendor.DataSource = _dataSet.WorkExperianceData;
        GridVendor.DataBind();
        _lastEditedPage = GridVendor.PageIndex;
    }
    private void Inetialized()
    {
        _dataSet.WorkExperianceData.AddWorkExperianceDataRow("", "", "", "", "", "", "", "", "", "", "");
    }
    protected void GridVendor_OnRowDataBound(object sender, GridViewRowEventArgs e)
    {

        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            TextBox txtNewLocation = (TextBox)(e.Row.FindControl("txtNewLocation"));
            ((Button)(e.Row.FindControl("btncodepopup"))).Attributes.Add("onclick", "javascript:return nwOpen2('" + txtNewLocation.ClientID.ToString() + "')");
        }
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
        foreach (GridViewRow gridrow in GridVendor.Rows)
        {
            TextBox txtDocumentNo = (TextBox)gridrow.FindControl("txtDocumentNo");
            TextBox txtNewLocation = (TextBox)gridrow.FindControl("txtNewLocation");

            sqlChange = "update webx_THC_Summary set balamtbrcd='" + txtNewLocation.Text.ToString() + "' where thcno='" + txtDocumentNo.Text + "'";
            SqlCommand cmd = new SqlCommand(sqlChange, conn);
            cmd.ExecuteNonQuery();
        }
        conn.Close();
        Response.Redirect("./ReassignLocationDone.aspx");
    }
}
