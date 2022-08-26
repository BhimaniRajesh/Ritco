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

public partial class GUI_admin_VehicleMaster_VehicleMasterEdSelect : System.Web.UI.Page
{
    SqlConnection cn;  // = new SqlConnection(ConfigurationManager.AppSettings["dbConn"].ToString());
    protected void Page_Load(object sender, EventArgs e)
    {
        cn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        cn.Open();
        getallvehno();
        if (IsPostBack == false)
        {
            ddVendorName.Items.Add("--Select--");
            ddVehicleNumber.Items.Add("--Select--");
            //SqlCommand cmd = new SqlCommand("select VENDORNAME + ' : ' + VENDORCODE from webx_VENDOR_HDR order by VENDORNAME", cn);
            SqlCommand cmd = new SqlCommand("Select Type_Code, [Type_Name] AS VehicleType From webx_vehicle_type", cn);
            SqlDataReader dr = cmd.ExecuteReader();
            //ddVndrNm.Items.Add(new ListItem(drddVndrNm.GetValue(0).ToString(), drddVndrNm.GetValue(1).ToString())); 
            while (dr.Read())
            {
                ddVendorName.Items.Add(new ListItem(dr.GetValue(1).ToString(), dr.GetValue(0).ToString()));
            }
            dr.Close();
            //cn.Close();

        }
    }
    private void getallvehno()
    {
        string sql = "SELECT vehno FROM webx_VEHICLE_HDR";
        SqlCommand sqlCommand = new SqlCommand(sql, cn);
        SqlDataReader dr_Location;
        dr_Location = sqlCommand.ExecuteReader();
        while (dr_Location.Read())
        {
            Page.RegisterArrayDeclaration("vehno", "'" + Convert.ToString(dr_Location["vehno"] + "'"));
        }
        dr_Location.Close();
    }
    protected void btnAdd_Click(object sender, EventArgs e)
    {
        Server.Transfer("VehicleMasterAdd.aspx");
    }
    protected void btnEdit_Click(object sender, EventArgs e)
    {
        string[] strdVhclNo = ddVehicleNumber.SelectedValue.Split(':');
        Session["ssDVhclNo"] = strdVhclNo[1].Trim();
        Session["ssTVhclNo"] = "";
        string[] vno = ddVehicleNumber.SelectedValue.Split(':');
        Session["vehno"] = vno[0].Trim();
        Server.Transfer("VehicleMasterEdit.aspx");  
        
    }
    protected void btnQckEdit_Click(object sender, EventArgs e)
    {
        //Session["ssTVhclNo"] = txtVehicleNo.Text;
        //Session["ssDVhclNo"] = "";
        string getVal = "";
        //cn.Open();
        string sql = "select vehno from webx_VEHICLE_HDR where vehno = '" + txtVehicleNo.Text + "'";// and vendorcode = '" + txtVndrCd.Text + "'";
        SqlCommand cmd = new SqlCommand(sql, cn);
        SqlDataReader dr = cmd.ExecuteReader();
        if (dr.Read())
        {
            getVal = dr["vehno"].ToString().Trim();  
        }
        dr.Close();
        //cn.Close();

        if (getVal != "")
        {
            Session["ssTVhclNo"] = getVal;
            Session["ssDVhclNo"] = "";
            Server.Transfer("VehicleMasterEdit.aspx");
        }
        else
        {
            //lblMsg.Text = "Record not found"; 
        }

    }
    protected void btnQckLstAll_Click(object sender, EventArgs e)
    {
        Server.Transfer("ListAll.aspx");
    }
    protected void btnListing_Click(object sender, EventArgs e)
    {
        Server.Transfer("ListAll.aspx");
    }
    protected void ddVendorName_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddVendorName.SelectedIndex == 0)
        {
            ddVehicleNumber.Items.Clear();
        }
        else
        {
            string[] strVndrCd = ddVendorName.SelectedValue.Split(':');
            //cn.Open();
            SqlCommand cmd = new SqlCommand("select VEHNO + ' : ' + VENDORCODE from webx_VEHICLE_HDR where vehicle_type='" + ddVendorName.Text + "' order by VEHNO", cn);
            SqlDataReader dr = cmd.ExecuteReader();
            ddVehicleNumber.Items.Clear();
            while (dr.Read())
            {
                ddVehicleNumber.Items.Add(new ListItem(dr.GetValue(0).ToString()));
            }
            dr.Close();
            //cn.Close();
        }
    }
    protected void btnQckAdd_Click(object sender, EventArgs e)
    {
        Server.Transfer("VehicleMasterAdd.aspx");
    }
    protected void btnQckDelete_Click(object sender, EventArgs e)
    {
        string getVal = "";
        //cn.Open();
        string strSQL1 = "";
        string strSQL2 = "";
        string strSQL = "";

        if(txtVehicleNo.Text != "")
        {
            strSQL = "select vehno from webx_vehicle_hdr where vehno  ='" + txtVehicleNo.Text + "'";
            strSQL1 = "delete from webx_vehicle_hdr where vehno  ='" + txtVehicleNo.Text + "'";
            strSQL2 = "delete from webx_vehicle_det where vehno  ='" + txtVehicleNo.Text + "'";
        }
        
        SqlCommand cmd = new SqlCommand(strSQL, cn);
        SqlDataReader dr = cmd.ExecuteReader();
        if (dr.Read())
        {
            getVal = dr[0].ToString().Trim();
        }
        
        dr.Close();

        if(getVal != "")
        {
            SqlCommand cmd1 = new SqlCommand(strSQL1, cn);
            cmd1.ExecuteNonQuery();

            SqlCommand cmd2 = new SqlCommand(strSQL2, cn);
            cmd2.ExecuteNonQuery();

            txtVehicleNo.Text = "";

            //lblMsg.Text = "Record Deleted Successfully!";
        }
        //cn.Close();
    }
    protected void btnDelete_Click(object sender, EventArgs e)
    {
        string getVal = "";
        string[] strVndrCd = ddVendorName.SelectedValue.Split(':');
        cn.Open();
        string strsql = "select VENDORCODE from webx_vehicle_hdr WHERE VENDORCODE='" + strVndrCd[1].ToString().Trim() + "'";
        SqlCommand cmd = new SqlCommand(strsql, cn);
        SqlDataReader dr = cmd.ExecuteReader();
        if (dr.Read())
        {
            getVal = dr[0].ToString().Trim();
        }

        dr.Close();

        if (getVal != "")
        {
            string sql1 = "delete from webx_vehicle_det where vehno in (select vehno from webx_vehicle_hdr where VENDORCODE='" + strVndrCd[1].ToString().Trim() + "')";
            string sql2 = "delete from webx_vehicle_hdr where VENDORCODE='" + strVndrCd[1].ToString().Trim() + "'";

            SqlCommand cmd1 = new SqlCommand(sql1, cn);
            cmd1.ExecuteNonQuery();

            SqlCommand cmd2 = new SqlCommand(sql2, cn);
            cmd2.ExecuteNonQuery();

            lblMsg1.Text = "Record Deleted Successfully!";
        }
        else
        {
            lblMsg1.Text = "Record not found";
        }

        //cn.Close();

    }
}
