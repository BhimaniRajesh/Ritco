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

public partial class GUI_Telecomm_CommAssets_Crystal_Rpt : System.Web.UI.Page
{
    string ReportType, Location, Person, Vendor, Device;
    int SrNo = 0;
    string Number, Device_Type, Device_Loc, Assign, Devi_Vendor;
    public CostSummary _ds = new CostSummary();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!(IsPostBack))
        {
            ReportType = Request.QueryString["ReportType"];
            Location = Request.QueryString["Location"];
            Person = Request.QueryString["Person"];
            Vendor = Request.QueryString["Vendor"];
            Device = Request.QueryString["Device"];
        }
        BindGrid();
    }

    private void BindGrid()
    {
        if (ReportType == "Register")
        {
            SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
            conn.Open();
            string sql = "Webx_SP_Asset_Reg_Reg";
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
            if (Person != "All" && Person !="")
            {
                cmd.Parameters.Add("@CDM_Person", SqlDbType.VarChar).Value = Person;
            }
            if (Device != "All")
            {
                cmd.Parameters.Add("@CDM_Device_Type", SqlDbType.VarChar).Value = Device;
            }
            SqlDataReader dr = cmd.ExecuteReader();

            while (dr.Read())
            {
                SrNo = SrNo + 1;
                Number = Convert.ToString(dr["CDM_Number"]);
                Device_Type = Convert.ToString(dr["CDM_Type"]);
                Device_Loc = Convert.ToString(dr["CDM_Location"]);
                Assign = Convert.ToString(dr["Assign"]);
                Devi_Vendor = Convert.ToString(dr["CDM_Vendor"]);

                _ds.Assets_Register.AddAssets_RegisterRow(SrNo, Number, Device_Type, Device_Loc, Assign, Devi_Vendor);
            }

            ReportDocument Assets_Reg_Reg = new ReportDocument();
            Assets_Reg_Reg.Load(Server.MapPath("Assets_Register_Rpt.rpt"));
            Assets_Reg_Reg.SetDataSource(_ds);

            CRVAssetsReg.ReportSource = Assets_Reg_Reg;
            CRVAssetsReg.DataBind();
            conn.Close();
        }
    }
}
