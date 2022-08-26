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

public partial class GUI_UNI_NET_MIS_STOCK_SSRS_Query : System.Web.UI.Page
{
    SqlConnection conn;
    protected void Page_Load(object sender, EventArgs e)
    {
        hdnRptId.Value = Request.QueryString["RPTID"].ToString(); // added by Manisha 26/5/2014

        DT.EnableTillDate = true;
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

        string Str_VAL_to = "", STR_LV_to = "";
        string MAxStr_VAL_to = "", MAxSTR_LV_to = "";

        for (int i_to = Convert.ToInt32(minLV); i_to <= Convert.ToInt32(maxLV); i_to++)
        {
            DropDownList DL_to = (DropDownList)FRM.FindControl("DL_" + i_to);

            if (DL_to.SelectedValue.ToString() != "All")
            {
                if (Str_VAL_to == "")
                    Str_VAL_to = DL_to.SelectedValue.ToString();
                else
                    Str_VAL_to = Str_VAL_to + "," + DL_to.SelectedValue.ToString();

                MAxStr_VAL_to = DL_to.SelectedValue.ToString();

                if (STR_LV_to == "")
                    STR_LV_to = i_to.ToString();
                else
                    STR_LV_to = STR_LV_to + "," + i_to.ToString();
                MAxSTR_LV_to = i_to.ToString();
            }
        }

        conn.Close();

        TextBox txtDateFrom = (TextBox)DT.FindControl("txtDateFrom");
        TextBox txtDateTo = (TextBox)DT.FindControl("txtDateTo");

        RadioButtonList radDate = (RadioButtonList)DT.FindControl("radDate");
        string report_mode = "";
        RadioButtonList rb2 = new RadioButtonList();
        rb2 = (RadioButtonList)radDate;
        if ((rb2.Items[0].Selected))
        {
            report_mode = "Date";
        }
        if ((rb2.Items[1].Selected))
        {
            report_mode = "Week";
        }
        if ((rb2.Items[2].Selected))
        {
            report_mode = "Today";
        }
        if ((rb2.Items[3].Selected))
        {
            report_mode = "Tilldate";
        }

        if (RPT_FORTYP.SelectedValue == "3")
            report_mode = "Tilldate";



        string strrightnow, strrightnow1;
        System.DateTime righnow = System.DateTime.Today;
        strrightnow = righnow.ToString("dd/MM/yyyy");
        strrightnow1 = righnow.ToString("dd/MM/yyyy");
        if (report_mode == "Date")
        {
            strrightnow = txtDateFrom.Text.ToString();
            strrightnow1 = txtDateTo.Text.ToString(); //Request.QueryString.Get("txtDateTo");
        }
        else if (report_mode == "Week")
        {
            strrightnow = righnow.AddDays(-7).ToString("dd/MM/yyyy");
            strrightnow1 = righnow.ToString("dd/MM/yyyy");
        }
        else if (report_mode == "Today")
        {
            strrightnow = righnow.ToString("dd/MM/yyyy");
            strrightnow1 = righnow.ToString("dd/MM/yyyy");

        }
        else if (report_mode == "Tilldate")
        {
            strrightnow = "01/04/1990";
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
       // DropDownList company = (DropDownList)CMPFT1.FindControl("ddlCompanyList");
        string final;

        if (MAxStr_VAL == "")
            MAxStr_VAL = "All";
        if (MAxStr_VAL_to == "")
            MAxStr_VAL_to = "All";
        if (MAxSTR_LV == "")
            MAxSTR_LV = "1";
        if (MAxSTR_LV_to == "")
            MAxSTR_LV_to = "1";


        final = "?dtFrom=" + dtFrom;
        final += "&dtTo=" + dtTo;
        final += "&location=" + MAxStr_VAL;
        final += "&locLevel=" + MAxSTR_LV;
        final += "&location_to=" + MAxStr_VAL_to;
        final += "&locLevel_to=" + MAxSTR_LV_to;
        final += "&DT_TYP=" + RPT_DATE.SelectedValue.ToString();
        final += "&LOC_TYP=" + RPT_LOC.SelectedValue.ToString();
        final += "&RPT_TYP=" + RPT_TYP.SelectedValue.ToString();
        final += "&RPT_FORTYP=" + RPT_FORTYP.SelectedValue.ToString();
        final += "&RPT_SFTYP=" + RPT_SFTYP.SelectedValue.ToString();
		//final += "&company=" + company.SelectedValue.ToString();

        final += "&hdnRptId=" + hdnRptId.Value.ToString(); // added by Manisha 26/5/2014


        System.Text.StringBuilder sb = new System.Text.StringBuilder();
        sb.Append("<");
        sb.Append("script language='javascript'>");
        sb.Append("window.open('./Result.aspx" + final + "', '_blank',");
        sb.Append("'top=0, left=0, width=900, height=700, scrollbars=yes, menubar=no,toolbar=no,status=1,resizable=yes');");
        sb.Append("<");
        sb.Append("/script>");

        if (!this.IsStartupScriptRegistered("PopupWindow"))
        {
            //Register the script
            this.RegisterStartupScript("PopupWindow", sb.ToString());
        }

    }

}