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
using System.Collections.Generic;
using Microsoft.ApplicationBlocks.Data;

public partial class GUI_admin_CrossingVendorMaster_AddCrossingVendorContract : System.Web.UI.Page
{
    string VendorCode, vendorType, vendorLocation,VendorContractID="";
    DataSet ds, vendorLocations;

    MyFunctions fn = new MyFunctions();
    DataTable dt = new DataTable("table1");
    protected void Page_Load(object sender, EventArgs e)
    {        
        vendorType = Convert.ToString(Request.QueryString["vendorType"]);
        VendorCode = Convert.ToString(Request.QueryString["vendor"]);
        hdnVendorCode.Value = VendorCode;
        lblVendorType.Text = vendorType;
        lblVendorName.Text = fn.GetVendor_name(VendorCode);
        vendorLocations = GetLocationByVendorCode(VendorCode);
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

        SqlConnection conn = new SqlConnection(SessionUtilities.ConnectionString);
        conn.Open();
        string sqlQuery = "select VENDORBRCD from webx_vendor_det where VendorCode='" + Convert.ToString(Request.QueryString["vendor"]) + "'";
        SqlCommand cmd = new SqlCommand(sqlQuery, conn);
        SqlDataReader dr;
        dr = cmd.ExecuteReader();
        while (dr.Read())
        {
            vendorLocation = Convert.ToString(dr["VENDORBRCD"]);
        }
        grvcity.DataSource = dt;
        grvcity.DataBind();
        conn.Close();

    }
    protected void btnsubmit_Click(object sender, EventArgs e)
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

        conn.Open();
        string ratetype = "", sqlstr="";
        
        SqlCommand cmd = new SqlCommand();
        SqlTransaction trn;
        trn = conn.BeginTransaction();

        try 
        {
            
            VendorContractID = getContractID();

            VendorCorssingContract vcc = new VendorCorssingContract();
            vcc.ContractID = VendorContractID;
            vcc.VendorCode = Convert.ToString(Request.QueryString["vendor"]);
            vcc.ActiveFlag = "Y";
            vcc.EntryBy = SessionUtilities.CurrentEmployeeID;
            vcc.EntryDate = DateTime.Now;
            vcc.Details = new List<VendorCorssingContractDet>();
            foreach (GridViewRow gridrow in grvcity.Rows)
            {
                CheckBox chkyes = (CheckBox)gridrow.FindControl("chkyes");

                TextBox txtlocation = (TextBox)gridrow.FindControl("txtlocation");
                TextBox txtDestcity = (TextBox)gridrow.FindControl("txtDestcity");
                DropDownList cmbratetype = (DropDownList)gridrow.FindControl("cmbratetype");
                ratetype = cmbratetype.SelectedValue.ToString();
                TextBox txtrate = (TextBox)gridrow.FindControl("txtrate");
                TextBox txtDoorDelyCharge = (TextBox)gridrow.FindControl("txtDoorDelyCharge");
                DropDownList ddlOrigin = (DropDownList)gridrow.FindControl("ddlOrigin");

                if (chkyes.Checked)
                {
                    VendorCorssingContractDet CRDET = new VendorCorssingContractDet();
                    CRDET.ContractID = VendorContractID;
                    CRDET.VendorCode = Convert.ToString(Request.QueryString["vendor"]);
                    CRDET.Origin = ddlOrigin.SelectedValue;
                    CRDET.DestCity = txtDestcity.Text;
                    CRDET.Ratetype = ratetype;
                    CRDET.Rate = Convert.ToDouble(txtrate.Text);
                    CRDET.DoorDeliveryCharge = Convert.ToDouble(txtDoorDelyCharge.Text);
                    CRDET.OtherCharge = 0.00;
                    CRDET.ActiveFlag = "Y";
                    CRDET.EntryBy = SessionUtilities.CurrentEmployeeID;
                    CRDET.EntryDate = DateTime.Now;

                    //CRDET.Deleted = true;                    
                    vcc.Details.Add(CRDET);
                }
                

            }
            VendorCrossingContractController.Insert(vcc, trn);
            trn.Commit();
        }
        catch (Exception e1)
        {
            //Response.Write("<br><br><br><font class='blackboldfnt' >Error : " + e1.Message + "</font>");
            //string msg = e1.Message.ToString();
            //msg = msg.Replace('\n', ' ');
            //trn.Rollback();
            //conn.Close();
            //Response.Redirect("Message.aspx?" + e1.Message);
            
            throw e1;
            trn.Rollback();
            conn.Close();
        }
        conn.Close();
        string final = "";
        final = "ContractNo=" + VendorContractID;
        Response.Redirect("DoneCrossingVendorContract.aspx?" + final);
    }
    protected void grvcity_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            Button btnorigin = (Button)e.Row.FindControl("btnorigin");
            TextBox txtlocation = (TextBox)e.Row.FindControl("txtlocation");
            //txtlocation.Text = vendorLocation.ToString();
            Button btnDestination = (Button)e.Row.FindControl("btnDestination");
            TextBox txtDestcity = (TextBox)e.Row.FindControl("txtDestcity");
            DropDownList ddlOrigin = e.Row.FindControl("ddlOrigin") as DropDownList;

            ddlOrigin.DataSource = vendorLocations;
            ddlOrigin.DataTextField = "LocName";
            ddlOrigin.DataValueField = "LocCode";
            ddlOrigin.DataBind();
            ddlOrigin.Items.Insert(0, new ListItem("Select", ""));
            ddlOrigin.SelectedValue = "";

            btnorigin.Attributes.Add("onclick", "javascript:return popuplist('location','" + txtlocation.ClientID.ToString() + "','none')");
            btnDestination.Attributes.Add("onclick", "javascript:return popuplist('city','" + txtDestcity.ClientID.ToString() + "','none')");
        }
    }
    private string getContractID()
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

        conn.Open();
        string sql = "select ContractID from webx_vendor_Crossing_Contract_HDR";
        SqlCommand cmd = new SqlCommand(sql,conn);
        SqlDataReader dr = cmd.ExecuteReader();
        string oldcnid = "";
        Int64 ab = 0;
        Int64 greatno = 0;
        while (dr.Read())
        {
            oldcnid = dr["ContractID"].ToString();
            if (oldcnid.Length <= 3)
                continue;
            oldcnid = oldcnid.Substring(2, oldcnid.Length - 2);

            ab = Convert.ToInt64(oldcnid);
            if (greatno < ab)
            {
                greatno = ab;
            }

        }
        dr.Close();
        conn.Close();
        greatno = greatno + 1;
        string newcnid = "VC" + greatno.ToString().PadLeft(10, '0');

        return newcnid;
    }

    private DataSet GetLocationByVendorCode(string _VendorCode)
    {
        string strCMD = "SELECT LocCode, (LocCode+':'+LocName) as LocName from Webx_Location where (SELECT dbo.SplitWithSearch((SELECT VENDORBRCD From webx_Vendor_DET where VendorCode='{0}'),',',LocCode))='1'";
        strCMD = string.Format(strCMD, _VendorCode);
        return SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, strCMD);
    }
}
