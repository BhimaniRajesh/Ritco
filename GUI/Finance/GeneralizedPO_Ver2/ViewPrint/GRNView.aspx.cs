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
using Microsoft.ApplicationBlocks.Data;
public partial class GUI_Finance_Fix_Asset_ViewPrint_GRNView : System.Web.UI.Page
{
    string strGRNNo,Type="";
    protected void Page_Load(object sender, EventArgs e)
    {
        Type = Request.QueryString["Type"].ToString();
        if (!IsPostBack)
        {
            strGRNNo = Request.QueryString["GRNNO"].ToString();
            string[] Split = strGRNNo.Split(new Char[] { ',' });
            strGRNNo = Convert.ToString(Split[0]);
            string print_yn = Convert.ToString(Split[1]);
            DipsplayReport();
        }
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
    }

    public void DipsplayReport()
    {
        
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        string sql = "Select (VendorCode+' : '+ VendorName)As Vendor,(SELECT LOCCODE+' : '+LOCName From webx_LOcation Where Loccode=BBRCD) AS BBRCD, (SELECT LOCCODE+' : '+LOCName From webx_LOcation Where Loccode=PAY_Loc) AS Pay_Loc,Remark,Convert(varchar,ReceivedDT,106) AS ReceviedDt,Convert(varchar,GRNDT,106) AS GRNDT,ManualGRNNO,GRNSTATUS,CancelledBY=(SELECT USERID+' : '+NAME FROM webx_master_users where userid=CancelledBY),Convert(varchar,CancelledDT,106) AS CancelledDT from webx_GRN_HDR  WHERE GRNNO='" + strGRNNo + "'";
        //string sql = "select D.pocode,convert(varchar,D.podate,06) as podt,(select assetname from webx_assetmaster where assetcd=D.assetcd) as assetnm,qty,rate,total,assetcd,narration,vendorcod=(select VendorCode +':'+VendorName from webx_vendor_hdr where VendorCode=vendorcd) from webx_POASSET_det D With(NOLOCK) inner join webx_poasset_hdr M on D.pocode=M.pocode where M.GRNNO='" + strGRNNo + "' order by D.pocode  asc  ";
        conn.Open();
        SqlCommand cmd = new SqlCommand(sql, conn);
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        DataSet ds = new DataSet();
        da.Fill(ds);
        lblGRNNo.Text = strGRNNo;
        lblBBRCD.Text = ds.Tables[0].Rows[0]["BBRCD"].ToString();
        lblPAY_LOC.Text = ds.Tables[0].Rows[0]["Pay_Loc"].ToString();
        lblRemark.Text = ds.Tables[0].Rows[0]["Remark"].ToString();
        lblVendor.Text = ds.Tables[0].Rows[0]["Vendor"].ToString();
        lblReceviedDate.Text = ds.Tables[0].Rows[0]["ReceviedDt"].ToString();
        lblManualGRNNo.Text = ds.Tables[0].Rows[0]["ManualGRNNO"].ToString();
        lblGRNDATE.Text = ds.Tables[0].Rows[0]["GRNDT"].ToString();
        LblGRNStatus.Text = ds.Tables[0].Rows[0]["GRNSTATUS"].ToString();
        LblCancelledBy.Text = ds.Tables[0].Rows[0]["CancelledBY"].ToString();
        LblCancelledDate.Text = ds.Tables[0].Rows[0]["CancelledDT"].ToString();

        if (ds.Tables[0].Rows[0]["GRNSTATUS"].ToString() != "GRN CANCELLED")
        {
            string SQLDET = "";
            DataTable dt = new DataTable();
            if (Type == "STN")
            {
                SQLDET = "Select A.POCode,Convert(varchar,B.STNDate,106) AS POdate,IName,QTY=C.STNQTY,Convert(numeric(18,2),(C.BalanceQty)) As BalanceQty,Convert(numeric(18,2),ReceivedQty) as ReceivedQty,A.Rate,A.TOTALAMT FROM webx_GRN_DET A INNER JOIN webx_STN_HDR B ON A.POCode=B.STNNo INNER JOIN webx_STN_DET C ON B.STNNo=C.STNNo AND SKUID=ICODE AND A.QTY=C.STNQTY and ISNULL(A.POsrno,'')=(CASE WHEN ISNULL(A.POsrno,'')<>'' THEN CONVERT(VARCHAR,C.srno) ELSE '' END) WHERE A.GRNNO='" + strGRNNo + "'";
                dt = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, SQLDET).Tables[0];
                GrdSTN.DataSource = dt;
                GrdSTN.DataBind();
            }
            else
            {
                SQLDET = "Select A.POCode,Convert(varchar,B.PODate,106) AS POdate,IName,QTY=C.qty,Convert(numeric(18,2),(C.balanceqty)) As BalanceQty,Convert(numeric(18,2),ReceivedQty) as ReceivedQty,A.Rate,A.TOTALAMT FROM webx_GRN_DET A INNER JOIN webx_General_POASSET_HDR B ON A.POCode=B.POCode INNER JOIN webx_General_POASSET_DET C ON B.POCode=C.POCode AND ASSETCD=ICODE AND A.RATE=C.rate AND A.QTY=C.qty and ISNULL(A.POsrno,'')=(CASE WHEN ISNULL(A.POsrno,'')<>'' THEN CONVERT(VARCHAR,C.srno) ELSE '' END) WHERE A.GRNNO='" + strGRNNo + "'";
                dt = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, SQLDET).Tables[0];
                GV_Booking.DataSource = dt;
                GV_Booking.DataBind();
            }
        }
        else
        {
            Cancelled.Style["display"] = "block";
        }
    }
}
