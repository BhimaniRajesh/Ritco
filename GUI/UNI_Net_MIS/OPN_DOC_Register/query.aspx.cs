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
using System.Collections.Generic;


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
            //documet_type.Items.Add(new ListItem("Select", "S"));
            documet_type.Items.Add(new ListItem(dkt_Call, "DKT"));
            //documet_type.Items.Add(new ListItem("Manifest", "MF"));
            //documet_type.Items.Add(new ListItem("Loading Sheet", "LS"));
            documet_type.Items.Add(new ListItem(THC_Call, "THC"));
            documet_type.Items.Add(new ListItem("PRS", "PRS"));
            documet_type.Items.Add(new ListItem("DRS", "DRS"));
            documet_type.SelectedValue = "DKT";
            
            dread.Close();
            sqlstr = "select 'All' as codedesc,'All' codedesc  union select codedesc,codedesc from webx_master_general where  codetype='BUT' and  statuscode='Y'";
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

           
            sqlstr = "select 'All' as codeid,'All' codedesc  union select codeid,codedesc from webx_master_general where  codetype='PAYTYP' and  statuscode='Y'";
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

            sqlstr = "select 'All' as codeid,'All' codedesc  union select codedesc,codeid from webx_master_general where codetype='TRN'";
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


            sqlstr = "select 'All' as codeid,'All' codedesc  union select codedesc,codeid from webx_master_general where codetype='SVCTYP'";
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
          

            sqlstr = "select 'All' as codeid,'All' codedesc  union select rutnm +' : ' +rutcd,rutcd from webx_rutmas with(NOLOCK) where activeflag='Y'";
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

              sqlstr = "select 'All' as codeid,'All' codedesc  union select vendorname +' : ' +vendorcode,vendorcode from webx_vendor_hdr where active='Y'";
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
                sqlstr = "select 'All' as codeid,'' codedesc  union select custnm +' : ' +custcd,custcd from webx_custhdr where cust_active='Y' and  custloc like '%" + brcd + "%'";
            }
            else
            {
                sqlstr = "select 'All' as codeid,'' codedesc  union select custnm +' : ' +custcd,custcd from webx_custhdr where cust_active='Y'  ";
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

   

    protected void btnShow_Click(object sender, EventArgs e)
    {
        string report_mode = "", st_doctyp = "", report_Subtype = "", report_type = "", st_Docnolist = "", St_Manualnolist = "", st_Vehnolist = "", st_Freetext = "", st_ro = "", st_lo = "", st_ro_to = "", st_lo_to = "";
        string fromdt = "", todt = "";
        string st_status_str = "";

        DropDownList cboRO = (DropDownList)Fromlc.FindControl("cboRO");
        DropDownList cboLO = (DropDownList)Fromlc.FindControl("cboLO");

        DropDownList cboRO_to = (DropDownList)Tolc.FindControl("cboRO");
        DropDownList cboLO_to = (DropDownList)Tolc.FindControl("cboLO");
 

        st_ro = cboRO.SelectedValue.ToString();
        if (cboRO.SelectedValue.ToString() == "")
        {
            st_ro = "All";
        }

        st_lo = cboLO.SelectedValue.ToString();
        if (cboLO.SelectedValue.ToString() == "")
        {
            st_lo = "All";
        }

        st_ro_to = cboRO_to.SelectedValue.ToString();
        if (cboRO_to.SelectedValue.ToString() == "")
        {
            st_ro_to = "All";
        }

        st_lo_to = cboLO_to.SelectedValue.ToString();
        if (cboLO_to.SelectedValue.ToString() == "")
        {
            st_lo_to = "All";
        }

        st_doctyp = documet_type.SelectedValue.ToString();

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


        string st_paybasis_str = "", st_trnmod_str = "", st_type_str = "";
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
            st_paybasis_str = DDLPaybas.SelectedItem.ToString();
            st_trnmod_str = DDLMode.SelectedItem.ToString();
            st_type_str = DDLType.SelectedItem.ToString();
            //st_custcd = custcd.Text.ToString();
            st_custcd = custcd.SelectedValue.ToString();
            st_status = DDStatus.SelectedValue.ToString();
            st_status_str = DDStatus.SelectedItem.ToString();

            int Npos1 = select_list.ToUpper().IndexOf("MR");
            int Npos2 = select_list.ToUpper().IndexOf("MR");
            int Npos3 = select_list.ToUpper().IndexOf("BILL");
            int Npos4 = select_list.ToUpper().IndexOf("BILL");
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
             st_trnmod_str = DDLROute.SelectedItem.ToString();
            st_custcd=DDLVendor_thc.SelectedValue.ToString();
            st_status = DDLStatus_thc.SelectedValue.ToString();
            st_status_str = DDLStatus_thc.SelectedItem.ToString();
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
        string BUSTYP_str = DDLBusTyp.SelectedItem.ToString();

        //string final;
        //final = "?RO=" + st_ro;
        //final += "&LO=" + st_lo;
        //final += "&RO_TO=" + st_ro_to;
        //final += "&LO_TO=" + st_lo_to;
        //final += "&DateType=" + report_mode;
        //final += "&fromdt=" + dtFrom;
        //final += "&todt=" + dtTo;
        //final += "&st_Docnolist=" + st_Docnolist;
        //final += "&select_list=" + select_list;
        //final += "&select_Text=" + select_Text;
        //final += "&st_paybasis=" + st_paybasis;
        //final += "&st_trnmod=" + st_trnmod;
        //final += "&st_type=" + st_type;
        //final += "&st_custcd=" + st_custcd;
        //final += "&st_status=" + st_status;
        //final += "&View_Sales=" + View_Sales;
        //final += "&BUSTYP=" + BUSTYP;
        //final += "&st_status_str=" + st_status_str;
        //final += "&st_paybasis_str=" + st_paybasis_str;
        //final += "&st_trnmod_str=" + st_trnmod_str;
        //final += "&st_type_str=" + st_type_str;
        //final += "&st_doctyp=" + st_doctyp;
        //final += "&DWN_XLS=" + DWN_XLS;
        //final += "&BUSTYP_str=" + BUSTYP_str;

        Guid g = Guid.NewGuid();
        Dictionary<string, string> listDet = new Dictionary<string, string>();

        listDet.Add("RO", st_ro);
        listDet.Add("LO", st_lo);
        listDet.Add("RO_TO", st_ro_to);
        listDet.Add("LO_TO", st_lo_to);
        listDet.Add("DateType", report_mode);
        listDet.Add("fromdt", dtFrom);
        listDet.Add("todt", dtTo);
        listDet.Add("st_Docnolist", st_Docnolist);
        listDet.Add("select_list", select_list);
        listDet.Add("select_Text", select_Text);
        listDet.Add("st_paybasis", st_paybasis);
        listDet.Add("st_trnmod", st_trnmod);
        listDet.Add("st_type", st_type);
        listDet.Add("st_custcd", st_custcd);
        listDet.Add("st_status", st_status);
        listDet.Add("View_Sales", View_Sales);
        listDet.Add("BUSTYP", BUSTYP);
        listDet.Add("st_status_str", st_status_str);
        listDet.Add("st_paybasis_str", st_paybasis_str);
        listDet.Add("st_trnmod_str", st_trnmod_str);
        listDet.Add("st_type_str", st_type_str);
        listDet.Add("st_doctyp", st_doctyp);
        listDet.Add("DWN_XLS", DWN_XLS);
        listDet.Add("BUSTYP_str", BUSTYP_str);
        Session[g.ToString()] = listDet;

        Response.Redirect("Result.aspx?GUID=" + g.ToString());

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

