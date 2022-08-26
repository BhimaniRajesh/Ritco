using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web.Security;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Text.RegularExpressions;
using WebX.Controllers;
using WebX.Entity;

public partial class GUI_Operations_FM_NewPODModules_PODHandoverAcknowledgementResult : BasePage
{
    public string brcd, empcd, selyear, dkt_Call, empnm, PODNo;
    protected void Page_Load(object sender, EventArgs e)
    {
        UserMessage.Hide();
        try
        {
            PODNo = Request.QueryString["PODNo"].ToString();
            brcd = Session["brcd"].ToString();
            empcd = Session["empcd"].ToString();
            empnm = Session["empnm"].ToString();
            dkt_Call = Session["DocketCalledAs"].ToString();
            if (!IsPostBack)
            {
                CreateToken();
                if (PODNo != null)
                {
                    bindGrid();
                }
            }
        }
        catch (Exception Ex)
        {
            UserMessage.Show("Oops!! Some issue has occure, Kindly Contact to Support Team");
            ExceptionUtility.LogException(Ex, "NewPODModules->PODHandoverAcknowledgementResult.aspx->Page_Load");
        }
    }
    public void bindGrid()
    {
        DataTable dtPODHandOverList = new DataTable();
        NewPODModuleController objPODModuleController = new NewPODModuleController();
        try
        {
            dtPODHandOverList = objPODModuleController.GetDocketListForPODHandOverAcknowledgement(Convert.ToString(PODNo));

            if (dtPODHandOverList == null || dtPODHandOverList.Rows.Count == 0)
            {
                btnAccept.Visible = false;
                btnReject.Visible = false;
            }
            dgPODHdOvr.DataSource = dtPODHandOverList;
            dgPODHdOvr.DataBind();

        }
        catch (Exception Ex)
        {
            UserMessage.Show("Oops!! Some issue has occure, Kindly Contact to Support Team");
            ExceptionUtility.LogException(Ex, "NewPODModules->PODHandoverAcknowledgementResult.aspx->bindGrid");
            btnReject.Visible = true;
            btnAccept.Visible = true;
        }
    }
    protected void OnSubmit(string AcceptReject)
    {
        if (IsTokenValid())
        {

            NewPODModuleController objPODModuleController = new NewPODModuleController();
            List<PODHandOverAcknowledgement> lstobjPODHandOverEntity = new List<PODHandOverAcknowledgement>();

            try
            {
                int i = 1;
                bool IsChkd = false;
                foreach (GridViewRow gr in dgPODHdOvr.Rows)
                {

                    CheckBox chkDocket = (CheckBox)gr.FindControl("chkDocket");
                    TextBox txtRejectRemarks = (TextBox)gr.FindControl("txtRejectRemarks");
                    Label lnkDocketNo = ((Label)gr.FindControl("lnkDocketNo"));
                    if (chkDocket.Checked == true)
                    {
                        IsChkd = true;
                        PODHandOverAcknowledgement objPODHandOverEntity = new PODHandOverAcknowledgement();
                        objPODHandOverEntity.PODNo = PODNo;
                        objPODHandOverEntity.DockNo = lnkDocketNo.Text;
                        objPODHandOverEntity.RejectionRemark = txtRejectRemarks.Text;
                        if (AcceptReject == "Accept")
                        {
                            objPODHandOverEntity.IsAccept = true;
                            objPODHandOverEntity.IsReject = false;

                        }
                        else if (AcceptReject == "Reject")
                        {
                            if (txtRejectRemarks.Text == "" || txtRejectRemarks.Text == null)
                            {
                                txtRejectRemarks.Focus();
                                throw new Exception("Please Enter Reject Remarks at " + i + " row!!");

                            }
                            else
                            {
                                objPODHandOverEntity.IsAccept = false;
                                objPODHandOverEntity.IsReject = true;
                            }
                        }
                        else
                        {
                            objPODHandOverEntity.IsAccept = false;
                            objPODHandOverEntity.IsReject = false;
                        }
                        lstobjPODHandOverEntity.Add(objPODHandOverEntity);
                    }
                    i++;
                }
                if (!IsChkd)
                {
                    throw new Exception("Please Select atleast one Docket Detail!!");
                }
                DataTable dt = objPODModuleController.DocketPODHandOverAcknowledgement(lstobjPODHandOverEntity);
                ConsumeToken();
                if (dt != null && dt.Rows.Count > 0)
                {
                    Response.Redirect("PODHandOverAcknowledgementDone.aspx?PoCode=" + PODNo + "&AcceptReject=" + AcceptReject, false);
                }
              
            }
            catch (Exception Ex)
            {
                UserMessage.Show(Ex.Message);
            }
        }

    }
    protected void btnAccept_Click(object sender, EventArgs e)
    {
        OnSubmit("Accept");
    }

    protected void btnReject_Click(object sender, EventArgs e)
    {
        OnSubmit("Reject");
    }
}