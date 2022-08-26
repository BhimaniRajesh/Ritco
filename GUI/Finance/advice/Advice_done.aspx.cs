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

public partial class GUI_finance_advice_Advice_done : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            string AdviceNo = Request.QueryString["AdviceNo"];
            string AdviceType = Request.QueryString["AdviceType"];
            switch (AdviceType)
            { 
                case "C":
                    AdviceType = "Credit Advice";
                    break;
                case "D" :
                    AdviceType = "Debit Advice";
                    break;
            }
            lblDocNameVal.Text = AdviceType;
            lblDocNoVal.Text = AdviceNo;
        }
    }
}
