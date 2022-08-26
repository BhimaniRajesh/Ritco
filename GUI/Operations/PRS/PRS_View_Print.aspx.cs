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

public partial class GUI_Tracking_DRS_View_Print : System.Web.UI.Page
{
    SqlConnection cn;
    public string strDRSNo;
    static string strPDCType;
    static string Vendor;
    public int intTotalRecords;
    public static string strRemainData;
    public static string strCal;

    public static string strPreparedBy;
    public static string strPreparedBy1;
    public double totpkgs = 0.0, totweight = 0.0, totfreight = 0.0; 

    protected void Page_Load(object sender, EventArgs e)
    {
        cn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

        if (IsPostBack == false)
        {
            strDRSNo = HttpUtility.UrlDecode(Request.QueryString["DRSNo"].ToString());
            string[] Split = strDRSNo.Split(new Char[] { ',' });
            strDRSNo = Convert.ToString(Split[0]);
            string print_yn = Convert.ToString(Split[1]);
            strPDCType = "P";

            Prepare();
            getData();
            remainData();

            string logo = Session["logofile"].ToString();
            if (Session["Client"].ToString() == "PRRL")
            {
                imgLogo.ImageUrl = "~/GUI/images/clip_image002.gif";
            }
            if (Session["Client"].ToString() == "TLL")
            {
                imgLogo.ImageUrl = "~/GUI/images/TLL_Logo.gif";
            }
            else if (Session["Client"].ToString() == "EXL")
            {
                imgLogo.ImageUrl = "~/GUI/images/exl_logo.jpg";
            }
            else if (Session["Client"].ToString() == "Varuna")
            {
                imgLogo.ImageUrl = "~/GUI/images/Varuna_logoNew.jpg";
            }
            else if (Session["Client"].ToString() == "RITCO")
            {
                imgLogo.ImageUrl = "~/GUI/images/webxpress_logo.gif";
            }
            else if (Session["Client"].ToString() == "RCPL")
            {
                imgLogo.ImageUrl = "~/GUI/images/rcpl_logo.jpg";
            }
            else if (Session["Client"].ToString() == "Agility")
            {
                imgLogo.ImageUrl = "~/GUI/images/Agility lobo.jpg";
            }
            else if (Session["Client"].ToString() == "ASL")
            {
                imgLogo.ImageUrl = "~/GUI/images/ASL_New.bmp";
            }
            else
            {
                imgLogo.ImageUrl = "~/GUI/images/webxpress_logo.gif";
            }
        }
    }
    private void Prepare()
    {
        cn.Open();
        string sql = "Select (UserID + ': ' + Name) as emp From webx_master_users Where UserID='" + Session["empcd"].ToString().Trim() + "'";
        SqlCommand cmd = new SqlCommand(sql, cn);
        SqlDataReader dr = cmd.ExecuteReader();
        if (dr.Read())
        {
            lblPreparedBy1.Text = dr["emp"].ToString();
        }
        dr.Close();
        string sqlpdc = "select pdc_amt from webx_pdchdr where pdcno='" + strDRSNo + "'";
        SqlCommand cmd1 = new SqlCommand(sqlpdc, cn);
        SqlDataReader dr1 = cmd1.ExecuteReader();
        if (dr1.Read())
        {
            lbldelyverycharge.Text = Convert.ToString(dr1["pdc_amt"]);
            if (lbldelyverycharge.Text == "")
            {
                lbldelyverycharge.Text = "0";
            }
        }
        dr1.Close();
        cn.Close();
    }
    private void getData()
    {
        cn.Open();

        string sql1 = "Select pdcno as DRS, convert(varchar,pdcdt,106) As DRSDate, pdcbr As DRSLocation, isNull(vendorcode + ': ' + vendorname,'') As Vendor, vehno As VehicleNo,isNull(start_km,0) As StartKM,isNull(close_km,0) As EndKM,(case when (isNull(close_km,0)>isNull(start_km,0))  then (isNull(close_km,0)-isNull(start_km,0))  else 0 end) As DistTravel, convert(varchar,getdate(),6) As thisDate,vendor_type,driverName ,empcd = (select UserID + ': ' + Name From webx_master_users Where UserID=p.empcd) , Manualpdcno From webx_pdchdr p with(NOLOCK) Where pdcty='" + strPDCType + "' and pdcno='" + strDRSNo + "'";
        string sql3 = "Select S.* From (" + sql1 + ")S";

        SqlCommand cmdGetData = new SqlCommand(sql3, cn);
        SqlDataReader dr = cmdGetData.ExecuteReader();

        while (dr.Read())
        {
            lblDrsNo.Text = dr["DRS"].ToString();
            lblDrsDate.Text = dr["DRSDate"].ToString();
            lblManualDrsNo.Text = dr["Manualpdcno"].ToString();
            lblDRSlocation.Text = dr["DRSLocation"].ToString();
            lblVendor.Text = dr["Vendor"].ToString();
            lblVhclNo.Text = dr["VehicleNo"].ToString();
            lblStartingKM.Text = dr["StartKM"].ToString();
            lblEndingKM.Text = dr["EndKM"].ToString();
            lblDistance.Text = dr["DistTravel"].ToString();
            lblDateTime.Text = dr["thisDate"].ToString();
            lblDriverNm.Text = dr["driverName"].ToString();
            lblPreparedBy1.Text = dr["empcd"].ToString();
            lblAt.Text = dr[2].ToString();

            string vendortype = dr["vendor_type"].ToString();

            switch (vendortype)
            {
                case "1":
                    vendortype = "Market";
                    break;
                case "2":
                    vendortype = "Attached";
                    break;
                case "3":
                    vendortype = "Own";
                    lblBaVendor.Text = "By Company";
                    break;
            }
        }
        dr.Close();
        cn.Close();

    }
    private void remainData()
    {
        cn.Open();

        string sql1 = "select * from vw_PDCView with(nolock) where pdcno='" + strDRSNo + "'";

        SqlCommand sqlcmd = new SqlCommand(sql1, cn);
        SqlDataAdapter da = new SqlDataAdapter(sqlcmd);
        DataSet ds = new DataSet();
        da.Fill(ds);

        Dockdata.DataSource = ds;
        intTotalRecords = ds.Tables[0].Rows.Count;
        Dockdata.DataBind();

        cn.Close();

    }
    protected void Dockdata_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            Label lblpkgs = (Label)e.Row.FindControl("lblpkgs");
            Label lblactualweight = (Label)e.Row.FindControl("lblactualweight");
            Label lblfreight = (Label)e.Row.FindControl("lblfreight");

