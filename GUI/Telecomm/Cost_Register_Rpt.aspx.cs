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

public partial class GUI_Telecomm_Cost_Register_Rpt : System.Web.UI.Page
{
    DateTime From = new DateTime();
    DateTime To = new DateTime();
    public CostSummary _ds = new CostSummary();
    string User, Location, Vendor, Device, Number;
    int SrNo = 0;
    string Dev_No, Dev_Type, Loc, Assign, BillVendor, BillEntryNo, Dt, Tot_Amt, Svc_Tot, Cess_Tot, Bill_Tot, PaidDt;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!(IsPostBack))
        {
            From = Convert.ToDateTime(Request.QueryString["From"]);
            To = Convert.ToDateTime(Request.QueryString["To"]);
            User = HttpUtility.UrlDecode(Request.QueryString["User"].ToString());
            Location = HttpUtility.UrlDecode(Request.QueryString["Location"].ToString());
            Vendor = HttpUtility.UrlDecode(Request.QueryString["Vendor"].ToString());
            Device = HttpUtility.UrlDecode(Request.QueryString["Device"].ToString());
            Number = HttpUtility.UrlDecode(Request.QueryString["Number"].ToString());

            lblLocation.Text = Location;
            lblUser.Text = User;
            lblVendor.Text = Vendor;
            lblDevice.Text = Device;
            lblNumber.Text = Number;
            lblDtFrom.Text = From.ToString("dd MMM yyyy");
            lblDtTo.Text = To.ToString("dd MMM yyyy");
        }
        BindGrid();
    }

    private void BindGrid()
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
        string sql = "usp_Cost_Register";
        SqlCommand cmd = new SqlCommand(sql, conn);
        cmd.CommandType = CommandType.StoredProcedure;

        SqlDataAdapter da = new SqlDataAdapter(cmd);

        cmd.Parameters.Add("@createdfrom", SqlDbType.DateTime).Value = From;
        cmd.Parameters.Add("@createdto", SqlDbType.DateTime).Value = To;
        cmd.Parameters.Add("@Vendor", SqlDbType.VarChar).Value = Vendor == "All" ? "%" : Vendor;
        cmd.Parameters.Add("@Location", SqlDbType.VarChar).Value = Location == "All" ? "%" : Location;
        cmd.Parameters.Add("@Person", SqlDbType.VarChar).Value = User == "" ? "%" : User;
        cmd.Parameters.Add("@Device", SqlDbType.VarChar).Value = Device == "All" ? "%" : Device;
        cmd.Parameters.Add("@Number", SqlDbType.VarChar).Value = Number == "All" ? "%" : Number;

        DataSet ds = new DataSet();
        da.Fill(ds);
        DataView dv = new DataView();
        dv = ds.Tables[0].DefaultView;

        gvCostReg.DataSource = dv;
        gvCostReg.DataBind(); 

        //SqlDataReader dr = cmd.ExecuteReader();
        //while (dr.Read())
        //{
        //    SrNo = SrNo + 1;
        //    Dev_No = Convert.ToString(dr["Bill_Dev_No"]);
        //    Dev_Type = Convert.ToString(dr["CDM_Type"]);
        //    Loc = Convert.ToString(dr["CDM_Location"]);
        //    Assign = Convert.ToString(dr["AssignTo"]);
        //    BillVendor = Convert.ToString(dr["Bill_Vendor"]);
        //    BillEntryNo = Convert.ToString(dr["Bill_Entry_No"]);
        //    Dt = Convert.ToString(dr["Dt"]);
        //    Tot_Amt = Convert.ToString(dr["Bill_Tot_Amt"]);
        //    Svc_Tot = Convert.ToString(dr["Bill_Svc_Tax"]);
        //    Cess_Tot = Convert.ToString(dr["Bill_Tot_Cess"]);
        //    Bill_Tot = Convert.ToString(dr["Bill_Total"]);
        //    PaidDt = Convert.ToString(dr["PaidDt"]);

        //    _ds.Cost_Register.AddCost_RegisterRow(SrNo, Dev_No, Dev_Type, Loc, Assign, BillVendor, BillEntryNo, Dt, Tot_Amt, Svc_Tot, Cess_Tot, Bill_Tot, PaidDt);
        //}

        //ReportDocument Cost_Reg_Rpt = new ReportDocument();
        //Cost_Reg_Rpt.Load(Server.MapPath("Cost_Register_Rpt.rpt"));
        //Cost_Reg_Rpt.SetDataSource(_ds);

        //CRVCostRegister.ReportSource = Cost_Reg_Rpt;
        //CRVCostRegister.DataBind();
        conn.Close();
    }
}
