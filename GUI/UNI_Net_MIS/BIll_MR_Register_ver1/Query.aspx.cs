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
using System.Collections.Generic;

public partial class GUI_UNI_Net_MIS_BIll_MR_Register_ver1_Query : System.Web.UI.Page
{


    string Show = "f", hide = "t";
    protected void Page_Load(object sender, EventArgs e)
    {
        MySQLDataSource_GeneralMaster.ConnectionString = Session["SqlProvider"].ToString().Trim();
        //  MySQLDataSource_GeneralMaster1.ConnectionString = Session["SqlProvider"].ToString().Trim();
        MySQLDataSource_BILLCHARGES.ConnectionString = Session["SqlProvider"].ToString().Trim();
        MySQLDataSource_CLLIST_ALL_BILL.ConnectionString = Session["SqlProvider"].ToString().Trim();
        // MySQLDataSource_CLLIST_ALL_BILL_TYP.ConnectionString = Session["SqlProvider"].ToString().Trim();

        if (!IsPostBack)
        {
            Bill_Type.SelectedValue = "All";
            //BILLROWS("none");
            //MRROWS("none");
            //OTHERROWS("none");


        }
    }
    protected void btnShow_Click(object sender, EventArgs e)
    {
        string report_mode = "";
        TextBox txtDateFrom = (TextBox)DT.FindControl("txtDateFrom");
        TextBox txtDateTo = (TextBox)DT.FindControl("txtDateTo");

        RadioButtonList radDate = (RadioButtonList)DT.FindControl("radDate");

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


        string st_cust_vend = "", st_cust_vend_name = "";
        st_cust_vend = txtCustomer.Text.ToString();// LT_CUST_VEND.Items[i].Value.ToString();
        st_cust_vend_name = txtCustomer.Text.ToString();// LT_CUST_VEND.Items[i].Text.ToString();

        string BM_TYP = "", BM_STATUS = "", OV_DYS = "", BM_STATUS_str = "", CS_CHQ = "", AMT_G_THAN = "", BILLNO_list = "", MANBNOLIST = "", DKTSNOLIST = "";
        string DKTST = "", M_L_TYP = "", Select_list = "", Select_Text = "", MRSNOLIST = "";
        string RTP_DT = DT_TYPE.SelectedValue.ToString();

        string rpt = documet_type.SelectedValue.ToString();
        //if (rpt == "B")
        //{
        BM_TYP = Bill_Type.SelectedValue.ToString();
        BM_STATUS = BILL_Status.SelectedValue.ToString();
        CS_CHQ = Bill_CL_Type.SelectedValue.ToString();
        AMT_G_THAN = BillAMT.Text.ToString();
        OV_DYS = Days.Text.ToString();
        BILLNO_list = txtbillno.Text.ToString();
        MANBNOLIST = txtMAnbillno.Text.ToString();
        DKTSNOLIST = txtDKTno.Text.ToString();
        M_L_TYP = Bill_List_Type.SelectedValue.ToString();
        MRSNOLIST = txtMRNOLIST.Text.ToString();
        // }


        foreach (ListItem li in CHKBOXLIST1.Items)
        {
            if (li.Selected == true)
            {
                if (Select_list == "")
                    Select_list = li.Value.ToString();
                else
                    Select_list = Select_list + "," + li.Value.ToString();


                if (Select_Text == "")
                    Select_Text = li.Text.ToString();
                else
                    Select_Text = Select_Text + "," + li.Text.ToString();

            }
        }

        foreach (ListItem li in CHKBOXLIST2.Items)
        {
            if (li.Selected == true)
            {
                if (Select_list == "")
                    Select_list = li.Value.ToString();
                else
                    Select_list = Select_list + "," + li.Value.ToString();


                if (Select_Text == "")
                    Select_Text = li.Text.ToString();
                else
                    Select_Text = Select_Text + "," + li.Text.ToString();

            }
        }

        string TYPDET = loctypdet.SelectedValue.ToString();

        SqlConnection conn;
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



        var dictionary = new Dictionary<string, string>();
        dictionary.Add("MAxStr_VAL", MAxStr_VAL);
        dictionary.Add("MAxSTR_LV", MAxSTR_LV);
        dictionary.Add("fromdt", dtFrom);
        dictionary.Add("todt", dtTo);
        dictionary.Add("DT_TYPE", DT_TYPE.SelectedValue.ToString());
        dictionary.Add("st_cust_vend", st_cust_vend);
        dictionary.Add("RPT", rpt);
        dictionary.Add("BM_TYP", BM_TYP);
        dictionary.Add("BM_STATUS", BM_STATUS);
        dictionary.Add("CS_CHQ", CS_CHQ);
        dictionary.Add("AMT_G_THAN", AMT_G_THAN);
        dictionary.Add("OV_DYS", OV_DYS);
        dictionary.Add("BILLNO_list", BILLNO_list);
        dictionary.Add("MANBNOLIST", MANBNOLIST);
        dictionary.Add("DKTSNOLIST", DKTSNOLIST);
        dictionary.Add("DKTST", DKTST);
        dictionary.Add("M_L_TYP", M_L_TYP);
        dictionary.Add("MRSNOLIST", MRSNOLIST);
        dictionary.Add("Select_list", Select_list);
        dictionary.Add("Select_Text", Select_Text);
        dictionary.Add("RTP_DT", RTP_DT);
        dictionary.Add("TYPDET", TYPDET);

        var guid = Guid.NewGuid().ToString();
        Session[guid] = dictionary;

        string final;
        final = "?MAxStr_VAL=" + MAxStr_VAL;
        final += "&MAxSTR_LV=" + MAxSTR_LV;
        final += "&fromdt=" + dtFrom;
        final += "&todt=" + dtTo;
        final += "&DT_TYPE=" + DT_TYPE.SelectedValue.ToString();

        final += "&st_cust_vend=" + st_cust_vend;
        final += "&RPT=" + rpt;
        final += "&BM_TYP=" + BM_TYP;
        final += "&BM_STATUS=" + BM_STATUS;

        final += "&CS_CHQ=" + CS_CHQ;
        final += "&AMT_G_THAN=" + AMT_G_THAN;
        final += "&OV_DYS=" + OV_DYS;
        final += "&BILLNO_list=" + BILLNO_list;
        final += "&MANBNOLIST=" + MANBNOLIST;
        final += "&DKTSNOLIST=" + DKTSNOLIST;
        final += "&DKTST=" + DKTST;
        final += "&M_L_TYP=" + M_L_TYP;
        final += "&MRSNOLIST=" + MRSNOLIST;
        final += "&Select_list=" + Select_list;
        final += "&Select_Text=" + Select_Text;
        final += "&RTP_DT=" + RTP_DT;
        //final += "&RTP_DT_str=" + RTP_DT_str;
        //final += "&ASONDT=" + ASONDT;
        //final += "&ASONDT_To=" + ASONDT_To;
        final += "&TYPDET=" + TYPDET;

        System.Text.StringBuilder sb = new System.Text.StringBuilder();
        sb.Append("<");
        sb.Append("script language='javascript'>");
        //sb.Append("window.open('./Result1.aspx" + final + "', '_blank',");
        sb.Append("window.open('./Result1.aspx?guid=" + guid + "', '_blank',");
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
    protected void BILL_MR_TYPCHANGE(object sender, EventArgs e)
    {

        Bill_Type.SelectedValue = "All";
    }

    protected void BILL_MR_CHANGE(object sender, EventArgs e)
    {
        BILLROWS("none");
        MRROWS("none");
        OTHERROWS("none");

        string BMR = documet_type.SelectedValue.ToString();
        if (BMR == "M")
        {
            loctypdet.Items.Remove("Sumission Location");
        }
    }

    protected void BILLROWS_YN()
    {
        string BMR = documet_type.SelectedValue.ToString();

        if (BMR == "B")
        {
            BILLROWS("block");
            MRROWS("none");
        }
        else
        {
            BILLROWS("none");
            MRROWS("block");
        }
    }

    protected void OTHERROWS(string B_N)
    {
        TR_BM1.Style["display"] = B_N;
        TR_BM2.Style["display"] = B_N;
        TR_BM3.Style["display"] = B_N;
        TR_BM4.Style["display"] = B_N;
        TR_BILL1.Style["display"] = B_N;
        TR_BM5.Style["display"] = B_N;
        TR_BM6.Style["display"] = B_N;
        TR_BM7.Style["display"] = B_N;
        TR_BM8.Style["display"] = B_N;
        TR_BM9.Style["display"] = B_N;

        TR_BILLCL1.Style["display"] = B_N;
        TR_BILLCL2.Style["display"] = B_N;
        TR_BILLCL3.Style["display"] = B_N;
        TR_BILLCL4.Style["display"] = B_N;
    }

    protected void BILLROWS(string B_N)
    {
        // 
        TR_BILL2.Style["display"] = B_N;
        TR_BILL3.Style["display"] = B_N;
        TR_BILL4.Style["display"] = B_N;
    }
    protected void MRROWS(string B_N)
    {
        // TR_MR1.Style["display"] = B_N;
        TR_MR2.Style["display"] = B_N;
    }
}
