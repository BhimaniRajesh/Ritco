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
        if (mod.CompareTo("AccCode") == 0)
        {
            grouprow.Visible = true;
            lblCode.Text = "Account Code : ";
            lblName.Text = "Account Description : ";
        }
        if (mod.CompareTo("LocCode") == 0)
        {
            grouprow.Visible = false;
            lblCode.Text = "Location Code : ";
            lblName.Text = "Location Name : ";
        }
        if (mod.CompareTo("P") == 0)
        {
            grouprow.Visible = false;
            lblCode.Text = "Customer Code : ";
            lblName.Text = "Customer Name : ";
        } 
        if (mod.CompareTo("V") == 0)
        {
            grouprow.Visible = false;
            lblCode.Text = "Vendor Code : ";
            lblName.Text = "Vendor Name : ";
        } 
        if (mod.CompareTo("E") == 0)
        {
            grouprow.Visible = false; 
            lblCode.Text = "Employee Code : ";
            lblName.Text = "Employee Name : ";
        }
        if (mod.CompareTo("D") == 0)
        {
            grouprow.Visible = false;
            lblCode.Text = "Driver Code : ";
            lblName.Text = "Driver Name : ";
        }
        if (mod.CompareTo("L") == 0)
        {
            grouprow.Visible = false;
            namerow.Visible = false;
            lblCode.Text = "Vehicle Code : ";
        }
        
    }

    protected void btnpartysubmit_Click(object sender, EventArgs e)
    {
        SqlConnection con = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        con.Open();

        SqlCommand cmd;
        SqlDataReader dr;

        string mode = Request.QueryString["mode"].ToString();

        if (mode.CompareTo("AccLoc") == 0)
        {
            lblCode.Text = "Location Code : ";
            lblName.Text = "Location Name : ";
            divparty.Visible = true;

            string qry = "";
            
            if (txtcustcode.Text.CompareTo("") == 0 && txtcustname.Text.CompareTo("") == 0)
            {
                qry = "SELECT distinct loccode,locname from webx_location where Loc_Account = 'Y'";
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
        else if (mode.CompareTo("LocCode") == 0)
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
            else if (mode.CompareTo("AccCode") == 0)
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
                    qry = "select distinct Company_Acccode as Acccode,Accdesc,Acccode as acctcd  from webx_acctinfo  WITH(NOLOCK) where acccategory not in('BANK','CASH') and " + groupcode;
                }
                else if (txtcustcode.Text.CompareTo("") == 0 && txtcustname.Text.CompareTo("") == 0 && cbomaincat.SelectedValue.ToString().CompareTo("") == 0)
                {
                    qry = "select distinct Company_Acccode as Acccode,Accdesc,Acccode as acctcd  from webx_acctinfo WITH(NOLOCK) where acccategory not in('BANK','CASH') " + brcdcheck;
                }
                else if (txtcustcode.Text.CompareTo("") != 0 && txtcustname.Text.CompareTo("") == 0)
                {
                    if(cbomaincat.SelectedValue.ToString().CompareTo("") == 0)
                        qry = "select distinct Company_Acccode as Acccode,Accdesc,Acccode as acctcd  from webx_acctinfo  WITH(NOLOCK) WHERE Company_Acccode like '" + txtcustcode.Text.ToString() + "%' " + brcdcheck;
                    else
                        qry = "select distinct Company_Acccode as Acccode,Accdesc,Acccode as acctcd  from webx_acctinfo  WITH(NOLOCK) WHERE Company_Acccode like '" + txtcustcode.Text.ToString() + "%' and " + groupcode;
                }
                else if (txtcustcode.Text.CompareTo("") == 0 && txtcustname.Text.CompareTo("") != 0)
                {
                    if (cbomaincat.SelectedValue.ToString().CompareTo("") == 0)
                        qry = "select distinct Company_Acccode as Acccode,Accdesc,Acccode as acctcd  from webx_acctinfo  WITH(NOLOCK) WHERE Accdesc like '" + txtcustname.Text.ToString() + "%' " + brcdcheck;
                    else
                        qry = "select distinct Company_Acccode as Acccode,Accdesc,Acccode as acctcd  from webx_acctinfo  WITH(NOLOCK) WHERE Accdesc like '" + txtcustname.Text.ToString() + "%' and " + groupcode;

                }
                else if (txtcustcode.Text.CompareTo("") != 0 && txtcustname.Text.CompareTo("") != 0)
                {
                    if (cbomaincat.SelectedValue.ToString().CompareTo("") == 0)
                        qry = "select distinct Company_Acccode as Acccode,Accdesc,Acccode as acctcd  from webx_acctinfo WHERE Accdesc like '" + txtcustname.Text.ToString() + "%' and Company_Acccode like '" + txtcustcode.Text.ToString() + "%' " + brcdcheck;
                    else
                        qry = "select distinct Company_Acccode as Acccode,Accdesc,Acccode as acctcd from webx_acctinfo WHERE Accdesc like '" + txtcustname.Text.ToString() + "%' and Company_Acccode like '" + txtcustcode.Text.ToString() + "%' and " + groupcode;
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
            else if (mode.CompareTo("E") == 0)
            {
                lblCode.Text = "Employee Code : ";
                lblName.Text = "Employee Name : ";

                divparty.Visible = true;

                string qry = "";
                string BranchCheck = "";

                if (SessionUtilities.Client.CompareTo("Ritco") == 0)
                    BranchCheck = " and BranchCode='" + SessionUtilities.CurrentBranchCode + "'";
                else
                    BranchCheck = "";

                if (txtcustcode.Text.CompareTo("") == 0 && txtcustname.Text.CompareTo("") == 0)
                {
                    qry = "select userid,name from webx_master_users WITH(NOLOCK) where status='100'" + BranchCheck;
                }
                else if (txtcustcode.Text.CompareTo("") != 0 && txtcustname.Text.CompareTo("") == 0)
                {
                    qry = "select userid,name from webx_master_users WHERE userid like '" + txtcustcode.Text.ToString() + "%'" + BranchCheck;
                }
                else if (txtcustcode.Text.CompareTo("") == 0 && txtcustname.Text.CompareTo("") != 0)
                {
                    qry = "select userid,name from webx_master_users WHERE name like '" + txtcustname.Text.ToString() + "%'" + BranchCheck;
                }
                else if (txtcustcode.Text.CompareTo("") != 0 && txtcustname.Text.CompareTo("") != 0)
                {
                    qry = "select userid,name from webx_master_users WHERE name like '" + txtcustname.Text.ToString() + "%' and userid like '" + txtcustcode.Text.ToString() + "%'" + BranchCheck;
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
            else if (mode.CompareTo("V") == 0)
            {
                lblCode.Text = "Vendor Code : ";
                lblName.Text = "Vendor Name : ";
                divparty.Visible = true;

                string qry = "";
                if (txtcustcode.Text.CompareTo("") == 0 && txtcustname.Text.CompareTo("") == 0)
                {
                    qry = "select vendorCode,vendorname from webx_VENDOR_HDR WITH(NOLOCK) where vendorcode in ( select vendorcode from webx_VENDOR_det WITH(NOLOCK)  where vendorCode is not null and    PATINDEx ('%" + Session["brcd"].ToString() + "%',vendorbrcd)>0 ) order by vendorname";
                }
                else if (txtcustcode.Text.CompareTo("") != 0 && txtcustname.Text.CompareTo("") == 0)
                {
                    qry = "select vendorCode,vendorname from webx_VENDOR_HDR WITH(NOLOCK) WHERE vendorcode in ( select vendorcode from webx_VENDOR_det WITH(NOLOCK)  where vendorCode is not null and    PATINDEx ('%" + Session["brcd"].ToString() + "%',vendorbrcd)>0 ) and vendorCode like '" + txtcustcode.Text.ToString() + "%'";
                }
                else if (txtcustcode.Text.CompareTo("") == 0 && txtcustname.Text.CompareTo("") != 0)
                {
                    qry = "select vendorCode,vendorname from webx_VENDOR_HDR WITH(NOLOCK) WHERE vendorcode in ( select vendorcode from webx_VENDOR_det WITH(NOLOCK)  where vendorCode is not null and    PATINDEx ('%" + Session["brcd"].ToString() + "%',vendorbrcd)>0 ) and vendorname like '" + txtcustname.Text.ToString() + "%'";
                }
                else if (txtcustcode.Text.CompareTo("") != 0 && txtcustname.Text.CompareTo("") != 0)
                {
                    qry = "select vendorCode,vendorname from webx_VENDOR_HDR WITH(NOLOCK) WHERE vendorcode in ( select vendorcode from webx_VENDOR_det WITH(NOLOCK)  where vendorCode is not null and    PATINDEx ('%" + Session["brcd"].ToString() + "%',vendorbrcd)>0 ) and vendorname like '" + txtcustname.Text.ToString() + "%' and vendorCode like '" + txtcustcode.Text.ToString() + "%'";
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
            else if (mode.CompareTo("P") == 0)
            {
                lblCode.Text = "Customer Code : ";
                lblName.Text = "Customer Name : ";
                divparty.Visible = true;

                string qry = "";
                if (txtcustcode.Text.CompareTo("") == 0 && txtcustname.Text.CompareTo("") == 0)
                {
                    qry = "select custcd,custnm from webx_custhdr WITH(NOLOCK) where CUSTCD is not null and PATINDEx ('%" + Session["brcd"].ToString() + "%',custloc)>0  order by CUSTNM";
                }
                else if (txtcustcode.Text.CompareTo("") != 0 && txtcustname.Text.CompareTo("") == 0)
                {
                    qry = "select custcd,custnm from webx_custhdr WITH(NOLOCK) where CUSTCD is not null and PATINDEx ('%" + Session["brcd"].ToString() + "%',custloc)>0  and custcd like '" + txtcustcode.Text.ToString() + "%'";
                }
                else if (txtcustcode.Text.CompareTo("") == 0 && txtcustname.Text.CompareTo("") != 0)
                {
                    qry = "select custcd,custnm from webx_custhdr WITH(NOLOCK) where CUSTCD is not null and PATINDEx ('%" + Session["brcd"].ToString() + "%',custloc)>0  and custnm like '" + txtcustname.Text.ToString() + "%'";
                }
                else if (txtcustcode.Text.CompareTo("") != 0 && txtcustname.Text.CompareTo("") != 0)
                {
                    qry = "select custcd,custnm from webx_custhdr WITH(NOLOCK) where CUSTCD is not null and PATINDEx ('%" + Session["brcd"].ToString() + "%',custloc)>0 and custnm like '" + txtcustname.Text.ToString() + "%' and custcd like '" + txtcustcode.Text.ToString() + "%'";
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
            else if (mode.CompareTo("D") == 0)
            {
                lblCode.Text = "Driver Code : ";
                lblName.Text = "Driver Name : ";
                divparty.Visible = true;

                string qry = "";
                if (txtcustcode.Text.CompareTo("") == 0 && txtcustname.Text.CompareTo("") == 0)
                {
                    qry = "select Driver_id,Driver_Name from webx_fleet_drivermst WITH(NOLOCK) where Driver_id is not null and PATINDEx ('%" + Session["brcd"].ToString() + "%',Driver_Location)>0  order by Driver_Name";
                }
                else if (txtcustcode.Text.CompareTo("") != 0 && txtcustname.Text.CompareTo("") == 0)
                {
                    qry = "select Driver_id,Driver_Name from webx_fleet_drivermst WITH(NOLOCK) where Driver_id is not null and PATINDEx ('%" + Session["brcd"].ToString() + "%',Driver_Location)>0  and Manual_Driver_Code like '" + txtcustcode.Text.ToString() + "%'";
                }
                else if (txtcustcode.Text.CompareTo("") == 0 && txtcustname.Text.CompareTo("") != 0)
                {
                    qry = "select Driver_id,Driver_Name from webx_fleet_drivermst WITH(NOLOCK) where Driver_id is not null and PATINDEx ('%" + Session["brcd"].ToString() + "%',Driver_Location)>0  and Driver_Name like '" + txtcustname.Text.ToString() + "%'";
                }
                else if (txtcustcode.Text.CompareTo("") != 0 && txtcustname.Text.CompareTo("") != 0)
                {
                    qry = "select Driver_id,Driver_Name from webx_fleet_drivermst WITH(NOLOCK) where Driver_id is not null and PATINDEx ('%" + Session["brcd"].ToString() + "%',Driver_Location)>0 and Driver_Name like '" + txtcustname.Text.ToString() + "%' and Manual_Driver_Code like '" + txtcustcode.Text.ToString() + "%'";
                }

                ctlid = Request.QueryString["ctlid"].ToString();
                tbl = Request.QueryString["tbl"].ToString();

                cmd = new SqlCommand(qry, con);
                dr = cmd.ExecuteReader();
                TableRow trhead = new TableRow();

                TableCell tcheadra = new TableCell();
                TableCell tcheadname = new TableCell();
                TableCell tcheadlocname = new TableCell();

                tcheadlocname.Text = "Driver Name";
                tcheadname.Text = "Driver Code";
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
                    rad.ID = "rad" + dr["Driver_id"].ToString();
                    ctlval = dr["Driver_Name"].ToString();

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
            else if (mode.CompareTo("L") == 0)
            {
                lblCode.Text = "Vehicle Code : ";
                divparty.Visible = true;

                string qry = "";
                if (txtcustcode.Text.CompareTo("") == 0)
                {
                    qry = "select Vehno as Vehicleno,Vehno as Vehiclename from webx_vehicle_hdr WITH(NOLOCK) where Vehno is not null and PATINDEx ('%" + Session["brcd"].ToString() + "%',Conrtl_branch)>0  order by Vehno";
                }
                else if (txtcustcode.Text.CompareTo("") != 0)
                {
                    qry = "select Vehno as Vehicleno,Vehno as Vehiclename from webx_vehicle_hdr WITH(NOLOCK) where Vehno is not null and PATINDEx ('%" + Session["brcd"].ToString() + "%',Conrtl_branch)>0  and Vehno like '" + txtcustcode.Text.ToString() + "%'";
                }

                ctlid = Request.QueryString["ctlid"].ToString();
                tbl = Request.QueryString["tbl"].ToString();

                cmd = new SqlCommand(qry, con);
                dr = cmd.ExecuteReader();
                TableRow trhead = new TableRow();

                TableCell tcheadra = new TableCell();
                TableCell tcheadname = new TableCell();
                TableCell tcheadlocname = new TableCell();

                tcheadlocname.Text = "Vehicle Name";
                tcheadname.Text = "Vehicle Code";
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
                    rad.ID = "rad" + dr["Vehicleno"].ToString();
                    ctlval = dr["Vehiclename"].ToString();

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
