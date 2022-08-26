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
public partial class GUI_UNI_NET_MIS_SALES_SUMMAREY_Query : System.Web.UI.Page
{
    SqlConnection conn;
    public static string selyear;
    protected void Page_Load(object sender, EventArgs e)
    {
        string curryear = System.DateTime.Today.ToString("yy");
        if (!IsPostBack)
        {
            for (int i = 2005; i <= Convert.ToInt16(System.DateTime.Today.ToString("yyyy")); i++)
            {
                ddYear.Items.Add(new ListItem(i.ToString(), i.ToString()));
            }
            ddYear.SelectedValue = System.DateTime.Today.ToString("yyyy");
        }
    }
    protected void btnShow_Click(object sender, EventArgs e)
    {
        conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

        conn.Open();
        string brcd = Session["brcd"].ToString();
        string sqlstr = "select loc_level from webx_location where loccode='" + brcd + "'";
        // Response.Write("<br> sqlstr : " + sqlstr);
        SqlCommand cmd = new SqlCommand(sqlstr, conn);
        SqlDataReader dread = cmd.ExecuteReader();
        dread.Read();
        int loclevel = Convert.ToInt32(dread.GetValue(0).ToString());
        string loc_level = Convert.ToString(dread.GetValue(0).ToString());
        //Response.Write("<br> sqlstr : " + loclevel);
        dread.Close();

        string minLV = "", maxLV = "";

        sqlstr = "select max(codeid),min(codeid) from webx_master_general where codetype='HRCHY' and codeid<>'1'  and  codeid>=" + loclevel + " ";
        cmd = new SqlCommand(sqlstr, conn);
        SqlDataReader dr = cmd.ExecuteReader();

        while (dr.Read())
        {
            minLV = dr[1].ToString();
            maxLV = dr[0].ToString();
        }
        dr.Close();
        string Str_VAL = "", STR_LV = "";
        string MAxStr_VAL = "", MAxSTR_LV = "";

        for (int i = Convert.ToInt32(minLV); i <= Convert.ToInt32(maxLV); i++)
        {
            DropDownList DL = (DropDownList)Fromlc.FindControl("DL_" + i);

            if (DL.SelectedValue.ToString() != "All")
            {
                if (Str_VAL == "")
                    Str_VAL = DL.SelectedValue.ToString();
                else
                    Str_VAL = Str_VAL + "," + DL.SelectedValue.ToString();

                MAxStr_VAL = DL.SelectedValue.ToString();

                if (STR_LV == "")
                    STR_LV = i.ToString();
                else
                    STR_LV = STR_LV + "," + i.ToString();
                MAxSTR_LV = i.ToString();
            }


        }

        if (MAxStr_VAL == "")
            MAxStr_VAL = "All";

        if (MAxSTR_LV == "")
            MAxSTR_LV = "1";

        string report_mode = "", TYP_YEAR = "";

        for (int i = 0; i < 10; i++)
        {
            if (rdMonth.Items[i].Selected)
            {
                report_mode = rdMonth.Items[i].Value.ToString();
            }
        }

        for (int i = 0; i < 2; i++)
        {
            if (RTY_TY_YR.Items[i].Selected)
            {
                TYP_YEAR = RTY_TY_YR.Items[i].Value.ToString();
            }
        }

        string strrightnow, strrightnow1;
        System.DateTime righnow = System.DateTime.Today;
        strrightnow = righnow.ToString("dd/MM/yyyy");
        strrightnow1 = righnow.ToString("dd/MM/yyyy");

        strrightnow = txtDateFrom.Text.ToString();
        strrightnow1 = txtDateTo.Text.ToString(); //Request.QueryString.Get("txtDateTo");

        if (report_mode == "8")
        {
            strrightnow = "";
            strrightnow1 = "";
        }

        if (report_mode == "9")
        {
            strrightnow = righnow.AddDays(-7).ToString("dd/MM/yyyy");
            strrightnow1 = righnow.ToString("dd/MM/yyyy");
        }

        if (strrightnow == "")
        {
            strrightnow = righnow.ToString("dd/MM/yyyy");
        }

        if (strrightnow1 == "")
        {
            strrightnow1 = righnow.ToString("dd/MM/yyyy");
        }

        string[] strArrDtFrom = strrightnow.Split('/');
        string[] strArrDtTo = strrightnow1.Split('/');

        string dtFrom = Convert.ToDateTime(strArrDtFrom[1] + "/" + strArrDtFrom[0] + "/" + strArrDtFrom[2]).ToString("dd MMM yy");
        string dtTo = Convert.ToDateTime(strArrDtTo[1] + "/" + strArrDtTo[0] + "/" + strArrDtTo[2]).ToString("dd MMM yy");

        string stryear = ddYear.SelectedValue.ToString();
        string strmonths = "";

        if (report_mode == "3")
        {
            if (TYP_YEAR == "1")
                strmonths = "1,2,3";
            else
                strmonths = "4,5,6";
        }
        else if (report_mode == "4")
        {
            if (TYP_YEAR == "1")
                strmonths = "4,5,6";
            else
                strmonths = "7,8,9";
        }
        else if (report_mode == "5")
        {
            if (TYP_YEAR == "1")
                strmonths = "7,8,9";
            else
                strmonths = "10,11,12";
        }
        else if (report_mode == "6")
        {
            if (TYP_YEAR == "1")
                strmonths = "10,11,12";
            else
                strmonths = "1,2,3";
        }
        else if (report_mode == "1")
        {
            stryear = ddYear.SelectedValue.ToString();
            strmonths = Convert.ToString(Convert.ToInt16(System.DateTime.Today.ToString("MM")));
        }
        else if (report_mode == "2")
        {
            stryear = ddYear.SelectedValue.ToString();
            strmonths = Convert.ToString(Convert.ToInt16(System.DateTime.Today.ToString("MM")) - 1);
        }
        else
        {
            strmonths = "0";
            stryear = "All";
        }

        if (report_mode == "7")
            stryear = ddYear.SelectedValue.ToString();

        string strCustomer = string.Empty;

        if (txtCustomer.Text.Trim() == "")
            strCustomer = "All";
        else
            strCustomer = txtCustomer.Text.Trim();   

        string Final = "";
        Final = "?MAxStr_VAL=" + MAxStr_VAL.ToString();
        Final += "&MAxSTR_LV=" + MAxSTR_LV.ToString();
        Final += "&dtFrom=" + dtFrom.ToString();
        Final += "&dtTo=" + dtTo.ToString();
        Final += "&stryear=" + stryear.ToString();
        Final += "&DT_TYPE=" + DT_TYPE.SelectedValue.ToString();
        Final += "&strmonths=" + strmonths.ToString();
        Final += "&custcode=" + strCustomer.ToString();
        Response.Redirect("Result.aspx" + Final);

    }
}
