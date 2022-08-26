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
using WebX.Controllers;     

public partial class GUI_Octroi_Ver1_Octroi_Bill_Agent_Bill_Entry : System.Web.UI.Page
{
    MyFunctions fn = new MyFunctions();
 
    protected void Page_Load(object sender, EventArgs e)
    {        
        if (!IsPostBack)
        {
            string billdate = System.DateTime.Now.ToString("dd/MM/yyyy");
            txtbilldt.Text = billdate.ToString();
            txtagntbilldt.Text = billdate.ToString();
            DateTime dt = DateTime.Today.AddDays(15);
            txtduedate.Text = dt.ToString("dd/MM/yyyy");
            fn.Fill_Octroi_Vendor_Dataset(); 
        }
    }
    protected void btn_ok_Click(object sender, EventArgs e)
    {

    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        string Branch_Code = SessionUtilities.CurrentBranchCode;
        string Branch_Name = fn.GetLocation(Branch_Code);
        string[] Vendor = txtOctAgent.Text.Split('~');

        try
        {
            string Xml_OctBillHeader = "<root><BillOctHdr>";
            Xml_OctBillHeader = Xml_OctBillHeader + "<OCBILLSF>" + "." + "</OCBILLSF>";
            Xml_OctBillHeader = Xml_OctBillHeader + "<OCBILLDT>" + DateFunction.ConvertStringToDate(txtbilldt.Text.Trim()).ToString("MM/dd/yyyy") + "</OCBILLDT>";
            Xml_OctBillHeader = Xml_OctBillHeader + "<OCBRCD>" + Branch_Code.ToString() + "</OCBRCD>";
            Xml_OctBillHeader = Xml_OctBillHeader + "<OCAGCD>" + Vendor[1].ToString() + "</OCAGCD>";
            Xml_OctBillHeader = Xml_OctBillHeader + "<OCAGNM>" + Vendor[0].ToString() + "</OCAGNM>";
            Xml_OctBillHeader = Xml_OctBillHeader + "<OCAGBILLDT>" + DateFunction.ConvertStringToDate(txtagntbilldt.Text.Trim()).ToString("MM/dd/yyyy") + "</OCAGBILLDT>";
            Xml_OctBillHeader = Xml_OctBillHeader + "<OCAGBILLNO>" + txtagntbillno.Text.Trim() + "</OCAGBILLNO>";
            Xml_OctBillHeader = Xml_OctBillHeader + "<OCAGOCTAMT>" + hidOctAmt.Value + "</OCAGOCTAMT>";
            Xml_OctBillHeader = Xml_OctBillHeader + "<OCAGOTHCHRG>" + txtothrchg.Text.Trim() + "</OCAGOTHCHRG>";
            Xml_OctBillHeader = Xml_OctBillHeader + "<OCAGSERCHRG>" + txtagnttax.Text.Trim() + "</OCAGSERCHRG>";
            Xml_OctBillHeader = Xml_OctBillHeader + "<NetAmt>" + hidTotDue.Value + "</NetAmt>";
            Xml_OctBillHeader = Xml_OctBillHeader + "<PendAmt>" + hidTotDue.Value + "</PendAmt>";
            Xml_OctBillHeader = Xml_OctBillHeader + "<OCDUEDT>" + DateFunction.ConvertStringToDate(txtduedate.Text.Trim()).ToString("MM/dd/yyyy") + "</OCDUEDT>";
            Xml_OctBillHeader = Xml_OctBillHeader + "<ENTRYBY>" + SessionUtilities.CurrentEmployeeID + "</ENTRYBY>";
            Xml_OctBillHeader = Xml_OctBillHeader + "<REMARK>" + OctroiBillEntry1.Remarks.Text.Trim() + "</REMARK>";
            Xml_OctBillHeader = Xml_OctBillHeader + "<ACTSERCHRG>" + "0" + "</ACTSERCHRG>";
            Xml_OctBillHeader = Xml_OctBillHeader + "<servchargeper>" + hidserchgper.Value + "</servchargeper>";
            Xml_OctBillHeader = Xml_OctBillHeader + "<sundrychrg>" + txtsundry.Text.Trim() + "</sundrychrg>";
            Xml_OctBillHeader = Xml_OctBillHeader + "<formchrg>" + txtfrmcharg.Text.Trim() + "</formchrg>";
            Xml_OctBillHeader = Xml_OctBillHeader + "<clearchrg>" + txtclearchrg.Text.Trim() + "</clearchrg>";
            Xml_OctBillHeader = Xml_OctBillHeader + "<CANCEL_YN>" + "N" + "</CANCEL_YN>";
            Xml_OctBillHeader = Xml_OctBillHeader + "</BillOctHdr></root>";


            string Xml_OctBillDetail = "<root>";

            foreach (GridViewRow drow in OctroiBillEntry1.OctroiBillEntry.Rows)
            {
                TextBox txtdockno = (TextBox)drow.FindControl("txtdockno");
                HiddenField hidStatus = (HiddenField)drow.FindControl("hidStatus");
                TextBox txtoctamt = (TextBox)drow.FindControl("txtoctamt");
                HiddenField hidgoctamt = (HiddenField)drow.FindControl("hidoctamt");
                TextBox txtrcpno = (TextBox)drow.FindControl("txtrcpno");
                HiddenField hidrcpno = (HiddenField)drow.FindControl("hidrcpno");
                TextBox txtrcpdt = (TextBox)drow.FindControl("txtrcpdt");
                HiddenField hidrcpdt = (HiddenField)drow.FindControl("hidrcpdt");
                HiddenField hidtot = (HiddenField)drow.FindControl("hidtot");

                if (txtdockno.Text != "")
                {
                    Xml_OctBillDetail = Xml_OctBillDetail + "<BillOctDet>";
                    Xml_OctBillDetail = Xml_OctBillDetail + "<OCBILLSF>" + "." + "</OCBILLSF>";
                    Xml_OctBillDetail = Xml_OctBillDetail + "<DOCKNO>" + txtdockno.Text.Trim() + "</DOCKNO>";
                    Xml_OctBillDetail = Xml_OctBillDetail + "<OCTAMT>" + hidgoctamt.Value + "</OCTAMT>";
                    Xml_OctBillDetail = Xml_OctBillDetail + "<RECPTNO>" + hidrcpno.Value + "</RECPTNO>";
                    Xml_OctBillDetail = Xml_OctBillDetail + "<RECPTDT>" + DateFunction.ConvertStringToDate(hidrcpdt.Value).ToString("MM/dd/yyyy") + "</RECPTDT>";
                    Xml_OctBillDetail = Xml_OctBillDetail + "<vendor_paidby>" + SessionUtilities.CurrentEmployeeID + "</vendor_paidby>";
                    Xml_OctBillDetail = Xml_OctBillDetail + "<vendor_paidat>" + Branch_Code.ToString() + "</vendor_paidat>";
                    Xml_OctBillDetail = Xml_OctBillDetail + "<OCT_DET_YN>" + (hidStatus.Value == "" ? "N" : hidStatus.Value) + "</OCT_DET_YN>";
                    Xml_OctBillDetail = Xml_OctBillDetail + "</BillOctDet>";
                }
            }
            Xml_OctBillDetail = Xml_OctBillDetail + "</root>";

            string sql = "usp_Prepare_Agent_Bill_Entry";
            SqlParameter[] parm = new SqlParameter[5];
            parm[0] = ControllersHelper.GetSqlParameter("@Bill_Location", Branch_Code.Trim(), SqlDbType.VarChar);
            parm[1] = ControllersHelper.GetSqlParameter("@Xml_BillMst", Xml_OctBillHeader.Replace("&", "&amp;").Trim(), SqlDbType.Text);
            parm[2] = ControllersHelper.GetSqlParameter("@Xml_BillDet", Xml_OctBillDetail.Replace("&", "&amp;").Trim(), SqlDbType.Text);
            parm[3] = ControllersHelper.GetSqlParameter("@FinYear", SessionUtilities.FinYear.Substring(2, 2).Trim(), SqlDbType.VarChar);
            parm[4] = ControllersHelper.GetSqlParameter("@Businesstype", "N", SqlDbType.VarChar);

            //DataSet ds = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.StoredProcedure, sql, parm);
			SqlConnection con = new SqlConnection(SessionUtilities.ConnectionString);
            con.Open();
            SqlTransaction trn = con.BeginTransaction();
            DataSet ds;
            try
            {
                ds = SqlHelper.ExecuteDataset(trn, CommandType.StoredProcedure, sql, parm);
            }
            catch (Exception ex)
            {
                trn.Rollback();
                con.Close();
                throw ex;
            }
            trn.Commit();
            con.Close();

            string Billno = ds.Tables[0].Rows[0]["Billno"].ToString();
            string TranXaction = ds.Tables[0].Rows[0]["TranXaction"].ToString();
            Response.Redirect("Agent_Bill_Entry_Done.aspx?billno=" + Billno + "&TranXaction=" + TranXaction,false);
        }
        catch (Exception ex)
        {
            string strex = ex.Message.Replace('\n', '_');
            Response.Redirect("../ErrorPage.aspx?heading=Agent Bill Entry Generation Error&detail1=Agent Bill Entry Generation Error&detail2=" + strex);
            return;
        }
    }
}
