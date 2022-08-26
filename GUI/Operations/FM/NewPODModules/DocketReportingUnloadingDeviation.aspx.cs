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

public partial class GUI_Operations_FM_NewPODModules_DocketReportingUnloadingDeviation : BasePage
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
            var dt = obj.GetDocketListForReportingUnloadingDeviation(Request.QueryString["Location"].ToString(), Request.QueryString["FromDate"].ToString(), Request.QueryString["ToDate"].ToString());
            dgDockets.DataSource = dt;
            dgDockets.DataBind();
            if (dt.Rows.Count > 0) { btnClear.Visible = true; btnPending.Visible = true; } else { btnClear.Visible = false; btnPending.Visible = false; }
        }
    }



    protected void btnClear_Click(object sender, EventArgs e)
    {
        if (IsTokenValid())
        {

            try
            {
                int Cnt = 0;
                foreach (GridViewRow gridrow in dgDockets.Rows)
                {
                    CheckBox chkDocket = (CheckBox)gridrow.FindControl("chkDocket");
                    if (chkDocket.Checked == true)
                    { Cnt = Cnt + 1; }
                }
                if (Cnt <= 0)
                {
                    msgBox.Show("Please select At Least On Docket !!");
                    return;
                }
                SaveDetails("Clear");
                ConsumeToken();
                Response.Redirect("DocketReportingUnloadingDeviationResult.aspx", false);
            }
            catch (Exception ex)
            {
                msgBox.Show(ex.Message);
                return;
            }
        }
        else
        {
            msgBox.Show("Can't click Twise !!");
            return;
        }
    }

    protected void btnPending_Click(object sender, EventArgs e)
    {
        if (IsTokenValid())
        {
            try
            {
                int Cnt = 0;
                foreach (GridViewRow gridrow in dgDockets.Rows)
                {
                    CheckBox chkDocket = (CheckBox)gridrow.FindControl("chkDocket");
                    if (chkDocket.Checked == true)
                    { Cnt = Cnt + 1; }
                }
                if (Cnt <= 0)
                {
                    msgBox.Show("Please select At Least On Docket !!");
                    return;
                }
                SaveDetails("Pending");
                ConsumeToken();
                Response.Redirect("DocketReportingUnloadingDeviationResult.aspx", false);
            }
            catch (Exception ex)
            {
                msgBox.Show(ex.Message);
                return;
            }
        }
        else
        {
            msgBox.Show("Can't click Twise !!");
            return;
        }
    }

    public void SaveDetails(string Status)
    {
        var strDocketXML = "<DocketList>";
        foreach (GridViewRow gridrow in dgDockets.Rows)
        {
            CheckBox chkDocket = (CheckBox)gridrow.FindControl("chkDocket");
            HiddenField hdnDocketNo = (HiddenField)gridrow.FindControl("hdnDocketNo");
            TextBox txtRemark = (TextBox)gridrow.FindControl("txtRemark");

            if (chkDocket.Checked == true)
            {
                strDocketXML += "<Docket><DocketNo>" + hdnDocketNo.Value + "</DocketNo>";
                strDocketXML += "<Remark>" + txtRemark.Text + "</Remark></Docket>";
            }
        }
        strDocketXML += "</DocketList>";

        var obj = new NewPODModuleController();
        obj.DocketReportingUnloadingDeviationEntry(strDocketXML, Status);

    }
}
