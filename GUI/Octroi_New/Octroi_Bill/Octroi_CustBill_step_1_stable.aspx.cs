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

        //btnBillSubAt.Attributes.Add("onclick", "popuplist('LocCode','" + txtBillSubAt.ClientID.ToString() + "','none')");
        txtBillSubAt.Attributes.Add("onblur", "PartyLocBlur('" + txtBillSubAt.ClientID.ToString() + "','SubLoc')");
        //btnBillColAt.Attributes.Add("onclick", "popuplist('LocCode','" + txtBillColAt.ClientID.ToString() + "','none')");
        txtBillColAt.Attributes.Add("onblur", "PartyLocBlur('" + txtBillColAt.ClientID.ToString() + "','ColLoc')");
        //btnPartyCode.Attributes.Add("onclick", "popuplist('PartyCode','" + txtPartyCode.ClientID.ToString() + "','none')");
        txtPartyCode.Attributes.Add("onblur", "PartyLocBlur('" + txtPartyCode.ClientID.ToString() + "','Party')");
        txtBillDate.Text = System.DateTime.Now.ToString("dd/MM/yyyy");
        txtDueDate.Text = System.DateTime.Now.AddDays(15).ToString("dd/MM/yyyy");
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        string BillNo = getBillno();
        string[] ArrCustNo = txtPartyCode.Text.Split('~').ToString();
        string CustNo = ArrCustNo[1].ToString();
        string sql = "";

        SqlTransaction tran;
        tran = con.BeginTransaction();

        GridView grvcontrols = (GridView)OctDetails.FindControl("grvcontrols");
        try
        {
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


                if (DockNo != "")
                {
                    string[] ArrRecdt; ;
                    ArrRecdt = RecDt.Split('/');
                    string ReciptDt = Convert.ToDateTime(ArrRecdt[1] + "/" + ArrRecdt[0] + "/" + ArrRecdt[2]).ToString("yyyy/MM/dd");
                    //string ReciptDt = ArrRecdt[1].ToString() + "/" + ArrRecdt[0].ToString() + "/" + ArrRecdt[2].ToString();

                    //sql = "select DKTTOT,SVCTAX,Schg01 As DktChrg,Schg11 as FovChrg,schg14 as DemChrg,reassign_destcd,convert(varchar,dockdt,106) as dockdt,convert(varchar,cdeldt,106) as cdeldt,chrgwt";
                    //sql += " from webx_master_docket_charges a, WebX_Master_Docket b where a.dockno = b.dockno and a.dockno='" + DockNo + "'";

                    sql = "exec usp_Docket_Details '" + DockNo + "'";
                    cmd = new SqlCommand(sql, con, tran);
                    dr = cmd.ExecuteReader();

                    string reasdestcd = "", dockdt = "", cdeldt = "", chrgwt = "", dkttot = "";
                    string dktamt = "", demchg = "", fovchg = "", dktchg = "", svctax = "";


                    while (dr.Read())
                    {
                        reasdestcd = dr["reassign_destcd"].ToString();
                        dockdt = dr["dockdt"].ToString();
                        cdeldt = dr["cdeldt"].ToString();
                        chrgwt = dr["chrgwt"].ToString();
                        dkttot = dr["DKTTOT"].ToString();

                        dktamt = dr["DKTTOT"].ToString();
                        demchg = dr["DemChrg"].ToString();
                        fovchg = dr["FovChrg"].ToString();
                        dktchg = dr["DktChrg"].ToString();
                        svctax = dr["SVCTAX"].ToString();
                    }
                    
                    dr.Close();

                    //string sql_bill = "INSERT INTO webx_BILLDET (BILLNO, DOCKNO, DOCKSF,OCT_AMT,process_chrg,TOTAMT,";
                    //sql_bill += "declval,oct_percentage,clearance_chrg,OTCHG,OCT_RECEIPTNO,processing_per,recptdt,";
                    //sql_bill += "oct_svctax,oct_cess,Oct_High_cess,reassign_destcd,dockdt,cdeldt,chrgwt,dkttot,svrcamt,";
                    //sql_bill += "dktamt,dktchg,fovchg,demchgs)VALUES ('" + BillNo + "','" + DockNo + "','.','";
                    //sql_bill += OctAmt + "','" + Proc_Chrg + "','" + total + "','" + Delval + "','" + OctPer + "','";
                    //sql_bill += Clear_Chrg + "','" + Oth_Chrg + "','" + RecNo + "','" + Proce_per + "','";
                    //sql_bill += ReciptDt + "','" + stax + "','" + cess + "','" + hcess + "','" + reasdestcd + "','";
                    //sql_bill += dockdt + "','" + cdeldt + "','" + chrgwt + "','" + dkttot + "','" + svctax + "','";
                    //sql_bill += dktamt + "','" + dktchg + "','" + fovchg + "','" + demchg + "')";

                    string sql_bill = "exec usp_Insert_webx_billdet '" + BillNo + "','" + DockNo + "','" + OctAmt + "','";
                    sql_bill += Proc_Chrg + "','" + total + "','" + Delval + "','" + OctPer + "','" + Clear_Chrg + "','";
                    sql_bill += Oth_Chrg + "','" + RecNo + "','" + Proce_per + "','" + ReciptDt + "','" + stax + "','";
                    sql_bill += cess + "','" + hcess + "','" + reasdestcd + "','" + dockdt + "','" + cdeldt + "','";
                    sql_bill += chrgwt + "','" + dkttot + "','" + svctax + "','" + dktamt + "','";
                    sql_bill += dktchg + "','" + fovchg + "','" + demchg + "'";

                    cmd = new SqlCommand(sql_bill, con, tran);
                    cmd.ExecuteNonQuery();

                    Boolean dockexist = docket_EXIST(DockNo, con, cmd, tran);

                    if (dockexist)
                    {
                        //sql = "UPDATE webx_oct_det SET billno='" + BillNo + "',DOCKNO='" + DockNo + "',octamt='";
                        //sql += OctAmt + "',recptno='" + RecNo + "',docksf='" + "." + "',recptdt=convert(varchar,'";
                        //sql += ReciptDt + "',106),process_chrg='" + Proc_Chrg + "',declval='" + Delval + "',";
                        //sql += ",oct_percentage='" + OctPer + "',clearance_chrg='" + Clear_Chrg + "',OTCHG='";
                        //sql += Oth_Chrg + "',processing_per='" + Proce_per + "',bill_mr_dt=getdate()";
                        //sql += "',octroipaid_by='" + CustNo + "',oct_Custcd='" + CustNo + "'";
                        //sql += ",customer_paidby='" + Session["EMPCD"].ToString() + "',customer_paidat='";
                        //sql += Session["BRCD"].ToString() + "',customer_paiddt=getdate()";
                        //sql += " where DOCKNO='" + DockNo + "'";

                        sql = "exec usp_Update_webx_oct_det '" + BillNo + "','" + OctAmt + "','" + RecNo + "','" + ReciptDt + "','";
                        sql += Proc_Chrg + "','" + Delval + "','" + OctPer + "','" + Clear_Chrg + "','" + Oth_Chrg + "','";
                        sql += Proce_per + "','" + CustNo + "','" + CustNo + "','" + Session["empcd"].ToString() + "','";
                        sql += Session["brcd"].ToString() + "','" + DockNo + "',NULL,NULL,NULL";

                    }
                    else
                    {
                        //sql = "insert into webx_oct_det (billno,DOCKNO,octamt,recptno,docksf,recptdt,process_chrg,declval,";
                        //sql += "oct_percentage,clearance_chrg,OTCHG,processing_per,bill_mr_dt,octroipaid_by,oct_Custcd,";
                        //sql += "customer_paidby,customer_paidat,customer_paiddt) values('" + BillNo + "','";
                        //sql += DockNo + "','" + OctAmt + "','" + RecNo + "','" + "." + "','" + ReciptDt + "','";
                        //sql += Proc_Chrg + "','" + Delval + "','" + OctPer + "','" + Clear_Chrg + "','" + Oth_Chrg + "','";
                        //sql += Proce_per + "',getdate(),'" + CustNo + "','" + CustNo + "','" + Session["EMPCD"].ToString() + "','";
                        //sql += Session["BRCD"].ToString() + "',getdate())";

                        sql = "exec usp_Insert_webx_oct_det '" + BillNo + "','" + DockNo + "','" + OctAmt + "','";
                        sql += RecNo + "','" + ReciptDt + "','" + Proc_Chrg + "','" + Delval + "','" + OctPer + "','";
                        sql += Clear_Chrg + "','" + Oth_Chrg + "','" + Proce_per + "','" + CustNo + "','" + CustNo + "','";
                        sql += Session["EMPCD"].ToString() + "','" + Session["BRCD"].ToString() + "',NULL,NULL";
                    }

                    cmd = new SqlCommand(sql, con, tran);
                    cmd.ExecuteNonQuery();

                    sql = "update webx_trans_docket_status set octroibill='Y' where DOCKNO='" + DockNo + "'";
                    cmd = new SqlCommand(sql, con, tran);
                    cmd.ExecuteNonQuery();
                }
            }
            string[] ArrBilldt,ArrDueDt;
            ArrBilldt = txtBillDate.Text.Split('/');
            string BillDt = Convert.ToDateTime(ArrBilldt[1] + "/" + ArrBilldt[0] + "/" + ArrBilldt[2]).ToString("yyyy/MM/dd");

            ArrDueDt = txtDueDate.Text.Split('/');
            string DueDt = Convert.ToDateTime(ArrDueDt[1] + "/" + ArrDueDt[0] + "/" + ArrDueDt[2]).ToString("yyyy/MM/dd");

            //sql =  "insert into webx_billmst(billno,billstatus,bbrcd,paybas,ptmscd,bgndt,billsubbrcd,billcolbrcd,";
            //sql += "bduedt,billamt,remark,pendamt,ptmsnm) values('" + BillNo + "','Bill Generated','";
            //sql += Session["BRCD"].ToString() + "','6','" + CustNo + "','" + BillDt + "','";
            //sql += txtBillSubAt.Text + "','" + txtBillColAt.Text + "','" + DueDt + "','";
            //sql += txtBillAmt.Text + "','";
            //sql += txtRemarks.Text + "','" + txtBillAmt.Text + "','" + lblPartyName.Text + "')";

            sql = "exec usp_Insert_webx_billmst '" + BillNo + "','Bill Generated','";
            sql += Session["BRCD"].ToString() + "','6','" + CustNo + "','" + BillDt + "','" + txtBillSubAt.Text + "','";
            sql += txtBillColAt.Text + "','" + DueDt + "','" + txtBillAmt.Text + "','" + txtRemarks.Text + "','";
            sql += txtBillAmt.Text + "','" + lblPartyName.Text + "'";

            cmd = new SqlCommand(sql, con, tran);
            cmd.ExecuteNonQuery();

            sql = "exec usp_OctroiBIllTransaction 1,'" + BillNo + "','" + Financial_Year + "'";
            cmd = new SqlCommand(sql, con, tran);
            cmd.ExecuteNonQuery();

            tran.Commit();
            //tran.Rollback();

        }
        catch (Exception e1)
        {
            Response.Write("<br><br><br><center><font class='blackboldfnt' color='red'><b>Error : " + e1.Message + "</b></font></center>");
            string msg = e1.Message.ToString();
            msg = msg.Replace('\n', ' ');
            tran.Rollback();
            Response.Redirect("../Message.aspx?" + e1.Message);
            Response.End();
        }

        Response.Redirect("Octroi_CustBill_Result.aspx?Billno=" + BillNo);

    }
    public string getBillno()
    {   
        string sqlbillno = "exec sp_get_next_octbill_code '" + Session["brcd"].ToString() + "','" + Financial_Year + "'";
        cmd = new SqlCommand(sqlbillno, con);
        dr = cmd.ExecuteReader();
        
        string NewBillNo = "";
        
        while (dr.Read())
        {
            NewBillNo = dr["NewCode"].ToString();
        }
        
        dr.Close();

        return NewBillNo;
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
