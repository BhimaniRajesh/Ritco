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

public partial class GUI_admin_setting_cust_opn_bal_sel_brnch : System.Web.UI.Page
{
    public string custcode, vendorcode,custloc,vendorloc;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            string scr = @"<script>
                    function update1(elemValue1)
                  {
                        document.getElementById('ctl00_MyCPH1_txtCustCode').value=elemValue1;
                  }
                  </script>";

            Page.RegisterClientScriptBlock("update1", scr);
            //btnPopUp.Attributes.Add("onclick", "window.open('PopupCustomer.aspx?',null,'left=600, top=100, height=300, width= 400, status=n o, resizable= no, scrollbars= yes, toolbar= no,location= no, menubar= no');");
            btnPopUp.Attributes.Add("onclick", "javascript:return Cust_pop()");
            string scr1 = @"<script>
                    function update2(elemValue2)
                  {
                                        
                        document.getElementById('ctl00_MyCPH1_txtVendorCode').value=elemValue2;
                  }
                  </script>";

            Page.RegisterClientScriptBlock("update2", scr1);

            btnPopUp1.Attributes.Add("onclick", "javascript:return Vendor_pop()");
            // btnPopUp1.Attributes.Add("onclick", "window.open('PopupVendor.aspx',null,'left=600, top=100, height=300, width= 400, status=n o, resizable= no, scrollbars= yes, toolbar= no,location= no, menubar= no');");


            //            string scr2 = @"<script>
            //                    function update3(elemValue3)
            //                  {
            //                     document.getElementById('ctl00_MyCPH1_Txtcust_loccode').value=elemValue3;
            //                  }
            //                  </script>";

            //            Page.RegisterClientScriptBlock("update3", scr2);
            //            BTN_locpop.Attributes.Add("onclick", "window.open('../OpeningBalance/popupbranch.aspx',null,'left=600, top=100, height=300, width= 400, status=n o, resizable= no, scrollbars= yes, toolbar= no,location= no, menubar= no');");


            string scr3 = @"<script>
                    function update3(elemValue3)
                  {
                                        
                        document.getElementById('ctl00_MyCPH1_TXT_DRV_Code').value=elemValue3;
                  }
                  </script>";

            Page.RegisterClientScriptBlock("update3", scr3);

            Button1.Attributes.Add("onclick", "javascript:return DRV_pop()");

            string scr4 = @"<script>
                    function update4(elemValue4)
                  {
                                        
                        document.getElementById('ctl00_MyCPH1_Txt_Empcd').value=elemValue4;
                  }
                  </script>";

            Page.RegisterClientScriptBlock("update4", scr4);

            btnPopUp2.Attributes.Add("onclick", "javascript:return EMP_pop()");
            Button1.Attributes.Add("onclick", "javascript:return DRV_pop()");


            btnSubmit.Attributes.Add("onclick", "javascript:return fsubmit(" + txtCustCode.ClientID + "," + txtVendorCode.ClientID + "," + TXT_DRV_Code.ClientID + "," + Txt_Empcd.ClientID + "," + rd1.ClientID + "," + rd2.ClientID + "," + rd3.ClientID + "," + rd4.ClientID + ")");
            SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
            conn.Open();
            string sqlCustomer = "select  acccode,accdesc from webx_acctinfo where acccode in ('cda0001','cda0002') order by acccode";
            SqlCommand cmdCustomer = new SqlCommand(sqlCustomer, conn);
            SqlDataReader dr;
            dr = cmdCustomer.ExecuteReader();
            Dracccode.Items.Clear();
            //paybas.Items.Add("Select");
            // paybas.Items.Add(new ListItem("Select", ""));
            Dracccode.SelectedIndex = 0;
            Dracccode.CssClass = "blackfnt";
            while (dr.Read())
            {
                Dracccode.Items.Add(new ListItem(dr.GetValue(1).ToString(), dr.GetValue(0).ToString()));

            }

            dr.Close();

            string sqlVendortype = "select a.codeid+'~'+accthead+'~'+(select accdesc from webx_acctinfo where acccode=b.accthead) as val,a.codedesc from webx_master_general a ,webx_accthead b where a.codetype='VENDTY' and a.codeid=b.codeid and accthead is  not null";
            SqlCommand cmdVendor = new SqlCommand(sqlVendortype, conn);

            dr = cmdVendor.ExecuteReader();
            Dr_Vendortype.Items.Clear();
            //paybas.Items.Add("Select");
            Dr_Vendortype.Items.Add(new ListItem("Select", ""));
            Dr_Vendortype.SelectedIndex = 0;
            Dr_Vendortype.CssClass = "blackfnt";
            while (dr.Read())
            {
                Dr_Vendortype.Items.Add(new ListItem(dr.GetValue(1).ToString(), dr.GetValue(0).ToString()));

            }

            dr.Close();

