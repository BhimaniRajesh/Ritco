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
public partial class GUI_UNI_NET_MIS_OUTSTD_SSRS_Query : System.Web.UI.Page
{
    SqlConnection conn;

    protected void Page_Load(object sender, EventArgs e)
    {
        MySQLDataSource_GeneralMaster.ConnectionString = Session["SqlProvider"].ToString().Trim();
        DT.EnableTillDate = true;
        if (!IsPostBack)
        {

            hdnRptId.Value = Request.QueryString["RPTID"].ToString(); // added by Manisha 22/5/2014
            ChkPaybas.SelectedValue = "All";
            DataTable dt = new DataTable();
            dt.Columns.Add("from", typeof(string));
            dt.Columns.Add("to", typeof(string));

            for (int i = 0; i < 5; i++)
            {
                dt.Rows.Add();
            }
            grvftls.DataSource = dt;
            grvftls.DataBind();

            txtasondt.Text = System.DateTime.Today.ToString("dd/MM/yyyy");
            txtasondt_1.Text = System.DateTime.Today.ToString("dd/MM/yyyy");
            txtasondt_to.Text = System.DateTime.Today.ToString("dd/MM/yyyy");
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

        string final;

        if (MAxStr_VAL == "")
            MAxStr_VAL = "All";

        if (MAxSTR_LV == "")
            MAxSTR_LV = "1";

        string YearString = Session["FinYear"].ToString().Substring(2, 2);
        string CloseYear = Convert.ToString((Convert.ToInt16(YearString) + 1));
        if (CloseYear.Length == 1)
        {
            CloseYear = "0" + CloseYear;
        }
        DateTime yrstartdt;
        string yearSuffix = Convert.ToString(YearString) + "_" + Convert.ToString(CloseYear);

        string BILLTYP = ChkPaybas.SelectedValue.ToString();
        //foreach (ListItem li in ChkPaybas.Items)
        //{
        //    if (li.Selected == true)
        //    {
        //        if (BILLTYP == "")
        //            BILLTYP = li.Value.ToString();
        //        else
        //            BILLTYP = BILLTYP + "," + li.Value.ToString();

        //    }
        //}

        //if (BILLTYP == "")
        //{
        //    foreach (ListItem li in ChkPaybas.Items)
        //    {

        //            if (BILLTYP == "")
        //                BILLTYP = li.Text.ToString();
        //            else
        //                BILLTYP = BILLTYP + "," + li.Text.ToString();


        //    }
        //}

        string frm_as_dt = "", dtTo_as = "";
        if (RPT_FORTYP.SelectedValue == "3")
            frm_as_dt = txtasondt.Text.ToString();
        else
            frm_as_dt = txtasondt_1.Text.ToString();


        string to_as_dt = txtasondt_to.Text.ToString();

        string[] strArrDtFrom_as = frm_as_dt.Split('/');

        string dtFrom_as = Convert.ToDateTime(strArrDtFrom_as[1] + "/" + strArrDtFrom_as[0] + "/" + strArrDtFrom_as[2]).ToString("dd MMM yy");
        if (txtasondt_to.Text != "")
        {
            string[] strArrDtTo_as = to_as_dt.Split('/');

            dtTo_as = Convert.ToDateTime(strArrDtTo_as[1] + "/" + strArrDtTo_as[0] + "/" + strArrDtTo_as[2]).ToString("dd MMM yy");
        }

        final = "?dtFrom=" + dtFrom;
        final += "&dtTo=" + dtTo;
        final += "&location=" + MAxStr_VAL;
        final += "&locLevel=" + MAxSTR_LV;
        final += "&LOC_TYP=" + RPT_LOC.SelectedValue.ToString();

        if (RPT_FORTYP.SelectedValue == "3")
            final += "&DT_TYP=" + RPT_DATE_1.SelectedValue.ToString();
        else
            final += "&DT_TYP=" + RPT_DATE.SelectedValue.ToString();

        final += "&RPT=" + RPT_TYP.SelectedValue.ToString();
        final += "&RPT_SUB=" + RPT_SUBTYP.SelectedValue.ToString();

        final += "&ASONDT=" + dtFrom_as.ToString();
        final += "&ASONDT_to=" + dtTo_as.ToString();

        if (txtCustomer.Text.ToString().Trim() == "")
            final += "&CUSTSTR=All";
        else
            final += "&CUSTSTR=" + txtCustomer.Text.ToString();

        final += "&FinYear=" + yearSuffix.ToString();

        // final += "&CLLIST=" + CLLIST;
        final += "&TYP=" + RPT_FORTYP.SelectedValue.ToString();
        final += "&BILLTYP=" + BILLTYP;

        string HDR_DETAILS = "";

        // HDR_DETAILS = "<root>";
        HDR_DETAILS = HDR_DETAILS + "AF0FS0SA";
        int abc = 0;

        foreach (GridViewRow grv in grvftls.Rows)
        {
            TextBox txtfrom = (TextBox)grv.FindControl("txtfrom");
            TextBox txtto = (TextBox)grv.FindControl("txtto");

            if (txtfrom.Text.ToString() != txtto.Text.ToString())
                HDR_DETAILS = HDR_DETAILS + "AF" + abc + "FS" + txtto.Text.ToString() + "SA";

            abc = Convert.ToInt16(txtto.Text.ToString()) + 1;
        }
        HDR_DETAILS = HDR_DETAILS + "AF161FS365SA";

        //Response.Write("Abc : " + HDR_DETAILS);

        final += "&HDR_DETAILS=" + HDR_DETAILS;
        final += "&hdnRptId=" + hdnRptId.Value.ToString(); // added by Manisha 22/5/2014

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

        //Response.Redirect("Result.aspx" + final);
    }


    protected void grvftls_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        int i = 0;
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            TextBox txtfrom = (TextBox)e.Row.FindControl("txtfrom");
            TextBox txtto = (TextBox)e.Row.FindControl("txtto");

            if (e.Row.RowIndex == 0)
            {
                txtfrom.Text = "0";
                txtto.Text = "30";
            }
            else if (e.Row.RowIndex == 1)
            {
                txtfrom.Text = "31";
                txtto.Text = "60";
            }
            else if (e.Row.RowIndex == 2)
            {
                txtfrom.Text = "61";
                txtto.Text = "90";
            }
            else if (e.Row.RowIndex == 3)
            {
                txtfrom.Text = "91";
                txtto.Text = "120";
            }
            else if (e.Row.RowIndex == 4)
            {
                txtfrom.Text = "121";
                txtto.Text = "160";
            }

            txtto.Attributes.Add("onblur", "javascript:return toBlur(" + (e.Row.RowIndex + 2) + ")");

        }

        if (e.Row.RowType == DataControlRowType.Footer)
        {
            TextBox txtfrom = (TextBox)e.Row.FindControl("txtfrom");
            TextBox txtto = (TextBox)e.Row.FindControl("txtto");

            txtfrom.Text = "161";



        }
    }
    protected void btnnorows_Click(object sender, EventArgs e)
    {
        DataTable dt = new DataTable();
        dt.Columns.Add("from", typeof(string));
        dt.Columns.Add("to", typeof(string));

        foreach (GridViewRow grv in grvftls.Rows)
        {
            DataRow dtr = dt.NewRow();
            TextBox txtfrom = (TextBox)grv.FindControl("txtfrom");
            TextBox txtto = (TextBox)grv.FindControl("txtto");

            dtr["from"] = txtfrom.Text;
            dtr["to"] = txtto.Text;
            dt.Rows.Add(dtr);
        }
        Int16 rows = Convert.ToInt16(txtnorows.Text);
        for (int i = 0; i < rows; i++)
        {
            dt.Rows.Add();
        }
        grvftls.DataSource = dt;
        grvftls.DataBind();
    }
}
