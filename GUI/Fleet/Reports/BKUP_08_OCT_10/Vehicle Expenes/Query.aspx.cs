using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Data.SqlClient;
using System.Text;
using System.IO;
using Microsoft.Reporting.WebForms;

public partial class GUI_Fleet_Reports_Vehicle_Expen_Query : System.Web.UI.Page
{
    protected void Page_Load(object sender, System.EventArgs e)
    {

        if (!IsPostBack)
        {          
           BindDropDown("usp_master_location", "locname", "loccode", ddlBranch);
        }
    }



    public void BindDropDown(string strProc, string text, string value, DropDownList d)
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
        string STR = strProc;
        SqlCommand cmd = new SqlCommand(STR, conn);
        cmd.CommandType = CommandType.StoredProcedure;
        if (text == "locname")
        {
            cmd.Parameters.Add("@loccode", SqlDbType.VarChar, 15).Value = d.SelectedValue;
        }
        SqlDataReader dr = cmd.ExecuteReader();
        if (dr.HasRows)
        {
            while (dr.Read())
            {
                //d.Items.Add(new ListItem(Convert.ToString(dr[dr.GetOrdinal(text)])));
                d.Items.Add(new ListItem(Convert.ToString(dr[text]), Convert.ToString(dr[value])));
                //d.Items.Add(new ListItem(Convert.ToString(dr[value])));

            }
        }
        dr.Close();
        conn.Close();
    }

    //protected void btnShow_Click(object sender, EventArgs e)
    //{
    //    TextBox txtDateFrom = (TextBox)this.DT.FindControl("txtDateFrom");
    //    TextBox txtDateTo = (TextBox)this.DT.FindControl("txtDateTo");
    //    DropDownList company = (DropDownList)CMPFT1.FindControl("ddlCompanyList");
    //    Cls_VehicleRegister.StrStart_dt = txtDateFrom.Text;
    //    Cls_VehicleRegister.StrEnd_dt = txtDateFrom.Text;
    //    Cls_VehicleRegister.Strloccode = ddlBranch.SelectedItem.Text.ToString().Trim();
    //    Cls_VehicleRegister.StrVehicleNo = txtVehicleNo.Text;
    //    Cls_VehicleRegister.strCompany = company.SelectedValue.ToString().Trim();
    //    //Response.Redirect("Result.aspx?Start_dt=" + txtDateFrom.Text + "&End_dt=" + txtDateTo.Text + "&loccode=" + ddlBranch.SelectedItem.Text.ToString() + "&VehicleNo=" + txtVehicleNo.Text );
    //}
}