            string sqlDriver = "select  acccode,accdesc from webx_acctinfo where acccode in ('ASS0637') order by acccode";
            SqlCommand cmdDriver = new SqlCommand(sqlDriver, conn);

            dr = cmdDriver.ExecuteReader();
            DLL_DRV_COde.Items.Clear();
            //paybas.Items.Add("Select");
            //DLL_DRV_COde.Items.Add(new ListItem("Select", ""));
            DLL_DRV_COde.SelectedIndex = 0;
            DLL_DRV_COde.CssClass = "blackfnt";
            while (dr.Read())
            {
                DLL_DRV_COde.Items.Add(new ListItem(dr.GetValue(1).ToString(), dr.GetValue(0).ToString()));

            }
            dr.Close();

            string sqlEmp = "select  acccode,accdesc from webx_acctinfo where acccode in ('ASS0024','ASS0025','ASS0123') order by accdesc";
            SqlCommand cmdEmp = new SqlCommand(sqlEmp, conn);

            dr = cmdEmp.ExecuteReader();
            DR_EMPLEdgerCOde.Items.Clear();
            //paybas.Items.Add("Select");
            //DLL_DRV_COde.Items.Add(new ListItem("Select", ""));
            DR_EMPLEdgerCOde.SelectedIndex = 0;
            DR_EMPLEdgerCOde.CssClass = "blackfnt";
            while (dr.Read())
            {
                DR_EMPLEdgerCOde.Items.Add(new ListItem(dr.GetValue(1).ToString(), dr.GetValue(0).ToString()));

            }
            dr.Close();
            //DR_EMPLEdgerCOde

            conn.Close();


        }
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        string SlectedTpe = "", Custaccount = "", CustaccountDesc = "", Vend_account = "", Vend_accountDesc="",vendor_type="";
        string Driver_Code = "", DRV_account = "", DRV_accountDesc = "", DRVloc = "";
        string Emp_Code = "", Emp_account = "", Emp_accountDesc = "", Emploc = "";
        if (rd1.Checked == true)
        {
            custcode = txtCustCode.Text;
            custloc = txtBranchCode.Text;
            SlectedTpe = "C";
            Custaccount = Dracccode.SelectedValue.ToString();
            CustaccountDesc = Dracccode.SelectedItem.Text.ToString();
        }
        else if (rd2.Checked == true)
        {
            vendorcode = txtVendorCode.Text;
            vendorloc = txtBranchCode1.Text;
            SlectedTpe = "V";
            string[] Vend_account_arr = Dr_Vendortype.SelectedValue.ToString().Split('~');
            vendor_type = Vend_account_arr[0].ToString();
            Vend_account=Vend_account_arr[1].ToString();
            Vend_accountDesc=Vend_account_arr[2].ToString();
        }
        else if (rd3.Checked == true)
        {
            Driver_Code = TXT_DRV_Code.Text;
           // Response.Write("<BR>Driver_Code" + Driver_Code);
            DRVloc = txtBranchCode2.Text;
            SlectedTpe = "D";
            DRV_account = DLL_DRV_COde.SelectedValue.ToString();
            DRV_accountDesc = DLL_DRV_COde.SelectedItem.Text.ToString();
        }
        else if (rd4.Checked == true)
        {

            Emp_Code = Txt_Empcd.Text;
           // Response.Write("<BR>Driver_Code" + Driver_Code);
            Emploc = txtBranchCode3.Text;
            SlectedTpe = "E";
            Emp_account = DR_EMPLEdgerCOde.SelectedValue.ToString();
            Emp_accountDesc = DR_EMPLEdgerCOde.SelectedItem.Text.ToString();
        }
        //string custcode = txtCustCode.Text;
        //string vendor = txtVendorCode.Text;

        //Response.Write("<BR>Driver_Code" + Driver_Code);
       // Response.End();
        string final = "?custcode=" + custcode;
        final += "&vendorcode=" + vendorcode;
        final += "&Driver_Code=" + Driver_Code;
        final += "&Emp_Code=" + Emp_Code;
        final += "&custloc=" + custloc;
        final += "&vendorloc=" + vendorloc;
        final += "&DRVloc=" + DRVloc;
        final += "&Emploc=" + Emploc;
        final += "&Custaccount=" + Custaccount;
        final += "&CustaccountDesc=" + CustaccountDesc;
        final += "&Vend_account=" + Vend_account;
        final += "&Vend_accountDesc=" + Vend_accountDesc;
        final += "&DRV_account=" + DRV_account;
        final += "&DRV_accountDesc=" + DRV_accountDesc;
        final += "&Emp_account=" + Emp_account;
        final += "&Emp_accountDesc=" + Emp_accountDesc;
        final += "&vendor_type=" + vendor_type;
        final += "&SlectedTpe=" + SlectedTpe;
        Response.Redirect("OPBalCust_step2.aspx" + final);
    }
}
