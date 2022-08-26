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

public partial class GUI_Finance_Fix_Asset_ViewPrint_PO_GenerationView : System.Web.UI.Page
{
    SqlConnection cn;
    string strPONumber;
    double total;
    protected void Page_Load(object sender, EventArgs e)
    {
        cn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        if (!(IsPostBack))
        {
            strPONumber = Request.QueryString["PONumber"].ToString();
            string[] Split = strPONumber.Split(new Char[] { ',' });
            strPONumber = Convert.ToString(Split[0]);
            string print_yn = Convert.ToString(Split[1]);

            string logo = Session["logofile"].ToString();
            if (Session["Client"].ToString() == "PRRL")
            {
                imgLogo.ImageUrl = "~/GUI/images/clip_image002.gif";
            }
            if (Session["Client"].ToString() == "TLL")
            {
                imgLogo.ImageUrl = "~/GUI/images/TLL_Logo.gif";
            }
            else if (Session["Client"].ToString() == "EXL")
            {
                imgLogo.ImageUrl = "~/GUI/images/exl_logo.jpg";
            }
            else if (Session["Client"].ToString() == "Varuna")
            {
                imgLogo.ImageUrl = "~/GUI/images/Varuna_logoNew.jpg";
            }
            else if (Session["Client"].ToString() == "RITCO")
            {
                imgLogo.ImageUrl = "~/GUI/images/webxpress_logo.gif";
            }
            else if (Session["Client"].ToString() == "RCPL")
            {
                imgLogo.ImageUrl = "~/GUI/images/rcpl_logo.jpg";
            }
            else if (Session["Client"].ToString() == "Agility")
            {
                imgLogo.ImageUrl = "~/GUI/images/Agility lobo.jpg";
            }
            else if (Session["Client"].ToString() == "ASL")
            {
                imgLogo.ImageUrl = "~/GUI/images/ASL_New.bmp";
            }
            else if (Session["Client"].ToString() == "UFL")
            {
                imgLogo.ImageUrl = "~/GUI/images/ufl_logo_NEW.gif";
            }
            else if (Session["Client"].ToString() == "RLL")
            {
                imgLogo.ImageUrl = "~/GUI/images/webxpress_logo.jpg";
            }
            else
            {
                imgLogo.ImageUrl = "~/GUI/images/webxpress_logo.gif";
            }
            getData();
            bindgrid();
        }
    }

    private void bindgrid()
    {
        cn.Open();
        //string sql = "select (d.assetcd + ':' + (select top 1 assetname from webx_assetmaster where assetcd=d.assetcd)) as assetcd,d.narration,d.qty,d.tax_per,d.rate,d.total from webx_POASSET_det d where pocode='" + strPONumber + "'";
        string sql = "select (CASE WHEN MatCat in('01','04','03') THEN (SELECT SKU_Desc From Webx_PO_SKU_Master Where SKU_ID=assetcd) WHEN MatCat in('02') THEN (SELECT Model_Desc FROM WEBX_FLEET_TYREMODELMST Where Tyre_Model_ID=Assetcd) + ' ~ '+ (SELECT MFG_NAME From WEBX_FLEET_TYREMFG Where MFG_ID=TyreMFG_Code) + ' ~ '+ (Select CodeDesc from webx_master_general where CodeType ='TYTYP' and CodeID=TyreTypeCode) + ' ~ '+ (SELECT TYRE_SIZENAME FROM WEBX_FLEET_TYRESIZEMST Where TYRE_SIZEID=TyreSizeCode) ELSE '' END) AS assetcd,d.narration,d.qty,d.tax_per,d.rate,d.total,h.totalamt,d.Discount_Per from webx_General_POASSET_det d,webx_General_POASSET_HDR h where d.pocode='" + strPONumber + "' and h.pocode=d.pocode";
        SqlCommand sqlcmd = new SqlCommand(sql, cn);
        SqlDataAdapter da = new SqlDataAdapter(sqlcmd);
        DataSet ds = new DataSet();
        da.Fill(ds);

        GV_D.DataSource = ds;
        GV_D.DataBind();
        cn.Close();
    }

