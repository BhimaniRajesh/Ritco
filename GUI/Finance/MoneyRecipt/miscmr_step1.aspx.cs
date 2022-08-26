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

public partial class GUI_Finance_MoneyRecpt_miscmr_step1 : System.Web.UI.Page
{
    MyFunctions fn = new MyFunctions();
    string  Mrsno;
    
    protected void Page_Load(object sender, EventArgs e)
    {
       
        //if (!Page.IsPostBack)
        //{
            TextBox txtchqno = (TextBox)this.chqdetail11.FindControl("txtchqno");
            TextBox txtchqdt = (TextBox)this.chqdetail11.FindControl("txtchqdt");
            TextBox txtindchqamt = (TextBox)this.chqdetail11.FindControl("txtindchqamt");
            HiddenField txtonacctamt = (HiddenField)this.chqdetail11.FindControl("txtonacctamt");
            TextBox txtonacct = (TextBox)this.chqdetail11.FindControl("txtonacct");
            TextBox txtindclamt = (TextBox)this.chqdetail11.FindControl("txtindclamt");
            DropDownList cbopaytype = (DropDownList)this.chqdetail11.FindControl("cbopaytype");
            TextBox colamt = (TextBox)this.chqdetail11.FindControl("colamt");
            TextBox txtbanknm = (TextBox)this.chqdetail11.FindControl("txtbanknm");
            TextBox txtbankbrn = (TextBox)this.chqdetail11.FindControl("txtbankbrn");
            DropDownList tdsacccode = (DropDownList)this.chqdetail11.FindControl("tdsacccode");
            
       
    //}
        cbopaytype.Attributes.Add("onchange", "javascript:return ClAmt(" + netamt.ClientID + ")");
        branchpopup.Attributes.Add("onclick", "popuplist('partycode','" + txtpartycode.ClientID.ToString() + "','none')");
        txtpartycode.Attributes.Add("onblur", " return partyBlur();");
        txtdockno.Attributes.Add("onblur", "return docBlur();");

        //Calculation Of Net Total//
        txtdoordely_chrg.Attributes.Add("onblur", "javascript:return Cal(" + txtdoordely_chrg.ClientID + "," + txtdem_chrg.ClientID + "," + txtwarehouse_chrg.ClientID + "," + txtmathadi_chrg.ClientID + "," + txtother_chrg.ClientID + "," + subtotal.ClientID + "," + tds_rate.ClientID + "," + tds_chrg.ClientID + "," + ded_oth.ClientID + ", " + netamt.ClientID + ")");
        txtdem_chrg.Attributes.Add("onblur", "javascript:return Cal(" + txtdoordely_chrg.ClientID + "," + txtdem_chrg.ClientID + "," + txtwarehouse_chrg.ClientID + "," + txtmathadi_chrg.ClientID + "," + txtother_chrg.ClientID + "," + subtotal.ClientID + "," + tds_rate.ClientID + "," + tds_chrg.ClientID + "," + ded_oth.ClientID + ", " + netamt.ClientID + ")");
        txtwarehouse_chrg.Attributes.Add("onblur", "javascript:return Cal(" + txtdoordely_chrg.ClientID + "," + txtdem_chrg.ClientID + "," + txtwarehouse_chrg.ClientID + "," + txtmathadi_chrg.ClientID + "," + txtother_chrg.ClientID + "," + subtotal.ClientID + "," + tds_rate.ClientID + "," + tds_chrg.ClientID + "," + ded_oth.ClientID + ", " + netamt.ClientID + ")");
        txtmathadi_chrg.Attributes.Add("onblur", "javascript:return Cal(" + txtdoordely_chrg.ClientID + "," + txtdem_chrg.ClientID + "," + txtwarehouse_chrg.ClientID + "," + txtmathadi_chrg.ClientID + "," + txtother_chrg.ClientID + "," + subtotal.ClientID + "," + tds_rate.ClientID + "," + tds_chrg.ClientID + "," + ded_oth.ClientID + ", " + netamt.ClientID + ")");
        txtother_chrg.Attributes.Add("onblur", "javascript:return Cal(" + txtdoordely_chrg.ClientID + "," + txtdem_chrg.ClientID + "," + txtwarehouse_chrg.ClientID + "," + txtmathadi_chrg.ClientID + "," + txtother_chrg.ClientID + "," + subtotal.ClientID + "," + tds_rate.ClientID + "," + tds_chrg.ClientID + "," + ded_oth.ClientID + ", " + netamt.ClientID + ")");
        tds_rate.Attributes.Add("onblur", "javascript:return Cal(" + txtdoordely_chrg.ClientID + "," + txtdem_chrg.ClientID + "," + txtwarehouse_chrg.ClientID + "," + txtmathadi_chrg.ClientID + "," + txtother_chrg.ClientID + "," + subtotal.ClientID + "," + tds_rate.ClientID + "," + tds_chrg.ClientID + "," + ded_oth.ClientID + ", " + netamt.ClientID + ")");
        ded_oth.Attributes.Add("onblur", "javascript:return Cal(" + txtdoordely_chrg.ClientID + "," + txtdem_chrg.ClientID + "," + txtwarehouse_chrg.ClientID + "," + txtmathadi_chrg.ClientID + "," + txtother_chrg.ClientID + "," + subtotal.ClientID + "," + tds_rate.ClientID + "," + tds_chrg.ClientID + "," + ded_oth.ClientID + ", " + netamt.ClientID + ")");
        btnsubmit.Attributes.Add("onclick", "javascript:return Check(" + txtpartycode.ClientID + "," + txtpartyname.ClientID + "," + netamt.ClientID + ")");
        txtdocksf.Attributes.Add("onblur", "javascript:return CheckSf(" + txtdocksf.ClientID + ")");
        if (!Page.IsPostBack)
        {
            txtmrdt.Text = System.DateTime.Now.ToString("dd/MM/yyyy");
        }
        string BranchCode = Session["brcd"].ToString();
        lblBranchCode.Text = BranchCode;
        lblBranchName.Text = GetBranchName();


    }
    protected void btnsubmit_Click(object sender, EventArgs e)
    {

        TextBox txtchqno = (TextBox)this.chqdetail11.FindControl("txtchqno");
        TextBox txtchqdt = (TextBox)this.chqdetail11.FindControl("txtchqdt");
        TextBox txtindchqamt = (TextBox)this.chqdetail11.FindControl("txtindchqamt");
        HiddenField txtonacctamt = (HiddenField)this.chqdetail11.FindControl("txtonacctamt");
        TextBox txtonacct = (TextBox)this.chqdetail11.FindControl("txtonacct");
        TextBox txtindclamt = (TextBox)this.chqdetail11.FindControl("txtindclamt");
        DropDownList cbopaytype = (DropDownList)this.chqdetail11.FindControl("cbopaytype");
        TextBox colamt = (TextBox)this.chqdetail11.FindControl("colamt");
        TextBox txtbanknm = (TextBox)this.chqdetail11.FindControl("txtbanknm");
        TextBox txtbankbrn = (TextBox)this.chqdetail11.FindControl("txtbankbrn");
        DropDownList tdsacccode = (DropDownList)this.chqdetail11.FindControl("tdsacccode");

        string entryby = Session["empcd"].ToString();
        string BranchCode = Session["brcd"].ToString();
        string BranchName = GetBranchName();
                    
        string[] MrDt = txtmrdt.Text.Split('/');
        string MrsDate = Convert.ToDateTime(MrDt[1] + "/" + MrDt[0] + "/" + MrDt[2]).ToString("yyyy/MM/dd");

        Mrsno = fn.MRNogen(Session["brcd"].ToString());

        string PartyCode = "" ;
        string PartyName = "";
        if (txtpartycode.Text == "")
        {
            PartyCode = "8888";
            PartyName = txtpartyname.Text;
        }
        else
        {
            PartyCode = txtpartycode.Text;
            PartyName = GetPartyName();
        }

        string[] TDS = tdsacccode.SelectedValue.Split('~');
        
        double Deduction = Convert.ToDouble(tds_chrg.Text) + Convert.ToDouble(ded_oth.Text);

        SqlConnection con = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        con.Open();
        SqlTransaction trans;
        trans = con.BeginTransaction();
        string Financial_Year = Session["FinYear"].ToString();
        string Voucherno = fn.NextVoucherno(Session["brcd"].ToString(), Financial_Year);
        try
        {
            string qry = "insert into webx_mr_hdr(entryby,entrydt,mrsno,mrssf,mrsdt,mrstype,mrsbr,mrbrnnm,ptcd,ptname,dockno,docksf,";
            qry += "col_door,col_dem,col_ware,col_mathadi,col_oth,mrsamt,tds_rate,ded_tds,ded_oth,netamt,";
            qry += "deduction,mrscash,";
            qry += "paymode,tdsacccode,tdsaccdesc,remark)";
            qry += " values('" + entryby + "','" + DateTime.Now.ToString("yyyy/MM/dd") + "','" + Mrsno + "','.','" + MrsDate + "','6','"+ BranchCode +"','" + BranchName + "','"+ PartyCode +"','" + PartyName + "','" + txtdockno.Text + "',' " + txtdocksf.Text + "',";
            qry += "" + txtdoordely_chrg.Text + "," + txtdem_chrg.Text + "," + txtwarehouse_chrg.Text + "," + txtmathadi_chrg.Text + "," + txtother_chrg.Text + "," + subtotal.Text + "," + tds_rate.Text + "," + tds_chrg.Text + "," + ded_oth.Text + "," + netamt.Text + ",";
            qry += ""+ Deduction +","+ colamt.Text +",";
            qry += "'" + cbopaytype.SelectedItem.Text + "','" + TDS[0].ToString() + "','" + TDS[1].ToString() + "','" + remark.Text + "')";

            SqlCommand cmd = new SqlCommand(qry, con, trans);
            cmd.ExecuteNonQuery();


            if (cbopaytype.SelectedItem.Text != "Cash")
            {
                string[] ChkNo = txtchqno.Text.Split(',');
                string[] ChkDate = txtchqdt.Text.Split(',');
                string[] ChkAmt = txtindchqamt.Text.Split(',');
                string[] BnkName = txtbanknm.Text.Split(',');
                string[] BnkBranch = txtbankbrn.Text.Split(',');
                string[] ClAmt = txtindclamt.Text.Split(',');


                string strSql = "update webx_mr_hdr set mrschqno='" + ChkNo[0].ToString() + "',mrschqdt='" + fn.Mydate1(ChkDate[0].ToString()) + "',mrscash = 0, mrschq = " + colamt.Text + ",mrsbankbr='" + BnkBranch[0].ToString() + "',mrsbank='" + BnkName[0].ToString() + "' where mrsno='" + Mrsno + "' ";
                SqlCommand cmd2 = new SqlCommand(strSql, con, trans);
                cmd2.ExecuteNonQuery();

                strSql = "insert into webx_billchqdetail(chqno,chqdt,chqamt,clamt,banknm,bankbrn,docno,doctype,docsf)values('" + ChkNo[0].ToString() + "','" + fn.Mydate1(ChkDate[0].ToString()) + "'," + ChkAmt[0].ToString() + "," + ChkAmt[0].ToString() + ",'" + BnkName[0].ToString() + "','" + BnkBranch[0].ToString() + "','" + Mrsno + "','" + txtdockno.Text + "','" + txtdocksf.Text + "')";
                cmd2 = new SqlCommand(strSql, con, trans);
                //conn.Open();
                cmd2.ExecuteNonQuery();

                strSql = "select chqamt,adjustamt,banknm from webx_chq_det where chqno='" + ChkNo[0].ToString() + "' and convert(datetime,chqdt,106)=convert(varchar,'" + fn.Mydate1(ChkDate[0].ToString()) + "',106)";
                cmd2 = new SqlCommand(strSql, con, trans);
                SqlDataReader dr = null;
                // conn.Open();
                dr = cmd2.ExecuteReader();
                string chque_yn = "N";
                if (dr.Read())
                {
                    chque_yn = "Y";
                }
                dr.Close();
                if (chque_yn == "Y")
                {
                    strSql = "update webx_chq_det set adjustamt=adjustamt+" + ChkAmt[0].ToString() + " where chqno='" + ChkNo[0].ToString() + "' and convert(datetime,chqdt,106)=convert(varchar," + fn.Mydate1(ChkDate[0].ToString()) + ",106)";
                    
                }
                else
                {
                    strSql = "insert into webx_chq_det(Chqno,chqdt,chqamt,banknm,ptmsptcd,ptmsptnm,comments,bacd,banm,empcd,empnm,brcd,brnm,staffcd,staffnm,adjustamt,bankbrn,chq_trf)";
                    strSql += "values('" + ChkNo[0].ToString() + "','" + fn.Mydate1(ChkDate[0].ToString()) + "'," + ChkAmt[0].ToString() + ",'" + BnkName[0].ToString() + "','" + PartyCode + "','" + PartyName + "','','','','','','" + BranchCode + "','" + BranchName + "','',''," + ClAmt[0].ToString() + ",'" + BnkBranch[0].ToString() + "','')";

                }
                cmd2 = new SqlCommand(strSql, con, trans);
                cmd2.ExecuteNonQuery();
            }



            qry = "exec usp_MiscMRTransaction 1,'" + Mrsno + "','" + Financial_Year + "','"+Session["empcd"].ToString()+ "',''";
            cmd = new SqlCommand(qry, con, trans);
            cmd.ExecuteNonQuery();


            qry = "exec usp_MiscMRTransaction 2,'" + Mrsno + "','" + Financial_Year + "','" + Session["empcd"].ToString() + "','" + Voucherno + "'";
            cmd = new SqlCommand(qry, con, trans);
            cmd.ExecuteNonQuery();

            qry = "exec usp_MiscMRTransaction 3,'" + Mrsno + "','" + Financial_Year + "','" + Session["empcd"].ToString() + "','" + Voucherno + "'";
            cmd = new SqlCommand(qry, con, trans);
            cmd.ExecuteNonQuery();

            qry = "exec usp_MiscMRTransaction 4,'" + Mrsno + "','" + Financial_Year + "','" + Session["empcd"].ToString() + "','" + Voucherno + "'";
            cmd = new SqlCommand(qry, con, trans);
            cmd.ExecuteNonQuery();

            trans.Commit();
            con.Close();
            //Response.Redirect("MIscMR_done.aspx");
            
            lblMessage.Text = "Record Insert Succesfully";
        }
        catch (Exception e1)
        {
            Response.Write("<br><br><br><center><font class='blackboldfnt' color='red'><b>Error : " + e1.Message + "</b></font></center>");
            string msg = e1.Message.ToString();
            msg = msg.Replace('\n', ' ');
            trans.Rollback();
            Response.End();
        }
        Response.Redirect("MIscMR_done.aspx?MrsNo=" + Mrsno);
    }

    public string GetPartyName()
    {
        SqlConnection con = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        con.Open();

        string strSql = "select custnm from webx_custhdr where custcd = '" + txtpartycode.Text + "'";
        SqlCommand cmd = new SqlCommand(strSql, con);
        string res = Convert.ToString(cmd.ExecuteScalar());
        return res;
    }

    public string GetBranchName()
    {
        SqlConnection con = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        con.Open();

        string BranchCode = Session["brcd"].ToString();
        string strSql = "select LocName from webx_location where LocCode = '" + BranchCode + "'";
        SqlCommand cmd = new SqlCommand(strSql, con);
        string res = Convert.ToString(cmd.ExecuteScalar());
        return res;
    }
}
