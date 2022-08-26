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
using Microsoft.ApplicationBlocks.Data;

public partial class GUI_admin_CrossingVendorMaster_ViewCrossingVendorContract : System.Web.UI.Page
{
    string ContractID = "";
    SqlConnection cn;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack && !IsCallback)
        {
            ContractID = Request.QueryString.Get("ContractID");
            string[] Split = ContractID.Split(new Char[] { ',' });
            ContractID = Convert.ToString(Split[0]);
            string print_yn = Convert.ToString(Split[1]);

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
            else if (Session["Client"].ToString() == "SARCO")
            {
                imgLogo.ImageUrl = "~/GUI/images/sarco.JPG";
            }
            else
            {
                imgLogo.ImageUrl = "~/GUI/images/webxpress_logo.gif";
            }

            cn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
            cn.Open();
            string sql = "select top 1 c.vendorcode,vendorname=(select vendorname from webx_vendor_hdr h where h.vendorcode=c.vendorcode) from webx_vendor_Crossing_Contract_Det c where c.ContractID='" + ContractID + "' and ActiveFlag='Y'";
            SqlCommand cmd = new SqlCommand(sql, cn);
            SqlDataReader dr = cmd.ExecuteReader();
            if (dr.Read())
            {
                lblContractID.Text = ContractID;
                lblVendorCode.Text = dr["vendorcode"].ToString();
                lblVendorName.Text = dr["vendorname"].ToString();
            }
            dr.Close();
            cn.Close();

            string strCMD = "select * from webx_vendor_Crossing_Contract_Det where ContractID='" + ContractID + "' and ActiveFlag='Y'";
            //Response.Write(strCMD);
            //Response.End();
            DataTable dt = new DataTable();
            dt = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, strCMD).Tables[0];

            grvcity.DataSource = dt;
            grvcity.DataBind();

        }

    }
    protected void grvcity_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            Label lblRatetype = (Label)e.Row.FindControl("lblRatetype");
            if (lblRatetype.Text == "K")
                lblRatetype.Text = "Per Kg";
            else if (lblRatetype.Text == "F")
                lblRatetype.Text = "Flat RS";
            else if (lblRatetype.Text == "P")
                lblRatetype.Text = "Per Pkgs";
        }

    }
}
