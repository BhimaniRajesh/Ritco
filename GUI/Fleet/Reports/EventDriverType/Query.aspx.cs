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

public partial class GUI_Fleet_Reports_EventDriverType_Query : System.Web.UI.Page
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
            BindDropDown("sp_Master_EventType", "CodeType", "CodeId", ddlEvent);
           
        }
    }
    public void BindDropDown(string strProc, string text, string value, DropDownList d)
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
        string STR = strProc;
        SqlCommand cmd = new SqlCommand(STR, conn);
        cmd.CommandType = CommandType.StoredProcedure;
        if (text == "CodeType")
        {
            cmd.Parameters.Add("@codetype", SqlDbType.VarChar, 15).Value = d.SelectedValue;
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

    //    cls_Vehicle_Wise.strStartDt_From = txtDateFrom.Text;
    //    cls_Vehicle_Wise.strEndDt_To = txtDateTo.Text;
    //    cls_Vehicle_Wise.strDriver = txtDriver1.Text;
    //    cls_Vehicle_Wise.strCompany = company.SelectedValue.ToString().Trim();
    //    Response.Redirect("Result.aspx");
    //}

}
