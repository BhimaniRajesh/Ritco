using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Data.SqlClient;


public partial class GUI_UNI_MIS_BILL_MR_Register_Query : System.Web.UI.Page
{
    public static string  dkt_Call, THC_Call;
    protected void Page_Load(object sender, EventArgs e)
    {
        dkt_Call = Session["DocketCalledAs"].ToString();

        if (documet_type.Items[0].Selected == true)
        {
            tbl_BILL.Style["display"] = "block";
            tbl_CHK_BILL.Style["display"] = "block";
            tbl_CHK_MR.Style["display"] = "none";
            tbl_MR.Style["display"] = "none";
        }
        else
        {
            tbl_BILL.Style["display"] = "none";
            tbl_CHK_BILL.Style["display"] = "none";
            tbl_CHK_MR.Style["display"] = "block";
            tbl_MR.Style["display"] = "block";
        }
        
        if (!IsPostBack)
        {
            //imgfrm.ImageUrl= "../../images/calendar.jpg";
            SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
            conn.Open();
            //LT_CUST_VEND.Items.Clear();
            //LT_CUST_VEND.Items.Add(new ListItem("All", "All"));
            string sqlstr = " select custcd , custnm+ ' : ' +custcd  from webx_custhdr with(NOLOCK) where cust_active='Y'   order  by custnm";
            //SqlCommand cmd = new SqlCommand(sqlstr, conn);
            //SqlDataReader dread = cmd.ExecuteReader();
            //while (dread.Read())
            //{
            //    LT_CUST_VEND.Items.Add(new ListItem(dread.GetValue(1).ToString(), dread.GetValue(0).ToString()));
            //}
            //LT_CUST_VEND.SelectedValue = "All";
            //dread.Close();

            
            MR_Type.Items.Clear();
            MR_Type.Items.Add(new ListItem("All", "All"));
            sqlstr = "select codeid,codedesc from  webx_master_general with(NOLOCK) where codetype= 'Mrstype'";
            // cmd = new SqlCommand(sqlstr, conn);
             //dread = cmd.ExecuteReader();
            SqlCommand cmd = new SqlCommand(sqlstr, conn);
            SqlDataReader dread = cmd.ExecuteReader();
            while (dread.Read())
            {
                MR_Type.Items.Add(new ListItem(dread.GetValue(1).ToString(), dread.GetValue(0).ToString()));
            }
            MR_Type.SelectedValue = "All";
            dread.Close();


            Bill_Type.Items.Clear();
            Bill_Type.Items.Add(new ListItem("All", "All"));
            sqlstr = "select codeid,codedesc from  webx_master_general with(NOLOCK) where codetype= 'BILLTYP'";
            cmd = new SqlCommand(sqlstr, conn);
            dread = cmd.ExecuteReader();
            while (dread.Read())
            {
                Bill_Type.Items.Add(new ListItem(dread.GetValue(1).ToString(), dread.GetValue(0).ToString()));
            }
            Bill_Type.SelectedValue = "All";
            dread.Close();

            CheckBoxList1.Items[1].Text =dkt_Call+ " No.";
            CheckBoxList1.Items[7].Text = dkt_Call + " Delivered"; 

            //txtasondt_to.Text = System.DateTime.Today.ToString("dd/MM/yyyy");
            //string Year = Session["FinYear"].ToString().Substring(2, 2);
            //txtasondt.Text = "31/03/20" + Year;
        }
    }
    protected void btnShow_Click(object sender, EventArgs e)
    {
        DropDownList cboRO = (DropDownList)Fromlc.FindControl("cboRO");
        DropDownList cboLO = (DropDownList)Fromlc.FindControl("cboLO");
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


        string st_ro = cboRO.SelectedValue.ToString();
        string st_lo = cboLO.SelectedValue.ToString();
        string rpt = documet_type.SelectedValue.ToString();
        string rmd = rptmd.SelectedValue.ToString();
        string st_cust_vend = "", st_cust_vend_name = "";
        string ASONDT = "", ASONDT_To="";
        //for (int i = 0; i < LT_CUST_VEND.Items.Count; i++)
        //{
        //    if (LT_CUST_VEND.Items[i].Selected == true)
        //    {
        //        if (st_cust_vend == "")
        //        {
        st_cust_vend = txtCustomer.Text.ToString();// LT_CUST_VEND.Items[i].Value.ToString();
        st_cust_vend_name = txtCustomer.Text.ToString();// LT_CUST_VEND.Items[i].Text.ToString();
        //        }
        //        else
        //        {
        //            st_cust_vend = st_cust_vend + "," + LT_CUST_VEND.Items[i].Value.ToString();
        //            st_cust_vend_name = st_cust_vend_name + "," + LT_CUST_VEND.Items[i].Text.ToString();
        //        }
        //    }
        //}

        string BM_TYP = "", BM_STATUS = "",OV_DYS="", BM_STATUS_str = "", CS_CHQ = "", AMT_G_THAN = "", BILLNO_list = "", MANBNOLIST = "", DKTSNOLIST = "";
        string DKTST = "", M_L_TYP = "", Select_list = "", Select_Text = "";
        string RTP_DT = DT_TYPE.SelectedValue.ToString();
        string RTP_DT_str = DT_TYPE.SelectedItem.ToString();

        if (rpt == "B")
        {
            BM_TYP = Bill_Type.SelectedItem.ToString();
            BM_STATUS = BILL_Status.SelectedValue.ToString();
            BM_STATUS_str = BILL_Status.SelectedItem.ToString();
            CS_CHQ = Bill_CL_Type.SelectedValue.ToString();
            AMT_G_THAN = BillAMT.Text.ToString();
            OV_DYS = Days.Text.ToString();
            BILLNO_list = txtbillno.Text.ToString();
            MANBNOLIST = txtMAnbillno.Text.ToString();
            DKTSNOLIST = txtDKTno.Text.ToString();
            M_L_TYP = Bill_List_Type.SelectedValue.ToString();

            

            foreach (ListItem li in CheckBoxList2.Items)
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
        }
        else if (rpt == "M")
        {
            BM_TYP = MR_Type.SelectedItem.ToString();
            BM_STATUS = MR_Status.SelectedValue.ToString();
            BM_STATUS_str = MR_Status.SelectedItem.ToString();
            CS_CHQ = MR_CL_Type.SelectedValue.ToString();
            AMT_G_THAN = MRSAMT.Text.ToString();
            //OV_DYS = Days.Text.ToString();
            BILLNO_list = txtMRno.Text.ToString();
           // MANBNOLIST = txtMAnbillno.Text.ToString();
            DKTSNOLIST = txtDKTno_MR.Text.ToString();
            DKTST = DKT_STATS.SelectedValue.ToString();
            M_L_TYP = MR_List_Type.SelectedValue.ToString();

           

            foreach (ListItem li in CheckBoxList1.Items)
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
        }

  
        string final;
        final = "?RO=" + st_ro;
        final += "&LO=" + st_lo;
        final += "&fromdt=" + dtFrom;
        final += "&todt=" + dtTo;
        final += "&RPT=" + rpt;        
        final += "&RMD=" + rmd;
        final += "&st_cust_vend=" + st_cust_vend;
        final += "&st_cust_vend_name=" + st_cust_vend_name;
        final += "&BM_TYP=" + BM_TYP;
        final += "&BM_STATUS=" + BM_STATUS;
        final += "&BM_STATUS_str=" + BM_STATUS_str;
        final += "&CS_CHQ=" + CS_CHQ;
        final += "&AMT_G_THAN=" + AMT_G_THAN;
        final += "&OV_DYS=" + OV_DYS;
        final += "&BILLNO_list=" + BILLNO_list;
        final += "&MANBNOLIST=" + MANBNOLIST;
        final += "&DKTSNOLIST=" + DKTSNOLIST;
        final += "&DKTST=" + DKTST;
        final += "&M_L_TYP=" + M_L_TYP;
        final += "&Select_list=" + Select_list;
        final += "&Select_Text=" + Select_Text;
        final += "&RTP_DT=" + RTP_DT;
        final += "&RTP_DT_str=" + RTP_DT_str;   
        final += "&ASONDT=" + ASONDT;
         final += "&ASONDT_To=" + ASONDT_To;
         final += "&TYPDET=1";
        
        Response.Redirect("Result.aspx" + final);

       


    }


    protected void documet_type_SelectedIndexChanged(object sender, EventArgs e)
    {
        string DOCTYP = documet_type.SelectedValue.ToString();

        if (DOCTYP == "B")
        {
            tbl_BILL.Visible = true;
            tbl_CHK_BILL.Visible = true;
            tbl_CHK_MR.Visible = false;
            tbl_MR.Visible = false;
        }
        if (DOCTYP == "M")
        {
            tbl_BILL.Visible = false;
            tbl_CHK_BILL.Visible = false;
            tbl_CHK_MR.Visible = true;
            tbl_MR.Visible = true;
        }


    }
}
