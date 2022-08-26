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
using System.Web.SessionState;

public partial class octroi_octCustBillStep1 : System.Web.UI.Page
{

    public byte byteRadButtonSelection;
    protected void Page_Load(object sender, EventArgs e)
    {
        //Session["brcd"] = "PRHO";
        //Session["empcd"] = "p1438";
        if (!IsPostBack)
        {

            Session["SVCOPTFOR"] = null;
            string scr = @"<script>
                    function update1(elemValue1)
                  {
                        document.getElementById('ctl00_MyCPH1_Party_code').value=elemValue1;
                  }
                  </script>";

            Page.RegisterClientScriptBlock("update1", scr);
            btnPopUp.Attributes.Add("onclick", "window.open('../Billing_New/popup_cust.aspx',null,'left=600, top=100, height=300, width= 400, status=n o, resizable= no, scrollbars= yes, toolbar= no,location= no, menubar= no');");




            string scr4 = @"<script>
                    function update_city1(elemValue)
                  {
                     document.getElementById('ctl00_MyCPH1_txtFromCity').value=elemValue;
                     document.getElementById('ctl00_MyCPH1_txtFromCity').focus()
                  }
                  </script>";
            Page.RegisterClientScriptBlock("update_city1", scr4);


            string scr5 = @"<script>
                    function update_city2(elemValue)
                  {
                     document.getElementById('ctl00_MyCPH1_txtToCity').value=elemValue;
                     document.getElementById('ctl00_MyCPH1_txtToCity').focus()
                  }
                  </script>";

            Page.RegisterClientScriptBlock("update_city2", scr5);




            string strSubmit = "javascript:return SubmitQueryData()";
            Button1.Attributes.Add("onClick", strSubmit);

            PopulateBusType();
        }
    }

    protected void ShowData(object sender, EventArgs e)
    {
        if (cboBusType.SelectedItem.Value == "01")
        {
            Session["SVCOPTFOR"] = "01";
        }
        else if (cboBusType.SelectedItem.Value == "02")
        {
            Session["SVCOPTFOR"] = "02";
        }
        else
        {
            Session["SVCOPTFOR"] = null;
        }
    }
    public void PopulateBusType()
    {
        string sqlstr = "";

        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
        sqlstr = "Select CodeId,CodeDesc from webx_master_general where CodeType='SVCOPT' and StatusCode='Y'";
        SqlCommand cmd = new SqlCommand(sqlstr, conn);
        SqlDataReader dr = cmd.ExecuteReader();

        cboBusType.Items.Clear();

        while (dr.Read())
        {
            cboBusType.Items.Add(new ListItem(dr.GetValue(1).ToString(), dr.GetValue(0).ToString()));

        }
        dr.Close();
        conn.Close();
        cboBusType.Items.Insert(0, "");
        cboBusType.Items[0].Selected = true;
        conn.Close();
    }
    protected void submit1_Click(object sender, EventArgs e)
    {
        if (Page.IsValid == true)
        {
            //if (txtdoc.Text == "")
            //{
                string[] strArrDtFrom = txtDateFrom.Text.Split('/');
                string[] strArrDtTo = txtDateTo.Text.Split('/');

                DateTime dtFrom = Convert.ToDateTime(strArrDtFrom[1] + "/" + strArrDtFrom[0] + "/" + strArrDtFrom[2]);
                DateTime dtTo = Convert.ToDateTime(strArrDtTo[1] + "/" + strArrDtTo[0] + "/" + strArrDtTo[2]);

                string strDate = Convert.ToDateTime(strArrDtFrom[1] + "/" + strArrDtFrom[0] + "/" + strArrDtFrom[2]).ToString("dd MMM yy") + " - " + Convert.ToDateTime(strArrDtTo[1] + "/" + strArrDtTo[0] + "/" + strArrDtTo[2]).ToString("dd MMM yy");
                string para;
                para = "1";

                string mBusType = cboBusType.SelectedItem.Value;
                Response.Redirect("Bill_Cancellation_2.aspx?strcust=" + txtcust.Text + "&strbilltype=" + ddlbilltype.SelectedValue.ToString() + "&strdt=" + strDate + "&para1=" + para + "&BusType=" + mBusType);
            //}
        }

    }

    protected void submit2_Click(object sender, EventArgs e)
    {
        /*if (txtdoc.Text == "")
        {
            string[] strArrDtFrom = txtDateFrom.Text.Split('/');
            string[] strArrDtTo = txtDateTo.Text.Split('/');

            DateTime dtFrom = Convert.ToDateTime(strArrDtFrom[1] + "/" + strArrDtFrom[0] + "/" + strArrDtFrom[2]);
            DateTime dtTo = Convert.ToDateTime(strArrDtTo[1] + "/" + strArrDtTo[0] + "/" + strArrDtTo[2]);

            string strDate = Convert.ToDateTime(strArrDtFrom[1] + "/" + strArrDtFrom[0] + "/" + strArrDtFrom[2]).ToString("dd MMM yy") + " - " + Convert.ToDateTime(strArrDtTo[1] + "/" + strArrDtTo[0] + "/" + strArrDtTo[2]).ToString("dd MMM yy");
        }*/
            string para;
            para = "2";

            string mBusType = cboBusType.SelectedItem.Value;
            Response.Redirect("Bill_Cancellation_2.aspx?strbillno=" + txtdoc.Text + "&para1=" + para +"&BusType=" + mBusType);
       
    }
    protected void Billto_SelectedIndexChanged(object sender, EventArgs e)
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
        else if (rbl.Items[3].Selected)
        {
            txtDateFrom.ReadOnly = true;
            txtDateTo.ReadOnly = true;
            txtDateFrom.Text = System.DateTime.Today.AddYears(-50).ToString("dd/MM/yyyy");
            txtDateTo.Text = System.DateTime.Now.ToString("dd/MM/yyyy");
        }

    }

    public void daterange(object source, ServerValidateEventArgs value)
    {

        if (txtDateFrom.Text != "" && txtDateTo.Text != "")
        {
            string[] strDtFrom = txtDateFrom.Text.Split('/');
            DateTime dt1 = new DateTime(Convert.ToInt16(strDtFrom[2]), Convert.ToInt16(strDtFrom[1]), Convert.ToInt16(strDtFrom[0]));
            string[] strDtTo = txtDateTo.Text.Split('/');
            DateTime dt2 = new DateTime(Convert.ToInt16(strDtTo[2]), Convert.ToInt16(strDtTo[1]), Convert.ToInt16(strDtTo[0]));
            System.TimeSpan diffResult = dt2.Subtract(dt1);
        }
        
    }

     
}
