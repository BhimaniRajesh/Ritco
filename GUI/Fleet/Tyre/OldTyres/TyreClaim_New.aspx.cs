using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;

public partial class GUI_Fleet_Tyre_OldTyreStock_TyreClaim_New : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Response.Cache.SetCacheability(HttpCacheability.NoCache);
        Response.Cache.SetNoStore();
        Response.Cache.SetExpires(DateTime.MinValue);

        if (!IsPostBack)
        {
            cls_TyreIssueMaster CTIM = new cls_TyreIssueMaster(Session["SqlProvider"].ToString().Trim());
            string Str = Request.QueryString["Tyre_ID"];
            //string Str = "T0011,T0012,T0013,T0014,T0015,T0018";

            BindDropDown("USP_VendorList", "Vendor", "vendorcode", ddlVendor);
            CTIM.GetTyres_Claim(GV_TyreClaim, Str);

            //  btnStep.Attributes.Add("OnClick", "javascript:OnSubmitStep();");
            // btnSubmit.Attributes.Add("OnClick", "javascript:OnSubmit();");
        }
    }

    /// <summary>
    /// Bind Vendor
    /// </summary>
    /// <param name="strProc"></param>
    /// <param name="text"></param>
    /// <param name="value"></param>
    /// <param name="Where"></param>
    /// <param name="d"></param>
    public void BindDropDown(string strProc, string text, string value, DropDownList d)
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        string STR = strProc;
        conn.Open();
        SqlCommand cmd = new SqlCommand(STR, conn);
        cmd.CommandType = CommandType.StoredProcedure;
        SqlDataReader dr = cmd.ExecuteReader();
        if (dr.HasRows)
        {
            while (dr.Read())
            {
                d.Items.Add(new ListItem(Convert.ToString(dr[text]), Convert.ToString(dr[value])));
            }
        }
        dr.Close();
        conn.Close();
    }

    /// <summary>
    /// 
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void GV_TyreClaim_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow || e.Row.RowType == DataControlRowType.EmptyDataRow)
        {
            TextBox txtClaim = (TextBox)e.Row.FindControl("txtClaim");
            TextBox txtClaimDT = (TextBox)e.Row.FindControl("txtClaimDT");
            //TextBox txtClaimAmt = (TextBox)e.Row.FindControl("txtClaimAmt");
            //TextBox txtReason = (TextBox)e.Row.FindControl("txtReason");

            //txtClaimAmt.Enabled = false;
            //txtReason.Enabled = false;
            ////txtClaim.Attributes.Add("OnBlur", "javascript:CheckVendor();");
            ////txtClaim.Attributes.Add("OnBlur", "javascript:CheckVendor(" + e.Row.RowIndex + "," + txtClaim.ClientID.ToString() + ");");
            ////txtClaimDT.Attributes.Add("onblur", "javascript:MIn_Max_Date_Validation(this,'02','../../../images/Fleet_Date_Control_Rule_Check.aspx')");
        }
    }



    /// <summary>
    /// 
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void btnStep_Click(object sender, EventArgs e)
    {
        List<string> list = new List<string>();
        string final = "";
        string[] ARR_vendcd;
        string VendorCD = "", VendorNM = "";
        string mCheck = "CLAIM", mDocuementNo = "";
        Boolean IsCommited = false;

        GetFinancialYear objFinYear = new GetFinancialYear(Convert.ToString(Session["SqlProvider"]));

        string Xml_PAY_MST = "<root>";
        cls_TyreIssueMaster CTIM = new cls_TyreIssueMaster(Session["SqlProvider"].ToString().Trim());
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();

        if (mCheck == "CLAIM")
        {
            string YearVal = "";

            YearVal = objFinYear.FinancialYear();

            //string mSTR = "WebX_SP_GetNextDocumentCode";
            string mSTR = "WebX_SP_GetNextDocumentCode_FA";
            SqlCommand mcmd1 = new SqlCommand(mSTR, conn);
            mcmd1.CommandType = CommandType.StoredProcedure;
            mcmd1.Parameters.Add("@LocCode", SqlDbType.VarChar).Value = SessionUtilities.CurrentBranchCode.ToString().Trim();
            mcmd1.Parameters.Add("@FinYear", SqlDbType.VarChar).Value = YearVal.Substring(0, 2).Trim();
            mcmd1.Parameters.Add("@Document", SqlDbType.VarChar).Value = mCheck;
            SqlDataReader rFR = mcmd1.ExecuteReader();
            if (rFR.Read())
            {
                mDocuementNo = rFR[0].ToString().Trim();
                list.Add(rFR[0].ToString().Trim());
            }
            rFR.Close();
            conn.Close();
        }


        foreach (GridViewRow gridrow in GV_TyreClaim.Rows)
        {
            CheckBox chkSelect = gridrow.FindControl("chkSelect") as CheckBox;
            TextBox txtSysTyreNo = gridrow.FindControl("txtSysTyreNo") as TextBox;
            //TextBox txtClaim = gridrow.FindControl("txtClaim") as TextBox;
            //TextBox txtClaimDT = gridrow.FindControl("txtClaimDT") as TextBox;
            TextBox txtFittment_DT = gridrow.FindControl("txtFittment_DT") as TextBox;
            TextBox txtRemovalDT = gridrow.FindControl("txtRemovalDT") as TextBox;
            TextBox txtStatus = gridrow.FindControl("txtStatus") as TextBox;
            TextBox txtRemark = gridrow.FindControl("txtRemark") as TextBox;
            TextBox txtDist = gridrow.FindControl("txtDist") as TextBox;
            HiddenField hdfTYRE_ID = gridrow.FindControl("hdfTYRE_ID") as HiddenField;

            if (chkSelect.Checked)
            {
                list.Add(hdfTYRE_ID.Value.Trim());

                ////if (txtClaim.Text != "")
                ////{
                ////    ARR_vendcd = txtClaim.Text.Split('~');

                ////    VendorCD = ARR_vendcd[0].ToString();
                ////    VendorNM = ARR_vendcd[1].ToString();
                ////    CTIM.VendorCode = VendorCD;
                ////}
                ////else
                ////{
                ////    VendorCD = "";
                ////    VendorNM = "";
                ////}
                CTIM.TYRE_ID = hdfTYRE_ID.Value;//txtSysTyreNo.Text.Trim();
                CTIM.ENTRY_BY = SessionUtilities.CurrentEmployeeID.Trim();
                CTIM.CLAIM_REMOLD_SALE_ID = mDocuementNo;
                CTIM.VendorCode = ddlVendor.SelectedValue.Trim();
                CTIM.ACTION_DT = txtClaimDT.Text.Trim();//txtClaimDT.Text;
                CTIM.BRANCH = SessionUtilities.CurrentBranchCode.Trim();
                CTIM.mobileNo = "";
                CTIM.STATUS = "Pending";
                CTIM.Actions = "CLAIM";
                CTIM.CLAIM_AMT = 0;
                CTIM.C_Remark = txtRemark.Text.Trim();
                CTIM.Claim_YN = "N";
                CTIM.Suffix = "C";
                CTIM.Dist_Covered = Convert.ToDouble(txtDist.Text.Trim());

                //updated by vidya on 14 Nov 2013

                CTIM.UpdateTyreDtl_ClaimNew();
                IsCommited = true;
                //CTIM.PayMode = "";
                //CTIM.Acccode = "";
                //CTIM.Chqno = "";
                //CTIM.Chqdate = "";
                //CTIM.ChqAmt = 0;
                //CTIM.PAYDT = "";
                //CTIM.CashAmt = 0;
                //CTIM.Cashcode = "";
                //CTIM.Bankaccode = "";
                //CTIM.NetPay = 0;

                //txtSysTyreNo

                //Xml_PAY_MST = Xml_PAY_MST + "<Tyre_MST>";
                //Xml_PAY_MST = Xml_PAY_MST + "<TYRE_ID>" + txtSysTyreNo.Text.ToString() + "</TYRE_ID>";
                //Xml_PAY_MST = Xml_PAY_MST + "<Suffix>CP</Suffix>";
                //Xml_PAY_MST = Xml_PAY_MST + "<Actions>Claim Pending</Actions>";
                //Xml_PAY_MST = Xml_PAY_MST + "<VendorCode>" + VendorCD.Trim() + "</VendorCode>";
                //Xml_PAY_MST = Xml_PAY_MST + "<Claim_Amt>0.00</Claim_Amt>";
                //Xml_PAY_MST = Xml_PAY_MST + "<Claim_DT>" + txtClaimDT.Text.Trim() + "</Claim_DT>";
                //Xml_PAY_MST = Xml_PAY_MST + "<C_Remark></C_Remark>";
                //Xml_PAY_MST = Xml_PAY_MST + "<Claim_YN>P</Claim_YN>";

                ////Payment Details
                //Xml_PAY_MST = Xml_PAY_MST + "<PayMode></PayMode>";
                //Xml_PAY_MST = Xml_PAY_MST + "<CashAmt>0.00</CashAmt>";
                //Xml_PAY_MST = Xml_PAY_MST + "<Cashcode></Cashcode>";
                //Xml_PAY_MST = Xml_PAY_MST + "<ChqAmt>0.00</ChqAmt>";
                //Xml_PAY_MST = Xml_PAY_MST + "<Chqno></Chqno>";
                //Xml_PAY_MST = Xml_PAY_MST + "<Bankaccode></Bankaccode>";
                //Xml_PAY_MST = Xml_PAY_MST + "<Chqdate></Chqdate>";
                //Xml_PAY_MST = Xml_PAY_MST + "<NetPay>0.00</NetPay>";
                //Xml_PAY_MST = Xml_PAY_MST + "</Tyre_MST>";

            }
        }

        //Xml_PAY_MST = Xml_PAY_MST + "</root>";
        //CTIM.XMLData = Xml_PAY_MST.Trim();

        ////CTIM.UpdateTyreDtl_Claim();

        if (IsCommited)
        {
            btnStep.Enabled = false;

            //for (int i = 0; i < list.Count; i++)
            //{
            //    if (final == "")
            //    {
            //        final = list[i];
            //    }
            //    else
            //    {
            //        final = final + "," + list[i];
            //    }
            //}

            Response.Redirect("ClaimMsg.aspx?ID=" + mDocuementNo);
        }
    }
}