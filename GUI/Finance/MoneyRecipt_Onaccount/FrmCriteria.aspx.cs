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

public partial class GUI_Finance_MoneyRecipt_Updatemr_step1 : System.Web.UI.Page
{
    public byte byteRadButtonSelection;


    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {

            if (!IsPostBack)
            {
                radDate.Items[2].Selected = true;
                txtDateFrom.Text = DateTime.Today.ToString("dd/MM/yyyy");
                txtDateTo.Text = txtDateFrom.Text;
            }

        }
        Button3.Attributes.Add("onclick", "javascript:return Submitdata()");
       
        
    }
    public void abc(object source, ServerValidateEventArgs value)
    {
        //value.IsValid = true; 
        txtDateFrom.Text = txtDateFrom.Text.Replace('.', '/');
        txtDateTo.Text = txtDateTo.Text.Replace('.', '/');
        txtDateFrom.Text = txtDateFrom.Text.Replace('-', '/');
        txtDateTo.Text = txtDateTo.Text.Replace('-', '/');
        string[] strDtFrom = txtDateFrom.Text.Split('/');
        DateTime dt1 = new DateTime(Convert.ToInt16(strDtFrom[2]), Convert.ToInt16(strDtFrom[1]), Convert.ToInt16(strDtFrom[0]));
        string[] strDtTo = txtDateTo.Text.Split('/');
        DateTime dt2 = new DateTime(Convert.ToInt16(strDtTo[2]), Convert.ToInt16(strDtTo[1]), Convert.ToInt16(strDtTo[0]));
        if (DateTime.Compare(dt1, dt2) > 0)
        {
            value.IsValid = false;
        }
        else
        {
            value.IsValid = true;
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
        else
        {
            value.IsValid = true;
        }
    }


    protected void Button3_Click(object sender, EventArgs e)
    {
        if (Page.IsValid == true)
        {
            string strDate = "";
           //Response.Write("<br>docno-" + txtmrsno.Text);
          // Response.Write("<br>Mrstype-" + txtdocno.Text);
          // Response.End();
           // if (txtmrsno.Text == "" || txtdocno.Text == "")
           // {
                string[] strArrDtFrom = txtDateFrom.Text.Split('/');
                string[] strArrDtTo = txtDateTo.Text.Split('/');

                DateTime dtFrom = Convert.ToDateTime(strArrDtFrom[1] + "/" + strArrDtFrom[0] + "/" + strArrDtFrom[2]);
                DateTime dtTo = Convert.ToDateTime(strArrDtTo[1] + "/" + strArrDtTo[0] + "/" + strArrDtTo[2]);

                 strDate = Convert.ToDateTime(strArrDtFrom[1] + "/" + strArrDtFrom[0] + "/" + strArrDtFrom[2]).ToString("dd MMM yy") + " - " + Convert.ToDateTime(strArrDtTo[1] + "/" + strArrDtTo[0] + "/" + strArrDtTo[2]).ToString("dd MMM yy");
          //  }
            //Response.Write("<br>Mrstype-" + strDate);
            //Response.End();
            string strFinalQS = "?strDateRange=" + strDate;
            strFinalQS = strFinalQS + "&mrno=" + txtmrsno.Text;
            strFinalQS = strFinalQS + "&docno=" + txtdocno.Text;
            strFinalQS = strFinalQS + "&mrstype=" + mrstype.SelectedValue;
            Response.Redirect("FrmMRDetail.aspx" + strFinalQS);
        }

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
        if (rbl.Items[0].Selected)
        {
            DateTime MyDate = DateTime.Today;
            MyDate = MyDate + TimeSpan.FromDays(-31);
            //  txtDateFrom.Text = MyDate.ToString("dd/MM/yyyy");
            txtDateFrom.Text = MyDate.ToString("dd/MM/yyyy");
            txtDateTo.Text = DateTime.Today.ToString("dd/MM/yyyy");
            txtDateFrom.ReadOnly = false;
            txtDateTo.ReadOnly = false;

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

}
