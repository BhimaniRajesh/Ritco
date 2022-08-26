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

public partial class GUI_query_darshan : System.Web.UI.Page
{
    SqlConnection conn;
    protected void Page_Load(object sender, EventArgs e)
    {
        MySQLDataSource_GeneralMaster.ConnectionString = Session["SqlProvider"].ToString().Trim();
        MySQLDataSource_GeneralMaster1.ConnectionString = Session["SqlProvider"].ToString().Trim();
        MySQLDataSource_GeneralMaster2.ConnectionString = Session["SqlProvider"].ToString().Trim();
        MySQLDataSource_GeneralMaster3.ConnectionString = Session["SqlProvider"].ToString().Trim();
        lblno.Text ="select "+ Session["DocketCalledAs"].ToString();
        
        if (!IsPostBack)
        {
            hdnRptId.Value = Request.QueryString["RPTID"].ToString(); // added by Manisha 26/5/2014

            dbpaybas.SelectedValue = "All";
            dbmode.SelectedValue = "All";
            dbSclass.SelectedValue = "All";
            dbbusinesstype.SelectedValue = "All";
        }
    }
    protected void btn_submit_Click(object sender, EventArgs e)
    {
        conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();

        string brcd = Session["brcd"].ToString();
        string sqlstr = "select loc_level from webx_location where loccode='" + brcd + "'";

        SqlCommand cmd = new SqlCommand(sqlstr, conn);
        SqlDataReader dread = cmd.ExecuteReader();
        dread.Read();
        int loclevel = Convert.ToInt32(dread.GetValue(0).ToString());
        string loc_level = Convert.ToString(dread.GetValue(0).ToString());

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
            DropDownList DL = (DropDownList)LOC.FindControl("DL_" + i);

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

        DropDownList zone = (DropDownList)LOC_TO.FindControl("dbR");
        DropDownList zone_loc = (DropDownList)LOC_TO.FindControl("dbL");
        

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
        
        if (MAxStr_VAL == "")
            MAxStr_VAL = "All";
        if (MAxSTR_LV == "")
            MAxSTR_LV = "1";

        string paybas = dbpaybas.SelectedValue.ToString();
        string mode = dbmode.SelectedValue.ToString();
        string sclass = dbSclass.SelectedValue.ToString();
        string businesstype = dbbusinesstype.SelectedValue.ToString();
        string RPTTYP = dbrptype.SelectedValue.ToString();
        string RPTSUBTYP = dbsubrptype.SelectedValue.ToString();
        string docketlist = txtdocket.Text.ToString();
        string custcode = txtCustomer.Text;
		if(custcode=="")
		{
			custcode="All";
		}
        string datetype = Date.SelectedValue.ToString();
		string zone1=zone.SelectedValue.ToString();
		string zone_loc1=zone_loc.SelectedValue.ToString();

        string final;
        final = "?&MAxStr_VAL=" + MAxStr_VAL;
        final += "&MAxSTR_LV=" + MAxSTR_LV;
        final += "&zone=" + zone1;
        final += "&zone_loc=" + zone_loc1;
        final += "&fromdt=" + dtFrom;
        final += "&todt=" + dtTo;
        final += "&paybas=" + paybas;
        final += "&mode=" + mode;
        final += "&sclass=" + sclass;
        final += "&businesstype=" + businesstype;
        final += "&RPTTYP=" + RPTTYP;
        final += "&custcode=" + custcode;
        final += "&RPTSUBTYP=" + RPTSUBTYP;
        final += "&dockelist=" + docketlist;
        final += "&datetype=" + datetype;
        final += "&hdnRptId=" + hdnRptId.Value.ToString(); // added by Manisha 26/5/2014

        //Response.Redirect("Result_new.aspx"+final);
		
        System.Text.StringBuilder sb = new System.Text.StringBuilder();
        sb.Append("<");
        sb.Append("script language='javascript'>");
        sb.Append("window.open('./Result_new.aspx" + final + "', '_blank',");
        sb.Append("'top=0, left=0, width=900, height=650, scrollbars=yes, menubar=no,toolbar=no,status=1,resizable=yes');");
        sb.Append("<");
        sb.Append("/script>");

        Random rnd = new Random();
        rnd.Next();
        ClientScript.RegisterClientScriptBlock(typeof(string), rnd.Next().ToString(), sb.ToString());
	}
}
