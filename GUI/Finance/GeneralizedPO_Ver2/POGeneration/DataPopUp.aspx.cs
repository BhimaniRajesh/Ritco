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

public partial class GUI_Finance_Billing_BillEdit_DataPopUp : System.Web.UI.Page
{
    string ctlid = "";
    string ctlval = "";
    string tbl = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        divparty.Visible = true;
        //lblCode.Text = "Code : ";
        //lblName.Text = "Name : ";
        string mod = Request.QueryString["mode"].ToString();
        string doctype = Request.QueryString["doctype"].ToString();
        string brcd = Session["brcd"].ToString();

        if (mod.CompareTo("6") == 0 || mod.CompareTo("06") == 0)
        {
            lblCode.Text = "Asset Code : ";
            lblName.Text = "Asset Name : ";
        }
        else
        {
            lblCode.Text = "SKU Code : ";
            lblName.Text = "SKU Description : ";
        }
        hdnmode.Value = mod;
    }

    protected void btnpartysubmit_Click(object sender, EventArgs e)
    {
        SqlConnection con = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        con.Open();

        SqlCommand cmd;
        SqlDataReader dr;

        //string mode = Request.QueryString["mode"].ToString();
        string mode = hdnmode.Value;
        string brcd = Session["brcd"].ToString();

        if (mode.CompareTo("1") == 0 || mode.CompareTo("01") == 0)
        {
            lblCode.Text = "SKU Code : ";
            lblName.Text = "SKU Description : ";
            divparty.Visible = true;

            string qry = "";

            if (txtcode.Text.CompareTo("") == 0 && txtname.Text.CompareTo("") == 0)
            {
                qry = "SELECT distinct loccode,locname from Webx_Master_General where MatCat_Id=";
            }
            else if (txtcustcode.Text.CompareTo("") != 0 && txtcustname.Text.CompareTo("") == 0)
            {
                qry = "SELECT distinct loccode,locname from webx_location where Loc_Account = 'Y'and loccode like '" + txtcustcode.Text.ToString() + "%'";
            }
            else if (txtcustcode.Text.CompareTo("") == 0 && txtcustname.Text.CompareTo("") != 0)
            {
                qry = "SELECT distinct loccode,locname from webx_location where Loc_Account = 'Y' and locname like '" + txtcustname.Text.ToString() + "%'";
            }
            else if (txtcustcode.Text.CompareTo("") != 0 && txtcustname.Text.CompareTo("") != 0)
            {
                qry = "SELECT distinct loccode,locname from webx_location where Loc_Account = 'Y' and locname like '" + txtcustname.Text.ToString() + "%' and loccode like '" + txtcustcode.Text.ToString() + "%'";
            }

            ctlid = Request.QueryString["ctlid"].ToString();
            tbl = Request.QueryString["tbl"].ToString();

            cmd = new SqlCommand(qry, con);
            dr = cmd.ExecuteReader();
            TableRow trhead = new TableRow();

            TableCell tcheadra = new TableCell();
            TableCell tcheadname = new TableCell();
            TableCell tcheadlocname = new TableCell();

            tcheadlocname.Text = "Location Name";
            tcheadname.Text = "Location Code";
            tcheadra.Text = "Select";

            tcheadra.CssClass = "blackfnt";
            tcheadlocname.CssClass = "blackfnt";
            tcheadname.CssClass = "blackfnt";

            trhead.Cells.Add(tcheadra);
            trhead.Cells.Add(tcheadname);
            trhead.Cells.Add(tcheadlocname);
            trhead.CssClass = "bgbluegrey";

            tbllist.Rows.Add(trhead);

            while (dr.Read())
            {
                TableRow tr = new TableRow();

                TableCell tcra = new TableCell();
                TableCell tcname = new TableCell();
                TableCell tclocname = new TableCell();
                RadioButton rad = new RadioButton();

                tr.BackColor = System.Drawing.Color.White;
                tcname.CssClass = "blackfnt";
                tcname.HorizontalAlign = HorizontalAlign.Left;
                tclocname.HorizontalAlign = HorizontalAlign.Left;
                tbllist.CssClass = "blackfnt";
                tclocname.CssClass = "blackfnt";

                rad.GroupName = "grplist";
                rad.ID = "rad" + dr["loccode"].ToString();

                //rad.Attributes.Add("onclick", "javascript:return radPartyClick(this.getAttribute('id'),'" + codeid + "','" + nameid + "','" + Convert.ToString(dr["custcd"]) + "','" + Convert.ToString(dr["custnm"]) + "')");
                rad.Attributes.Add("onclick", "javascript:return radEmpClick(this.getAttribute('id'),'" + ctlid + "','" + tbl + "')");

                tcname.Text = dr[0].ToString();
                tclocname.Text = dr[1].ToString();
                tcra.Controls.Add(rad);

                tr.Cells.Add(tcra);
                tr.Cells.Add(tcname);
                tr.Cells.Add(tclocname);

                tbllist.Rows.Add(tr);

            }
            dr.Close();
            return;
        }
        else if (mode.CompareTo("2") == 0 || mode.CompareTo("02") == 0)
        {
            lblCode.Text = "Location Code : ";
            lblName.Text = "Location Name : ";
            divparty.Visible = true;

            string qry = "";
            if (txtcustcode.Text.CompareTo("") == 0 && txtcustname.Text.CompareTo("") == 0)
            {
                qry = "SELECT distinct loccode,locname from webx_location";
            }
            else if (txtcustcode.Text.CompareTo("") != 0 && txtcustname.Text.CompareTo("") == 0)
            {
                qry = "SELECT distinct loccode,locname from webx_location WHERE loccode like '" + txtcustcode.Text.ToString() + "%'";
            }
            else if (txtcustcode.Text.CompareTo("") == 0 && txtcustname.Text.CompareTo("") != 0)
            {
                qry = "SELECT distinct loccode,locname from webx_location WHERE locname like '" + txtcustname.Text.ToString() + "%'";
            }
            else if (txtcustcode.Text.CompareTo("") != 0 && txtcustname.Text.CompareTo("") != 0)
            {
                qry = "SELECT distinct loccode,locname from webx_location WHERE locname like '" + txtcustname.Text.ToString() + "%' and loccode like '" + txtcustcode.Text.ToString() + "%'";
            }

            ctlid = Request.QueryString["ctlid"].ToString();
            tbl = Request.QueryString["tbl"].ToString();

            cmd = new SqlCommand(qry, con);
            dr = cmd.ExecuteReader();
            TableRow trhead = new TableRow();

            TableCell tcheadra = new TableCell();
            TableCell tcheadname = new TableCell();
            TableCell tcheadlocname = new TableCell();

            tcheadlocname.Text = "Location Name";
            tcheadname.Text = "Location Code";
            tcheadra.Text = "Select";

            tcheadra.CssClass = "blackfnt";
            tcheadlocname.CssClass = "blackfnt";
            tcheadname.CssClass = "blackfnt";

            trhead.Cells.Add(tcheadra);
            trhead.Cells.Add(tcheadname);
            trhead.Cells.Add(tcheadlocname);
            trhead.CssClass = "bgbluegrey";

            tbllist.Rows.Add(trhead);

            while (dr.Read())
            {
                TableRow tr = new TableRow();

                TableCell tcra = new TableCell();
                TableCell tcname = new TableCell();
                TableCell tclocname = new TableCell();
                RadioButton rad = new RadioButton();

                tr.BackColor = System.Drawing.Color.White;
                tcname.CssClass = "blackfnt";
                tcname.HorizontalAlign = HorizontalAlign.Left;
                tclocname.HorizontalAlign = HorizontalAlign.Left;
                tbllist.CssClass = "blackfnt";
                tclocname.CssClass = "blackfnt";

                rad.GroupName = "grplist";
                rad.ID = "rad" + dr["loccode"].ToString();

                //rad.Attributes.Add("onclick", "javascript:return radPartyClick(this.getAttribute('id'),'" + codeid + "','" + nameid + "','" + Convert.ToString(dr["custcd"]) + "','" + Convert.ToString(dr["custnm"]) + "')");
                rad.Attributes.Add("onclick", "javascript:return radLocClick(this.getAttribute('id'),'" + ctlid + "','" + tbl + "')");

                tcname.Text = dr[0].ToString();
                tclocname.Text = dr[1].ToString();
                tcra.Controls.Add(rad);

                tr.Cells.Add(tcra);
                tr.Cells.Add(tcname);
                tr.Cells.Add(tclocname);

                tbllist.Rows.Add(tr);

            }
            dr.Close();
            return;

        }
        else if (mode.CompareTo("3") == 0 || mode.CompareTo("03") == 0)
        {
            lblCode.Text = "Account Code : ";
            lblName.Text = "Account Description : ";
            divparty.Visible = true;
            //grouptable.Visible = true;
            string groupcode = "";
            string brcdcheck = "";

            double count = 0;
            hdnbrcdcheck.Value = "N";
            count = Convert.ToDouble(SqlHelper.ExecuteScalar(SessionUtilities.ConnectionString, CommandType.Text, "select count(*) from webx_modules_rules where Module_Name='Account Master' and RULE_DESC='Set Branch Code For Account Head'"));
            if (count > 0)
            {
                hdnbrcdcheck.Value = SqlHelper.ExecuteScalar(SessionUtilities.ConnectionString, CommandType.Text, "select RULE_Y_N from webx_modules_rules where Module_Name='Account Master' and RULE_DESC='Set Branch Code For Account Head'").ToString();
            }
            if (hdnbrcdcheck.Value.CompareTo("Y") == 0)
            {
                brcdcheck = " and (brcd like 'All' or PATINDEx ('%" + SessionUtilities.CurrentBranchCode + "%',brcd)>0)";
            }

            if (cbomaincat.SelectedValue.ToString().CompareTo("") != 0)
            {
                groupcode = " groupcode in ( select groupcode from webx_groups WITH(NOLOCK) where main_category = '" + cbomaincat.SelectedValue.ToString() + "') " + brcdcheck;
            }
            string qry = "";
            if (txtcustcode.Text.CompareTo("") == 0 && txtcustname.Text.CompareTo("") == 0 && cbomaincat.SelectedValue.ToString().CompareTo("") != 0)
            {
                qry = "select distinct Company_Acccode as Acccode,Accdesc,Acccode as acctcd  from webx_acctinfo  WITH(NOLOCK) where Activeflag='Y' and acccategory not in('BANK','CASH') and " + groupcode;
            }
            else if (txtcustcode.Text.CompareTo("") == 0 && txtcustname.Text.CompareTo("") == 0 && cbomaincat.SelectedValue.ToString().CompareTo("") == 0)
            {
                qry = "select distinct Company_Acccode as Acccode,Accdesc,Acccode as acctcd  from webx_acctinfo WITH(NOLOCK) where Activeflag='Y' and acccategory not in('BANK','CASH') " + brcdcheck;
            }
            else if (txtcustcode.Text.CompareTo("") != 0 && txtcustname.Text.CompareTo("") == 0)
            {
                if (cbomaincat.SelectedValue.ToString().CompareTo("") == 0)
                    qry = "select distinct Company_Acccode as Acccode,Accdesc,Acccode as acctcd  from webx_acctinfo  WITH(NOLOCK) WHERE Activeflag='Y' and Company_Acccode like '" + txtcustcode.Text.ToString() + "%' " + brcdcheck;
                else
                    qry = "select distinct Company_Acccode as Acccode,Accdesc,Acccode as acctcd  from webx_acctinfo  WITH(NOLOCK) WHERE Activeflag='Y' and Company_Acccode like '" + txtcustcode.Text.ToString() + "%' and " + groupcode;
            }
            else if (txtcustcode.Text.CompareTo("") == 0 && txtcustname.Text.CompareTo("") != 0)
            {
                if (cbomaincat.SelectedValue.ToString().CompareTo("") == 0)
                    qry = "select distinct Company_Acccode as Acccode,Accdesc,Acccode as acctcd  from webx_acctinfo  WITH(NOLOCK) WHERE Activeflag='Y' and Accdesc like '" + txtcustname.Text.ToString() + "%' " + brcdcheck;
                else
                    qry = "select distinct Company_Acccode as Acccode,Accdesc,Acccode as acctcd  from webx_acctinfo  WITH(NOLOCK) WHERE Activeflag='Y' and Accdesc like '" + txtcustname.Text.ToString() + "%' and " + groupcode;

            }
            else if (txtcustcode.Text.CompareTo("") != 0 && txtcustname.Text.CompareTo("") != 0)
            {
                if (cbomaincat.SelectedValue.ToString().CompareTo("") == 0)
                    qry = "select distinct Company_Acccode as Acccode,Accdesc,Acccode as acctcd  from webx_acctinfo WHERE Activeflag='Y' and Accdesc like '" + txtcustname.Text.ToString() + "%' and Company_Acccode like '" + txtcustcode.Text.ToString() + "%' " + brcdcheck;
                else
                    qry = "select distinct Company_Acccode as Acccode,Accdesc,Acccode as acctcd from webx_acctinfo WHERE Activeflag='Y' and Accdesc like '" + txtcustname.Text.ToString() + "%' and Company_Acccode like '" + txtcustcode.Text.ToString() + "%' and " + groupcode;
            }

            ctlid = Request.QueryString["ctlid"].ToString();
            tbl = Request.QueryString["tbl"].ToString();

            cmd = new SqlCommand(qry, con);
            dr = cmd.ExecuteReader();
            TableRow trhead = new TableRow();

            TableCell tcheadra = new TableCell();
            TableCell tcheadname = new TableCell();
            TableCell tcheadlocname = new TableCell();

            tcheadlocname.Text = "Account Description";
            tcheadname.Text = "Account Code";
            tcheadra.Text = "Select";

            tcheadra.CssClass = "blackfnt";
            tcheadlocname.CssClass = "blackfnt";
            tcheadname.CssClass = "blackfnt";

            trhead.Cells.Add(tcheadra);
            trhead.Cells.Add(tcheadname);
            trhead.Cells.Add(tcheadlocname);
            trhead.CssClass = "bgbluegrey";

            tbllist.Rows.Add(trhead);

            while (dr.Read())
            {
                TableRow tr = new TableRow();

                TableCell tcra = new TableCell();
                TableCell tcname = new TableCell();
                TableCell tclocname = new TableCell();

                RadioButton rad = new RadioButton();

                tr.BackColor = System.Drawing.Color.White;
                tcname.CssClass = "blackfnt";
                tcname.HorizontalAlign = HorizontalAlign.Left;
                tclocname.HorizontalAlign = HorizontalAlign.Left;
                tbllist.CssClass = "blackfnt";
                tclocname.CssClass = "blackfnt";

                rad.GroupName = "grplist";
                rad.ID = "rad" + dr["acccode"].ToString();

                //rad.Attributes.Add("onclick", "javascript:return radPartyClick(this.getAttribute('id'),'" + codeid + "','" + nameid + "','" + Convert.ToString(dr["custcd"]) + "','" + Convert.ToString(dr["custnm"]) + "')");

                tcname.Text = dr[0].ToString();
                tclocname.Text = dr[1].ToString();

                tcra.Controls.Add(rad);
                rad.Attributes.Add("onclick", "javascript:return radAccClick('" + tcname.Text + "','" + ctlid + "','" + tbl + "','" + tclocname.Text + "')");

                tr.Cells.Add(tcra);
                tr.Cells.Add(tcname);
                tr.Cells.Add(tclocname);

                tbllist.Rows.Add(tr);

            }
            dr.Close();
            return;

        }
        else if (mode.CompareTo("4") == 0 || mode.CompareTo("04") == 0)
        {
            lblCode.Text = "Employee Code : ";
            lblName.Text = "Employee Name : ";

            divparty.Visible = true;

            string qry = "";
            string BranchCheck = "";

            if (SessionUtilities.Client.CompareTo("Ritco") == 0)
                BranchCheck = " and BranchCode='" + brcd + "'";
            else
                BranchCheck = "";

            if (txtcustcode.Text.CompareTo("") == 0 && txtcustname.Text.CompareTo("") == 0)
            {
                qry = "select userid,name from webx_master_users WITH(NOLOCK) where status='100'" + BranchCheck;
            }
            else if (txtcustcode.Text.CompareTo("") != 0 && txtcustname.Text.CompareTo("") == 0)
            {
                qry = "select userid,name from webx_master_users WHERE status='100' and userid like '" + txtcustcode.Text.ToString() + "%'" + BranchCheck;
            }
            else if (txtcustcode.Text.CompareTo("") == 0 && txtcustname.Text.CompareTo("") != 0)
            {
                qry = "select userid,name from webx_master_users WHERE status='100' and name like '" + txtcustname.Text.ToString() + "%'" + BranchCheck;
            }
            else if (txtcustcode.Text.CompareTo("") != 0 && txtcustname.Text.CompareTo("") != 0)
            {
                qry = "select userid,name from webx_master_users WHERE status='100' and name like '" + txtcustname.Text.ToString() + "%' and userid like '" + txtcustcode.Text.ToString() + "%'" + BranchCheck;
            }

            ctlid = Request.QueryString["ctlid"].ToString();
            tbl = Request.QueryString["tbl"].ToString();

            cmd = new SqlCommand(qry, con);
            dr = cmd.ExecuteReader();
            TableRow trhead = new TableRow();

            TableCell tcheadra = new TableCell();
            TableCell tcheadname = new TableCell();
            TableCell tcheadlocname = new TableCell();

            tcheadlocname.Text = "Employee Name";
            tcheadname.Text = "Employee Code";
            tcheadra.Text = "Select";

            tcheadra.CssClass = "blackfnt";
            tcheadlocname.CssClass = "blackfnt";
            tcheadname.CssClass = "blackfnt";

            trhead.Cells.Add(tcheadra);
            trhead.Cells.Add(tcheadname);
            trhead.Cells.Add(tcheadlocname);
            trhead.CssClass = "bgbluegrey";

            tbllist.Rows.Add(trhead);

            while (dr.Read())
            {
                TableRow tr = new TableRow();

                TableCell tcra = new TableCell();
                TableCell tcname = new TableCell();
                TableCell tclocname = new TableCell();
                RadioButton rad = new RadioButton();

                tr.BackColor = System.Drawing.Color.White;
                tcname.CssClass = "blackfnt";
                tcname.HorizontalAlign = HorizontalAlign.Left;
                tclocname.HorizontalAlign = HorizontalAlign.Left;
                tbllist.CssClass = "blackfnt";
                tclocname.CssClass = "blackfnt";

                rad.GroupName = "grplist";
                rad.ID = "rad" + dr["userid"].ToString();
                ctlval = dr["name"].ToString();

                //rad.Attributes.Add("onclick", "javascript:return radPartyClick(this.getAttribute('id'),'" + codeid + "','" + nameid + "','" + Convert.ToString(dr["custcd"]) + "','" + Convert.ToString(dr["custnm"]) + "')");
                rad.Attributes.Add("onclick", "javascript:return radEmpVenCustClick(this.getAttribute('id'),'" + ctlid + "','" + tbl + "','" + ctlval + "')");


                tcname.Text = dr[0].ToString();
                tclocname.Text = dr[1].ToString();
                tcra.Controls.Add(rad);

                tr.Cells.Add(tcra);
                tr.Cells.Add(tcname);
                tr.Cells.Add(tclocname);

                tbllist.Rows.Add(tr);

            }
            dr.Close();
            return;

        }
        else if (mode.CompareTo("5") == 0 || mode.CompareTo("05") == 0)
        {
            lblCode.Text = "Vendor Code : ";
            lblName.Text = "Vendor Name : ";
            divparty.Visible = true;

            string qry = "";
            if (txtcustcode.Text.CompareTo("") == 0 && txtcustname.Text.CompareTo("") == 0)
            {
                qry = "select vendorCode,vendorname from webx_VENDOR_HDR WITH(NOLOCK) where ACTIVE='Y' and vendorcode in ( select vendorcode from webx_VENDOR_det WITH(NOLOCK)  where vendorCode is not null and    PATINDEx ('%" + brcd + "%',vendorbrcd)>0 ) order by vendorname";
            }
            else if (txtcustcode.Text.CompareTo("") != 0 && txtcustname.Text.CompareTo("") == 0)
            {
                qry = "select vendorCode,vendorname from webx_VENDOR_HDR WITH(NOLOCK) WHERE ACTIVE='Y' and vendorcode in ( select vendorcode from webx_VENDOR_det WITH(NOLOCK)  where vendorCode is not null and    PATINDEx ('%" + brcd + "%',vendorbrcd)>0 ) and vendorCode like '" + txtcustcode.Text.ToString() + "%'";
            }
            else if (txtcustcode.Text.CompareTo("") == 0 && txtcustname.Text.CompareTo("") != 0)
            {
                qry = "select vendorCode,vendorname from webx_VENDOR_HDR WITH(NOLOCK) WHERE ACTIVE='Y' and vendorcode in ( select vendorcode from webx_VENDOR_det WITH(NOLOCK)  where vendorCode is not null and    PATINDEx ('%" + brcd + "%',vendorbrcd)>0 ) and vendorname like '" + txtcustname.Text.ToString() + "%'";
            }
            else if (txtcustcode.Text.CompareTo("") != 0 && txtcustname.Text.CompareTo("") != 0)
            {
                qry = "select vendorCode,vendorname from webx_VENDOR_HDR WITH(NOLOCK) WHERE ACTIVE='Y' and vendorcode in ( select vendorcode from webx_VENDOR_det WITH(NOLOCK)  where vendorCode is not null and    PATINDEx ('%" + Session["brcd"].ToString() + "%',vendorbrcd)>0 ) and vendorname like '" + txtcustname.Text.ToString() + "%' and vendorCode like '" + txtcustcode.Text.ToString() + "%'";
            }

            ctlid = Request.QueryString["ctlid"].ToString();
            tbl = Request.QueryString["tbl"].ToString();

            cmd = new SqlCommand(qry, con);
            dr = cmd.ExecuteReader();
            TableRow trhead = new TableRow();

            TableCell tcheadra = new TableCell();
            TableCell tcheadname = new TableCell();
            TableCell tcheadlocname = new TableCell();

            tcheadlocname.Text = "Vendor Name";
            tcheadname.Text = "Vendor Code";
            tcheadra.Text = "Select";

            tcheadra.CssClass = "blackfnt";
            tcheadlocname.CssClass = "blackfnt";
            tcheadname.CssClass = "blackfnt";

            trhead.Cells.Add(tcheadra);
            trhead.Cells.Add(tcheadname);
            trhead.Cells.Add(tcheadlocname);
            trhead.CssClass = "bgbluegrey";

            tbllist.Rows.Add(trhead);

            while (dr.Read())
            {
                TableRow tr = new TableRow();

                TableCell tcra = new TableCell();
                TableCell tcname = new TableCell();
                TableCell tclocname = new TableCell();
                RadioButton rad = new RadioButton();

                tr.BackColor = System.Drawing.Color.White;
                tcname.CssClass = "blackfnt";
                tcname.HorizontalAlign = HorizontalAlign.Left;
                tclocname.HorizontalAlign = HorizontalAlign.Left;
                tbllist.CssClass = "blackfnt";
                tclocname.CssClass = "blackfnt";

                rad.GroupName = "grplist";
                rad.ID = "rad" + dr["vendorCode"].ToString();
                ctlval = dr["vendorname"].ToString();

                //rad.Attributes.Add("onclick", "javascript:return radPartyClick(this.getAttribute('id'),'" + codeid + "','" + nameid + "','" + Convert.ToString(dr["custcd"]) + "','" + Convert.ToString(dr["custnm"]) + "')");
                rad.Attributes.Add("onclick", "javascript:return radEmpVenCustClick(this.getAttribute('id'),'" + ctlid + "','" + tbl + "','" + ctlval + "')");

                tcname.Text = dr[0].ToString();
                tclocname.Text = dr[1].ToString();
                tcra.Controls.Add(rad);

                tr.Cells.Add(tcra);
                tr.Cells.Add(tcname);
                tr.Cells.Add(tclocname);

                tbllist.Rows.Add(tr);

            }
            dr.Close();
            return;


        }
        else if (mode.CompareTo("6") == 0 || mode.CompareTo("06") == 0)
        {
            lblCode.Text = "Customer Code : ";
            lblName.Text = "Customer Name : ";
            divparty.Visible = true;

            string qry = "";
            if (txtcustcode.Text.CompareTo("") == 0 && txtcustname.Text.CompareTo("") == 0)
            {
                qry = "select custcd,custnm from webx_custhdr WITH(NOLOCK) where CUST_ACTIVE='Y' and CUSTCD is not null and PATINDEx ('%" + brcd + "%',custloc)>0  order by CUSTNM";
            }
            else if (txtcustcode.Text.CompareTo("") != 0 && txtcustname.Text.CompareTo("") == 0)
            {
                qry = "select custcd,custnm from webx_custhdr WITH(NOLOCK) where CUST_ACTIVE='Y' and CUSTCD is not null and PATINDEx ('%" + brcd + "%',custloc)>0  and custcd like '" + txtcustcode.Text.ToString() + "%'";
            }
            else if (txtcustcode.Text.CompareTo("") == 0 && txtcustname.Text.CompareTo("") != 0)
            {
                qry = "select custcd,custnm from webx_custhdr WITH(NOLOCK) where CUST_ACTIVE='Y' and CUSTCD is not null and PATINDEx ('%" + brcd + "%',custloc)>0  and custnm like '" + txtcustname.Text.ToString() + "%'";
            }
            else if (txtcustcode.Text.CompareTo("") != 0 && txtcustname.Text.CompareTo("") != 0)
            {
                qry = "select custcd,custnm from webx_custhdr WITH(NOLOCK) where CUST_ACTIVE='Y' and CUSTCD is not null and PATINDEx ('%" + brcd + "%',custloc)>0 and custnm like '" + txtcustname.Text.ToString() + "%' and custcd like '" + txtcustcode.Text.ToString() + "%'";
            }

            ctlid = Request.QueryString["ctlid"].ToString();
            tbl = Request.QueryString["tbl"].ToString();

            cmd = new SqlCommand(qry, con);
            dr = cmd.ExecuteReader();
            TableRow trhead = new TableRow();

            TableCell tcheadra = new TableCell();
            TableCell tcheadname = new TableCell();
            TableCell tcheadlocname = new TableCell();

            tcheadlocname.Text = "Customer Name";
            tcheadname.Text = "Customer Code";
            tcheadra.Text = "Select";

            tcheadra.CssClass = "blackfnt";
            tcheadlocname.CssClass = "blackfnt";
            tcheadname.CssClass = "blackfnt";

            trhead.Cells.Add(tcheadra);
            trhead.Cells.Add(tcheadname);
            trhead.Cells.Add(tcheadlocname);
            trhead.CssClass = "bgbluegrey";

            tbllist.Rows.Add(trhead);

            while (dr.Read())
            {
                TableRow tr = new TableRow();

                TableCell tcra = new TableCell();
                TableCell tcname = new TableCell();
                TableCell tclocname = new TableCell();
                RadioButton rad = new RadioButton();

                tr.BackColor = System.Drawing.Color.White;
                tcname.CssClass = "blackfnt";
                tcname.HorizontalAlign = HorizontalAlign.Left;
                tclocname.HorizontalAlign = HorizontalAlign.Left;
                tbllist.CssClass = "blackfnt";
                tclocname.CssClass = "blackfnt";

                rad.GroupName = "grplist";
                rad.ID = "rad" + dr["custcd"].ToString();
                ctlval = dr["custnm"].ToString();

                //rad.Attributes.Add("onclick", "javascript:return radPartyClick(this.getAttribute('id'),'" + codeid + "','" + nameid + "','" + Convert.ToString(dr["custcd"]) + "','" + Convert.ToString(dr["custnm"]) + "')");
                rad.Attributes.Add("onclick", "javascript:return radEmpVenCustClick(this.getAttribute('id'),'" + ctlid + "','" + tbl + "','" + ctlval + "')");


                tcname.Text = dr[0].ToString();
                tclocname.Text = dr[1].ToString();
                tcra.Controls.Add(rad);

                tr.Cells.Add(tcra);
                tr.Cells.Add(tcname);
                tr.Cells.Add(tclocname);

                tbllist.Rows.Add(tr);

            }
            dr.Close();
            return;
        }
    }
}
