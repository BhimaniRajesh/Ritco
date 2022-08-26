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


public partial class GUI_Fleet_Job_SparePartQuery : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string pagetitle = System.Configuration.ConfigurationManager.AppSettings["PageTitle"];
        Response.Cache.SetCacheability(HttpCacheability.NoCache);
        Response.Cache.SetNoStore();
        Response.Cache.SetExpires(DateTime.MinValue);

        Common objCommon = new Common();
        objCommon.doCacheRoutine();

        this.Title = pagetitle;

        if (!IsPostBack)
        {
          
        }
    }

    protected void btnShowParts_Click(object sender, EventArgs e)
    {
        BindGrid();
    }
    protected void pgChange(object sender, GridViewPageEventArgs e)
    {
        dgPart.PageIndex = e.NewPageIndex;
        BindGrid();
    }
    protected void dg_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (((Control)e.CommandSource).ID == "DeleteButton")
        {
            int thisRow = (((GridViewRow)((System.Web.UI.Control)e.CommandSource).Parent.Parent).RowIndex);
            string PartID = dgPart.DataKeys[thisRow].Values[0].ToString();
            PartID = PartID.Trim().ToString();
            string Query = "Delete from  WEBX_FLEET_SPAREPARTHDR where Part_ID='" + PartID + "'";
            SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
            conn.Open();
            SqlCommand Command = new System.Data.SqlClient.SqlCommand(Query, conn);
            Command.ExecuteNonQuery();
            string Query1 = "Delete from  WEBX_FLEET_SPAREPARTDET where Part_ID='" + PartID + "'";
            SqlCommand Command1 = new System.Data.SqlClient.SqlCommand(Query1, conn);
            Command1.ExecuteNonQuery();
            conn.Close();
            BindGrid();
        }
    }
    public void BindGrid()
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
        string sql = "usp_SparePartHdr_List";
        SqlCommand sqlcmd = new SqlCommand(sql, conn);
        sqlcmd.CommandType = CommandType.StoredProcedure;
        SqlDataAdapter da = new SqlDataAdapter(sqlcmd);
        TextBox txtDateFrom = (TextBox)this.DT.FindControl("txtDateFrom");
        TextBox txtDateTo = (TextBox)this.DT.FindControl("txtDateTo");
        DateTime dtFrom = new DateTime();
        DateTime dtTo = new DateTime();
        System.Globalization.DateTimeFormatInfo dtfi = new System.Globalization.DateTimeFormatInfo();
        dtfi.ShortDatePattern = "dd/MM/yyyy";
        dtfi.DateSeparator = "/";
        {
            dtFrom = Convert.ToDateTime(txtDateFrom.Text, dtfi);
            dtTo = Convert.ToDateTime(txtDateTo.Text, dtfi);
        }
        da.SelectCommand.Parameters.Add("@createdfrom", SqlDbType.DateTime).Value = dtFrom;
        da.SelectCommand.Parameters.Add("@createdto", SqlDbType.DateTime).Value = dtTo;
        da.SelectCommand.Parameters.Add("@PartID", SqlDbType.VarChar).Value = "";
        DataSet ds = new DataSet();
        da.Fill(ds);
        dgPart.DataSource = ds;
        dgPart.DataBind();
        conn.Close();
    }
}
