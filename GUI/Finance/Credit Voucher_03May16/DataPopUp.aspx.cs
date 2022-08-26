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
    string tbl = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        divparty.Visible = true;
        lblCode.Text = "Code : ";
        lblName.Text = "Name : ";
        string mod = Request.QueryString["mode"].ToString();
        if (mod.CompareTo("AccCode") == 0)
        {
            grouprow.Visible = true;
        }
        if (mod.CompareTo("LocCode") == 0)
        {
            grouprow.Visible = false;
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
                    groupcode = "groupcode in ( select groupcode from webx_groups WITH(NOLOCK) where main_category like '%" + cbomaincat.SelectedValue.ToString() + "%') " + brcdcheck;
                }
                else
                {   
                    groupcode = "1=1 " + brcdcheck;
                }
                string qry = "";
                if (txtcustcode.Text.CompareTo("") == 0 && txtcustname.Text.CompareTo("") == 0 && cbomaincat.SelectedValue.ToString().CompareTo("") != 0)
                {
                    qry = "select distinct Company_Acccode as Acccode,Accdesc,Acccode as acctcd  from webx_acctinfo  WITH(NOLOCK) where " + groupcode;
                }
                else if (txtcustcode.Text.CompareTo("") == 0 && txtcustname.Text.CompareTo("") == 0 && cbomaincat.SelectedValue.ToString().CompareTo("") == 0)
                {
                    qry = "select distinct Company_Acccode as Acccode,Accdesc,Acccode as acctcd  from webx_acctinfo WITH(NOLOCK) where " + groupcode;
                }
                else if (txtcustcode.Text.CompareTo("") != 0 && txtcustname.Text.CompareTo("") == 0)
                {
                    if(cbomaincat.SelectedValue.ToString().CompareTo("") == 0)
                        qry = "select distinct Company_Acccode as Acccode,Accdesc,Acccode as acctcd  from webx_acctinfo  WITH(NOLOCK) WHERE Company_Acccode like '" + txtcustcode.Text.ToString() + "%' and " + groupcode;
                    else
                        qry = "select distinct Company_Acccode as Acccode,Accdesc,Acccode as acctcd  from webx_acctinfo  WITH(NOLOCK) WHERE Company_Acccode like '" + txtcustcode.Text.ToString() + "%' and " + groupcode;
                }
                else if (txtcustcode.Text.CompareTo("") == 0 && txtcustname.Text.CompareTo("") != 0)
                {
                    if (cbomaincat.SelectedValue.ToString().CompareTo("") == 0)
                        qry = "select distinct Company_Acccode as Acccode,Accdesc,Acccode as acctcd  from webx_acctinfo  WITH(NOLOCK) WHERE Accdesc like '" + txtcustname.Text.ToString() + "%' and " + groupcode;
                    else
                        qry = "select distinct Company_Acccode as Acccode,Accdesc,Acccode as acctcd  from webx_acctinfo  WITH(NOLOCK) WHERE Accdesc like '" + txtcustname.Text.ToString() + "%' and " + groupcode;
                }
                else if (txtcustcode.Text.CompareTo("") != 0 && txtcustname.Text.CompareTo("") != 0)
                {
                    if (cbomaincat.SelectedValue.ToString().CompareTo("") == 0)
                        qry = "select distinct Company_Acccode as Acccode,Accdesc,Acccode as acctcd  from webx_acctinfo WHERE Accdesc like '" + txtcustname.Text.ToString() + "%' and Company_Acccode like '" + txtcustcode.Text.ToString() + "%' and " + groupcode;
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
    }
}
