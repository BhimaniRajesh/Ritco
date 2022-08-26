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

public partial class GUI_Telecomm_CommAssets_Reg_Rpt : System.Web.UI.Page
{
    string ReportType, Location, Person, Vendor, Device, Region;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!(IsPostBack))
        {
            ReportType = Request.QueryString["ReportType"];
            Location = Request.QueryString["Location"];
            Person = Request.QueryString["Person"];
            Vendor = Request.QueryString["Vendor"];
            Device = Request.QueryString["Device"];
            Region = Request.QueryString["Region"];

            lblLocation.Text = Location;
            lblUser.Text = Person == "" ? "All" : Person;
            lblVendor.Text = Vendor;
            lblDevice.Text = Device;
        }
        BindGrid();
    }
    DataColumn dc;
    DataTable dt = new DataTable();
    DataRow dr;
    private void BindGrid()
    {
        if (ReportType == "Summary")
        {
            SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
            conn.Open();
            string sql = "Webx_SP_Asset_Reg_Device_Type";
            SqlCommand cmd = new SqlCommand(sql, conn);
            cmd.CommandType = CommandType.StoredProcedure;

            if (Location != "All")
            {
                cmd.Parameters.Add("@CDM_Location", SqlDbType.VarChar).Value = Location;
            }
            if (Vendor != "All" )
            {
                cmd.Parameters.Add("@CDM_Vendor", SqlDbType.VarChar).Value = Vendor;
            }
            if (Person != "All" && Person != "")
            {
                cmd.Parameters.Add("@CDM_Person", SqlDbType.VarChar).Value = Person;
            }
            if (Device != "All")
            {
                cmd.Parameters.Add("@CDM_Device_Type", SqlDbType.VarChar).Value = Device;
            }
            if (Region != "All")
            {
                cmd.Parameters.Add("@LocCity", SqlDbType.VarChar).Value = Region;
            }

            string op = Convert.ToString(cmd.ExecuteScalar());
            Array a1,a2,a3;
            //string spl = "||";
            a1 = op.Split('|');
            string e = ((string[])(a1))[0];
            a2 = e.Split(',');
            for (int k = 0; k < a2.Length; k++)
            {
                dc = new DataColumn("" + ((string[])(a2))[k] + "", typeof(string));
                dt.Columns.Add(dc);
            }

            for (int i = 1; i < a1.Length; i++)
            {
                e = ((string[])(a1))[i];
                a3 = e.Split(',') ;
                
                dr = dt.NewRow();
                for (int j = 0; j < a3.Length; j++)
                {
                    dr[j] = ((string[])(a3))[j];                    
                }
                dt.Rows.Add(dr);
            }
            gvAssetsReg.DataSource = dt;
            BindData();
            gvAssetsReg.DataBind();   
            
            TableRow tr;
            TableCell tc;
            tr = new TableRow();
            for (int k = 0; k < dt.Columns.Count; k++)
            {
                tc = new TableCell();
                Label l1 = new Label();
                l1.CssClass = "blackfnt";
                l1.Text = dt.Columns[k].ColumnName;
                tc.Style.Add("border", "solid 1px black");
                tc.Style.Add("width", "25%");
                tc.Controls.Add(l1);
                tr.CssClass = "bgbluegrey";
                tr.Cells.Add(tc);
            }
            Table1.Rows.Add(tr);
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                tr = new TableRow();
                for (int j = 0; j < dt.Columns.Count; j++)
                {
                    if (j == 0)
                    {
                        tc = new TableCell();
                        Label l1 = new Label();
                        l1.Text = Convert.ToString(dt.Rows[i][j]);
                        l1.CssClass = "blackfnt";
                        tc.Style.Add("border", "solid 1px black");
                        tc.Style.Add("width", "25%");
                        //tc.Width = 25;
                        tc.Controls.Add(l1);
                        tr.Cells.Add(tc);
                    }
                    else
                    {
                        tc = new TableCell();
                        HyperLink h1 = new HyperLink();
                        h1.Text = Convert.ToString(dt.Rows[i][j]);
                        if (h1.Text != "0")
                        {
                            //h1.NavigateUrl = "FrmQry?a=" + dt.Rows[i][0] + "&b=" + dt.Columns[j].ColumnName.ToString() + "";
                            h1.NavigateUrl = "#";// + dt.Rows[i][0] + "&b=" + dt.Columns[j].ColumnName.ToString() + "";
                        }
                        tc.Controls.Add(h1);
                        h1.CssClass = "blackfnt";
                        //tc.Width = "25%";
                        tc.Style.Add("border", "solid 1px black");
                        tr.Cells.Add(tc);
                    }
                    tr.BackColor = System.Drawing.Color.White;
                }
                Table1.Rows.Add(tr);
            }
        }
        if (ReportType == "Vendor")
        {
            SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
            //SqlConnection conn = new SqlConnection("Data Source=PRISM;Initial Catalog=Telecom;UID=sa;pwd=sys");
            conn.Open();
            string sql = "Webx_SP_Asset_Reg_Vendor";
            SqlCommand cmd = new SqlCommand(sql, conn);
            cmd.CommandType = CommandType.StoredProcedure;

            if (Location != "All")
            {
                cmd.Parameters.Add("@CDM_Location", SqlDbType.VarChar).Value = Location;
            }
            if (Vendor != "All")
            {
                cmd.Parameters.Add("@CDM_Vendor", SqlDbType.VarChar).Value = Vendor;
            }
            if (Person != "All" && Person != "")
            {
                cmd.Parameters.Add("@CDM_Person", SqlDbType.VarChar).Value = Person;
            }
            if (Device != "All")
            {
                cmd.Parameters.Add("@CDM_Device_Type", SqlDbType.VarChar).Value = Device;
            }
            if (Region != "All")
            {
                cmd.Parameters.Add("@LocCity", SqlDbType.VarChar).Value = Region;
            }

            string op = Convert.ToString(cmd.ExecuteScalar());
            Array a1, a2, a3;
            //string spl = "||";
            a1 = op.Split('|');
            string e = ((string[])(a1))[0];
            a2 = e.Split(',');
            for (int k = 0; k < a2.Length; k++)
            {
                dc = new DataColumn("" + ((string[])(a2))[k] + "", typeof(string));
                dt.Columns.Add(dc);
            }

            for (int i = 1; i < a1.Length; i++)
            {
                e = ((string[])(a1))[i];
                a3 = e.Split(',');

                dr = dt.NewRow();
                for (int j = 0; j < a3.Length; j++)
                {
                    dr[j] = ((string[])(a3))[j];

                }
                dt.Rows.Add(dr);

            }
            gvAssetsReg.DataSource = dt;
            BindData();
            gvAssetsReg.DataBind();
            TableRow tr;
            TableCell tc;
            tr = new TableRow();
            for (int k = 0; k < dt.Columns.Count; k++)
            {
                tc = new TableCell();
                Label l1 = new Label();
                l1.CssClass = "blackfnt";
                l1.Text = dt.Columns[k].ColumnName;
                tc.Style.Add("border", "solid 1px black");
                tc.Style.Add("width", "25%");
                tc.Controls.Add(l1);
                tr.CssClass = "bgbluegrey";
                tr.Cells.Add(tc);
            }
            Table1.Rows.Add(tr);
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                tr = new TableRow();
                for (int j = 0; j < dt.Columns.Count; j++)
                {
                    if (j == 0)
                    {
                        tc = new TableCell();
                        Label l1 = new Label();
                        l1.Text = Convert.ToString(dt.Rows[i][j]);
                        l1.CssClass = "blackfnt";
                        tc.Style.Add("border", "solid 1px black");
                        tc.Style.Add("width", "25%");
                        //tc.Width = 25;
                        tc.Controls.Add(l1);
                        tr.Cells.Add(tc);
                    }
                    else
                    {
                        tc = new TableCell();
                        HyperLink h1 = new HyperLink();
                        h1.Text = Convert.ToString(dt.Rows[i][j]);
                        if (h1.Text != "0")
                        {
                            //h1.NavigateUrl = "FrmQry?a=" + dt.Rows[i][0] + "&b=" + dt.Columns[j].ColumnName.ToString() + "";
                            h1.NavigateUrl = "#";// + dt.Rows[i][0] + "&b=" + dt.Columns[j].ColumnName.ToString() + "";
                        }
                        tc.Controls.Add(h1);
                        h1.CssClass = "blackfnt";
                        //tc.Width = "25%";
                        tc.Style.Add("border", "solid 1px black");
                        tr.Cells.Add(tc);
                    }
                    tr.BackColor = System.Drawing.Color.White;
                }
                Table1.Rows.Add(tr);
                //Table1.Style.Add("border", "solid 1px black");
            }
        }
        if (ReportType == "Register")
        {
            SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
            conn.Open();
            string sql = "Webx_SP_Asset_Reg_Reg";
            SqlCommand cmd = new SqlCommand(sql, conn);
            cmd.CommandType = CommandType.StoredProcedure;

            SqlDataAdapter da = new SqlDataAdapter(cmd);

            if (Location != "All")
            {
                cmd.Parameters.Add("@CDM_Location", SqlDbType.VarChar).Value = Location;
            }
            if (Vendor != "All")
            {
                cmd.Parameters.Add("@CDM_Vendor", SqlDbType.VarChar).Value = Vendor;
            }
            if (Person != "All" && Person != "")
            {
                cmd.Parameters.Add("@CDM_Person", SqlDbType.VarChar).Value = Person;
            }
            if (Device != "All")
            {
                cmd.Parameters.Add("@CDM_Device_Type", SqlDbType.VarChar).Value = Device;
            }
            if (Region != "All")
            {
                cmd.Parameters.Add("@LocCity", SqlDbType.VarChar).Value = Region;
            }

            DataSet ds = new DataSet();
            da.Fill(ds);
            DataView dv = new DataView();
            dv = ds.Tables[0].DefaultView;

            gvAssetsReg1.DataSource = dv;
            gvAssetsReg1.DataBind(); 
        }
    }
    protected void BindData()
    {
        BoundField bf_HelpDesk;
        HyperLinkField hf_HelpDesk;
        string[] Arr = new string[1];
        for (int i = 0; i < dt.Columns.Count; i++)
        {
            if (i == 0)
            {
                bf_HelpDesk = new BoundField();
                bf_HelpDesk.ControlStyle.CssClass = "blackfnt";
                bf_HelpDesk.ItemStyle.CssClass = "blackfnt";
                bf_HelpDesk.HeaderStyle.CssClass = "blackfnt";
                bf_HelpDesk.DataField = dt.Columns[i].ColumnName;
                bf_HelpDesk.HeaderText = dt.Columns[i].ColumnName.ToString();
                gvAssetsReg.Columns.Add(bf_HelpDesk);
            }
            else 
            {
                hf_HelpDesk = new HyperLinkField();
                hf_HelpDesk.ControlStyle.CssClass = "blackfnt";
                hf_HelpDesk.ItemStyle.CssClass = "blackfnt";
                hf_HelpDesk.HeaderStyle.CssClass = "blackfnt";
                hf_HelpDesk.DataTextField = dt.Columns[i].ColumnName;
                hf_HelpDesk.HeaderText = dt.Columns[i].ColumnName.ToString();
                //Array Arr;
                //Array.Clear(Arr, 0, 1);
                //Arr[0] = hf_HelpDesk.HeaderText;//dt.Columns[i].ColumnName;
                //Arr[1] = dt.Rows[0][0].ToString();
                //hf_HelpDesk.DataNavigateUrlFields = Arr;
                //hf_HelpDesk.DataNavigateUrlFormatString = "FrmSalesDocketDetail.aspx?loccode1={0}";//&locname={1}";
                gvAssetsReg.Columns.Add(hf_HelpDesk);
            }
        }        
    }    
}
