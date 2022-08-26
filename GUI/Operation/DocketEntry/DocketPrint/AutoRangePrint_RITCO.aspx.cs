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
using System.Drawing.Printing;
using System.IO;
using System.Drawing;
using System.Data.SqlClient;
using Microsoft.ApplicationBlocks.Data;
using WebX.Entity;
using WebX.Controllers;

public partial class GUI_Operation_DocketEntry_DocketPrint_AutoPrint : System.Web.UI.Page
{
    SqlConnection con;
    MyFunctions fn;
    DataTable dtdocket;
    protected void Page_Load(object sender, EventArgs e)
    {

        string tp = Request.QueryString["tp"].ToString();

        hdnchargerule.Value = DocketRules.GetDefaultValue("CHRG_RULE");
        string sqlstr = "SELECT Discount,DiscountRate,DiscountType,d.dockno,orgnaddr,deladdr,booktime=CONVERT(varchar,dockdt_entry,108),dockdate=CONVERT(varchar,dockdt,103),from_loc AS fromcity,to_loc AS tocity,";
        sqlstr = sqlstr + "csgnaddr=CASE WHEN CSGNCD<>'8888' THEN WCN.CUSTNM else csgnnm end,csgeaddr=CASE WHEN CSGECD<>'8888' THEN WCE.CUSTNM ELSE csgenm END ,privatemark,";
        sqlstr = sqlstr + " paynote=(SELECT codedesc FROM webx_master_general WHERE codetype='PAYTYP' AND codeid=d.paybas) + '  ' + CONVERT(VARCHAR,c.dkttot),";
        sqlstr = sqlstr + " packprod=packname + ' - ' + prodname,insupl AS policyno,policydate=(CASE WHEN insupldt>'01 Jan 1990' THEN CONVERT(varchar,insupldt,103) ELSE '' END),invamt,invno,invdt,";
        sqlstr = sqlstr + " frt_rate,pkgsno=CONVERT(NUMERIC,pkgsno),dkttot,chrgwt,actuwt,service_class,businesstype,freight,reprint,spl_svc_req=CASE WHEN ISNULL(GSTIN,'')!='' THEN 'GST No. '+GSTIN+' .GST by Customer' ELSE 'GST No. not provided. GST  by Transporter' end ";
        sqlstr = sqlstr + " FROM webx_master_docket d";
        sqlstr = sqlstr + " INNER JOIN webx_master_docket_charges c ON d.dockno=c.dockno";
        sqlstr = sqlstr + " INNER JOIN webx_trans_docket_status s ON s.dockno=d.dockno";
	sqlstr = sqlstr + " INNER JOIN dbo.webx_CUSTHDR WCN ON WCN.CUSTCD=d.CSGNCD";
        sqlstr = sqlstr + " INNER JOIN dbo.webx_CUSTHDR WCE ON WCE.CUSTCD=d.CSGECD";
        sqlstr = sqlstr + " CROSS APPLY (SELECT (LocAddr+' Person Name '+(case when LocFaxno='' then '           ,' else LocFaxno end)+', Mobile No '+(case when Locmobile='' then '           ' else Locmobile  end)) As deladdr FROM webx_location WHERE loccode=reassign_destcd)orlc";
        sqlstr = sqlstr + " CROSS APPLY (SELECT locaddr AS orgnaddr FROM webx_location WHERE loccode=orgncd)delc";
        sqlstr = sqlstr + " CROSS APPLY (SELECT codedesc AS paybasname FROM webx_master_general WHERE codetype='PAYTYP' AND codeid=paybas)payname";
        sqlstr = sqlstr + " CROSS APPLY (SELECT codedesc AS modename FROM webx_master_general WHERE codetype='TRN' AND codeid=trn_mod)trnanme";
        //sqlstr = sqlstr + " CROSS APPLY (SELECT codedesc AS prodname FROM webx_master_general WHERE codetype='PROD' AND codeid=prodcd)prodname";
        sqlstr = sqlstr + " CROSS APPLY ( SELECT Count(codeid) PROD_CNT FROM webx_master_general WHERE codetype='PROD' AND codeid=prodcd )prodname_Cnt";
        sqlstr = sqlstr + " CROSS APPLY ( SELECT prodname=(CASE WHEN PROD_CNT=0 THEN 'OTHERS'+'-'+prodcd ELSE (SELECT top 1 (codedesc) AS prodname FROM webx_master_general WHERE codetype='PROD' AND codeid=prodcd) END))productname";
        sqlstr = sqlstr + " CROSS APPLY (SELECT codedesc AS businessname FROM webx_master_general WHERE codetype='BUT' AND codeid=businesstype)busname";
        sqlstr = sqlstr + " CROSS APPLY (SELECT codedesc AS packname FROM webx_master_general WHERE codetype='PKGS' AND codeid=pkgsty)packname";


        if (tp.CompareTo("0") == 0)
        {
            string strdocknos = Request.QueryString["docknos"].ToString();
            strdocknos = strdocknos.Replace(",", "','");
            sqlstr = sqlstr + " WHERE d.dockno IN ('" + strdocknos + "') AND (orgncd='" + Session["brcd"].ToString() + "'  OR 'HQTR'='" + Session["brcd"].ToString() + "') AND ISNULL(s.cancelled,'N')='N'";
        }
        else if (tp.CompareTo("1") == 0)
        {
            string start = "", end = "";
            start = Request.QueryString["start"].ToString();
            end = Request.QueryString["end"].ToString();
            sqlstr = sqlstr + " WHERE (d.dockno BETWEEN '" + start + "' AND '" + end + "') AND LEN(d.dockno)=LEN('" + start + "') AND (orgncd='" + Session["brcd"].ToString() + "'  OR 'HQTR'='" + Session["brcd"].ToString() + "') AND ISNULL(s.cancelled,'N')='N' ORDER BY d.dockno";
        }

        DataTable dt = new DataTable();
        dt = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, sqlstr).Tables[0];

