using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class GUI_Operations_FM_NewPODModules_PODHandoverAcknowledgementDone : System.Web.UI.Page
{
    public string poCode, acceptReject;
    protected void Page_Load(object sender, EventArgs e)
    {
        UserMessage.Hide();
        try
        {
            if (!Page.IsPostBack)
            {
                poCode = Convert.ToString(Request.QueryString["PoCode"]);
                acceptReject = Convert.ToString(Request.QueryString["AcceptReject"]);
                if (poCode != "")
                {
                    lblPODNo.Text = poCode;
                    if (acceptReject == "Accept")
                    {
                        lblTitle.Text = "POD HandOver Acknowledgement done successfully………";
                    }
                    else if (acceptReject== "Reject")
                    {
                        lblTitle.Text = "Following POD HandOver Number are Rejected.";
                        lblview.Visible = false;
                    }

                }
            }
        }
        catch (Exception Ex)
        {
            UserMessage.Show("Some issue has occur, Kindly Contact to Support Team");
            ExceptionUtility.LogException(Ex, "POApproval_Ver1->POApprovalVer1Done.aspx->Page_Load");
        }
    }
}