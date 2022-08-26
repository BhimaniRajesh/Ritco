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
using WebX.Controllers;
using Microsoft.ApplicationBlocks.Data;


public partial class GUI_Operation_DocketEditFields_DocketEditFields : System.Web.UI.Page
{
    SqlConnection con;
    MyFunctions fn;
    protected void Page_Load(object sender, EventArgs e)
    {
        hdndockno.Value = Request.QueryString["dockno"].ToString();
        fn = new MyFunctions();
        hdnrequestcode.Value = Request.QueryString["requestcode"].ToString();
        con = new SqlConnection(Session["SqlProvider"].ToString());
        con.Open();

        hdnfinyear2d.Value = Session["finyear"].ToString().Substring(2, 2);
        int a = Convert.ToInt16(hdnfinyear2d.Value);
        a++;
        hdnfinyear2d.Value = hdnfinyear2d.Value + "_" + a.ToString().PadLeft(2, '0');
        if (!IsPostBack)
        {
            lbldockno.Text = hdndockno.Value;
            switch (hdnrequestcode.Value)
            {
                case "custinfo":
                    divcustinfo.Style["display"] = "block";
                    divfields.Style["display"] = "none";
                    custInfo();
                    break;
                case "spcinst":
                    spcInst();
                    break;
                case "obdno":
                    obdNo();
                    break;
                case "localflag":
                    localFlag();
                    break;
                case "bustype":
                    businessType();
                    break;
                case "pickupdel":
                    pickUpDel();
                    break;
                case "pmark":
                    privateMark();
                    break;
                case "custrefno":
                    custRefNo();
                    break;
                case "billedat":
                    billedAt();
                    break;

            }
        }
    }

    protected void btnsubmit_Click(object sender, EventArgs e)
    {
        switch (hdnrequestcode.Value)
        {
            case "spcinst":
                saveSpcInst();
                break;
            case "obdno":
                saveOBDno();
                break;
            case "localflag":
                saveLocalFlag();
                break;
            case "bustype":
                saveBusinessType();
                break;
            case "pickupdel":
                savePickUpDel();
                break;
            case "custrefno":
                saveCustRefNo();
                break;
            case "pmark":
                savePrivateMark();
                break;
            case "billedat":
                saveBilledAt();
                break;

        }
        Response.Redirect("Docket_Submit_Done.aspx?dockno=" + hdndockno.Value);
    }
    
    protected void custRefNo()
    {
        lbldesc.Text = "Customer Reference No";
        trcmb.Style["display"] = "none";
        trchk.Style["display"] = "none";
        string sqlstr = "SELECT ctr_no FROM webx_master_docket WHERE dockno='" + hdndockno.Value + "'";
        SqlCommand cmd = new SqlCommand(sqlstr, con);
        txtone.Text = Convert.ToString(cmd.ExecuteScalar());

        divfields.Style["display"] = "block";
        divcustinfo.Style["display"] = "none";
        txttwo.Style["display"] = "none";
        txtone.Width = 200;
        txtone.TextMode = TextBoxMode.MultiLine;
        btnpartypopup.Style["display"] = "none";
    }

    protected void billedAt()
    {
        lbldesc.Text = "Billed At";
        trcmb.Style["display"] = "none";
        trchk.Style["display"] = "none";
        string sqlstr = "SELECT fincmplbr FROM webx_master_docket WHERE dockno='" + hdndockno.Value + "'";
        SqlCommand cmd = new SqlCommand(sqlstr, con);
        txtone.Text = Convert.ToString(cmd.ExecuteScalar());

        divfields.Style["display"] = "block";
        divcustinfo.Style["display"] = "none";
        txttwo.Style["display"] = "none";
        txtone.Attributes.Add("onblur", "javascript:return locTest(this.getAttribute('id'),'partybillloc')");
        txtone.Width = 200;
        btnpartypopup.Style["display"] = "none";
    }
    
