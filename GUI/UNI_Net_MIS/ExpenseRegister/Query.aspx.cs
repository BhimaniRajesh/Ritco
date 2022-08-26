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
using System.ComponentModel;
using System.Drawing;
using System.Web.SessionState;
using System.Security;

public partial class GUI_UNI_NET_MIS_ExpenseRegister_Query : System.Web.UI.Page
{
    SqlConnection conn;
    public static int chgV = 0;
    int loclevel;
    public static string brcd, empcd, selyear, dkt_Call, THC_Call;
    protected void Page_Load(object sender, EventArgs e)
    {
        conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

        conn.Open();
        brcd = Session["brcd"].ToString();
        empcd = Session["empcd"].ToString();
        dkt_Call = Session["DocketCalledAs"].ToString();
        THC_Call = Session["THCCalledAs"].ToString();

        if (!IsPostBack)
        {
            hdnRptId.Value = Request.QueryString["RPTID"].ToString(); // added by Manisha 23/5/2014
            string sqlstr = "select loc_level from webx_location where loccode='" + brcd + "'";
            SqlCommand cmd = new SqlCommand(sqlstr, conn);
            SqlDataReader dread = cmd.ExecuteReader();

            dread.Read();
            loclevel = Convert.ToInt32(dread.GetValue(0).ToString());

            dread.Close();

            documet_type.Items.Add(new ListItem(THC_Call, "THC"));
            documet_type.Items.Add(new ListItem("DRS", "DRS"));
            documet_type.Items.Add(new ListItem("PRS", "PRS"));
            documet_type.SelectedValue = "THC";

            dread.Close();

            sqlstr = "select 'All' as codeid,'All' codedesc from webx_master_general union select codedesc,codeid from webx_master_general where codetype='TRN'";
            cmd = new SqlCommand(sqlstr, conn);
            dread = cmd.ExecuteReader();
            {

                while (dread.Read())
                {
                    DDLMode.Items.Add(new ListItem(dread.GetValue(0).ToString(), dread.GetValue(1).ToString()));
                }

            }
            dread.Close();
            DDLMode.SelectedValue = "All";

            sqlstr = "select 'All' as codeid,'All' codedesc from webx_rutmas union select rutnm +' : ' +rutcd,rutcd from webx_rutmas with(NOLOCK) where activeflag='Y'";
            cmd = new SqlCommand(sqlstr, conn);
            dread = cmd.ExecuteReader();
            {

                while (dread.Read())
                {
                    DDLROute.Items.Add(new ListItem(dread.GetValue(0).ToString(), dread.GetValue(1).ToString()));
                }

            }
            dread.Close();
            DDLROute.SelectedValue = "All";

            sqlstr = "select 'All' as codeid,'All' codedesc union select 'MARKET' as codeid,'MARKET' codedesc union select codedesc,codeid from webx_master_general where codetype='VENDTY'";
            cmd = new SqlCommand(sqlstr, conn);
            dread = cmd.ExecuteReader();
            {
                while (dread.Read())
                {
                    DDLVendorType.Items.Add(new ListItem(dread.GetValue(0).ToString(), dread.GetValue(1).ToString()));
                }
            }
            dread.Close();
            DDLVendorType.SelectedValue = "All";


            //sqlstr = "select 'All' as codeid,'All' codedesc from webx_vendor_hdr union select vendorname +' : ' +vendorcode,vendorcode from webx_vendor_hdr where active='Y'";
            //cmd = new SqlCommand(sqlstr, conn);
            //dread = cmd.ExecuteReader();
            //{

            //    while (dread.Read())
            //    {
            //        DDLVendor_thc.Items.Add(new ListItem(dread.GetValue(0).ToString(), dread.GetValue(1).ToString()));
            //    }

            //}
            //dread.Close();

            //DDLVendor_thc.SelectedValue = "All";
        }
        conn.Close();

    }
    protected void documet_type_SelectedIndexChanged(object sender, EventArgs e)
    {
        string DOCTYP = documet_type.SelectedValue.ToString();


        if (DOCTYP == "DRS")
        {
            
        }
        if (DOCTYP == "PRS")
        {
           
        }

        if (DOCTYP == "THC")
        {
            
        }
    }
    protected void btnShow_Click(object sender, EventArgs e)
    {
        string fromdt = "", todt = "";

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
            DropDownList DL_to = (DropDownList)Tolc.FindControl("DL_" + i_to);

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
        if ((rb2.Items[3].Selected))
        {
            report_mode = "Tilldate";
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


        string doctype = documet_type.SelectedItem.Text;
        string mode = DDLMode.SelectedValue.ToString();
        string route = DDLROute.SelectedValue.ToString();
        string vendtype = DDLVendorType.SelectedValue.ToString();
        string Vendor = txtVendor.Text;
        string status = DDLStatus_thc.SelectedValue.ToString();
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
        final += "&MAxStr_VAL=" + MAxStr_VAL;
        final += "&MAxSTR_LV=" + MAxSTR_LV;
        final += "&MAxStr_VAL_to=" + MAxStr_VAL_to;
        final += "&MAxSTR_LV_to=" + MAxSTR_LV_to;
        final += "&DocType=" + doctype;
        final += "&vendtype=" + vendtype;
        final += "&Mode=" + mode;
        final += "&Route=" + route;
        final += "&Vendor=" + Vendor;
        final += "&DocList=" + txtDocumentNo.Text;
        final += "&Status=" + status;
        final += "&hdnRptId=" + hdnRptId.Value.ToString(); // added by Manisha 26/5/2014




        //Response.Redirect("Result.aspx" + final);
		  System.Text.StringBuilder sb = new System.Text.StringBuilder();
        sb.Append("<");
        sb.Append("script language='javascript'>");
        sb.Append("function NoConfirm()");
        sb.Append("{");
        sb.Append("win = top;");
        sb.Append("win.opener = top;");
        sb.Append("win.close ();");
        sb.Append("}");
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
