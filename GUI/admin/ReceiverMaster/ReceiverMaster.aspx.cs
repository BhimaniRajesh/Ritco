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

using WebX.Entity;
using WebX.Controllers;

public partial class ReceiverMasterAdd : System.Web.UI.Page
{

    #region Variable[s]
    private string receiverCode = string.Empty, ErrorMsg = string.Empty, strLocations = string.Empty;   
    #endregion

    #region Event[e]
    protected void Page_Load(object sender, EventArgs e)
  {
        try
        {
            if (!Page.IsPostBack)
            {

                txtReceiverName.Focus();

                if (Request.QueryString["Flag"] == "Edit")
                {
                    receiverCode = Convert.ToString(Request.QueryString["receiverCode"]);
                    getData();
                }               
            }
        }
        catch (Exception Exc)
        {
            Response.Redirect("~/GUI/admin/ErrorPage.aspx?heading=Error in data retrival.&detail1=" + Exc.Message.Replace('\n', '_'));
        }       
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        ReceiverMasterController objReceiverMasterController = new ReceiverMasterController();
        ReceiverMaster objReceiverMaster = new ReceiverMaster();

        try
        {         

            Validation();

            if (string.IsNullOrEmpty(ErrorMsg))
            {             

                if (Request.QueryString["Flag"] == "Edit")
                {
                    objReceiverMaster.UpdateBy = Session["empcd"] != null ? Session["empcd"].ToString().Trim() : "";
                    objReceiverMaster.UpdateOnDate = Convert.ToDateTime(System.DateTime.Now.ToString("MM/dd/yyyy"));
                }
                else
                {
                    objReceiverMaster.EntryBy = Session["empcd"] != null ? Session["empcd"].ToString().Trim() : "";
                    objReceiverMaster.EntryDate = Convert.ToDateTime(System.DateTime.Now.ToString("MM/dd/yyyy"));
                }

                objReceiverMaster.ReceiverName = txtReceiverName.Text.Trim();
                objReceiverMaster.LocationCode = txtCstLoc.Text.Trim();
                objReceiverMaster.ActiveFlag = chkActiveFlag.Checked ? "Y" : "N";  
              
             

                if (Request.QueryString["Flag"] == "Edit")
                {
                    objReceiverMaster.ReceiverCode = lblReceiverCode.Text.Trim();
                    objReceiverMasterController.updateReceiverMaster(objReceiverMaster);
                    Response.Redirect("ReceiverMasterDone.aspx?Flag=Edit&receiverCode=" + lblReceiverCode.Text.Trim(), false);
                }
                else
                {
                    receiverCode = Convert.ToString(getNewReceiverCode());
                    objReceiverMaster.ReceiverCode = receiverCode;
                    objReceiverMasterController.insertReceiverMaster(objReceiverMaster);
                    Response.Redirect("ReceiverMasterDone.aspx?Flag=Add&receiverCode=" + receiverCode, false);
                }
            }
            else
            {
                Response.Redirect("~/GUI/admin/ErrorPage.aspx?heading=" + ErrorMsg, false);
            }
        }
        catch (Exception Exc)
        {
            Response.Redirect("~/GUI/admin/ErrorPage.aspx?heading=Error in record Insert/Update.&detail1=" + Exc.Message.Replace('\n', '_'));
        }
    }     
    #endregion

    #region Private Function[s]  
    public void getData()
    {
        try
        {
            ReceiverMasterController objReceiverMasterController = new ReceiverMasterController();
            DataTable dtReceiverMaster = new DataTable();            

            if (!string.IsNullOrEmpty(receiverCode))
            {
                dtReceiverMaster = objReceiverMasterController.getReceiverInfoByReceiverCode(receiverCode);
            }

            if (dtReceiverMaster != null && dtReceiverMaster.Rows.Count > 0)
            {
                lblReceiverCode.Text = Convert.ToString(dtReceiverMaster.Rows[0]["receiverCode"]);
                txtReceiverName.Text = Convert.ToString(dtReceiverMaster.Rows[0]["receiverName"]);
                txtCstLoc.Text = Convert.ToString(dtReceiverMaster.Rows[0]["LocCode"]);                

                if (Convert.ToString(dtReceiverMaster.Rows[0]["ActiveFlag"]) == "Y")
                    chkActiveFlag.Checked = true;
                else
                    chkActiveFlag.Checked = false;       
             }
        }
        catch (Exception Exc)
        {
            throw Exc;
        }
    }
    private void Validation()
    {
        try
        {
            if (string.IsNullOrEmpty(txtReceiverName.Text))
            {
                ErrorMsg = "Please Enter Receiver Name.";
                return;
            }
         
            if (string.IsNullOrEmpty(txtCstLoc.Text))
            {
                ErrorMsg = "Please enter Location.";
                return;
            }
            else
            {
                if (!DataValidations.IsActiveLocation(txtCstLoc.Text))
                {
                    ErrorMsg = "Please enter active location.";
                    return;
                }           
            }           
        }
        catch (Exception Exc)
        {
            throw Exc;
        }
    }

    public string getNewReceiverCode()
    {
        int intCustCode = 1;
        ReceiverMasterController objReceiverMasterController = new ReceiverMasterController();

        try
        {
            intCustCode = objReceiverMasterController.getNextReceiverCode();
            return "R" + intCustCode.ToString().PadLeft(5, '0');
        }
        catch (Exception Exc)
        {
            throw Exc;
        }
    }
    #endregion
}
