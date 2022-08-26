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

public partial class GUI_UNI_MIS_Login_View_Login_view : System.Web.UI.Page
{

    public byte byteRadButtonSelection;


    protected void Page_Load(object sender, EventArgs e)
    {
        string scr = @"<script>
        function update(elemValue)
        {        
            document.getElementById('ctl00_MyCPH1_txtloc').value=elemValue;        
        }
        </script>";

        Page.RegisterClientScriptBlock("update", scr);
        btnSubLoc.Attributes.Add("onclick", "window.open('TDS_Cust_Popup.aspx',null,'left=600, top=100, height=300, width= 450, status=no, resizable= no, scrollbars= yes, toolbar= no,location= no, menubar= no');");


        string scr1 = @"<script>
        function update1(elemValue)
        {        
            document.getElementById('ctl00_MyCPH1_txtemp').value=elemValue;        
        }
        </script>";

        Page.RegisterClientScriptBlock("update1", scr1);
        btnColLoc.Attributes.Add("onclick", "window.open('TDS_Cust_Popup12.aspx',null,'left=600, top=100, height=300, width= 450, status=no, resizable= no, scrollbars= yes, toolbar= no,location= no, menubar= no');");

        if (!IsPostBack)
        {
         
            txtDateFrom.Text = System.DateTime.Today.ToString("dd/MM/yyyy");
            txtDateTo.Text = txtDateFrom.Text;
            rdtreptype.SelectedIndex = 0;
         
        }

    }
    protected void ddlro_SelectedIndexChanged(object sender, EventArgs e)
    {

    }
    protected void ddlloc_SelectedIndexChanged(object sender, EventArgs e)
    {

    }
    protected void radDate_SelectedIndexChanged(object sender, EventArgs e)
    {
        RadioButtonList rbl = new RadioButtonList();
        rbl = (RadioButtonList)sender;

        byteRadButtonSelection = Convert.ToByte(rbl.SelectedItem.Value);

        if (rbl.Items[0].Selected)
        {
            txtDateFrom.ReadOnly = false;
            txtDateTo.ReadOnly = false;
        }
        else
        {
            txtDateFrom.ReadOnly = true;
            txtDateTo.ReadOnly = true;
        }

        if (rbl.Items[1].Selected)
        {
            txtDateFrom.ReadOnly = true;
            txtDateTo.ReadOnly = true;
            txtDateFrom.Text = System.DateTime.Today.AddDays(-7).ToString("dd/MM/yyyy");
            txtDateTo.Text = System.DateTime.Today.ToString("dd/MM/yyyy");
        }
        else if (rbl.Items[2].Selected)
        {
            txtDateFrom.ReadOnly = true;
            txtDateTo.ReadOnly = true;
            txtDateFrom.Text = System.DateTime.Now.ToString("dd/MM/yyyy");
            txtDateTo.Text = txtDateFrom.Text;
        }
        
    }

    public void daterange(object source, ServerValidateEventArgs value)
    {

        string[] strDtFrom = txtDateFrom.Text.Split('/');
        DateTime dt1 = new DateTime(Convert.ToInt16(strDtFrom[2]), Convert.ToInt16(strDtFrom[1]), Convert.ToInt16(strDtFrom[0]));
        string[] strDtTo = txtDateTo.Text.Split('/');
        DateTime dt2 = new DateTime(Convert.ToInt16(strDtTo[2]), Convert.ToInt16(strDtTo[1]), Convert.ToInt16(strDtTo[0]));

        System.TimeSpan diffResult = dt2.Subtract(dt1);
        if (diffResult.Days > 31)
        {
            value.IsValid = false;
        }

        else if (dt1 > dt2)
        {
            value.IsValid = false;
            CustomValidator1.ErrorMessage = "From Date Can not Be Greter Than To Date.";
        }
        else
        {
            value.IsValid = true;

        }
    }


    


    protected void Button3_Click(object sender, EventArgs e)
    {
        if (Page.IsValid == true)
        {

            string[] strArrDtFrom = txtDateFrom.Text.Split('/');
            string[] strArrDtTo = txtDateTo.Text.Split('/');

            DateTime dtFrom = Convert.ToDateTime(strArrDtFrom[1] + "/" + strArrDtFrom[0] + "/" + strArrDtFrom[2]);
            DateTime dtTo = Convert.ToDateTime(strArrDtTo[1] + "/" + strArrDtTo[0] + "/" + strArrDtTo[2]);

            string strDate = Convert.ToDateTime(strArrDtFrom[1] + "/" + strArrDtFrom[0] + "/" + strArrDtFrom[2]).ToString("dd MMM yy") + " - " + Convert.ToDateTime(strArrDtTo[1] + "/" + strArrDtTo[0] + "/" + strArrDtTo[2]).ToString("dd MMM yy");

            string strFinalQS = "?strDateRange=" + strDate;
            strFinalQS = strFinalQS + "&strloc=" + txtloc.Text.ToString();
            strFinalQS = strFinalQS + "&stremp=" + txtemp.Text.ToString();
            strFinalQS = strFinalQS + "&strlogininstence=" + txtli.Text;
            strFinalQS = strFinalQS + "&strreptype=" + rdtreptype.SelectedValue.ToString();


            if (rdtreptype.SelectedValue.ToString() == "D" || rdtreptype.SelectedValue.ToString() == "A")
            {
                Response.Redirect("Login_2_2.aspx" + strFinalQS);
            }
            else
            {
                Response.Redirect("login_Summary.aspx" + strFinalQS);
            }


            
        }

    }
}

