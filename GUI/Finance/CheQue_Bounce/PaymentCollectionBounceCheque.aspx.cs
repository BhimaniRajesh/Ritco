using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using WebX.Common;
using WebX.Entity;

public partial class GUI_Finance_CheQue_Bounce_PaymentCollectionBounceCheque : BasePage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        msgBox.Hide();
        if (!IsPostBack)
        {
            divData.Visible = false;
            ddlBankAccount.Items.Clear();
            SqlConnection con = new SqlConnection(Session["SqlProvider"].ToString().Trim());
            con.Open();
            string strSql = "select top 1 '' as asscodeval,'--Select--' as accdesc Union select acccode  as asscodeval,accdesc from webx_acctinfo where  ( ((bkloccode like 'All' or PATINDEx ('%" + SessionUtilities.CurrentBranchCode + "%',bkloccode)>0) AND acccategory='BANK')) order by accdesc asc";
            SqlCommand cmd = new SqlCommand(strSql, con);

            SqlDataReader dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                ddlBankAccount.Items.Add(new ListItem(dr.GetValue(1).ToString(), dr.GetValue(0).ToString()));
            }
            dr.Close();

            ddlBankAccount.CssClass = "blackfnt";
        }
    }
    protected void btnShow_Click(object sender, EventArgs e)
    {
        TextBox txtDateFrom = (TextBox)DT.FindControl("txtDateFrom");
        TextBox txtDateTo = (TextBox)DT.FindControl("txtDateTo");


        string[] strArrDtFrom = txtDateFrom.Text.ToString().Split('/');
        string[] strArrDtTo = txtDateTo.Text.ToString().Split('/');

        string dtFrom = Convert.ToDateTime(strArrDtFrom[1] + "/" + strArrDtFrom[0] + "/" + strArrDtFrom[2]).ToString("dd MMM yy");
        string dtTo = Convert.ToDateTime(strArrDtTo[1] + "/" + strArrDtTo[0] + "/" + strArrDtTo[2]).ToString("dd MMM yy");

        try
        {
            var objChequBouncePaymentRequest = new ChequBouncePaymentRequest();
            var objChequeBounce_Controller = new ChequeBounce_Controller();

            DropDownList cboRO = (DropDownList)Fromlc.FindControl("cboRO");
            DropDownList cboLO = (DropDownList)Fromlc.FindControl("cboLO");

            objChequBouncePaymentRequest.FromDate = dtFrom;
            objChequBouncePaymentRequest.ToDate = dtTo;
            objChequBouncePaymentRequest.ROLocation = cboRO.SelectedValue;
            objChequBouncePaymentRequest.Loccode = cboLO.SelectedValue;
            objChequBouncePaymentRequest.Customer = txtCustomer.Text;
            objChequBouncePaymentRequest.ChequeNo = txtChequeNo.Text;

            DataTable dt = objChequeBounce_Controller.GetPaymentListCheque(objChequBouncePaymentRequest.FromDate, objChequBouncePaymentRequest.ToDate, objChequBouncePaymentRequest.ROLocation, objChequBouncePaymentRequest.Loccode, objChequBouncePaymentRequest.Customer, objChequBouncePaymentRequest.ChequeNo);
            if (dt.Rows.Count > 0)
            {
                gvChequeDetail.DataSource = dt;
                gvChequeDetail.DataBind();
                btnShow.Style["display"] = "none";
                btnSubmit.Visible = true;
                divData.Visible = true;
            }
            else
            {
                msgBox.Show("No Record Found in this Criteria ");
            }
        }
        catch (Exception ex)
        {
            ExceptionUtils.LogException(ex, "Cheque Bounce PAyment  Issue");
        }
    }
    [WebMethod]
    public static string PaymentChequeInsert(PaymentCheque objPaymentCheque)
    {
        string strResult = "";
        var ajaxDataCollection = new List<String>();
        var strxml = XmlUtility.XmlSerializeToString(objPaymentCheque);
        using (var objWh = new WebXHelper())
        {
            try
            {
                var dt = new DataTable();
                var sqp = new SqlParameter[4];
                sqp[0] = new SqlParameter("@xmlDetail", SqlDbType.Xml) { Value = XmlUtility.XmlSerializeToString(objPaymentCheque) };
                sqp[1] = new SqlParameter("@EntryBy", SessionUtilities.CurrentEmployeeID);
                sqp[2] = new SqlParameter("@FinYear", SessionUtilities.FinYear);
                sqp[3] = new SqlParameter("@EntryBranch", SessionUtilities.CurrentBranchCode);
                objWh.BeginTransaction();
                dt = objWh.ExecuteDataTable("Usp_ChequeBounce_PaymentCollection", sqp);

                if (dt.Rows.Count > 0)
                {
                    strResult = JsonConvert.SerializeObject(dt);
                    objWh.CommitTransaction();
                }
                else
                {
                    throw new Exception("Voucher Not generated");
                }
            }
            catch (Exception ex)
            {
                objWh.RollBackTransaction();
                throw new Exception(ex.Message);
            }
        }
        return strResult;
    }
    protected void gvChequeDetail_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        if (e.Item.ItemType == ListItemType.Item)
        {
            Label lblBalanceAmount = (Label)e.Item.FindControl("lblBalanceAmount");
            TextBox txtReceiveAmount = (TextBox)e.Item.FindControl("txtReceiveAmount");
            Label lblChequeAmount = (Label)e.Item.FindControl("lblChequeAmount");

            lblBalanceAmount.Text = (WebXConvert.ToDouble(lblChequeAmount.Text) - WebXConvert.ToDouble(txtReceiveAmount.Text)).ToString();
        }
    }
}