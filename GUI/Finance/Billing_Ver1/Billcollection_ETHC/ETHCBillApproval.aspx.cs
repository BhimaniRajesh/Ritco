using Microsoft.ApplicationBlocks.Data;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using WebX.Common;

public partial class GUI_Finance_Billing_Ver1_Billcollection_ETHC_ETHCBillApproval : BasePage
{
    string MRNo = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        UserMessage.Hide();
        MRNo = Convert.ToString(Request.QueryString["MRNo"]);

        if (!IsPostBack)
        {
            CreateToken();
            try
            {
                DataTable dt = new DataTable();
                using (var oWebXHelper = new WebXHelper())
                {
                    dt = oWebXHelper.ExecuteDataTable("WEBX_BILLCollection_Detail_ETHC_Approval", new[] {
                    new SqlParameter("@MRNo", MRNo)
                    });
                }
                dockdata.DataSource = dt;
                dockdata.DataBind();

                if (dt.Rows.Count > 0)
                {
                    lblPayMode.Text = dt.Rows[0]["paymode"].ToString();
                    lblInstrumentNo.Text = dt.Rows[0]["MRSCHQNO"].ToString();
                    lblInstrumentDate.Text = dt.Rows[0]["MRSCHQDT"].ToString();
                    lblDepositedBank.Text = dt.Rows[0]["ReceivedBank"].ToString();
                    lblReceivedBank.Text = dt.Rows[0]["DepositedBank"].ToString();
                    lblInstrumentAmount.Text = dt.Rows[0]["TotalCollectionAmt"].ToString();
                }
            }
            catch (Exception Ex)
            {
                UserMessage.Show(Ex.Message);
            }
        }
    }
    int J = 0, RowCnt = 0;
    protected void dockdata_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        int Index_Plus = 6;
        GridView oGridView = (GridView)sender;
        if (oGridView.ID == "GridView1")
        {
            Index_Plus = 0;
        }
        RowCnt = RowCnt + 1;
        if (e.Row.RowType == DataControlRowType.Header)
        {
            if (oGridView.ID == "GridView1")
            {
                Label lblBillno = (Label)e.Row.FindControl("lblBillno");
                lblBillno.Text = SessionUtilities.DocketCalledAs.ToString() + " Details";
            }
        }
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            GridViewRow oGridViewRow = new GridViewRow(2, 2, DataControlRowType.Footer, DataControlRowState.Insert);
            Label Header_Chg;
            Label lbl_Chg;
            HiddenField Hnd_CHG = (HiddenField)e.Row.FindControl("Hnd_SCHG");
            HiddenField hdn_chargeValue = (HiddenField)e.Row.FindControl("hdn_chargeValue");


            string[] Hnd_CHG_Arr = Hnd_CHG.Value.ToString().Split(new string[] { "*/" }, StringSplitOptions.None);
            for (int i = 1; i <= Hnd_CHG_Arr.Length; i++)
            {
                e.Row.Cells[i + Index_Plus].Visible = Get_Charges_Value(Hnd_CHG_Arr[i - 1].ToString());
                oGridView.HeaderRow.Cells[i + Index_Plus].Visible = Get_Charges_Value(Hnd_CHG_Arr[i - 1].ToString());

                Header_Chg = (Label)oGridView.HeaderRow.FindControl("Lbl_Chg_" + i.ToString());
                Header_Chg.Text = Get_Charges_Header_Text(Hnd_CHG_Arr[i - 1].ToString());
            }

            string[] Hnd_CHG_Arr1 = hdn_chargeValue.Value.ToString().Split(new string[] { "~" }, StringSplitOptions.None);
            for (int i = 1; i <= Hnd_CHG_Arr1.Length; i++)
            {
                lbl_Chg = (Label)e.Row.FindControl("CHG" + i.ToString());
                lbl_Chg.Text = Hnd_CHG_Arr1[i - 1].ToString();
            }
        }
    }
    public bool Get_Charges_Value(string Hnd_CHG_value)
    {
        string[] Arr_Hnd_CHG = Hnd_CHG_value.ToString().Split('~');
        string Bill_ColFlag = Arr_Hnd_CHG[2].ToString();
        string Active_Flag = Arr_Hnd_CHG[3].ToString();
        bool Rturn_Value = false;
        if (Bill_ColFlag == "Y" && Active_Flag == "Y")
        {
            Rturn_Value = true;
        }
        Rturn_Value = true;
        return Rturn_Value;
    }
    public string Get_Charges_Header_Text(string Hnd_CHG_value)
    {
        string[] Arr_Hnd_CHG = Hnd_CHG_value.ToString().Split('~');
        string Charges_Header_Text = Arr_Hnd_CHG[1].ToString() + "(" + Arr_Hnd_CHG[4].ToString() + ")";
        return Charges_Header_Text;
    }
    protected void btnApprove_Click(object sender, EventArgs e)
    {
        if (IsTokenValid())
        {
            
            try
            {
                DataTable dt = new DataTable();
                using (var oWebXHelper = new WebXHelper())
                {
                    dt = oWebXHelper.ExecuteDataTable("Usp_MRApproval_ETHC", new[] {
                    new SqlParameter("@MRNo", MRNo) ,
                    new SqlParameter("@Remarks",txtRemarks.Text) ,
                    new SqlParameter("@ApprovalFlag", "1") ,
                    new SqlParameter("@ApprovedBy", SessionUtilities.CurrentEmployeeID) ,
                    new SqlParameter("@FinYear", SessionUtilities.FinYear)
                    });
                }

                if (dt.Rows.Count > 0)
                {
                    var vouchernos = dt.Rows[0]["Voucherno"].ToString();

                    if (vouchernos != "")
                    {
                        Response.Redirect("ETHCBillApprovalDone.aspx?vouchernos=" + vouchernos + "&Flag=Approve");
                    }
                    else
                    {
                        UserMessage.Show("something is Wrong! voucher Not generated");
                    }
                }
            }
            catch (Exception Ex)
            {
                UserMessage.Show(Ex.Message);
            }
            ConsumeToken();
        }
    }
    protected void btnReject_Click(object sender, EventArgs e)
    {
        if (IsTokenValid())
        {
           
            try
            {
                DataTable dt = new DataTable();
                using (var oWebXHelper = new WebXHelper())
                {
                    dt = oWebXHelper.ExecuteDataTable("Usp_MRApproval_ETHC", new[] {
                    new SqlParameter("@MRNo", MRNo) ,
                    new SqlParameter("@Remarks",txtRemarks.Text) ,
                    new SqlParameter("@ApprovalFlag", "0") ,
                    new SqlParameter("@ApprovedBy", SessionUtilities.CurrentEmployeeID) ,
                    new SqlParameter("@FinYear", SessionUtilities.FinYear)
                    });
                }

                if (dt.Rows.Count > 0)
                {
                    var vouchernos = dt.Rows[0]["Voucherno"].ToString();

                    if (vouchernos == "")
                    {
                        Response.Redirect("ETHCBillApprovalDone.aspx?vouchernos=" + vouchernos + "&Flag=Reject");
                    }
                    else
                    {
                        UserMessage.Show("something is Wrong! voucher Not generated");
                    }
                }
            }
            catch (Exception Ex)
            {
                UserMessage.Show(Ex.Message);
            }
            ConsumeToken();
        }
    }
}