        rptmain.DataSource = dt;
        rptmain.DataBind();
    }

    protected double returnDouble(string num)
    {
        if (num.ToString().CompareTo("") == 0 || num is DBNull)
        {
            num = "0";
        }

        try
        {
            return Convert.ToDouble(num);
        }
        catch (Exception ex)
        {
            return 0.00;
        }
    }

    protected void rptmain_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
        {
            Label lbldockno = e.Item.FindControl("lbldockno") as Label;
            Label lbldupcop1 = e.Item.FindControl("lbldupcop1") as Label;
            Label lbldupcop2 = e.Item.FindControl("lbldupcop2") as Label;
            Label lblprintby = e.Item.FindControl("lblprintby") as Label;
            Label lblDiscount = e.Item.FindControl("lblDiscount") as Label;

            lblprintby.Text = SessionUtilities.CurrentEmployeeID;

            DataRow dr = (e.Item.DataItem as DataRowView).Row as DataRow;

            if (dr["DiscountType"].ToString() == "B")
            {
                lblDiscount.Text = "Discount " + dr["DiscountRate"].ToString() + " % on Basic Freight";
            }
            else if (dr["DiscountType"].ToString() == "F")
            {
                lblDiscount.Text = "Discount " + dr["Discount"].ToString() + " rs. Flat on Freight";
            }
            else if (dr["DiscountType"].ToString() == "P")
            {
                lblDiscount.Text = "Discount " + dr["DiscountRate"].ToString() + " on Per Pkg";
            }

            string dbflag = dr["reprint"].ToString();

            string reprint = "0";
            try
            { reprint = Request.QueryString["reprint"].ToString(); }
            catch (Exception ex) { }

            Table tblmain = e.Item.FindControl("tblmain") as Table;
            tblmain.Visible = true;

            if (dbflag == "Y" && reprint == "0")
            {
                tblmain.Visible = false;
            }
            else if (dbflag == "Y" && reprint == "1")
            {
                lbldupcop1.Visible = true;
                lbldupcop2.Visible = true;
            }

            string servicetype = dr["service_class"].ToString();
            string businesstype = dr["businesstype"].ToString();

            string strsql = "";
            strsql = "SELECT chargevalue=0.00,chargename,chargecode FROM webx_master_charge WHERE basedon='BUT' AND basecode='" + businesstype + "' AND activeflag='Y' AND chargetype='DKT' AND booktimeflag='Y' ";//UNION ALL select chargevalue=0.00,chargename='Discount(-)',chargecode='Discount' 

            DataTable dtcharges = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, strsql).Tables[0];
            

            strsql = "SELECT GSTCharged=isnull(GSTCharged,0.00),GSTAmount=isnull(GSTAmount,0.00) ,Discount=isnull(Discount,0.00),* FROM webx_master_docket_charges WHERE dockno='" + lbldockno.Text + "'";
            //servicetax=isnull(svctax,0)+isnull(cess,0)+ isnull(SBCess,0) + isnull(KKCess,0)
            GridView grvcharge = (GridView)e.Item.FindControl("grvcharges");

            DataRow drcharge = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, strsql).Tables[0].Rows[0];

            DataRow drsevicetax = dtcharges.NewRow();
            drsevicetax["chargename"] = "GST Amount";
            drsevicetax["chargecode"] = "GSTAmount";
            drsevicetax["chargevalue"] = drcharge["GSTAmount"].ToString();

            DataRow drsevicetax1 = dtcharges.NewRow();
            drsevicetax1["chargename"] = "GST Charged";
            drsevicetax1["chargecode"] = "GSTCharged";
            drsevicetax1["chargevalue"] =drcharge["GSTCharged"].ToString();

            for (int i = 0; i < dtcharges.Rows.Count; i++)
            {
                dtcharges.Rows[i]["chargevalue"] = drcharge[dtcharges.Rows[i]["chargecode"].ToString()];
            }

            bool isRiskChargeApplied = false;
            for (int i = 0; i < dtcharges.Rows.Count; i++)
            {
                if (dtcharges.Rows[i]["chargecode"].ToString() == "SCHG16")
                {
                    if (Convert.ToDouble(dtcharges.Rows[i]["chargevalue"]) > 0)
                    {
                        isRiskChargeApplied = true;
                    }
                }
            }
            Label lbldockdate = e.Item.FindControl("lbldockdate") as Label;
            MyFunctions mf = new MyFunctions();
            if (Convert.ToDateTime(mf.Mydate1(lbldockdate.Text)) > new DateTime(2013, 12, 30))
            {
                isRiskChargeApplied = true;
            }
            var index = -1;
            if (isRiskChargeApplied)
            {
                for (int i = 0; i < dtcharges.Rows.Count; i++)
                {
                    if (dtcharges.Rows[i]["chargecode"].ToString() == "SCHG11")
                    {
                        index = i;
                    }
                }
                if (index > -1)
                {
                    dtcharges.Rows.RemoveAt(index);
                }
            }
            else
            {
                for (int i = 0; i < dtcharges.Rows.Count; i++)
                {
                    if (dtcharges.Rows[i]["chargecode"].ToString() == "SCHG16")
                    {
                        index = i;
                    }
                }
                if (index > -1)
                {
                    dtcharges.Rows.RemoveAt(index);
                }
            }

            //drsevicetax["chargevalue"] = drcharge["servicetax"].ToString();
            dtcharges.Rows.Add(drsevicetax);
            dtcharges.Rows.Add(drsevicetax1);
            grvcharge.DataSource = dtcharges;
            grvcharge.DataBind();

            string strqry = "UPDATE WebX_Trans_Docket_Status WITH(ROWLOCK) SET reprint='Y' WHERE dockno='" + lbldockno.Text.ToString() + "'";
            SqlHelper.ExecuteNonQuery(SessionUtilities.ConnectionString, CommandType.Text, strqry);

        }
    }

}