            if (lblpkgs.Text != "" && lblpkgs.Text != null)
            {
                totpkgs = totpkgs + Convert.ToDouble(lblpkgs.Text);
            }
            if (lblactualweight.Text != "" && lblactualweight.Text != null)
            {
                totweight = totweight + Convert.ToDouble(lblactualweight.Text);
            }
            if (lblfreight.Text != "" && lblfreight.Text != null)
            {
                totfreight = totfreight + Convert.ToDouble(lblfreight.Text);
            }
            
            


            HiddenField hidCODDOD = (HiddenField)e.Row.FindControl("hidCODDOD");
            if (hidCODDOD.Value == "Y")
            {
                Label lblCODDODAmount = (Label)e.Row.FindControl("lblCODDODAmount");
                lblCODDODAmount.Visible = true;
                Label CODDODamount = (Label)e.Row.FindControl("CODDODamount");
                CODDODamount.Visible = true;

                Label lblCODDODCharge = (Label)e.Row.FindControl("lblCODDODCharge");
                lblCODDODCharge.Visible = true;
                Label CODDODCharge = (Label)e.Row.FindControl("CODDODCharge");
                CODDODCharge.Visible = true;


                //Label lblCODDODCollected = (Label)e.Row.FindControl("lblCODDODCollected");
                //lblCODDODCollected.Visible = true;
                //Label CODDODCollected = (Label)e.Row.FindControl("CODDODCollected");
                //CODDODCollected.Visible = true;
            }



        }
        if (e.Row.RowType == DataControlRowType.Footer)
        {
            Label lbltotpkgs = (Label)e.Row.FindControl("lbltotpkgs");
            Label lbltotweight = (Label)e.Row.FindControl("lbltotweight");
            Label lbltotfreight = (Label)e.Row.FindControl("lbltotfreight");

            lbltotpkgs.Text = totpkgs.ToString();
            lbltotweight.Text = totweight.ToString();
            lbltotfreight.Text = totfreight.ToString();
        }
    }
}
