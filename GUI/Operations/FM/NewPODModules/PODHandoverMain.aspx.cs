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
using System.Text.RegularExpressions;
using WebX.Controllers;

public partial class GUI_Operations_FM_NewPODModules_PODHandoverMain : BasePage
{
    public string brcd, empcd, selyear, dkt_Call, empnm;

    protected void Page_Load(object sender, EventArgs e)
    {
        brcd = Session["brcd"].ToString();
        empcd = Session["empcd"].ToString();
        empnm = Session["empnm"].ToString();
        dkt_Call = Session["DocketCalledAs"].ToString();
        msgBox.Hide();
        if (!IsPostBack && !IsCallback)
        {
            CreateToken();
            var obj = new NewPODModuleController();
            var dt = obj.GetDocketListForPODHandOver(Request.QueryString["Location"].ToString(), Request.QueryString["FromDate"].ToString(), Request.QueryString["ToDate"].ToString(), Request.QueryString["DocketNo"].ToString());
            dgDockets.DataSource = dt;
            dgDockets.DataBind();
            if (dt.Rows.Count > 0) { btnSubmit.Visible = true; } else { btnSubmit.Visible = false; }
        }
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        if (IsTokenValid())
        {
            
            try
            {
                foreach (GridViewRow gridrow in dgDockets.Rows)
                {
                    CheckBox chkDocket = (CheckBox)gridrow.FindControl("chkDocket");
                    TextBox txtRemark = (TextBox)gridrow.FindControl("txtRemark");
                    TextBox txtBillingDate = (TextBox)gridrow.FindControl("txtBillingDate");

                    if (chkDocket.Checked == true && (txtRemark.Text == "" || txtBillingDate.Text == ""))
                    {
                        msgBox.Show("Please enter Remark and Billing Date !!");
                        return;

                    }
                }

		
				ConsumeToken();
				
                int docketCnt = 0;
                var strDocketXML = "<DocketList>";
                foreach (GridViewRow gridrow in dgDockets.Rows)
                {
                    CheckBox chkDocket = (CheckBox)gridrow.FindControl("chkDocket");
                    HiddenField hdnDocketNo = (HiddenField)gridrow.FindControl("hdnDocketNo");
                    TextBox txtRemark = (TextBox)gridrow.FindControl("txtRemark");
                    TextBox txtBillingDate = (TextBox)gridrow.FindControl("txtBillingDate");

                    if (chkDocket.Checked == true)
                    {
                        docketCnt = docketCnt + 1;
                        strDocketXML += "<Docket><DocketNo>" + hdnDocketNo.Value + "</DocketNo>";
                        strDocketXML += "<EntryBy>" + SessionUtilities.CurrentEmployeeID + "</EntryBy>";
                        strDocketXML += "<BillingDate>" + getDateInddMMMyyFormat(txtBillingDate.Text) + "</BillingDate>";
                        strDocketXML += "<Remark>" + txtRemark.Text + "</Remark></Docket>";

                    }
                }
                strDocketXML += "</DocketList>";

                if (docketCnt > 0)
                {
					
                    var obj = new NewPODModuleController();
                    var dtResult = obj.DocketPODHandover(strDocketXML);
                    Response.Redirect("PODHandoverResult.aspx?PDHNo=" + dtResult.Rows[0]["PDHNo"].ToString(), false);
                }
                else
                {
                    msgBox.Show("Please select At Least On Docket !!");
                }


            }
            catch (Exception ex)
            {
                msgBox.Show(ex.Message);
                return;
            }
        }
        else {
            msgBox.Show("Can't click Twise !!");
            return;
        }

    }

    private string getDateInddMMMyyFormat(string strDate)
    {
        try
        {
            string[] strDateParts = strDate.Split('/');

            return strDateParts[0] + " " + getShortMonthName(Convert.ToInt32(strDateParts[1])) + " " + strDateParts[2].Substring(2, 2);
        }
        catch (Exception Ex)
        {
            return "";
        }
    }

    private string getShortMonthName(int intMonth)
    {
        string strShortMonthName = "";

        switch (intMonth)
        {
            case 1:
                strShortMonthName = "Jan";
                break;
            case 2:
                strShortMonthName = "Feb";
                break;
            case 3:
                strShortMonthName = "Mar";
                break;
            case 4:
                strShortMonthName = "Apr";
                break;
            case 5:
                strShortMonthName = "May";
                break;
            case 6:
                strShortMonthName = "Jun";
                break;
            case 7:
                strShortMonthName = "Jul";
                break;
            case 8:
                strShortMonthName = "Aug";
                break;
            case 9:
                strShortMonthName = "Sep";
                break;
            case 10:
                strShortMonthName = "Oct";
                break;
            case 11:
                strShortMonthName = "Nov";
                break;
            case 12:
                strShortMonthName = "Dec";
                break;
        }

        return strShortMonthName;
    }
}