    protected void privateMark()
    {
        lbldesc.Text = "Private Mark";
        trcmb.Style["display"] = "none";
        trchk.Style["display"] = "none";
        string sqlstr = "SELECT privatemark FROM webx_master_docket WHERE dockno='" + hdndockno.Value + "'";
        SqlCommand cmd = new SqlCommand(sqlstr, con);
        txtone.Text = Convert.ToString(cmd.ExecuteScalar());

        divfields.Style["display"] = "block";
        divcustinfo.Style["display"] = "none";
        txttwo.Style["display"] = "none";
        txtone.Width = 200;
        txtone.TextMode = TextBoxMode.MultiLine;
        btnpartypopup.Style["display"] = "none";
    }

    protected void pickUpDel()
    {
        lbldesc.Text = "PickUp Delivery";
        trtxt.Style["display"] = "none";
        trchk.Style["display"] = "none";
        divcustinfo.Style["display"] = "none";
        lbllistname.Text = "PickUp Delivery Type";

        cmblist.Items.Add(new ListItem("Select", "0"));
        cmblist.Items.Add(new ListItem("Godown Pickup - Godown Delivery", "1"));
        cmblist.Items.Add(new ListItem("Godown Pickup - Door Delivery", "2"));
        cmblist.Items.Add(new ListItem("Door Pickup - Godown Delivery", "3"));
        cmblist.Items.Add(new ListItem("Door Pickup - Door Delivery", "4"));

        string sqlstr = "SELECT pickup_dely FROM webx_master_docket WHERE dockno='" + hdndockno.Value + "'";
        SqlCommand cmd = new SqlCommand(sqlstr, con);
        cmblist.SelectedValue = Convert.ToString(cmd.ExecuteScalar()).Trim();

    }

    protected void businessType()
    {
        lbldesc.Text = "OBD No";
        trtxt.Style["display"] = "none";
        trchk.Style["display"] = "none";
        divcustinfo.Style["display"] = "none";
        lblcheckname.Text = "Local" + Session["docketcalledas"].ToString();
        string sqlstr = "SELECT codeid,codedesc FROM webx_master_general WHERE codetype='BUT'";
        SqlCommand cmd = new SqlCommand(sqlstr, con);
        SqlDataReader dr = cmd.ExecuteReader();
        cmblist.Items.Clear();
        while (dr.Read())
        {
            cmblist.Items.Add(new ListItem(Convert.ToString(dr["codedesc"]), Convert.ToString(dr["codeid"])));
        }
        dr.Close();

        sqlstr = "SELECT businesstype FROM webx_master_docket WHERE dockno='" + hdndockno.Value + "'";
        cmd = new SqlCommand(sqlstr, con);
        cmblist.SelectedValue = Convert.ToString(cmd.ExecuteScalar());
    }

    protected void localFlag()
    {
        lbldesc.Text = "OBD No";
        trtxt.Style["display"] = "none";
        trcmb.Style["display"] = "none";
        divcustinfo.Style["display"] = "none";
        lblcheckname.Text = "Local" + Session["docketcalledas"].ToString();
        string sqlstr = "SELECT localcn_yn FROM webx_master_docket WHERE dockno='" + hdndockno.Value + "'";
        SqlCommand cmd = new SqlCommand(sqlstr, con);
        if (Convert.ToString(cmd.ExecuteScalar()).CompareTo("Y") == 0)
            chkone.Checked = true;
        else
            chkone.Checked = false;
    }

    protected void obdNo()
    {
        lbldesc.Text = "OBD No";
        divfields.Style["display"] = "block";
        divcustinfo.Style["display"] = "none";
        trcmb.Style["display"] = "none";
        trchk.Style["display"] = "none";
        txttwo.Style["display"] = "none";
        btnpartypopup.Style["display"] = "none";
        string sqlstr = "SELECT obdno FROM webx_master_docket WHERE dockno='" + hdndockno.Value + "'";
        SqlCommand cmd = new SqlCommand(sqlstr, con);
        txtone.Text = Convert.ToString(cmd.ExecuteScalar());
    }

