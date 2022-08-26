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
using CrystalDecisions.CrystalReports.Engine;

public partial class GUI_Telecomm_Cost_Summary_Rpt : System.Web.UI.Page
{
    string Loc, Location, User, Vendor, Device, Number, Months, Year, Region;
    string Person, Date, Credit;
    public CostSummary _ds = new CostSummary();
    DataColumn dc;
    DataTable dt = new DataTable();
    DataRow dr;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!(IsPostBack))
        {
            Loc = Request.QueryString["Loc"];
            Location = Request.QueryString["Location"];
            User = Request.QueryString["User"];
            Vendor = Request.QueryString["Vendor"];
            Device = Request.QueryString["Device"];
            Number = Request.QueryString["Number"];
            Months = Request.QueryString["Months"];
            Year = Request.QueryString["Year"];
            Region = Request.QueryString["Region"];

            lblLocation.Text = Location;
            lblUser.Text = User;
            lblVendor.Text = Vendor;
            lblDevice.Text = Device;
            lblNumber.Text = Number;
            lblMonths.Text = Months;
            lblYear.Text = Year;
        }
        BindGrid();
    }

    private void BindGrid()
    {
        string sql = "";
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
        if (Loc == "Loc")
        {
            sql = "Webx_SP_Comm_Cost_Summary";
        }
        if (Loc == "Vendor")
        {
            sql = "Webx_SP_Comm_Cost_Vendor_Summary";
        }
        if (Loc == "Device")
        {
            sql = "Webx_SP_Comm_Cost_Device_Summary";
        }        
        SqlCommand cmd = new SqlCommand(sql, conn);
        cmd.CommandType = CommandType.StoredProcedure;

        SqlDataAdapter da = new SqlDataAdapter(cmd);

        if (Location != "All")
        {
            cmd.Parameters.Add("@CDM_Location", SqlDbType.VarChar).Value = Location;
        }
        if (Vendor != "All")
        {
            cmd.Parameters.Add("@CDM_Vendor", SqlDbType.VarChar).Value = Vendor;
        }
        if (User != "All" && User != "")
        {
            cmd.Parameters.Add("@CDM_Person", SqlDbType.VarChar).Value = User;
        }
        if (Device != "All")
        {
            cmd.Parameters.Add("@CDM_Device_Type", SqlDbType.VarChar).Value = Device;
        }
        if (Number != "All")
        {
            cmd.Parameters.Add("@CDM_Number", SqlDbType.VarChar).Value = Number;
        }
        if (Region != "All")
        {
            cmd.Parameters.Add("@LocCity", SqlDbType.VarChar).Value = Region;
        }
        cmd.Parameters.Add("@ReportYear", SqlDbType.VarChar).Value = Year;
        cmd.Parameters.Add("@ReportMonths_ORG", SqlDbType.VarChar).Value = Months;

        string op = Convert.ToString(cmd.ExecuteScalar());
        Array a1, a2, a3;
        a1 = op.Split('|');
        string e = ((string[])(a1))[0];
        a2 = e.Split(',');
        for (int k = 0; k < a2.Length; k++)
        {
            dc = new DataColumn("" + ((string[])(a2))[k] + "", typeof(string));
            dt.Columns.Add(dc);
        }

        for (int i = 1; i < a1.Length; i++)
        {
            e = ((string[])(a1))[i];
            a3 = e.Split(',');

            dr = dt.NewRow();
            for (int j = 0; j < a3.Length; j++)
            {
                dr[j] = ((string[])(a3))[j];
            }
            dt.Rows.Add(dr);
        }
        TableRow tr;
        TableCell tc;
        tr = new TableRow();
        for (int k = 0; k < dt.Columns.Count; k++)
        {
            tc = new TableCell();
            Label l1 = new Label();
            l1.CssClass = "blackfnt";
            l1.Text = dt.Columns[k].ColumnName;
            tc.Style.Add("border", "solid 1px black");
            tc.Style.Add("width", "25%");
            tc.Controls.Add(l1);
            tr.CssClass = "bgbluegrey";
            tr.Cells.Add(tc);
        }
        Table1.Rows.Add(tr);
        for (int i = 0; i < dt.Rows.Count; i++)
        {
            tr = new TableRow();
            for (int j = 0; j < dt.Columns.Count; j++)
            {
                if (j == 0)
                {
                    tc = new TableCell();
                    Label l1 = new Label();
                    l1.Text = Convert.ToString(dt.Rows[i][j]);
                    l1.CssClass = "blackfnt";
                    tc.Style.Add("border", "solid 1px black");
                    tc.Style.Add("width", "25%");
                    //tc.Width = 25;
                    tc.Controls.Add(l1);
                    tr.Cells.Add(tc);
                }
                else
                {
                    tc = new TableCell();
                    HyperLink h1 = new HyperLink();
                    h1.Text = Convert.ToString(dt.Rows[i][j]);
                    if (h1.Text != "0")
                    {
                        //h1.NavigateUrl = "FrmQry?a=" + dt.Rows[i][0] + "&b=" + dt.Columns[j].ColumnName.ToString() + "";
                        h1.NavigateUrl = "#";// + dt.Rows[i][0] + "&b=" + dt.Columns[j].ColumnName.ToString() + "";
                    }
                    tc.Controls.Add(h1);
                    h1.CssClass = "blackfnt";
                    //tc.Width = "25%";
                    tc.Style.Add("border", "solid 1px black");
                    tr.Cells.Add(tc);
                }
                tr.BackColor = System.Drawing.Color.White;
            }
            Table1.Rows.Add(tr);
        }
        
        //ReportDocument CostRpt = new ReportDocument();
        //CostRpt.Load(Server.MapPath("Cost_Summary_Rpt.rpt"));
        //CostRpt.SetDataSource(dt);

        ////////CostRpt.SetParameterValue("@Location", Location == "All" ? "%" : Location);
        ////////CostRpt.SetParameterValue("@Months", Months);
        ////////CostRpt.SetParameterValue("@Numbers", Number == "All" ? "%" : Number);
        ////////CostRpt.SetParameterValue("@Device", Device == "All" ? "%" : Device);
        ////////CostRpt.SetParameterValue("@Vendor", Vendor == "All" ? "%" : Vendor);
        ////////CostRpt.SetParameterValue("@Person", User == "All" ? "%" : User);
        ////////CostRpt.SetParameterValue("@Loc", Loc);

        //CRVCostSummary.ReportSource = CostRpt;
        //CRVCostSummary.DataBind();
        //conn.Close();
    }
}
