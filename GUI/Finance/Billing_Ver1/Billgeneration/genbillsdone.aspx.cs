using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.ComponentModel;
using System.Drawing;
using System.Web.SessionState;
using System.Text;
using Microsoft.ApplicationBlocks.Data;
using WebX.Common;
public partial class Finance_Billing_Billgeneration_genbillsdone : BasePage
{
    string Party_code;
    string orgncd;
    public static string fincmplbr;
    string DocketDelivery = "";
    string DateType = "";
    string fromdt;
    string Todt;
    string PAYBAS;
    string Fromdate = "", Todate = "", Docketnos = "", Financial_Year = "", Businesstype_desc = "", Businesstype = "", BIll_POD_Approval_YN = "", BT_Wise_YN = "";

    string TRN_MOD;
    MyFunctions fn = new MyFunctions();

    public int intTotalRecords;
    string Businesstype_code = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        MsgBox.Hide();
        Financial_Year = Session["FinYear"].ToString().Substring(2, 2);
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        Businesstype_desc = Request.QueryString.Get("Businesstype_desc");
        Businesstype = Request.QueryString.Get("Businesstype");
        Businesstype_code = Request.QueryString.Get("Businesstype");
        DocketDelivery = Request.QueryString.Get("DocketDelivery");
        DateType = Request.QueryString.Get("DateType");
        if (Businesstype != "")
        {
            Tr_but.Visible = true;
            Lblbut.Text = Businesstype_desc;
        }

        //Docketnos = Request.QueryString.Get("Docketnos");
        //BIll_POD_Approval_YN = Request.QueryString.Get("BIll_POD_Approval_YN");
        Party_code = Request.QueryString.Get("custcd");
        orgncd = "All";
        fincmplbr = Session["brcd"].ToString();
        fromdt = Request.QueryString.Get("fromtdate");
        Fromdate = Request.QueryString.Get("fromtdate");
        Todt = Request.QueryString.Get("todate");
        Todate = Request.QueryString.Get("todate");
        PAYBAS = "P02";
        TRN_MOD = Request.QueryString.Get("trnmod");
        lbldaterange.Text = fromdt.Trim() + "-" + Todt.Trim();
        LblPTMSCD.Text = Party_code.ToString() + ":" + fn.Getcustomer(Party_code);
        lblparty.Text = Party_code.ToString() + ":" + fn.Getcustomer(Party_code);
        lblpaybas.Text = fn.Getpaybas(PAYBAS);
        if (TRN_MOD != "134")
        {
            lblmod.Text = fn.Gettrnmod(TRN_MOD);
        }
        else
        {
            lblmod.Text = "All";
        }