    protected void spcInst()
    {
        lbldesc.Text = "Special Instructions";
        trcmb.Style["display"] = "none";
        trchk.Style["display"] = "none";
        string sqlstr = "SELECT spl_svc_req FROM webx_master_docket WHERE dockno='" + hdndockno.Value + "'";
        SqlCommand cmd = new SqlCommand(sqlstr, con);
        txtone.Text = Convert.ToString(cmd.ExecuteScalar());

        divfields.Style["display"] = "block";
        divcustinfo.Style["display"] = "none";
        txttwo.Style["display"] = "none";
        txtone.Width = 200;
        txtone.TextMode = TextBoxMode.MultiLine;
        btnpartypopup.Style["display"] = "none";
    }

    protected void custInfo()
    {
        lbldesc.Text = "Cosignor Code Name";
        txttwo.Enabled = false;
        trcmb.Style["display"] = "none";
        trchk.Style["display"] = "none";

        string sqlstr = "SELECT csgecd,csgenm,paybas,destcd,csgncd,csgnnm,csgnaddr,csgnpincode,csgncity,csgnteleno,csgnemail,";
        sqlstr = sqlstr + "csgeaddr,csgepincode,csgecity,csgeteleno,csgeemail,paybas,orgncd FROM webx_master_docket WHERE dockno='" + hdndockno.Value + "'";
        SqlCommand cmd = new SqlCommand(sqlstr, con);
        SqlDataReader dr = cmd.ExecuteReader();

        while (dr.Read())
        {
            hdnpaybas.Value = Convert.ToString(dr["paybas"]);
            txtcsgncd.Text = Convert.ToString(dr["csgncd"]);
            txtcsgecd.Text = Convert.ToString(dr["csgecd"]);

            if (txtcsgncd.Text.CompareTo("8888") == 0)
                txtcsgncd.Text = "";

            if (txtcsgecd.Text.CompareTo("8888") == 0)
                txtcsgecd.Text = "";

            if (txtcsgncd.Text.CompareTo("8888") == 0 || txtcsgncd.Text.CompareTo("") == 0)
            {
                txtcsgnname.Text = Convert.ToString(dr["csgnnm"]);
                txtcsgnaddress.Text = Convert.ToString(dr["csgnaddr"]);
                txtcsgncity.Text = Convert.ToString(dr["csgncity"]);
                txtcsgnpin.Text = Convert.ToString(dr["csgnpincode"]);
                txtcsgnphone.Text = Convert.ToString(dr["csgnteleno"]);
                txtcsgnemail.Text = Convert.ToString(dr["csgnemail"]);
            }
            else
                txtcsgnnm.Text = fn.Getcustomer(txtcsgncd.Text);

            if (txtcsgecd.Text.CompareTo("8888") == 0 || txtcsgecd.Text.CompareTo("") == 0)
            {
                txtcsgename.Text = Convert.ToString(dr["csgenm"]);
                txtcsgeaddress.Text = Convert.ToString(dr["csgeaddr"]);
                txtcsgecity.Text = Convert.ToString(dr["csgecity"]);
                txtcsgepin.Text = Convert.ToString(dr["csgepincode"]);
                txtcsgephone.Text = Convert.ToString(dr["csgeteleno"]);
                txtcsgeemail.Text = Convert.ToString(dr["csgeemail"]);
            }
            else
                txtcsgenm.Text = fn.Getcustomer(txtcsgecd.Text);


            hdnorgnloc.Value = Convert.ToString(dr["orgncd"]);
            hdndelloc.Value = Convert.ToString(dr["destcd"]);
        }
        dr.Close();

        txtcsgncd.Attributes.Add("onblur", "javascript:return partyTest('csgn','" + hdnorgnloc.Value + "')");
        txtcsgecd.Attributes.Add("onblur", "javascript:return partyTest('csge','" + hdndelloc.Value + "')");

    }


