using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Web.Services;
using System.Web.UI.WebControls;
using WebX.Common;
using WebX.Controllers;
using WebX.Entity;

public partial class GUI_Finance_CheQue_Bounce_ChequeBounce_Criteria : BasePage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        msgBox.Hide();
        if (!IsPostBack && !IsCallback)
        { }
    }

    protected void btnShow_Click(object sender, EventArgs e)
    {
        try
        {
            var objChequBounceRequest = new ChequBounceRequest();
            var objChequeBounce_Controller = new ChequeBounce_Controller();

            DropDownList objcboRO = (DropDownList)Fromlc.FindControl("cboRO");
            DropDownList objcboAO = (DropDownList)Fromlc.FindControl("cboAO");
            DropDownList objcboLO = (DropDownList)Fromlc.FindControl("cboLO");
            DropDownList objDDL_BankList = (DropDownList)Fromlc.FindControl("DDL_BankList");

            objChequBounceRequest.BankName = objDDL_BankList.SelectedValue;
            objChequBounceRequest.ChequeNo = txtChequeNo.Text;
            objChequBounceRequest.Amount = Convert.ToDecimal(txtAmount.Text);
            objChequBounceRequest.ChequeDate = Convert.ToDateTime(WebXConvert.ToDateTime(txtChequekdate.Text.Trim(), "en-GB"));
            DataTable dt = objChequeBounce_Controller.GetListCheque(objChequBounceRequest.BankName, objChequBounceRequest.ChequeNo, objChequBounceRequest.Amount, objChequBounceRequest.ChequeDate);
            if (dt.Rows.Count > 0)
            {
                gvChequeDetail.DataSource = dt;
                gvChequeDetail.DataBind();
                btnShow.Style["display"] = "none";
                btnSubmit.Visible = true;
            }
            else
            {
                msgBox.Show("No Record Found in this Criteria ");
            }
        }
        catch (Exception ex)
        {
            ExceptionUtils.LogException(ex, "Cheque Bounce Issue");
        }
    }
    [WebMethod]
    public static string ChequeInsert(ChequBounceRequest objChequeBounceRequest)
    {
        string strResult = "";
        var ajaxDataCollection = new List<String>();
        var oResponse = new ChequBounceResponse();
        using (var objWh = new WebXHelper())
        {
            try
            {
                var dt = new DataTable();
                var sqp = new SqlParameter[1];
                sqp[0] = new SqlParameter("@xmlDetail", SqlDbType.Xml) { Value = XmlUtility.XmlSerializeToString(objChequeBounceRequest) };

                objWh.BeginTransaction();
                dt = objWh.ExecuteDataTable("Usp_ChequeBounce_InsertBounceCheque", sqp);
                strResult = JsonConvert.SerializeObject(dt);
                objWh.CommitTransaction();

                //if (WebXConvert.ToBoolean(dt.Rows[0]["Status"].ToString()) == true)
                //{
                //    strResult = dt.Rows[0]["VoucherNo"].ToString();
                //}
                //else
                //{
                //    strResult = "Error : " + dt.Rows[0]["Message"].ToString();
                //}
            }
            catch (Exception ex)
            {
                objWh.RollBackTransaction();
                throw new Exception(ex.Message);
            }
        }
        return strResult;
    }
}