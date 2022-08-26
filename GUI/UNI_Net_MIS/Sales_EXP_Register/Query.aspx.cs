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

public partial class GUI_UNI_Net_MIS_Sales_EXP_Register_Query : System.Web.UI.Page
{
    SqlConnection conn;
    public static int chgV = 0;
    protected void Page_Load(object sender, EventArgs e)
    {
        // documet_type.Items.Add(new ListItem("Docket", "DKT"));

        MySQLDataSource_GeneralMaster.ConnectionString = Session["SqlProvider"].ToString().Trim();
        MySQLDataSource_GeneralMaster1.ConnectionString = Session["SqlProvider"].ToString().Trim();
        MySQLDataSource_GeneralMaster2.ConnectionString = Session["SqlProvider"].ToString().Trim();
        MySQLDataSource_GeneralMaster3.ConnectionString = Session["SqlProvider"].ToString().Trim();
        MySQLDataSource_GeneralMaster4.ConnectionString = Session["SqlProvider"].ToString().Trim();
        MySQLDataSource_Route.ConnectionString = Session["SqlProvider"].ToString().Trim();
        MySQLDataSource_BKGCHARGES.ConnectionString = Session["SqlProvider"].ToString().Trim();
        MySQLDataSource_DLYCHARGES.ConnectionString = Session["SqlProvider"].ToString().Trim();

        conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

        conn.Open();
        if (!IsPostBack)
        {

            hdnRptId.Value = Request.QueryString["RPTID"].ToString(); // added by Manisha 22/5/2014



            cboMode.SelectedValue = "All";
            cboPaybas.SelectedValue = "All";
            cboType.SelectedValue = "All";
            cboBUTType.SelectedValue = "All";
            //DllVendTy.SelectedValue = "All";

            //string sqlstr = " select DOCNO,DOCNO_ID,DOC_Called_AS from [Webx_View_Track] where  title='O' and srno in (select reportid from Webx_Master_View_TracksAccess where HasAccess='Y' and Userid='" + Session["empcd"].ToString() + "') and activeflag='Y' order by title";

            //SqlCommand cmd1 = new SqlCommand("select DOCNO,DOCNO_ID,DOC_Called_AS from [Webx_View_Track] where  title='O' and srno in (select reportid from Webx_Master_View_TracksAccess where HasAccess='Y' and Userid='" + Session["empcd"].ToString() + "') and activeflag='Y' order by title", conn);
            // SqlCommand cmd1 = new SqlCommand("select DOCNO,DOCNO_ID,DOC_Called_AS from [Webx_View_Track] where  title='O' and srno in (select reportid from Webx_Master_View_TracksAccess where DOCNO_ID='DKT' and  HasAccess='Y' and Userid='" + Session["empcd"].ToString() + "') and activeflag='Y' order by title", conn);
            SqlCommand cmd1 = new SqlCommand("select DOCNO,DOCNO_ID,DOC_Called_AS from [Webx_View_Track] where  title='O' and  DOCNO_ID='DKT' ", conn);
            SqlDataReader dread1 = cmd1.ExecuteReader();
            Int32 i1 = 0;
            while (dread1.Read())
            {

                documet_type.Items.Add(new ListItem(dread1.GetValue(2).ToString(), dread1.GetValue(1).ToString()));

            }

            documet_type.SelectedValue = "DKT";

            documet_type.CssClass = "blackfnt";
            dread1.Close();

            //SqlCommand cmd = new SqlCommand("select  codeid,codedesc from Webx_Master_General where codetype='CHG' and statuscode='Y'", conn);
            //SqlDataReader dread = cmd.ExecuteReader();
            //Int32 i = 0;
            //while (dread.Read())
            //{
            //    string a;
            //    ChkAmtChrgDtl.Items.Add(Convert.ToString(dread["codedesc"]));
            //    ChkAmtChrgDtl.Items[i].Value = Convert.ToString(dread["codeid"]);
            //    i += 1;
            //}
            //chgV = i;
            //ChkAmtChrgDtl.CssClass = "blackfnt";
            //dread.Close();

            //string strSP = "EXEC  WebxNetGET_XMLString 'dockno,orgncd,destcd,reassign_destcd','webx_master_docket','Items','1=1','Sales Register',''";
            //SqlCommand cmd2 = new SqlCommand(strSP, conn);
            ////string STR_XML = cmd2.ExecuteScalar().ToString();


            //string strSP1 = "insert into Document(Description,DocumentStore) values('Sales Register','" + STR_XML + "')";
            //SqlCommand cmd3 = new SqlCommand(strSP, conn);
            // cmd3.ExecuteNonQuery().ToString();

        }

       conn.Close();

    }
    protected void btnDownload_Click(object sender, EventArgs e)
    {
        RedirectToResult(3);
    }
    protected void btnShow_Click(object sender, EventArgs e)
    {
        RedirectToResult(1);
    }
    private void RedirectToResult(int renderType)
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
        string select_list = "", select_Text = "";
        string selectView = "";
        foreach (ListItem li in CheckBoxList1.Items)
        {
            if (li.Selected == true)
            {
                if (select_list == "")
                    select_list = li.Value.ToString();
                else
                    select_list = select_list + "," + li.Value.ToString();

                //if (Insert_list == "")
                //    Insert_list = li.Value.ToString();
                //else
                //    Insert_list = select_list + "," + li.Value.ToString();


                if (select_Text == "")
                    select_Text = li.Text.ToString();
                else
                    select_Text = select_Text + "," + li.Text.ToString();
                selectView = " VWNet_Salse_Register";
            }
        }

