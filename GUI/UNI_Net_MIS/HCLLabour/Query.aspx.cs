using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class GUI_UNI_Net_MIS_HCLLabour_Query : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        UserMessage.Hide();
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        try
        {
            string strFinalQS = "?Fromdt=" + dtBookingDate.FromDate;
            strFinalQS = strFinalQS + "&Todt=" + dtBookingDate.ToDate;
            strFinalQS = strFinalQS + "&BillNo=" + txtBillNo.Text;
            strFinalQS = strFinalQS + "&Status=" + ddStatus.SelectedValue;

            System.Text.StringBuilder sb = new System.Text.StringBuilder();
            sb.Append("<");
            sb.Append("script language='javascript'>");
            sb.Append("window.open('./Result.aspx" + strFinalQS + "', '_blank',");
            sb.Append("'top=0, left=0, width=900, height=700, scrollbars=yes, menubar=no,toolbar=no,status=1,resizable=yes');");
            sb.Append("<");
            sb.Append("/script>");

            if (!this.IsStartupScriptRegistered("PopupWindow"))
            {
                //Register the script
                this.RegisterStartupScript("PopupWindow", sb.ToString());
            }
        }
        catch (Exception Ex)
        {
            UserMessage.Show("Error Messege : " + Ex.Message);
        }
    }

}
