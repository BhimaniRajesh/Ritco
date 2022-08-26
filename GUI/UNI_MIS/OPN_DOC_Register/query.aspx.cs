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


public partial class GUI_UNI_MIS_OPN_DOC_Register_query : System.Web.UI.Page
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
            string sqlstr = "select loc_level from webx_location where loccode='" + brcd + "'";
            // Response.Write("<br>sqlstr : " + sqlstr);
            SqlCommand cmd = new SqlCommand(sqlstr, conn);
            SqlDataReader dread = cmd.ExecuteReader();

            dread.Read();
            loclevel = Convert.ToInt32(dread.GetValue(0).ToString());

            dread.Close();
            documet_type.Items.Add(new ListItem("Select", "S"));
            documet_type.Items.Add(new ListItem(dkt_Call, "DKT"));
            //documet_type.Items.Add(new ListItem("Manifest", "MF"));
            //documet_type.Items.Add(new ListItem("Loading Sheet", "LS"));
            documet_type.Items.Add(new ListItem(THC_Call, "THC"));
            documet_type.Items.Add(new ListItem("PRS", "PRS"));
            documet_type.Items.Add(new ListItem("DRS", "DRS"));
            documet_type.SelectedValue = "S";
            cboRO_Lo.Items.Clear();
            //cboRO_Lo_TO.Items.Clear();
            cboRO.Items.Clear();
            //cboRO_TO.Items.Clear();
            if (loclevel < 3)
            {

                sqlstr = "select 'All' as loccode,'All'  as locname from webx_location  union select loccode,loccode + ' : '+ locname from webx_location where LOC_LEVEL='2' or loccode in (select loccode from webx_location where loc_level='1') order by locname";

                if (loclevel == 2)
                {
                    sqlstr = " select loccode,loccode + ' : '+ locname from webx_location where loccode='" + brcd + "' order by locname";
                }
                else
                {
                    cboRO_Lo.Items.Add(new ListItem("All", "All"));

                }
                cboRO_Lo_TO.Items.Add(new ListItem("All", "All"));
            }
            else
            {
                sqlstr = "select loccode,loccode + ' : '+ locname from webx_location where  loccode='" + brcd + "'";


                ROWLO.Style["display"] = "none";
            }
            cmd = new SqlCommand(sqlstr, conn);
            dread = cmd.ExecuteReader();
            {

                while (dread.Read())
                {
                    if (loclevel < 3)
                    {
                        cboRO.Items.Add(new ListItem(dread.GetValue(1).ToString(), dread.GetValue(0).ToString()));

                    }
                    else
                    {
                        cboRO_Lo.Items.Add(new ListItem(dread.GetValue(1).ToString(), dread.GetValue(0).ToString()));
                    }



                }

            }
            cboRO.SelectedValue = "All";

            dread.Close();
            sqlstr = "select 'All' as codedesc,'All' codedesc from webx_master_general union select codedesc,codedesc from webx_master_general where  codetype='BUT' and  statuscode='Y'";
            cmd = new SqlCommand(sqlstr, conn);
            dread = cmd.ExecuteReader();
            {

                while (dread.Read())
                {
                    DDLBusTyp.Items.Add(new ListItem(dread.GetValue(1).ToString(), dread.GetValue(0).ToString()));
                }

            }
            dread.Close();
            DDLBusTyp.SelectedValue = "All";

            sqlstr = " select 'All' as loccode,'All' as locname  from webx_location  union  select loccode,loccode + ' : '+ locname from webx_location where LOC_LEVEL='2' or loccode in (select loccode from webx_location where loc_level='1') order by locname";

            cmd = new SqlCommand(sqlstr, conn);
            SqlDataReader dread12 = cmd.ExecuteReader();
            {

                while (dread12.Read())
                {

                    cboRO_Lo_TO.Items.Add(new ListItem(dread12.GetValue(1).ToString(), dread12.GetValue(0).ToString()));
                    cboRO_Lo_TO.SelectedValue = "All";
                }

            }
            dread12.Close();



            string sqlstr13 = " select 'All' as loccode,'All' as locname  from webx_location  union  select loccode,loccode + ' : '+ locname from webx_location where LOC_LEVEL='2' or loccode in (select loccode from webx_location where loc_level='1') order by locname";

            cmd = new SqlCommand(sqlstr13, conn);
            SqlDataReader dread13 = cmd.ExecuteReader();
            {

                while (dread13.Read())
                {

                    cboRO_TO.Items.Add(new ListItem(dread13.GetValue(1).ToString(), dread13.GetValue(0).ToString()));
                    cboRO_TO.SelectedValue = "All";
                }

            }
            dread13.Close();

            if (loclevel == 2)
            {

                string sqlstr14 = " select 'All' as loccode,'All' as locname  from webx_location  union  select loccode,loccode + ' : '+ locname from webx_location where  report_loc='" + brcd + "'";

                SqlCommand cmd1 = new SqlCommand(sqlstr14, conn);
                SqlDataReader dread14 = cmd1.ExecuteReader();
                {

                    while (dread14.Read())
                    {

                        cboRO_Lo.Items.Add(new ListItem(dread14.GetValue(1).ToString(), dread14.GetValue(0).ToString()));
                        cboRO_Lo.SelectedValue = "All";
                    }

                }
                dread14.Close();
            }

            sqlstr = "select 'All' as codeid,'All' codedesc from webx_master_general union select codeid,codedesc from webx_master_general where  codetype='PAYTYP' and  statuscode='Y'";
            cmd = new SqlCommand(sqlstr, conn);
            dread = cmd.ExecuteReader();
            {

                while (dread.Read())
                {
                    DDLPaybas.Items.Add(new ListItem(dread.GetValue(1).ToString(), dread.GetValue(0).ToString()));
                }

            }
            dread.Close();
            DDLPaybas.SelectedValue = "All";

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


            sqlstr = "select 'All' as codeid,'All' codedesc from webx_master_general union select codedesc,codeid from webx_master_general where codetype='SVCTYP'";
            cmd = new SqlCommand(sqlstr, conn);
            dread = cmd.ExecuteReader();
            {

                while (dread.Read())
                {
                    DDLType.Items.Add(new ListItem(dread.GetValue(0).ToString(), dread.GetValue(1).ToString()));
                }

            }
            dread.Close();

            //(codeid + ' as '+ replace((replace((replace(codedesc,' ','')),'-','_')),'/','_'))as
            cmd = new SqlCommand("select  codeid,codedesc from Webx_Master_General where codetype='CHG' and statuscode='Y'", conn);
            dread = cmd.ExecuteReader();
            Int32 i = 0;
            while (dread.Read())
            {
                string a;
                ChkAmtChrgDtl.Items.Add(Convert.ToString(dread["codedesc"]));
                ChkAmtChrgDtl.Items[i].Value = Convert.ToString(dread["codeid"]);
                i += 1;
            }
            chgV = i;
            ChkAmtChrgDtl.CssClass = "blackfnt";
            dread.Close();

            DDLType.SelectedValue = "All";
          

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

              sqlstr = "select 'All' as codeid,'All' codedesc from webx_vendor_hdr union select vendorname +' : ' +vendorcode,vendorcode from webx_vendor_hdr where active='Y'";
              cmd = new SqlCommand(sqlstr, conn);
              dread = cmd.ExecuteReader();
              {

                  while (dread.Read())
                  {
                      DDLVendor_thc.Items.Add(new ListItem(dread.GetValue(0).ToString(), dread.GetValue(1).ToString()));
                      DDLVendor_PRS.Items.Add(new ListItem(dread.GetValue(0).ToString(), dread.GetValue(1).ToString()));

                  }

              }
              dread.Close();

              DDLVendor_thc.SelectedValue = "All";
              DDLVendor_PRS.SelectedValue = "All";
            if(loclevel>2)
            {
                sqlstr = "select 'All' as codeid,'' codedesc from webx_custhdr union select custnm +' : ' +custcd,custcd from webx_custhdr where cust_active='Y' and  custloc like '%" + brcd + "%'";
            }
            else
            {
                sqlstr = "select 'All' as codeid,'' codedesc from webx_custhdr union select custnm +' : ' +custcd,custcd from webx_custhdr where cust_active='Y'  ";
            }
              cmd = new SqlCommand(sqlstr, conn);
              dread = cmd.ExecuteReader();
              {

                  while (dread.Read())
                  {
                      custcd.Items.Add(new ListItem(dread.GetValue(0).ToString(), dread.GetValue(1).ToString()));
                      

                  }

              }
              dread.Close();
              custcd.SelectedValue = "All";
              custcd.SelectedValue = "";
        }
        conn.Close();

    }

    protected void cboRO_SelectedIndexChanged_TO(object sender, EventArgs e)
    {


        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();

        String sqlstr = "";

        if (loclevel <= 2)
        {
            sqlstr = "select 'All' as loccode,'All'  as locname  union select loccode,loccode + ' : '+ locname from webx_location where report_loc='" + cboRO_TO.SelectedValue.ToString() + "' or loccode='" + cboRO.SelectedValue.ToString() + "' ";
        }
        else
        {
            sqlstr = "select loccode,loccode + ' : '+ locname from webx_location where  loccode='" + brcd + "'";
        }

        //String sqlstr = "select loccode,loccode + ' : '+ locname from webx_location where report_loc='" + cboRO_TO.SelectedValue.ToString() + "'";
        SqlCommand cmd = new SqlCommand(sqlstr, conn);
        SqlDataReader dread = cmd.ExecuteReader();
        cboRO_Lo_TO.Items.Clear();
        {

            while (dread.Read())
            {
                cboRO_Lo_TO.Items.Add(new ListItem(dread.GetValue(1).ToString(), dread.GetValue(0).ToString()));
                //cboRO_Lo_TO.SelectedValue = "All";     
            }

        }
        dread.Close();


        


        conn.Close();
    }

    protected void cboRO_SelectedIndexChanged(object sender, EventArgs e)
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();



        String sqlstr = "";

        if (loclevel <= 2)
        {
            sqlstr = "select 'All' as loccode,'All'  as locname  union select loccode,loccode + ' : '+ locname from webx_location where report_loc='" + cboRO.SelectedValue.ToString() + "' or loccode='" + cboRO.SelectedValue.ToString() + "'";
        }
        else
        {
            sqlstr = " select loccode,loccode + ' : '+ locname from webx_location where  loccode='" + brcd + "'";
        }

        SqlCommand cmd = new SqlCommand(sqlstr, conn);
        SqlDataReader dread = cmd.ExecuteReader();
        cboRO_Lo.Items.Clear();
        {

            while (dread.Read())
            {
                cboRO_Lo.Items.Add(new ListItem(dread.GetValue(1).ToString(), dread.GetValue(0).ToString()));
                //cboRO_Lo.SelectedValue = "All";      
            }

        }
        dread.Close();
        conn.Close();
    }


    protected void btnShow_Click(object sender, EventArgs e)
    {
        string report_mode = "", st_doctyp = "", report_Subtype = "", report_type = "", st_Docnolist = "", St_Manualnolist = "", st_Vehnolist = "", st_Freetext = "", st_ro = "", st_lo = "", st_ro_to = "", st_lo_to = "";
        string fromdt = "", todt = "";


 

        st_ro = cboRO.SelectedValue.ToString();
        if (cboRO.SelectedValue.ToString() == "")
        {
            st_ro = "All";
        }

        st_lo = cboRO_Lo.SelectedValue.ToString();
        if (cboRO_Lo.SelectedValue.ToString() == "")
        {
            st_lo = "All";
        }

        st_ro_to = cboRO_TO.SelectedValue.ToString();
        if (cboRO_TO.SelectedValue.ToString() == "")
        {
            st_ro_to = "All";
        }

        st_lo_to = cboRO_Lo_TO.SelectedValue.ToString();
        if (cboRO_Lo_TO.SelectedValue.ToString() == "")
        {
            st_lo_to = "All";
        }

        st_doctyp = documet_type.SelectedValue.ToString();

        fromdt = txtDateFrom.Text.ToString();
        todt = txtDateTo.Text.ToString();



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


        st_Docnolist = txtsysno.Text.ToString();
        //St_Manualnolist = txtmanbo.Text.ToString();
        //st_Vehnolist = txtCustRefno.Text.ToString();
        //st_Freetext = txtFreeText.Text.ToString();
        string select_list = "", select_Text = "",Insert_list="";
        string st_paybasis = "", st_trnmod = "", View_Sales = "", st_custcd = "", st_type = "", st_status = "";

        if (documet_type.SelectedValue.ToString().ToUpper() == "DKT")
        {

            foreach (ListItem li in CheckBoxList1.Items)
            {
                if (li.Selected == true)
                {
                    if (select_list == "")
                        select_list = li.Value.ToString();
                    else
                        select_list = select_list + "," + li.Value.ToString();

                    if (Insert_list == "")
                        Insert_list = li.Value.ToString();
                    else
                        Insert_list = select_list + "," + li.Value.ToString();
                    

                    if (select_Text == "")
                        select_Text = li.Text.ToString();
                    else
                        select_Text = select_Text + "," + li.Text.ToString();

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

                }
            }

            st_paybasis = DDLPaybas.SelectedValue.ToString();
            st_trnmod = DDLMode.SelectedValue.ToString();
            st_type=DDLType.SelectedValue.ToString();
            //st_custcd = custcd.Text.ToString();
            st_custcd = custcd.SelectedValue.ToString();
            st_status = DDStatus.SelectedValue.ToString();


            int Npos1 = select_list.IndexOf("MRSNo");
            int Npos2 = select_list.IndexOf("MRSDate");
            int Npos3 = select_list.IndexOf("BillNo");
            int Npos4 = select_list.IndexOf("Bill_Date");
            Response.Write("<br> abNpos1cd : " + Npos1);
            //Response.End;
            if (Npos1 == 0 && Npos2 == 0 && Npos3 == 0 && Npos4 == 0)
            {
                View_Sales = "vw_Docket_Sales_register";
            }
            else
            {
                if (Npos1 > 0 && Npos2 > 0 && Npos3 > 0 && Npos4 > 0)
                {
                    View_Sales = "vw_Docket_Sales_register_All";
                }
                else if (Npos1 > 0 || Npos2 > 0)
                {
                    View_Sales = "vw_Docket_Sales_register_MR";
                }
                else if (Npos1 > 0)
                {
                    View_Sales = "vw_Docket_Sales_register_MR";
                }
                else if (Npos2 > 0)
                {
                    View_Sales = "vw_Docket_Sales_register_MR";
                }
                else if (Npos3 > 0 || Npos4 > 0)
                {
                    View_Sales = "vw_Docket_Sales_register_BIll";
                }
                else if (Npos3 > 0)
                {
                    View_Sales = "vw_Docket_Sales_register_BIll";
                }
                else if (Npos4 > 0)
                {
                    View_Sales = "vw_Docket_Sales_register_BIll";
                }
                else
                {
                    View_Sales = "vw_Docket_Sales_register";
                }
            }
        }
        else if (documet_type.SelectedValue.ToString().ToUpper() == "THC")
        {
            st_trnmod = DDLROute.SelectedValue.ToString();
            st_custcd=DDLVendor_thc.SelectedValue.ToString();
            st_status = DDLStatus_thc.SelectedValue.ToString();

            foreach (ListItem li in THCCHKLIST1.Items)
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

                }
            }

            foreach (ListItem li in THCCHKLIST2.Items)
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

                }
            }

            foreach (ListItem li in THCCHKLIST3.Items)
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

                }
            }

            foreach (ListItem li in THCCHKLIST4.Items)
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

                }
            }

            foreach (ListItem li in THCCHKLIST5.Items)
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

                }
            }
        }
        else if (documet_type.SelectedValue.ToString().ToUpper() == "PRS")
        {
            st_custcd =DDLVendor_PRS.SelectedValue.ToString();


            foreach (ListItem li in PRSCHKLIST1.Items)
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

                }
            }

            foreach (ListItem li in PRSCHKLIST2.Items)
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

                }
            }

            foreach (ListItem li in PRSCHKLIST3.Items)
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

                }
            }

            foreach (ListItem li in PRSCHKLIST4.Items)
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

                }
            }

            foreach (ListItem li in PRSCHKLIST5.Items)
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

                }
            }
        }
        else if (documet_type.SelectedValue.ToString().ToUpper() == "DRS")
        {
            st_custcd = DDLVendor_PRS.SelectedValue.ToString();

            foreach (ListItem li in DRSCHKLIST1.Items)
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

                }
            }

            foreach (ListItem li in DRSCHKLIST2.Items)
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

                }
            }

            foreach (ListItem li in DRSCHKLIST3.Items)
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

                }
            }

            foreach (ListItem li in DRSCHKLIST4.Items)
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

                }
            }

            foreach (ListItem li in DRSCHKLIST5.Items)
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

                }
            }

            foreach (ListItem li in DRSCHKLIST6.Items)
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

                }
            }
        }

        string DWN_XLS = "";
        if (rptfrt.Items[0].Selected)
        {
            DWN_XLS = "0";
        }
        else if (rptfrt.Items[1].Selected)
        {
            DWN_XLS = "1";
        }
        else if (rptfrt.Items[2].Selected)
        {
            DWN_XLS = "2";
        }

        string BUSTYP = DDLBusTyp.SelectedValue.ToString();
        string final;
        final = "?RO=" + st_ro;
        final += "&LO=" + st_lo;
        final += "&RO_TO=" + st_ro_to;
        final += "&LO_TO=" + st_lo_to;
        final += "&DateType=" + report_mode;
        final += "&fromdt=" + fromdt;
        final += "&todt=" + todt;
        final += "&st_Docnolist=" + st_Docnolist;
        final += "&select_list=" + select_list;
        final += "&select_Text=" + select_Text;
        final += "&st_paybasis=" + st_paybasis;
        final += "&st_trnmod=" + st_trnmod;
        final += "&st_type=" + st_type;
        final += "&st_custcd=" + st_custcd;
        final += "&st_status=" + st_status;
        final += "&View_Sales=" + View_Sales;
        final += "&BUSTYP=" + BUSTYP;
        //final += "&st_Freetext=" + st_Freetext;
        //final += "&St_Manualnolist=" + St_Manualnolist;
        //final += "&st_Vehnolist=" + st_Vehnolist;
        //final += "&st_Freetext=" + st_Freetext;
        final += "&st_doctyp=" + st_doctyp;
        final += "&DWN_XLS=" + DWN_XLS;
        Response.Redirect("Result.aspx" + final);

    }

    protected void documet_type_SelectedIndexChanged(object sender, EventArgs e)
    {
        string DOCTYP = documet_type.SelectedValue.ToString();

        if (DOCTYP == "DKT")
        {
            tbl_dkt.Visible = true;
            tbl_CHKdkt.Visible = true;
           
            tbl_thcchk.Visible = false;
            tbl_DRSchk.Visible = false;
            tbl_PRSchk.Visible = false;
            tbl_prs.Visible = false;
            tbl_thc.Visible = false;
        }
        if (DOCTYP == "PRS")
        {
            tbl_dkt.Visible = false;
            tbl_CHKdkt.Visible = false;
             tbl_thcchk.Visible = false;
             tbl_DRSchk.Visible = false;
             tbl_PRSchk.Visible = true;
            tbl_prs.Visible = true;
            tbl_thc.Visible = false;
        }
        if (DOCTYP == "DRS")
        {
            tbl_dkt.Visible = false;
            tbl_CHKdkt.Visible = false;
            tbl_thcchk.Visible = false;
            tbl_PRSchk.Visible = false;
            tbl_DRSchk.Visible = true;
            tbl_prs.Visible = true;
            tbl_thc.Visible = false;
        }
         if (DOCTYP == "THC")
        {
            tbl_dkt.Visible = false;
            tbl_CHKdkt.Visible = false;
             tbl_thcchk.Visible = true;
             tbl_PRSchk.Visible = false;
             tbl_DRSchk.Visible = false;
             tbl_prs.Visible = false;
             tbl_thc.Visible = true;
        }
    }
}