    protected void saveCustInfo()
    {
        SqlTransaction trn;
        trn = con.BeginTransaction();
        string sqlstr = "";
        SqlCommand cmd;
        try
        {

            DocketFinEditController.BackUpDocket(hdndockno.Value, SessionUtilities.ConnectionString, trn);
            sqlstr = "UPDATE webx_master_docket SET editinfo=ISNULL(editinfo,'')+'FIELDS' ";
            sqlstr = sqlstr + " WHERE dockno='" + hdndockno.Value + "'";
            SqlHelper.ExecuteNonQuery(trn, CommandType.Text, sqlstr);

    
            if (txtcsgncd.Text.CompareTo("") == 0 || txtcsgncd.Text.CompareTo("8888") == 0)
            {
                sqlstr = "UPDATE webx_master_docket SET csgncd='8888',";
                sqlstr = sqlstr + "csgnnm='" + txtcsgnname.Text + "',";
                sqlstr = sqlstr + "csgnaddr='" + txtcsgnaddress.Text + "',";
                sqlstr = sqlstr + "csgncity='" + txtcsgncity.Text + "',";
                sqlstr = sqlstr + "csgnpincode='" + txtcsgnpin.Text + "',";
                sqlstr = sqlstr + "csgnteleno='" + txtcsgnphone.Text + "',";
                sqlstr = sqlstr + "csgnemail='" + txtcsgnemail.Text + "'";
                sqlstr = sqlstr + " WHERE dockno='" + hdndockno.Value + "'";
                SqlHelper.ExecuteNonQuery(trn, CommandType.Text, sqlstr);

                if (hdnpaybas.Value.CompareTo("P01") == 0)
                {
                    sqlstr = "UPDATE webx_mr_hdr SET ptcd='8888',";
                    sqlstr = sqlstr + "ptname='" + txtcsgnname.Text + "',";
                    sqlstr = sqlstr + "ptadd='" + txtcsgnaddress.Text + "',";
                    sqlstr = sqlstr + "ptpin='" + txtcsgnpin.Text + "',";
                    sqlstr = sqlstr + "pttel='" + txtcsgnphone.Text + "'";
                    sqlstr = sqlstr + " WHERE dockno='" + hdndockno.Value + "' AND mrstype='1' AND mr_cancel<>'Y'";
                    SqlHelper.ExecuteNonQuery(trn, CommandType.Text, sqlstr);

                    sqlstr = "UPDATE webx_acctrans_" + hdnfinyear2d.Value + " SET pbov_name='" + txtcsgnname.Text + "'";
                    sqlstr = sqlstr + " WHERE dockno='" + hdndockno.Value + "' AND voucher_cancel<>'Y'";
                    SqlHelper.ExecuteNonQuery(trn, CommandType.Text, sqlstr);
                }

            }
            else
            {
                sqlstr = "UPDATE webx_master_docket SET csgncd='" + txtcsgncd.Text + "'";
                sqlstr = sqlstr + " WHERE dockno='" + hdndockno.Value + "'";
                SqlHelper.ExecuteNonQuery(trn, CommandType.Text, sqlstr);

                if (hdnpaybas.Value.CompareTo("P01") == 0)
                {
                    sqlstr = "UPDATE webx_mr_hdr SET ptcd='" + txtcsgncd.Text + "'";
                    sqlstr = sqlstr + " WHERE dockno='" + hdndockno.Value + "' AND mrstype='1' AND mr_cancel<>'Y'";
                    SqlHelper.ExecuteNonQuery(trn, CommandType.Text, sqlstr);

                    sqlstr = "UPDATE webx_acctrans_" + hdnfinyear2d.Value + " SET pbov_code='" + txtcsgncd.Text + "'";
                    sqlstr = sqlstr + " WHERE dockno='" + hdndockno.Value + "' AND voucher_cancel<>'Y'";
                    SqlHelper.ExecuteNonQuery(trn, CommandType.Text, sqlstr);
                }
            }

            if (txtcsgecd.Text.CompareTo("") == 0 || txtcsgecd.Text.CompareTo("8888") == 0)
            {
                sqlstr = "UPDATE webx_master_docket SET csgecd='8888',";
                sqlstr = sqlstr + "csgenm='" + txtcsgename.Text + "',";
                sqlstr = sqlstr + "csgeaddr='" + txtcsgeaddress.Text + "',";
                sqlstr = sqlstr + "csgecity='" + txtcsgecity.Text + "',";
                sqlstr = sqlstr + "csgepincode='" + txtcsgepin.Text + "',";
                sqlstr = sqlstr + "csgeteleno='" + txtcsgephone.Text + "',";
                sqlstr = sqlstr + "csgeemail='" + txtcsgeemail.Text + "'";
                sqlstr = sqlstr + " WHERE dockno='" + hdndockno.Value + "'";
                cmd = new SqlCommand(sqlstr, con, trn);
                cmd.ExecuteNonQuery();

                if (hdnpaybas.Value.CompareTo("P03") == 0)
                {
                    sqlstr = "UPDATE webx_mr_hdr SET ptcd='8888',";
                    sqlstr = sqlstr + "ptname='" + txtcsgename.Text + "',";
                    sqlstr = sqlstr + "ptadd='" + txtcsgeaddress.Text + "',";
                    sqlstr = sqlstr + "ptpin='" + txtcsgepin.Text + "',";
                    sqlstr = sqlstr + "pttel='" + txtcsgephone.Text + "'";
                    sqlstr = sqlstr + " WHERE dockno='" + hdndockno.Value + "' AND  mr_cancel<>'Y'";
                    cmd = new SqlCommand(sqlstr, con, trn);
                    cmd.ExecuteNonQuery();

                    sqlstr = "UPDATE webx_acctrans_" + hdnfinyear2d.Value + " SET pbov_name='" + txtcsgename.Text + "'";
                    sqlstr = sqlstr + " WHERE dockno='" + hdndockno.Value + "' AND voucher_cancel<>'Y'";
                    cmd = new SqlCommand(sqlstr, con, trn);
                    cmd.ExecuteNonQuery();
                }
            }
            else
            {
                sqlstr = "UPDATE webx_master_docket SET csgecd='" + txtcsgecd.Text + "'";
                sqlstr = sqlstr + " WHERE dockno='" + hdndockno.Value + "'";
                cmd = new SqlCommand(sqlstr, con, trn);
                cmd.ExecuteNonQuery();

                if (hdnpaybas.Value.CompareTo("P03") == 0)
                {
                    sqlstr = "UPDATE webx_mr_hdr SET ptcd='" + txtcsgecd.Text + "'";
                    sqlstr = sqlstr + " WHERE dockno='" + hdndockno.Value + "' AND mr_cancel<>'Y'";
                    cmd = new SqlCommand(sqlstr, con, trn);
                    cmd.ExecuteNonQuery();
                }
            }



        }
        catch (Exception ex)
        {
            string strex = ex.Message.Replace('\n', '_');
            trn.Rollback();
            Response.Redirect("../DocketEntry/ErrorPage.aspx?heading=Database Updation Error&detail1=" + strex);
            return;
        }

        trn.Commit();
        Response.Redirect("Docket_Submit_Done.aspx?dockno=" + hdndockno.Value);
    }

