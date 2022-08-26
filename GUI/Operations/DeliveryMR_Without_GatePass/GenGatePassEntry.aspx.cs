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
using WebX.Entity;


public partial class GUI_Operation_DeliveryMR_DeliveryMR : System.Web.UI.Page
{
    string dkt_call, MrLocation, GatePassLocation, DocType, Dockno, suffix;
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            dkt_call = SessionUtilities.DocketCalledAs;
            hdnemployee.Value = SessionUtilities.CurrentEmployeeID.ToUpper();
            txtcurrloc.Text = SessionUtilities.CurrentBranchCode.ToUpper();
            hdnclient.Value = SessionUtilities.Client.ToUpper();

            MrLocation = Request.QueryString["MrLocation"].ToString();
            GatePassLocation = Request.QueryString["GatePassLocation"].ToString();
            DocType = Request.QueryString["Type"].ToString();
            Dockno = Request.QueryString["Dockno"].ToString();
            suffix = Request.QueryString["suffix"].ToString();

            HdnDockNo.Value = Dockno;
            HdnGatePassLoc.Value = GatePassLocation;
            HdnDocType.Value = DocType;
            HdnSuffix.Value = suffix;
            lbldockno.Text = Dockno + suffix;
            txtcurrloc.Text = GatePassLocation;
        }
        catch (Exception ex)
        {
            Response.Redirect("ErrorPage.aspx?heading=Session Expired&detail1=Session Time Out&suggesion1=Log On again and ReTry.", false);
            return;
        }
        if (!IsPostBack)
        {
            trstep2.Style["display"] = "block";
            hdnserverdate.Value = DataProvider.GetServerDate();

            string strsql = "";
            DataTable dt_docket = new DataTable();
            strsql = "SELECT CONVERT(VARCHAR,dockdt,103) AS dockdate,";
            strsql = strsql + "paymentbas,service_class,ftl_types,businesstype,orgncd,reassign_destcd as delloc,from_loc,to_loc,";
            strsql = strsql + " paybas,party_code,csgecd,csgenm,pkgsno,trn_mod,prodcd,diplomat,stax_exmpt_yn,stax_paidby,";
            strsql = strsql + " dacc_yn,cod_dod,insuyn,packtype,CONVERT(VARCHAR,cdeldt,106) AS edd,chrgwt,convert(varchar,arrived_dt,106) as ArrivedDate,";
            strsql = strsql + " prodcd=ISNULL(GP.CodeID,'08'),csgecd,csgenm,stax_exmpt_yn,CONVERT(INT,pkgsno) AS totpkgs,stax_paidby,curr_loc,invamt,product=ISNULL(GP.codedesc,prodcd),";
            strsql = strsql + " godown=(SELECT godown_desc AS godownname FROM dbo.webx_godownmst WITH(NOLOCK) WHERE godown_srno=s.godown),isNULL(arrpkgqty,0) as arrpkgqty,isNULL(arrweightqty,0) as arrweightqty";
            strsql = strsql + " FROM dbo.webx_master_docket d WITH(NOLOCK) INNER JOIN dbo.webx_trans_docket_status s WITH(NOLOCK)";
            strsql = strsql + " ON d.dockno=s.dockno";
            strsql = strsql + " CROSS APPLY(SELECT codedesc AS packtype FROM dbo.webx_master_general WITH(NOLOCK) WHERE codetype='PKGS' AND codeid=pkgsty)pkty";
            strsql = strsql + " CROSS APPLY(SELECT codedesc AS paymentbas FROM dbo.webx_master_general WITH(NOLOCK) WHERE codetype='PAYTYP' AND codeid=paybas)pytp";
            //strsql = strsql + " CROSS APPLY(SELECT codedesc AS product FROM dbo.webx_master_general WITH(NOLOCK) WHERE codetype='PROD' AND codeid=prodcd)prdcd";
            strsql = strsql + " LEFT OUTER JOIN dbo.webx_master_general GP WITH(NOLOCK) ON GP.CodeType='PROD' AND GP.codeid=prodcd";
            strsql = strsql + " WHERE d.dockno='" + HdnDockNo.Value + "' AND s.docksf='" + HdnSuffix.Value + "'";
            dt_docket = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, strsql).Tables[0];

            hdndockdate.Value = dt_docket.Rows[0]["dockdate"].ToString();
            TxtGatePassDate.Text = hdnserverdate.Value;
            //lblpaybas.Text = dt_docket.Rows[0]["paymentbas"].ToString();
            hdnservicetype.Value = dt_docket.Rows[0]["service_class"].ToString();
            hdnftltype.Value = dt_docket.Rows[0]["ftl_types"].ToString();
            hdnbusinesstype.Value = dt_docket.Rows[0]["businesstype"].ToString();
            hdnorgnloc.Value = dt_docket.Rows[0]["orgncd"].ToString();
            hdndelloc.Value = dt_docket.Rows[0]["delloc"].ToString();
            hdnfrom.Value = dt_docket.Rows[0]["from_loc"].ToString();
            hdnto.Value = dt_docket.Rows[0]["to_loc"].ToString();
            hdnpaybas.Value = dt_docket.Rows[0]["paybas"].ToString();
            hdnpartycode.Value = dt_docket.Rows[0]["party_code"].ToString();
            hdnpartyname.Value = DataProvider.GetCustomerName(hdnpartycode.Value);
            hdncsgecd.Value = dt_docket.Rows[0]["csgecd"].ToString();
            hdncsgenm.Value = dt_docket.Rows[0]["csgenm"].ToString();

            hdnpkgsno.Value = dt_docket.Rows[0]["pkgsno"].ToString();
            hdnchargedweight.Value = Convert.ToDouble(dt_docket.Rows[0]["chrgwt"].ToString()).ToString("F0");
            hdntransmode.Value = dt_docket.Rows[0]["trn_mod"].ToString();
            hdnprodtype.Value = dt_docket.Rows[0]["prodcd"].ToString();
            hdnflagoda.Value = dt_docket.Rows[0]["diplomat"].ToString();
            hdnflagstaxempted.Value = dt_docket.Rows[0]["stax_exmpt_yn"].ToString().ToUpper();
            hdnstaxpayer.Value = dt_docket.Rows[0]["stax_paidby"].ToString();
            hdnflagdacc.Value = dt_docket.Rows[0]["dacc_yn"].ToString();
            hdnflagcoddod.Value = dt_docket.Rows[0]["cod_dod"].ToString();
            hdnrisktype.Value = dt_docket.Rows[0]["insuyn"].ToString();
            //lblProductType.Text = dt_docket.Rows[0]["product"].ToString();
            //lblnoOfPkgs.Text = dt_docket.Rows[0]["pkgsno"].ToString();
            lblUnLoadingDate.Text = dt_docket.Rows[0]["ArrivedDate"].ToString();

            string Mrflag = "N", strPartyCode = "", strPartyName = "";
            strsql = "Select PTCD,PTNAME from Webx_Mr_Hdr where ISNULL(Mr_cancel,'N')='N' AND MRSTYPE='12' AND Dockno='" + HdnDockNo.Value + "' and Docksf='" + HdnSuffix.Value + "'";
            DataTable dt_MR = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, strsql).Tables[0];
            if (dt_MR.Rows.Count > 0)
            {
                Mrflag = "Y";
                strPartyCode = dt_MR.Rows[0]["PTCD"].ToString();
                strPartyName = dt_MR.Rows[0]["PTNAME"].ToString();
            }
            if (hdnpaybas.Value.CompareTo("P02") == 0)
            {
                if (dt_docket.Rows[0]["csgecd"].ToString().CompareTo("8888") == 0)
                {
                    txtpartyw.Text = dt_docket.Rows[0]["csgenm"].ToString();
                }
                else
                {
                    if (Mrflag == "Y")
                    {
                        txtpartycode.Text = strPartyCode;
                        txtpartyname.Text = strPartyName;
                    }
                    else
                    {
                        txtpartycode.Text = dt_docket.Rows[0]["csgecd"].ToString();
                        txtpartyname.Text = DataProvider.GetCustomerName(dt_docket.Rows[0]["csgecd"].ToString());
                    }
                }
                optpartytype.SelectedValue = "P";
                trpartyw.Style["display"] = "none";
                trpartyc.Style["display"] = "none";
                trcneewc.Style["display"] = "none";
            }
            else
            {
                optpartytype.SelectedValue = "CE";
                trpartytype.Style["display"] = "none";
            }
            if (dt_docket.Rows[0]["csgecd"].ToString().CompareTo("8888") != 0)
            {
                optpartyc.Checked = true;
                optpartyw.Checked = false;
                txtpartycode.Text = dt_docket.Rows[0]["csgecd"].ToString();
                txtpartyname.Text = DataProvider.GetCustomerName(dt_docket.Rows[0]["csgecd"].ToString());
                trpartyw.Style["display"] = "none";
                trpartyc.Style["display"] = "block";
            }
            else
            {
                optpartyc.Checked = false;
                optpartyw.Checked = true;
                txtpartyw.Text = dt_docket.Rows[0]["csgenm"].ToString();
                trpartyw.Style["display"] = "block";
                trpartyc.Style["display"] = "none";
            }

            if (hdncsgecd.Value.CompareTo("8888") == 0)
                hdncsgecd.Value = "";

            hdncurrloc.Value = dt_docket.Rows[0]["curr_loc"].ToString();

            hdndeclval.Value = dt_docket.Rows[0]["invamt"].ToString();
            hdnarrpkgqty.Value = dt_docket.Rows[0]["arrpkgqty"].ToString();
            hdnarrweightqty.Value = dt_docket.Rows[0]["arrweightqty"].ToString();

            try
            {
                hdnfinstartyear.Value = Session["finyear"].ToString();
            }
            catch (Exception ex)
            {
                Response.Redirect("ErrorPage.aspx?heading=Session Expired&detail1=Session Time Out&suggesion1=Log On again and ReTry.", false);
                return;
            }
        }
    }
    protected void btnstep2_Click(object sender, EventArgs e)
    {
        DateTime dtdockdate, dtmrdate, dtserverdate;
        dtdockdate = WebXConvert.ToDateTime(hdndockdate.Value, "en-GB");
        dtserverdate = WebXConvert.ToDateTime(hdnserverdate.Value, "en-GB");
        dtmrdate = WebXConvert.ToDateTime(TxtGatePassDate.Text, "en-GB");

        if (dtmrdate < dtdockdate)
        {
            Response.Redirect("ErrorPage.aspx?heading=Not allowed for Gate Pass&detail1=Gate Pass Date is less than " + hdndockname.Value + " Date&Suggestion1=Please Enter MR Date properly&detail2=.", false);
            return;
        }
        if (dtmrdate > dtserverdate)
        {
            Response.Redirect("ErrorPage.aspx?heading=Not allowed for Delivery MR&detail1=MR Date is more than Today's Date&Suggestion1=Please Enter MR Date Today's date or Back Date&detail2=.", false);
            return;
        }

        disableStep2();

        string strXMLGatepassEntry;
        strXMLGatepassEntry = "";
        strXMLGatepassEntry = GetGatePassObject();
        strXMLGatepassEntry = strXMLGatepassEntry.Replace("&", "&amp;");

        SqlConnection con = new SqlConnection(Session["SqlProvider"].ToString());
        con.Open();

        SqlTransaction trn = con.BeginTransaction();
        
        DataTable dtmr = new DataTable();
        try
        {
            dtmr = DeliveryMRGatePassEntry(strXMLGatepassEntry, trn);
        }
        catch (Exception ex)
        {
            trn.Rollback();
            con.Close();
            Response.Redirect("../ErrorPage.aspx?heading=Delivery MR Entry Failed&detail1=" + ex.Message.Replace('\n', '_'), false);
            return;
        }
        trn.Commit();
        con.Close();

        Response.Redirect("GatePass_done.aspx?GATEPASSNO=" + dtmr.Rows[0]["GATEPASSNO"].ToString() , false);
    }
    private string GetGatePassObject()
    {
        string strXMLGPEntry = "<root><gatepass_entry>"
        + "<gpbrcd>" + HdnGatePassLoc.Value + "</gpbrcd>"
        + "<dockno>" + HdnDockNo.Value + "</dockno>"
        + "<docksf>" + HdnSuffix.Value + "</docksf>"
        + "<gatepassdate>" + WebXConvert.ToDateTime(TxtGatePassDate.Text, "en-GB").ToString("dd MMM yyyy") + "</gatepassdate>";
        if (hdnpaybas.Value.CompareTo("P02") == 0)
        {
            if (optpartytype.SelectedValue.CompareTo("P") == 0)
            {
                if (hdnpartycode.Value.CompareTo("") == 0)
                {
                    Response.Redirect("ErrorPage.aspx?heading=Party Code Missing.&detail1=&suggesion1=", false);
                }
                strXMLGPEntry = strXMLGPEntry + "<ptcd>" + hdnpartycode.Value + "</ptcd>" + "<ptname>" + hdnpartyname.Value + "</ptname>";
            }
            else
            {
                if (optpartyc.Checked == true)
                {
                    strXMLGPEntry = strXMLGPEntry + "<ptcd>" + txtpartycode.Text + "</ptcd>" + "<ptname>" + txtpartyname.Text + "</ptname>";
                }
                else
                {
                    strXMLGPEntry = strXMLGPEntry + "<ptcd>8888</ptcd>" + "<ptname>" + txtpartyw.Text + "</ptname>";
                }
            }
        }
        else
        {
            if (optpartyc.Checked == true)
            {
                strXMLGPEntry = strXMLGPEntry + "<ptcd>" + txtpartycode.Text + "</ptcd>" + "<ptname>" + txtpartyname.Text + "</ptname>";
            }
            else
            {
                strXMLGPEntry = strXMLGPEntry + "<ptcd>8888</ptcd>" + "<ptname>" + txtpartyw.Text + "</ptname>";
            }
        }
        if (optrecc.Checked == true)
        {
            strXMLGPEntry = strXMLGPEntry + "<receivercode>" + txtreceivercode.Text + "</receivercode>";
            strXMLGPEntry = strXMLGPEntry + "<receivername>" + txtreceivername.Text + "</receivername>";
        }
        else
        {
            strXMLGPEntry = strXMLGPEntry + "<receivercode>8888</receivercode>";
            strXMLGPEntry = strXMLGPEntry + "<receivername>" + txtreceiverw.Text + "</receivername>";
        }
        strXMLGPEntry = strXMLGPEntry + "<delvehicle>" + txtdelvehicle.Text + "</delvehicle>";
        strXMLGPEntry = strXMLGPEntry + "<remarks>" + txtremarks.Text + "</remarks>";
        strXMLGPEntry = strXMLGPEntry + "<activeflag>Y</activeflag>";
        strXMLGPEntry = strXMLGPEntry + "<entryby>" + hdnemployee.Value + "</entryby>";
        strXMLGPEntry = strXMLGPEntry + "<entrydate>GETDATE()</entrydate></gatepass_entry></root>";
        return strXMLGPEntry;
    }
    protected void disableStep2()
    {
        trbtnstep2.Style["display"] = "none";
        txtdelvehicle.Enabled = false;
        txtremarks.Enabled = false;

        txtpartycode.Enabled = false;
        txtpartyname.Enabled = false;
        txtpartyw.Enabled = false;
        btnpartypopup.Disabled = true;
        optpartyw.Enabled = false;
        optpartyc.Enabled = false;
        optpartytype.Enabled = false;
        if (optpartytype.SelectedValue.CompareTo("P") == 0)
        {
            trcneewc.Style["display"] = "none";
            trpartyc.Style["display"] = "none";
            trpartyw.Style["display"] = "none";
        }
        else
        {
            trcneewc.Style["display"] = "block";
            if (optpartyc.Checked == true)
            {
                trpartyc.Style["display"] = "block";
                trpartyw.Style["display"] = "none";
            }
            else
            {
                trpartyc.Style["display"] = "none";
                trpartyw.Style["display"] = "block";
            }

        }

        btnpartypopup.Disabled = true;
        optrecc.Enabled = false;
        optrecw.Enabled = false;
        txtreceivercode.Enabled = false;
        txtreceivername.Enabled = false;
        txtreceiverw.Enabled = false;


        if (optrecc.Checked == true)
        {
            trrecc.Style["display"] = "block";
            trrecw.Style["display"] = "none";
        }
        else
        {
            trrecc.Style["display"] = "none";
            trrecw.Style["display"] = "block";
        }     
    }
    public DataTable DeliveryMRGatePassEntry(string strXMLGatepassEntry, SqlTransaction trn)
    {
        DataTable dt = new DataTable();
        try
        {
            SqlParameter[] paramsToStore = new SqlParameter[1];
            paramsToStore[0] = ControllersHelper.GetSqlParameter("@strXMLGatepassEntry", strXMLGatepassEntry, SqlDbType.NVarChar);
            dt = SqlHelper.ExecuteDataset(trn, CommandType.StoredProcedure, "USP_GATEPASS_GENERATION", paramsToStore).Tables[0];

        }
        catch (Exception excp)
        {
            throw excp;
        }

        return dt;
    }
}