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

public partial class GUI_Finance_Fix_Asset_aaaaa : System.Web.UI.Page
{
      public byte byteRadButtonSelection;
      protected void Page_Load(object sender, EventArgs e)
    {

     

        if (!IsPostBack)
        {

             
        }
        
    
    }

     






    protected void Button3_Click(object sender, EventArgs e)
    {
        if (Page.IsValid == true)
        {

            //string[] strArrDtFrom = txtDateFrom.Text.Split('/');
            //string[] strArrDtTo = txtDateTo.Text.Split('/');

            //DateTime dtFrom = Convert.ToDateTime(strArrDtFrom[1] + "/" + strArrDtFrom[0] + "/" + strArrDtFrom[2]);
            //DateTime dtTo = Convert.ToDateTime(strArrDtTo[1] + "/" + strArrDtTo[0] + "/" + strArrDtTo[2]);

            //string strDate = Convert.ToDateTime(strArrDtFrom[1] + "/" + strArrDtFrom[0] + "/" + strArrDtFrom[2]).ToString("dd MMM yy") + " - " + Convert.ToDateTime(strArrDtTo[1] + "/" + strArrDtTo[0] + "/" + strArrDtTo[2]).ToString("dd MMM yy");

            //string strFinalQS = "?strDateRange=" + strDate;
            //strFinalQS = strFinalQS + "&ven=" + txtven.Text;
            //strFinalQS = strFinalQS + "&po=" + txtpono.Text;



            //Response.Redirect("Goods_RCPT_2.aspx" + strFinalQS);


        }


    }
}