        fn.Fill_Location_Dataset();
        if (!IsPostBack)
        {
            CreateToken();
            //string sql = "exec Usp_Cust_Billdetails  '" + Party_code.ToString() + "'";
            string sql = "exec Usp_Cust_Billdetails  '" + Party_code.ToString() + "','" + PAYBAS + "'";
            SqlCommand cmd = new SqlCommand(sql, conn);
            conn.Open();
            SqlDataReader dr = null;
            dr = cmd.ExecuteReader();
            string Sublocation = "", collLocation = "";
            if (dr.Read())
            {
                Sublocation = dr["billsub_loccode"].ToString();
                collLocation = dr["billcol_loccode"].ToString();
                txtbillsubloc.Text = fn.GetLocation(Sublocation) + '~' + Sublocation;
                txtbillcolloc.Text = fn.GetLocation(collLocation) + '~' + collLocation;
                if (Sublocation == "")
                {
                    txtbillsubloc.Text = fn.GetLocation(Session["brcd"].ToString()) + '~' + Session["brcd"].ToString();
                    Sublocation = Session["brcd"].ToString();
                }
                if (collLocation == "")
                {
                    txtbillcolloc.Text = fn.GetLocation(Session["brcd"].ToString()) + '~' + Session["brcd"].ToString();
                    collLocation = Session["brcd"].ToString();
                }

                Lbl_Party_address.Text = dr["custaddress"].ToString();
                Lbl_Party_tellno.Text = dr["telno"].ToString();
                Lbl_Party_Email.Text = dr["emailids"].ToString();
                Lbl_Credit_Limit.Text = dr["credit_limit"].ToString();
                Lbl_Credit_days.Text = dr["credit_day"].ToString();
            }
            else
            {
                txtbillsubloc.Text = fn.GetLocation(Session["brcd"].ToString()) + '~' + Session["brcd"].ToString();
                txtbillcolloc.Text = fn.GetLocation(Session["brcd"].ToString()) + '~' + Session["brcd"].ToString();
            }
            dr.Close();
            sql = "select RUleID+'~'+RULE_value+'~'+rule_Y_N from Webx_Modules_Rules WITH(NOLOCK) where Module_Name in ('Bill Generation')";
            cmd = new SqlCommand(sql, conn);
            dr = cmd.ExecuteReader();
            string[] DR_Value_Arr = null;

            while (dr.Read())
            {
                DR_Value_Arr = dr.GetValue(0).ToString().Split('~');
                if (DR_Value_Arr[0] == "RULE01")
                {
                    BT_Wise_YN = DR_Value_Arr[2];
                }
                else if (DR_Value_Arr[0] == "RULE02")
                {
                    BIll_POD_Approval_YN = DR_Value_Arr[2];
                }
                else if (DR_Value_Arr[0] == "RULE03")
                {
                    Hnd_Mindate.Value = DR_Value_Arr[1];
                }
                else if (DR_Value_Arr[0] == "RULE04")
                {
                    Hnd_Maxdate.Value = DR_Value_Arr[1];
                }
                else if (DR_Value_Arr[0] == "RULE05")
                {
                    Hnd_Mindate.Value = DR_Value_Arr[2];
                }
                else if (DR_Value_Arr[0] == "RULE08")
                {
                    Hnd_OutStd_Limit_Allow.Value = DR_Value_Arr[2];
                }
                else if (DR_Value_Arr[0] == "RULE07")
                {
                    Hnd_BillGen_Loc_BasedOn.Value = DR_Value_Arr[1];
                }
                else if (DR_Value_Arr[0] == "RULE09")
                {
                    Hnd_ON_CR_Limit_Allow.Value = DR_Value_Arr[2];
                }
                else if (DR_Value_Arr[0] == "RULE13")
                {
                    Hnd_manual_billno_Mandatory.Value = DR_Value_Arr[2];
                }
                else if (DR_Value_Arr[0] == "RULE14")
                {
                    Hnd_Duplicate_check.Value = DR_Value_Arr[2];
                }

                //Hnd_Mindate.Value = dr.GetValue(0).ToString();
                //Hnd_AlloW_BackDate.Value = dr.GetValue(1).ToString();
                // Hnd_Maxdate.Value = dr.GetValue(2).ToString();
                //Hnd_BillGen_Loc_BasedOn.Value = dr.GetValue(3).ToString();
            }
            dr.Close();
            string Outstanding_amt = "";
            sql = "exec WebxNet_OutStd_Cust_billLoc '" + collLocation + "', '" + Party_code.ToString() + "'";
            cmd = new SqlCommand(sql, conn);
            dr = cmd.ExecuteReader();
            if (dr.Read())
            {
                Outstanding_amt = dr.GetValue(3).ToString();
            }
            Lbl_Outstanding_amt.Text = Outstanding_amt.ToString();
            conn.Close();
            string billdate;
            billdate = System.DateTime.Now.ToString("dd/MM/yyyy");
            txtbgndt.Text = billdate.ToString(); //System.DateTime.Now.ToShortDateString();
            int Duedays = 0;//Convert.ToInt16(Lbl_Credit_days.Text);
            DateTime dt = DateTime.Today.AddDays(Duedays);
            txtduedate.Text = dt.ToString("dd/MM/yyyy");
            Hnd_Server_dt.Value = System.DateTime.Now.ToString("dd/MM/yyyy");
            txtbgndt.Attributes.Add("onblur", "javascript:MIn_Max_Date_Validation(this,'02','../../../images/Date_Control_Rule_Check.aspx')");
            BindGrid();
        }
        //*******************************************
    }

    public void BindGrid()
    {

        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
        //string sql = "exec webx_UNI_BillGeneration_new '" + fromdt.Trim() + "','" + Todt.Trim() + "','" + Party_code.Trim() + "','" + orgncd.Trim() + "','" + fincmplbr.Trim() + "','" + PAYBAS.Trim() + "','" + TRN_MOD.Trim() + "','" + Businesstype.Trim() + "','" + BIll_POD_Approval_YN.Trim() + "','" + Session["Docketnos"] + "'";
        //string sql = "exec webx_UNI_BillGeneration_new '" + fromdt.Trim() + "','" + Todt.Trim() + "','" + Party_code.Trim() + "','" + orgncd.Trim() + "','" + fincmplbr.Trim() + "','" + PAYBAS.Trim() + "','" + TRN_MOD.Trim() + "','" + Businesstype.Trim() + "','" + BIll_POD_Approval_YN.Trim() + "','" + Session["Docketnos"] + "','" + DocketDelivery + "'";
        string sql = "exec webx_UNI_BillGeneration_new '" + fromdt.Trim() + "','" + Todt.Trim() + "','" + Party_code.Trim() + "','" + orgncd.Trim() + "','" + fincmplbr.Trim() + "','" + PAYBAS.Trim() + "','" + TRN_MOD.Trim() + "','" + Businesstype.Trim() + "','" + BIll_POD_Approval_YN.Trim() + "','" + Session["Docketnos"] + "','" + DocketDelivery + "','" + DateType + "'";
        SqlCommand cmd = new SqlCommand(sql, conn);
        SqlDataAdapter myAdapter = new SqlDataAdapter(cmd);
        DataSet ds = new DataSet();
        myAdapter.Fill(ds, "billdata");
        intTotalRecords = ds.Tables[0].Rows.Count;
        dockdata.DataSource = ds;
        dockdata.DataBind();
        conn.Close();
    }
    protected void pgChange(object sender, GridViewPageEventArgs e)
    {

        BindGrid();

    }

    protected void Button1_Click(object sender, EventArgs e)
    {
        if (IsTokenValid())
        {
            try
            {
		using (var dbObject = new WebXHelper())
                {
                    string YesNo = "";
                    var paraArray = new SqlParameter[1];
                    paraArray[0] = new SqlParameter("@BillDate", SqlDbType.VarChar) { Value = fn.Mydate1(txtbgndt.Text.ToString()) };

                    using (DataTable dt = dbObject.ExecuteDataTable(CommandType.StoredProcedure, "USP_Block_Customer_Bill_Generation", paraArray))
                    {
                        if (dt.Rows.Count > 0)
                        {
                            YesNo = dt.Rows[0]["Flag"].ToString();
                            if (YesNo=="N")
                            {
                                throw new Exception("Bill generation date must be before 01 Jul 2017");
                            }
                        }
                    }
                }
                string sql1 = "";
                Businesstype = Request.QueryString.Get("Businesstype");
                string Loccode = Session["brcd"].ToString();
                string showmessage = "";
                string[] billsubbrcd_arr = txtbillsubloc.Text.ToString().Split('~');
                string billsubbrcd = billsubbrcd_arr[1].ToString();
                string[] billcolbrcd_arr = txtbillcolloc.Text.ToString().Split('~');
                string billcolbrcd = billcolbrcd_arr[1].ToString();
                string Billno = "";
                string bbrcd = Session["brcd"].ToString();
                string bgndt = fn.Mydate1(txtbgndt.Text.ToString());
                string billduedt = fn.Mydate1(txtduedate.Text.ToString());
                string Brnm = fn.GetLocation(bbrcd);
                string Paybas = "2";
                SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
                conn.Open();

                string Bill_Location = Session["brcd"].ToString();
                if (Hnd_BillGen_Loc_BasedOn.Value == "BBRCD")
                {
                    Bill_Location = Session["brcd"].ToString();
                }
                else if (Hnd_BillGen_Loc_BasedOn.Value == "BILLSUBBRCD")
                {
                    Bill_Location = billsubbrcd;
                }
                string sql = "WEBX_Customer_Other";
                SqlCommand cmd = new SqlCommand(sql, conn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@brcd", SqlDbType.VarChar).Value = "";
                cmd.Parameters.Add("@custcd", SqlDbType.VarChar).Value = Party_code.Trim();
                SqlDataReader dr = null;
                dr = cmd.ExecuteReader();
                string PTMSCD = Party_code.Trim();
                string PTMSNM = fn.Getcustomer(Party_code.Trim());
                string PTMSTEL = "";
                string PTMSEMAIL = "";
                string PTMSADDR = "";
                while (dr.Read())
                {
                    PTMSCD = Party_code.Trim();
                    PTMSNM = fn.Getcustomer(Party_code.Trim());
                    PTMSTEL = Convert.ToString(dr["CUSTTEL"]);
                    PTMSEMAIL = Convert.ToString(dr["CUSTEMAIL"]);
                    PTMSADDR = Convert.ToString(dr["CUSTADDRESS"]);
                }
                dr.Close();
                string BILLSTATUS = "Bill Generated";
                string remarks = txtremars.Text.ToString();
                string spe_inst = txtspl_ins.Text.ToString();
                string bgenempcd = Session["empcd"].ToString();
                string BILLAMT = Txt_BillAmt.Text;
                string PENDAMT = Txt_BillAmt.Text;

                string Xml_BillMst = "<root><Bill>";
                //Xml_BillMst = Xml_BillMst + "<Billno>" + Billno.Trim() + "</Billno>";
                Xml_BillMst = Xml_BillMst + "<Bgndt>" + bgndt.Trim() + "</Bgndt>";
                Xml_BillMst = Xml_BillMst + "<Bduedt>" + billduedt.Trim() + "</Bduedt>";
                Xml_BillMst = Xml_BillMst + "<Bbrcd>" + bbrcd.Trim() + "</Bbrcd>";
                Xml_BillMst = Xml_BillMst + "<Brnm>" + Brnm.Trim() + "</Brnm>";
                Xml_BillMst = Xml_BillMst + "<Paybas>" + Paybas.Trim() + "</Paybas>";
                Xml_BillMst = Xml_BillMst + "<PTMSCD>" + PTMSCD.Trim() + "</PTMSCD>";
                Xml_BillMst = Xml_BillMst + "<PTMSNM></PTMSNM>";
                Xml_BillMst = Xml_BillMst + "<PTMSTEL></PTMSTEL>";
                Xml_BillMst = Xml_BillMst + "<PTMSEMAIL></PTMSEMAIL>";
                Xml_BillMst = Xml_BillMst + "<PTMSADDR></PTMSADDR>";
                Xml_BillMst = Xml_BillMst + "<remarks>" + remarks.ToUpper().Trim() + "</remarks>";
                Xml_BillMst = Xml_BillMst + "<BILLAMT>" + BILLAMT.Trim() + "</BILLAMT>";
                Xml_BillMst = Xml_BillMst + "<PENDAMT>" + PENDAMT.Trim() + "</PENDAMT>";
                Xml_BillMst = Xml_BillMst + "<BILLSTATUS>" + BILLSTATUS.Trim() + "</BILLSTATUS>";
                Xml_BillMst = Xml_BillMst + "<billsubbrcd>" + billsubbrcd.Trim() + "</billsubbrcd>";
                Xml_BillMst = Xml_BillMst + "<billcolbrcd>" + billcolbrcd.Trim() + "</billcolbrcd>";
                Xml_BillMst = Xml_BillMst + "<spe_inst>" + spe_inst.ToUpper().Trim() + "</spe_inst>";
                Xml_BillMst = Xml_BillMst + "<Manualbillno>" + txtManualbillno.Text.ToUpper().Trim() + "</Manualbillno>";
                Xml_BillMst = Xml_BillMst + "<TRN_Mod>" + Request.QueryString.Get("trnmod") + "</TRN_Mod>";
                Xml_BillMst = Xml_BillMst + "<Businesstype>" + Businesstype.Trim() + "</Businesstype>";
                Xml_BillMst = Xml_BillMst + "<BillGen_Loc_BasedOn>" + Hnd_BillGen_Loc_BasedOn.Value + "</BillGen_Loc_BasedOn>";
                Xml_BillMst = Xml_BillMst + "<Empcd>" + Session["empcd"].ToString() + "</Empcd>";
                Xml_BillMst = Xml_BillMst + "</Bill></root>";

                string Xml_BillDet = "<root>";

                foreach (DataGridItem gridrow in dockdata.Items)
                {

                    CheckBox chkOrderNo = (CheckBox)gridrow.FindControl("chkOrderNo");
                    Label Lbl_DOckno = (Label)gridrow.FindControl("docketno");
                    if (chkOrderNo.Checked)
                    {
                        Xml_BillDet = Xml_BillDet + "<Det>";
                        Xml_BillDet = Xml_BillDet + "<DOCKNO>" + Lbl_DOckno.Text.Trim() + "</DOCKNO>";
                        Xml_BillDet = Xml_BillDet + "</Det> ";
                    }
                }
                Xml_BillDet = Xml_BillDet + "</root>";
                string Message = CHECK_DOCKET_BILLED(Xml_BillDet);
                if (Message != "")
                {
                    throw new Exception(Message);
                }
                sql = "Usp_Bill_Generate";
                // Response.Write("<br>XML:-" + Xml_BillMst.Replace("&", "&amp;").Trim());
                // Response.Write("<br>XML2:-" + Xml_BillDet.Replace("&", "&amp;").Trim());
                // Response.End();
                SqlCommand sqlCmd = new SqlCommand(sql, conn);
                sqlCmd.CommandType = CommandType.StoredProcedure;
                sqlCmd.Parameters.Add("@Bill_Location", SqlDbType.VarChar).Value = Bill_Location.Trim();
                sqlCmd.Parameters.Add("@Xml_BillMst", SqlDbType.Text).Value = Xml_BillMst.Replace("&", "&amp;").Trim();//xmlTHC.Trim();
                sqlCmd.Parameters.Add("@Xml_BillDet", SqlDbType.Text).Value = Xml_BillDet.Replace("&", "&amp;").Trim();
                sqlCmd.Parameters.Add("@FinYear", SqlDbType.VarChar).Value = Session["FinYear"].ToString().Substring(2, 2).Trim();
                sqlCmd.Parameters.Add("@Businesstype", SqlDbType.VarChar).Value = Businesstype.Trim();
                SqlDataAdapter da = new SqlDataAdapter(sqlCmd);
                DataSet ds = new DataSet();
                da.Fill(ds);
                ConsumeToken();
                da.Dispose();
                Billno = ds.Tables[0].Rows[0]["Billno"].ToString();
                string TranXaction = ds.Tables[0].Rows[0]["TranXaction"].ToString();
                Response.Redirect("genbillsdone2.aspx?billno=" + Billno + "&TranXaction=" + TranXaction);
            }
            catch (Exception ex)
            {
                MsgBox.Show(ex.Message);
            }
        }
    }
    protected void chkDock_CheckedChanged1(object sender, EventArgs e)
    {
        CheckBox checkbox = (CheckBox)sender;
        GridViewRow row = (GridViewRow)checkbox.NamingContainer;
        Response.Write(row.Cells[0].Text);
    }
    public static string CHECK_DOCKET_BILLED(string Xml_BillDet)
    {
        string Cnt = "";
        string Sql = "EXEC USP_CHECK_DOCKET_BILLED '" + Xml_BillDet + "'";
        //DataSet ds = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, Sql);
        object Obj = SqlHelper.ExecuteScalar(SessionUtilities.ConnectionString, CommandType.Text, Sql);
        if (Obj != null)
            Cnt = Obj.ToString();
        return Cnt;
    }
}