    protected void savePickUpDel()
    {
        try
        {
            string sqlstr = "UPDATE webx_master_docket SET edited='Y',pickup_dely='" + cmblist.SelectedValue + "',";
            sqlstr = sqlstr + "editinfo=ISNULL(editinfo,'') + '," + hdnrequestcode.Value + "',lasteditby='" + Session["empcd"].ToString() + "'";
            sqlstr = sqlstr + " WHERE dockno='" + hdndockno.Value + "'";
            SqlCommand cmd = new SqlCommand(sqlstr, con);
            cmd.ExecuteNonQuery();
        }
        catch (Exception ex)
        {
            string strex = ex.Message.Replace('\n', '_');
            Response.Redirect("../DocketEntry/ErrorPage.aspx?heading=Database Updation Error&detail1=" + strex);
            return;
        }
        Response.Redirect("Docket_Submit_Done.aspx?dockno=" + hdndockno.Value);
    }

    protected void btncustinfo_Click(object sender, EventArgs e)
    {
        switch (hdnrequestcode.Value)
        {

            case "custinfo":
                saveCustInfo();
                break;
        }
    }

    protected void saveOBDno()
    {
        try
        {
            string sqlstr = "UPDATE webx_master_docket SET edited='Y',editinfo=ISNULL(editinfo,'') + ',FIELD',obdno='" + txtone.Text + "',lasteditby='" + Session["empcd"].ToString() + "'";
            sqlstr = sqlstr + " WHERE dockno='" + hdndockno.Value + "'";
            SqlCommand cmd = new SqlCommand(sqlstr, con);
            cmd.ExecuteNonQuery();
        }
        catch (Exception ex)
        {
            string strex = ex.Message.Replace('\n', '_');
            Response.Redirect("../DocketEntry/ErrorPage.aspx?heading=Database Updation Error&detail1=" + strex);
            return;
        }
        Response.Redirect("Docket_Submit_Done.aspx?dockno=" + hdndockno.Value);
    }