        foreach (ListItem li in ChkAmtChrgDtl.Items)
        {
            if (li.Selected == true)
            {
                if (select_list == "")
                    select_list = li.Value.ToString();
                else
                    select_list = select_list + "," + li.Value.ToString();



                if (select_Text == "")
                    select_Text = li.Text.ToString();
                else
                    select_Text = select_Text + "," + li.Text.ToString();
                selectView = " VWNet_Salse_Register";
            }
        }

        foreach (ListItem li in ChkAmtChrgDt2.Items)
        {
            if (li.Selected == true)
            {
                if (select_list == "")
                    select_list = li.Value.ToString();
                else
                    select_list = select_list + "," + li.Value.ToString();



                if (select_Text == "")
                    select_Text = li.Text.ToString();
                else
                    select_Text = select_Text + "," + li.Text.ToString();
                selectView = " VWNet_Salse_Register";
            }
        }
        foreach (ListItem li in CheckBoxList3.Items)
        {
            if (li.Selected == true)
            {
                if (select_list == "")
                    select_list = li.Value.ToString();
                else
                    select_list = select_list + "," + li.Value.ToString();


                if (select_Text == "")
                    select_Text = li.Text.ToString();
                else
                    select_Text = select_Text + "," + li.Text.ToString();
                selectView = " VWNet_Salse_Register";
            }
        }

        foreach (ListItem li in CheckBoxList4.Items)
        {
            if (li.Selected == true)
            {
                if (select_list == "")
                    select_list = li.Value.ToString();
                else
                    select_list = select_list + "," + li.Value.ToString();


                if (select_Text == "")
                    select_Text = li.Text.ToString();
                else
                    select_Text = select_Text + "," + li.Text.ToString();
                selectView = " VWNet_Salse_Register_All";
            }
        }



        string st_paybasis = cboPaybas.SelectedValue.ToString();
        string st_trnmod = cboMode.SelectedValue.ToString();
        string st_type = cboType.SelectedValue.ToString();
        string st_busttype = cboBUTType.SelectedValue.ToString();

        string str_paybasis = cboPaybas.SelectedItem.ToString();
        string str_trnmod = cboMode.SelectedItem.ToString();
        string str_type = cboType.SelectedItem.ToString();
        string str_busttype = cboBUTType.SelectedItem.ToString();

        string st_custcd = txtCustomer.Text.ToString();// custcd.SelectedValue.ToString();
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

        string DTTYPE = DT_TYPE.SelectedValue.ToString();

        string final;

        if (MAxStr_VAL == "")
            MAxStr_VAL = "All";
        if (MAxStr_VAL_to == "")
            MAxStr_VAL_to = "All";
        if (MAxSTR_LV == "")
            MAxSTR_LV = "1";
        if (MAxSTR_LV_to == "")
            MAxSTR_LV_to = "1";
        string strcustcd = txtCustomer.Text.ToString();
        string DocketLsit = txtsysno.Text.ToString();
        string st_status = dllStatus.SelectedValue.ToString();
        string str_status = dllStatus.SelectedItem.ToString();

        final = "?select_list=" + select_list.Replace(" ", "").ToString();
        // final += "&select_Text=" + select_Text;
        final += "&selectView=" + selectView;
        final += "&st_paybasis=" + st_paybasis;
        final += "&st_trnmod=" + st_trnmod;
        final += "&st_type=" + st_type;
        final += "&st_busttype=" + st_busttype;
        final += "&str_paybasis=" + str_paybasis;
        final += "&str_trnmod=" + str_trnmod;
        final += "&str_type=" + str_type;
        final += "&str_busttype=" + str_busttype;
        final += "&dtFrom=" + dtFrom;
        final += "&dtTo=" + dtTo;
        final += "&MAxStr_VAL=" + MAxStr_VAL;
        final += "&MAxSTR_LV=" + MAxSTR_LV;
        final += "&MAxStr_VAL_to=" + MAxStr_VAL_to;
        final += "&MAxSTR_LV_to=" + MAxSTR_LV_to;
        final += "&DTTYPE=" + DTTYPE;
        final += "&strcustcd=" + strcustcd;
        final += "&DocketLsit=" + DocketLsit;
        final += "&st_status=" + st_status;
        final += "&str_status=" + str_status;

        final += "&hdnRptId=" + hdnRptId.Value.ToString(); // added by Manisha 23/5/2014
        final += "&RenderType=" + renderType;
        //Response.Redirect("Result.aspx" + final);

        System.Text.StringBuilder sb = new System.Text.StringBuilder();
        sb.Append("<");
        sb.Append("script language='javascript'>");
        sb.Append("window.open('./Result.aspx" + final + "', '_blank',");
        sb.Append("'top=0, left=0, width=900, height=700, scrollbars=yes, menubar=no,toolbar=no,status=1,resizable=yes');");
        sb.Append("<");
        sb.Append("/script>");

        Random rnd = new Random();
        rnd.Next();
        ClientScript.RegisterClientScriptBlock(typeof(string), rnd.Next().ToString(), sb.ToString());
    }
   
}
