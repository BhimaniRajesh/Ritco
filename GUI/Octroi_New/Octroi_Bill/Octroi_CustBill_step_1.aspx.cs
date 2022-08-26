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
using System.ComponentModel;
using System.Drawing;
using System.Web.SessionState;
using System.Text;


public partial class GUI_Octroi_New_Octroi_Bill_Octroi_CustBill_step_1 : System.Web.UI.Page
{
    string Financial_Year,result;
    SqlConnection con;
    SqlCommand cmd;
    SqlDataReader dr;
    MyFunctions fn = new MyFunctions();
    protected void Page_Load(object sender, EventArgs e)
    {
        con = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        con.Open();

        fn.Fill_Customer_Dataset();
        fn.Fill_Location_Dataset();

        Financial_Year = Session["FinYear"].ToString().Substring(2, 2);

        lblPreparedFor.Text = Session["brcd"].ToString();
        lblPreparedLoc.Text = Session["brcd"].ToString();

         
        txtBillSubAt.Attributes.Add("onblur", "PartyLocBlur('" + txtBillSubAt.ClientID.ToString() + "','SubLoc')");
         
        txtBillColAt.Attributes.Add("onblur", "PartyLocBlur('" + txtBillColAt.ClientID.ToString() + "','ColLoc')");
         
        txtPartyCode.Attributes.Add("onblur", "PartyLocBlur('" + txtPartyCode.ClientID.ToString() + "','Party')");
        if (!IsPostBack)
        {
            txtBillSubAt.Text = fn.GetLocation(Session["brcd"].ToString()) + '~' + Session["brcd"].ToString();
            txtBillColAt.Text = fn.GetLocation(Session["brcd"].ToString()) + '~' + Session["brcd"].ToString();

            txtBillDate.Text = System.DateTime.Now.ToString("dd/MM/yyyy");
            txtDueDate.Text = System.DateTime.Now.AddDays(15).ToString("dd/MM/yyyy");
            Hnd_Server_dt.Value = System.DateTime.Now.ToString("dd/MM/yyyy");



            string sql = "select convert(varchar,Mindate,103),AlloW_BackDate,convert(varchar,Maxdate,103),BillGen_Loc_basedOn  from webx_setup_process WITH(NOLOCK)";
            SqlCommand cmd = new SqlCommand(sql, con);
            SqlDataReader dr = null;
            dr = cmd.ExecuteReader();
            if (dr.Read())
            {
                Hnd_Mindate.Value = dr.GetValue(0).ToString();
                //Hnd_AlloW_BackDate.Value = dr.GetValue(1).ToString();
                Hnd_Maxdate.Value = dr.GetValue(2).ToString();
                Hnd_BillGen_Loc_BasedOn.Value = dr.GetValue(3).ToString();
            }

            dr.Close();
            con.Close();
        }
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        string BillNo = "";
        string[] ArrCustNo = txtPartyCode.Text.ToString().Split('~');
        string CustNo = ArrCustNo[1].ToString();
        string sql = "";
        string billStatus = "Bill Generated";
        string bbrcd = Session["BRCD"].ToString();
        string Paybas = "6";
        string bgndt = fn.Mydate1(txtBillDate.Text.ToString());
        string billduedt = fn.Mydate1(txtDueDate.Text.ToString());
        string[] billsubbrcd_arr = txtBillSubAt.Text.ToString().Split('~');
        string billsubbrcd = billsubbrcd_arr[1].ToString();
        string[] billcolbrcd_arr = txtBillColAt.Text.ToString().Split('~');
        string billcolbrcd = billcolbrcd_arr[1].ToString();
        string BILLAMT = txtBillAmt.Text.ToString();
        string remarks = txtRemarks.Text.ToString();
        string Pendamt = txtBillAmt.Text.ToString();
        string PTMSNM = "";
        // lblPartyName.Text.ToString();
        string Bill_Location = Session["brcd"].ToString();
        if (Hnd_BillGen_Loc_BasedOn.Value == "BBRCD")
        {
            Bill_Location = Session["brcd"].ToString();
        }
        else if (Hnd_BillGen_Loc_BasedOn.Value == "BILLSUBBRCD")
        {
            Bill_Location = billsubbrcd;
        }
            GridView grvcontrols = (GridView)OctDetails.FindControl("grvcontrols");
   
            string Xml_BillMst = "<root><Bill>";
            //Xml_BillMst = Xml_BillMst + "<Billno>" + Billno.Trim() + "</Billno>";

            Xml_BillMst = Xml_BillMst + "<Billstatus>" + billStatus.Trim() + "</Billstatus>";
            Xml_BillMst = Xml_BillMst + "<Bbrcd>" + bbrcd.Trim() + "</Bbrcd>";
            Xml_BillMst = Xml_BillMst + "<Paybas>" + Paybas.Trim() + "</Paybas>";
            Xml_BillMst = Xml_BillMst + "<PTMSCD>" + CustNo.Trim() + "</PTMSCD>";
            Xml_BillMst = Xml_BillMst + "<Bgndt>" + bgndt.Trim() + "</Bgndt>";
            Xml_BillMst = Xml_BillMst + "<billsubbrcd>" + billsubbrcd.Trim() + "</billsubbrcd>";
            Xml_BillMst = Xml_BillMst + "<billcolbrcd>" + billcolbrcd.Trim() + "</billcolbrcd>";
            Xml_BillMst = Xml_BillMst + "<Bduedt>" + billduedt.Trim() + "</Bduedt>";
            Xml_BillMst = Xml_BillMst + "<BILLAMT>" + BILLAMT.Trim() + "</BILLAMT>";
            Xml_BillMst = Xml_BillMst + "<remarks>" + remarks.ToUpper().Trim() + "</remarks>";
            Xml_BillMst = Xml_BillMst + "<pendamt>" + BILLAMT.Trim() + "</pendamt>";
            Xml_BillMst = Xml_BillMst + "<PTMSNM>" + PTMSNM.Trim() + "</PTMSNM>";
            Xml_BillMst = Xml_BillMst + "<Manualbillno>" + txtManualbillno.Text.ToUpper().Trim() + "</Manualbillno>";
            Xml_BillMst = Xml_BillMst + "<BGENEMPCD>" + Session["empcd"].ToString().Trim() + "</BGENEMPCD>";
            Xml_BillMst = Xml_BillMst + "</Bill></root>";

            string Xml_BillDet = "<root>";
            string Xml_UpoctDet = "<root>";
            string Xml_OctDet = "<root>";
            string Xml_TransDocketStatus = "<root>";

            string Cust_paidby = "PARTY";
            string Cust_paidat = Session["brcd"].ToString();
            string MRSNO = null, bill_mr_dt = null, MR_PAIDBY = null;
            string octroibill = "Y";

            foreach (GridViewRow gridrow in grvcontrols.Rows)
            {   
                string DockNo = ((TextBox)gridrow.FindControl("txtDockno")).Text;
                string OctAmt = ((TextBox)gridrow.FindControl("txtOctAmt")).Text;
                string OctPer = ((TextBox)gridrow.FindControl("txtOctper")).Text;
                string Clear_Chrg = ((TextBox)gridrow.FindControl("txtClearChrg")).Text;
                string Proce_per = ((TextBox)gridrow.FindControl("txtProPercent")).Text;
                string Proc_Chrg = ((TextBox)gridrow.FindControl("txtProChrg")).Text;
                string Oth_Chrg = ((TextBox)gridrow.FindControl("txtOtrChrg")).Text;
                string total = ((TextBox)gridrow.FindControl("txtTotal")).Text;
                string RecNo = ((TextBox)gridrow.FindControl("txtRecpno")).Text;
                string RecDt = ((TextBox)gridrow.FindControl("txtRecpdt")).Text;
                string stax = ((TextBox)gridrow.FindControl("txtSvrTax")).Text;
                string cess = ((TextBox)gridrow.FindControl("txtCess")).Text;
                string hcess = ((TextBox)gridrow.FindControl("txtHEduCess")).Text;
                string Delval = ((TextBox)gridrow.FindControl("txtDelVal")).Text;
                string Docksf = ".";

                if (DockNo != "")
                {
                    string ReciptDt = fn.Mydate1(RecDt.ToString());
                    Xml_BillDet = Xml_BillDet + "<BillDet>";
                    Xml_BillDet = Xml_BillDet + "<DockNo>" + DockNo.Trim() + "</DockNo>";
                    Xml_BillDet = Xml_BillDet + "<DOCKSF>" + Docksf.Trim() + "</DOCKSF>";
                    Xml_BillDet = Xml_BillDet + "<OCT_AMT>" + OctAmt.Trim() + "</OCT_AMT>";
                    Xml_BillDet = Xml_BillDet + "<process_chrg>" + Proc_Chrg.Trim() + "</process_chrg>";
                    Xml_BillDet = Xml_BillDet + "<TOTAMT>" + total.Trim() + "</TOTAMT>";
                    Xml_BillDet = Xml_BillDet + "<declval>" + Delval.Trim() + "</declval>";
                    Xml_BillDet = Xml_BillDet + "<oct_percentage>" + OctPer.Trim() + "</oct_percentage>";
                    Xml_BillDet = Xml_BillDet + "<clearance_chrg>" + Clear_Chrg.Trim() + "</clearance_chrg>";
                    Xml_BillDet = Xml_BillDet + "<OTCHG>" + Oth_Chrg.Trim() + "</OTCHG>";
                    Xml_BillDet = Xml_BillDet + "<OCT_RECEIPTNO>" + RecNo.Trim() + "</OCT_RECEIPTNO>";
                    Xml_BillDet = Xml_BillDet + "<processing_per>" + Proce_per.Trim() + "</processing_per>";
                    Xml_BillDet = Xml_BillDet + "<recptdt>" + ReciptDt.Trim() + "</recptdt>";
                    Xml_BillDet = Xml_BillDet + "<oct_svctax>" + stax.Trim() + "</oct_svctax>";
                    Xml_BillDet = Xml_BillDet + "<oct_cess>" + cess.Trim() + "</oct_cess>";
                    Xml_BillDet = Xml_BillDet + "<Oct_High_cess>" + hcess.Trim() + "</Oct_High_cess>";
                    Xml_UpoctDet = Xml_UpoctDet + "<octroipaid_by>" + Cust_paidby + "</octroipaid_by>";
                    Xml_UpoctDet = Xml_UpoctDet + "<oct_Custcd>" + CustNo.Trim() + "</oct_Custcd>";
                    Xml_UpoctDet = Xml_UpoctDet + "<customer_paidby>" + CustNo.Trim() + "</customer_paidby>";
                    Xml_UpoctDet = Xml_UpoctDet + "<customer_paidat>" + Cust_paidat.Trim() + "</customer_paidat>";
                    Xml_UpoctDet = Xml_UpoctDet + "<BILLMRDT>" + bgndt.Trim() + "</BILLMRDT>";
                    Xml_BillDet = Xml_BillDet + "</BillDet> ";
                }
            }
            
            Xml_BillDet = Xml_BillDet + "</root>";
            Xml_TransDocketStatus = Xml_TransDocketStatus + "</root>";
            sql = "usp_Generate_CustOctBill";
            //con.Open();
            SqlCommand sqlCmd = new SqlCommand(sql, con);
            sqlCmd.CommandType = CommandType.StoredProcedure;
            sqlCmd.Parameters.Add("@Bill_Location", SqlDbType.VarChar).Value = Bill_Location.Trim();
            sqlCmd.Parameters.Add("@Xml_BillMst", SqlDbType.Text).Value = Xml_BillMst.Replace("&", "&amp").Trim();
            sqlCmd.Parameters.Add("@Xml_BillDet", SqlDbType.Text).Value = Xml_BillDet.Replace("&", "&amp").Trim();
            sqlCmd.Parameters.Add("@FinYear", SqlDbType.VarChar).Value = Session["FinYear"].ToString().Substring(2, 2).Trim();
            
            SqlDataAdapter da = new SqlDataAdapter(sqlCmd);
            DataSet ds = new DataSet();
            da.Fill(ds);
            da.Dispose();
            BillNo = ds.Tables[0].Rows[0]["Billno"].ToString();
            con.Close();
            Response.Redirect("Octroi_CustBill_Result.aspx?Billno=" + BillNo);

    }
   
    public Boolean docket_EXIST(string dockno,SqlConnection con, SqlCommand cmd, SqlTransaction tran)
    {
        string msg;
        //SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        //conn.Open();

        //string dno = dockno;
        string sql = "select dockno from webx_oct_det where dockno='" + dockno + "'";
        cmd = new SqlCommand(sql, con,tran);

        SqlDataAdapter da = new SqlDataAdapter(cmd);
        DataSet ds = new DataSet();
        da.Fill(ds);

        if (ds.Tables[0].Rows.Count == 0)
        {
            return false;
        }
        else
        {
            return true;
        }
    }
}