    protected void saveBusinessType()
    {
        try
        {
            string sqlstr = "UPDATE webx_master_docket SET edited='Y',editinfo=ISNULL(editinfo,'') + ',FIELD',businesstype='" + cmblist.SelectedValue + "',lasteditby='" + Session["empcd"].ToString() + "'";
            sqlstr = sqlstr + " WHERE dockno='" + hdndockno.Value + "'";
            SqlCommand cmd = new SqlCommand(sqlstr, con);
            cmd.ExecuteNonQuery();
        }
        catch (Exception ex)
        {
            string strex = ex.Message.Replace('\n', '_');
            Response.Redirect("../DocketEntry/ErrorPage.aspx?heading=Database Updation Error&detail1=" + strex);
            return;
        }
        Response.Redirect("Docket_Submit_Done.aspx?dockno=" + hdndockno.Value);
    }

    protected void saveLocalFlag()
    {
        try
        {
            string sqlstr = "SELECT COUNT(dockno) FROM webx_master_docket WHERE dockno='" + hdndockno.Value + "'";
            sqlstr = sqlstr + " AND orgncd=reassign_destcd";
            int cnt = WebXConvert.ToInt16(SqlHelper.ExecuteScalar(SessionUtilities.ConnectionString, CommandType.Text, sqlstr));

            if (chkone.Checked && cnt == 0)
            {
                Exception ex = new Exception("Can't Make " + SessionUtilities.DocketCalledAs + " " + hdndockno.Value + " Local. Origin and Destination are not Same");
                throw ex;
            }

            sqlstr = "UPDATE webx_master_docket SET edited='Y',editinfo=ISNULL(editinfo,'') + ',FIELD',localcn_yn='" + (chkone.Checked == true ? "Y" : "N") + "',lasteditby='" + Session["empcd"].ToString() + "'";
            sqlstr = sqlstr + " WHERE dockno='" + hdndockno.Value + "'";
            SqlCommand cmd = new SqlCommand(sqlstr, con);
            cmd.ExecuteNonQuery();
        }
        catch (Exception ex)
        {
            string strex = ex.Message.Replace('\n', '_');
            Response.Redirect("../ErrorPage.aspx?heading=Database Updation Error&detail1=" + strex);
            return;
        }
        Response.Redirect("Docket_Submit_Done.aspx?dockno=" + hdndockno.Value);
    }