    private void getData()
    {
        cn.Open();

        string sql1 = "select convert(varchar,podate,06) as podate,qutno,convert(varchar,qutdate,06) as qutdate,reqno,convert(varchar,reqdt,06) as reqdt,attn,vendorcd,accdesc,paymode=(CASE WHEN paymode='-1' THEN '' ELSE paymode END),chqno,po_advamt,po_balamt,terms_condition,bank_accode=(select accdesc from webx_acctinfo where bank_accode=acccode),cash_accode=(select accdesc from webx_acctinfo where cash_accode=acccode),convert(varchar,chqdate,06) as chqdate,Po_advamt,PO_balamt,chqamt,cashamt,vendorcd +':'+ (select top 1 vendorname from webx_vendor_hdr where vendorcode=vendorcd) as vendor,* from webx_General_POASSET_HDR where pocode='" + strPONumber + "'";

        SqlCommand cmdGetData = new SqlCommand(sql1, cn);
        SqlDataReader dr = cmdGetData.ExecuteReader();

        while (dr.Read())
        {
            lblPONumber.Text = strPONumber;
            lblPoDate.Text = dr["podate"].ToString();
            lblVendorCode.Text = dr["vendor"].ToString();
            lblKindAttn.Text = dr["attn"].ToString();
            lblAdvanceAmt.Text = dr["Po_advamt"].ToString();
            lblBalAmt.Text = dr["PO_balamt"].ToString();
            lblTermsCondition.Text = dr["terms_condition"].ToString();
            lblPaymentMode.Text = dr["paymode"].ToString();
            lblAmountApplicable.Text = dr["Po_advamt"].ToString();
			lblManPo.Text = dr["Manual_PO_No"].ToString();
            if (lblPaymentMode.Text == "Cash")
            {
                lblCashAmount.Text = dr["cashamt"].ToString();
                lblCashAccount.Text = dr["cash_accode"].ToString();
                lblChequeAmount.Text = "--";
                lblBankAccount.Text = "--";
            }
            else if (lblPaymentMode.Text == "Bank")
            {
                lblChequeAmount.Text = dr["chqamt"].ToString();
                lblBankAccount.Text = dr["bank_accode"].ToString();
                lblChequeNo.Text = dr["chqno"].ToString();
                lblChequeDate.Text = dr["chqdate"].ToString();
                lblCashAmount.Text = "--";
                lblCashAccount.Text = "--";
            }
            else if (lblPaymentMode.Text == "BOTH")
            {
                lblCashAmount.Text = dr["cashamt"].ToString();
                lblCashAccount.Text = dr["cash_accode"].ToString();
                lblChequeAmount.Text = dr["Po_advamt"].ToString();
                lblBankAccount.Text = dr["bank_accode"].ToString();
                lblChequeNo.Text = dr["chqno"].ToString();
                lblChequeDate.Text = dr["chqdate"].ToString();
            }
            lblNetPayable.Text = dr["Po_advamt"].ToString();
        }
        dr.Close();
        string sql11 = "EXEC USP_Get_GRNNumber '" + strPONumber + "'";

        SqlCommand cmdGetGRN = new SqlCommand(sql11, cn);
        SqlDataReader drGetGRN = cmdGetGRN.ExecuteReader();
        while (drGetGRN.Read())
        {
            lblGRNNo.Text = drGetGRN["GRNNO"].ToString();
        }
        drGetGRN.Close();

        string sql111 = "select COMPANY_NAME from WEBX_COMPANY_MASTER WHERE COMPANY_CODE='" + SessionUtilities.DefaultCompanyCode.ToString() + "'";

        SqlCommand cmdGetCompany = new SqlCommand(sql111, cn);
        SqlDataReader drGetCompany = cmdGetCompany.ExecuteReader();
        while (drGetCompany.Read())
        {
            LblCompany.Text = drGetCompany["COMPANY_NAME"].ToString();
        }
        drGetCompany.Close();

        cn.Close();
    }

    protected void GV_D_rowdatabound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            Label lblTotalAmount = (Label)e.Row.FindControl("lblTotalAmount");
            total = total + Convert.ToDouble(lblTotalAmount.Text);
        }
        if (e.Row.RowType == DataControlRowType.Footer)
        {
            Label fooTotalAmount = (Label)e.Row.FindControl("fooTotalAmount");
            fooTotalAmount.Text = total.ToString();
        }
    }
}
