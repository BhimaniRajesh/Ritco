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

public partial class GUI_admin_CustomerContractMaster_PopUpContractID : System.Web.UI.Page
{
    MyFunctions fn;
    SqlConnection con;
    protected void Page_Load(object sender, EventArgs e)
    {

        fn = new MyFunctions();
        con = new SqlConnection(Session["SqlProvider"].ToString());
        con.Open();

        if (!IsPostBack)
        {

          

            string sqlstr = "select distinct custcode,custnm as custname from webx_custcontract_hdr c, webx_custhdr h where c.custcode=h.custcd";
            SqlCommand cmd = new SqlCommand(sqlstr, con);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);

            cmbcustcode.DataSource = dt;
            cmbcustcode.DataBind();

            cmbcustcode.Items.Insert(0, new ListItem("Select", "0"));
          
        }
    }



    protected void loadContracID()
    {
        string sqlstr = "SELECT contractid FROM webx_custcontract_hdr WHERE custcode='" + cmbcustcode.SelectedValue.Trim() + "' AND contract_type='" + cmbpaybas.SelectedValue.Trim() + "'";
        SqlCommand cmd = new SqlCommand(sqlstr, con);
        SqlDataReader dr = cmd.ExecuteReader();
        int cnt = 0;
        TableRow tr = new TableRow();
        tr.BackColor = System.Drawing.Color.White;
        while (dr.Read())
        {
            if (cnt == 0)
            {
                tr = new TableRow();
                tr.BackColor = System.Drawing.Color.White;
            }

            TableCell tc = new TableCell();
            tc.HorizontalAlign = HorizontalAlign.Center;
            tc.VerticalAlign = VerticalAlign.Middle;
            tc.BackColor = System.Drawing.Color.White;
            LinkButton lnk = new LinkButton();
            lnk.CssClass = "blackfnt";
            lnk.Text = dr["contractid"].ToString();
            lnk.Attributes.Add("onclick", "javascript:return selectContractID('" + dr["contractid"].ToString() + "')");
            lnk.Attributes.Add("onmouseover", "this.style.cursor='pointer'");
            lnk.ToolTip = "Click to Select ContractID ";
            tc.Controls.Add(lnk);
            tr.Cells.Add(tc);

            cnt++;
            if (cnt == 5)
            {
                tblcontractid.Rows.Add(tr);
                cnt = 0;
            }
        }
        dr.Close();

        if (cnt > 0)
        {
            for (int i = 0; i < 5 - cnt; i++)
            {
                TableCell tc = new TableCell();
                tc.HorizontalAlign = HorizontalAlign.Center;
                tc.Text = " ";
                tr.Cells.Add(tc);
            }
            tblcontractid.Rows.Add(tr);
        }

    }


    protected void btnstep1_Click(object sender, EventArgs e)
    {
        cmbcustcode.Enabled = false;
        cmbpaybas.Enabled = false;

        loadContracID();
        tblcontractid.Style["display"] = "block";
        divpopup.Style["display"] = "block";
        trstep1.Style["display"] = "none";
    }

  

}
