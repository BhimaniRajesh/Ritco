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

public partial class SFM_ProspectRegStateSub : System.Web.UI.Page
{
    public static SqlConnection conn;
    SqlCommand cmd = new SqlCommand();
    public string strrightnow;
    System.DateTime righnow = System.DateTime.Today;
    protected void Page_Load(object sender, EventArgs e)
    {
        conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        strrightnow = righnow.ToString("dd/MM/yyyy");

        string scr = @"<script>
                    function update(elemValue,elemValue1,elemValue2,elemValue3,elemValue4)
                  {
                     document.getElementById('ctl00_MyCPH1_txtCompanyName').value=elemValue;
                     document.getElementById('ctl00_MyCPH1_txtEmpId').value=elemValue1;
                     //document.getElementById('ctl00_MyCPH1_cboIndustry').value=elemValue2;

                     addItem(document.getElementById('ctl00_MyCPH1_cboIndustry'),elemValue2);

                     addItemAcc(document.getElementById('ctl00_MyCPH1_cboAccCategory'),elemValue3);

                     addItemStatus(document.getElementById('ctl00_MyCPH1_cboApproval'),elemValue4);
                  }
                    function addItem(ctrl,txt)
                    {
                    var oOption = document.createElement('OPTION');
                    oOption.text=txt;
                    
                    ctrl.add(oOption);
                    }

                    function addItemAcc(ctrl,txt)
                    {
                    var oOption = document.createElement('OPTION');
                    oOption.text=txt;
                    
                    ctrl.add(oOption);
                    }

                    function addItemStatus(ctrl,txt)
                    {
                    var oOption = document.createElement('OPTION');
                    oOption.text = txt
                        if(oOption.text == 'S')
                            {
                            oOption.text = 'Submmited';
                            }
                        else if(oOption.text == 'U')
                            {
                            oOption.text = 'Un-Submmited';
                            }
                        else if(oOption.text == 'R')
                            {
                            oOption.text = 'Rejected';
                            }
                        else if(oOption.text == 'A')
                            {
                            oOption.text = 'Approved';
                            }
                    //oOption.text=txt;
                    
                    ctrl.add(oOption);
                    }


                  </script>";

        Page.RegisterClientScriptBlock("update", scr);
        btnCompany.Attributes.Add("onclick", "window.open('TDS_Cust_Popup.aspx',null,'left=600, top=100, height=300, width= 300, status=n o, resizable= no, scrollbars= yes, toolbar= no,location= no, menubar= no');");

        if (!IsPostBack)
        {
            conn.Open();
            
        }
        
    }

    protected void Button3_Click(object sender, EventArgs e)
    {
        //string final = "?strFromDt=" + txtDateFrom.Text;
        //final = final + "&strToDt=" + txtDateTo.Text;
        //final = final + "&strFromDt1=" + txtDateFrom1.Text;
        //final = final + "&strToDt1=" + txtDateTo1.Text;
        string final =  "?strCompanyName=" + txtCompanyName.Text;
        final = final + "&strEmpId=" + txtEmpId.Text;
        final = final + "&strIndustry=" + cboIndustry.SelectedValue.ToString();
        final = final + "&strAccCategory=" + cboAccCategory.SelectedValue.ToString();
        final = final + "&strApproval=" + cboApproval.SelectedValue.ToString();
        
        Response.Redirect("ProspectRegStateSub2.aspx" + final);
    }

    //protected void rb1_CheckedChanged(object sender, EventArgs e)
    //{
    //    txtDateFrom1.Text = "";
    //    txtDateTo1.Text = "";
    //}
    //protected void rb2_CheckedChanged(object sender, EventArgs e)
    //{
    //    if (rb2.Checked==true)
    //    {
    //        string today = righnow.ToString("dd/MM/yyyy");
    //        righnow = righnow.AddDays(-7);
    //        strrightnow = righnow.ToString("dd/MM/yyyy");
    //        txtDateFrom.Text = righnow.ToString("dd/MM/yyyy");
    //        txtDateTo.Text = today;

    //        txtDateFrom1.Text = "";
    //        txtDateTo1.Text = "";

    //        txtDateFrom.ReadOnly = false;
    //        txtDateTo.ReadOnly = false;
    //    }
    //}
    //protected void rb3_CheckedChanged(object sender, EventArgs e)
    //{
    //    if (rb3.Checked == true)
    //    {
    //        strrightnow = righnow.ToString("dd/MM/yyyy");
    //        txtDateFrom.Text = strrightnow;
    //        txtDateTo.Text = strrightnow;

    //        txtDateFrom1.Text = "";
    //        txtDateTo1.Text = "";

    //        txtDateFrom.ReadOnly = false;
    //        txtDateTo.ReadOnly = false;
    //    }
    //}
    //protected void rb4_CheckedChanged(object sender, EventArgs e)
    //{
    //    if (rb4.Checked == true)
    //    {
    //        strrightnow = "01/01/2005";
    //        txtDateFrom.Text = strrightnow;
    //        txtDateTo.Text = righnow.ToString("dd/MM/yyyy");

    //        txtDateFrom1.Text = "";
    //        txtDateTo1.Text = "";

    //        txtDateFrom.ReadOnly = false;
    //        txtDateTo.ReadOnly = false;
    //    }
    //}
    //protected void rb5_CheckedChanged(object sender, EventArgs e)
    //{
    //    if (rb5.Checked == true)
    //    {
    //        txtDateFrom.Text = "";
    //        txtDateTo.Text = "";
    //    }
        
    //}
    //protected void rb6_CheckedChanged(object sender, EventArgs e)
    //{
    //    if (rb6.Checked == true)
    //    {
    //        txtDateFrom.Text = "";
    //        txtDateTo.Text = "";

    //        string today = righnow.ToString("dd/MM/yyyy");
    //        righnow = righnow.AddDays(-7);
    //        strrightnow = righnow.ToString("dd/MM/yyyy");
    //        txtDateFrom1.Text = righnow.ToString("dd/MM/yyyy");
    //        txtDateTo1.Text = today;

    //        txtDateFrom1.ReadOnly = false;
    //        txtDateTo1.ReadOnly = false;
    //    }
    //}
    //protected void rb7_CheckedChanged(object sender, EventArgs e)
    //{
    //    if (rb7.Checked == true)
    //    {
    //        txtDateFrom.Text = "";
    //        txtDateTo.Text = "";

    //        strrightnow = righnow.ToString("dd/MM/yyyy");
    //        txtDateFrom1.Text = strrightnow;
    //        txtDateTo1.Text = strrightnow;

    //        txtDateFrom1.ReadOnly = false;
    //        txtDateTo1.ReadOnly = false;
    //    }
    //}
    //protected void rb8_CheckedChanged(object sender, EventArgs e)
    //{
    //    if (rb8.Checked == true)
    //    {
    //        txtDateFrom.Text = "";
    //        txtDateTo.Text = "";

    //        strrightnow = "01/01/2005";
    //        txtDateFrom1.Text = strrightnow;
    //        txtDateTo1.Text = righnow.ToString("dd/MM/yyyy");

    //        txtDateFrom1.ReadOnly = false;
    //        txtDateTo1.ReadOnly = false;
    //    }
    //}
  
}