    protected void saveSpcInst()
    {
        SqlTransaction tran;
        tran = con.BeginTransaction();

        try
        {
            DocketFinEditController.BackUpDocket(hdndockno.Value, Session["empcd"].ToString(), tran);

            string sqlstr = "UPDATE webx_master_docket SET edited='Y',editinfo=ISNULL(editinfo,'') + ',FIELD',spl_svc_req='" + txtone.Text + "',lasteditby='" + Session["empcd"].ToString() + "'";
            sqlstr = sqlstr + " WHERE dockno='" + hdndockno.Value + "'";
            SqlHelper.ExecuteNonQuery(tran, CommandType.Text, sqlstr);
        }
        catch (Exception ex)
        {
            tran.Rollback();
            string strex = ex.Message.Replace('\n', '_');
            Response.Redirect("../DocketEntry/ErrorPage.aspx?heading=Database Updation Error&detail1=" + strex);
            return;
        }
        tran.Commit();
        Response.Redirect("Docket_Submit_Done.aspx?dockno=" + hdndockno.Value);
    }

    protected void saveCustRefNo()
    {
        try
        {
            string sqlstr = "UPDATE webx_master_docket SET edited='Y',editinfo=ISNULL(editinfo,'') + ',FIELD',ctr_no='" + txtone.Text + "',lasteditby='" + Session["empcd"].ToString() + "'";
            sqlstr = sqlstr + " WHERE dockno='" + hdndockno.Value + "'";
            SqlCommand cmd = new SqlCommand(sqlstr, con);
            cmd.ExecuteNonQuery();
        }
        catch (Exception ex)
        {
            string strex = ex.Message.Replace('\n', '_');
            Response.Redirect("../DocketEntry/ErrorPage.aspx?heading=Database Updation Error&detail1=" + strex);
            return;
        }
        Response.Redirect("Docket_Submit_Done.aspx?dockno=" + hdndockno.Value);
    }

    protected void savePrivateMark()
    {
        try
        {
            string sqlstr = "UPDATE webx_master_docket SET edited='Y',editinfo=ISNULL(editinfo,'') + ',FIELD',privatemark='" + txtone.Text + "',lasteditby='" + Session["empcd"].ToString() + "'";
            sqlstr = sqlstr + " WHERE dockno='" + hdndockno.Value + "'";
            SqlCommand cmd = new SqlCommand(sqlstr, con);
            cmd.ExecuteNonQuery();
        }
        catch (Exception ex)
        {
            string strex = ex.Message.Replace('\n', '_');
            Response.Redirect("../DocketEntry/ErrorPage.aspx?heading=Database Updation Error&detail1=" + strex);
            return;
        }
        Response.Redirect("Docket_Submit_Done.aspx?dockno=" + hdndockno.Value);
    }
    
    protected void saveBilledAt()
    {
        try
        {
            if (DataValidations.IsActiveLocation(txtone.Text))
            {
                string sqlstr = "UPDATE webx_master_docket SET edited='Y',editinfo=ISNULL(editinfo,'') + ',FIELD',fincmplbr='" + txtone.Text + "',lasteditby='" + Session["empcd"].ToString() + "'";
                sqlstr = sqlstr + " WHERE dockno='" + hdndockno.Value + "'";
                SqlCommand cmd = new SqlCommand(sqlstr, con);
                cmd.ExecuteNonQuery();
            }
            else
            {
                Exception ex = new Exception("Billing Location not from Location Master");
                throw ex;
            }
        }
        catch (Exception ex)
        {
            string strex = ex.Message.Replace('\n', '_');
            Response.Redirect("../DocketEntry/ErrorPage.aspx?heading=Database Updation Error&detail1=" + strex);
            return;
        }

        Response.Redirect("Docket_Submit_Done.aspx?dockno=" + hdndockno.Value);
    }

}
