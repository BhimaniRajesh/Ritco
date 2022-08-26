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

public partial class GUI_admin_Godown_Master_GodownMASTER : System.Web.UI.Page
{
    SqlConnection conn;
    static DataSet ds = new DataSet();
    DataRow drow;
    protected void Page_Load(object sender, EventArgs e)
    {
        conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());;
        conn.Open();
        if (!IsPostBack)
        {
            FillLocation();
            //string js = "<script language=\"javascript\" type=\"text/javascript\">abc()</script>";
            //Page.RegisterStartupScript("a", js); 
            TxtRows.Text = "0";
            btnSubmit.Visible = false;
        }
        
    }
    public void FillLocation()
    {
        string sConn;
        //sConn = "data source=202.87.45.72;UID=sa;PWD=ecfy@pra$$ana;Database=ASL_Live;";
        //sConn = "data source=202.87.45.71;UID=sa;PWD=eCfY$@p@$$;Database=RCPL_Ver2_Live;";
        //sConn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

        //string sql = "select top 1 '--select--' as lOCATION,'select' as SPDBRCD from webx_location  union select DISTINCT spdbrcd+' : '+(SELECT LOCNAME FROM webx_Location WHERE LOCCODE=spdbrcd) AS location,spdbrcd from webx_Godownmst  order by location,spdbrcd";
        string sql = "select top 1 '--select--' as lOCATION,'select' as SPDBRCD from webx_location union select loccode +':'+ locname as lOCATION,loccode as SPDBRCD from webx_location where activeflag='y' order by location,spdbrcd";
        SqlCommand sqlcmd = new SqlCommand(sql, conn);
        DataSet ds = new DataSet();
        SqlDataAdapter da = new SqlDataAdapter(sqlcmd);
        da.Fill(ds, "tab1");
        cboLocationCode.DataSource = ds;
        cboLocationCode.DataTextField = "location";
        cboLocationCode.DataValueField = "spdbrcd";
        cboLocationCode.DataBind();
    }
    protected void cboLocationCode_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (cboLocationCode.Text != "select")
        {
            lblerror.Visible = false;  
            GrdPaidFollow.DataSource = null;
            ds.Clear(); 
            string sql = "select godown_name,godown_desc from webx_Godownmst  where spdbrcd='" + cboLocationCode.Text + "' order by spdbrcd";
            SqlCommand sqlcmd = new SqlCommand(sql, conn);
            SqlDataAdapter da = new SqlDataAdapter(sqlcmd);
            da.Fill(ds, "table1");
            GrdPaidFollow.DataSource = ds.Tables["table1"];
            GrdPaidFollow.DataBind();
            TxtRows.Text = "";
            SqlCommand sqlCommand = new SqlCommand(sql, conn);
            SqlDataReader dr_Location;
            dr_Location = sqlCommand.ExecuteReader();
            while (dr_Location.Read())
            {
                Page.RegisterArrayDeclaration("str", "'" + Convert.ToString(dr_Location["godown_name"] + "'"));
            }
            dr_Location.Close();
            if (ds.Tables["table1"].Rows.Count > 0)
            {
                TxtRows.Text = Convert.ToString(ds.Tables["table1"].Rows.Count);
                btnSubmit.Visible = true;
            }
            else 
            {
                TxtRows.Text = "0";
                btnSubmit.Visible = false;
            }
        }
    }
    protected void CmdAddRows_Click(object sender, EventArgs e)
    {
        if (cboLocationCode.Text == "select")
        {
            lblerror.Visible = true;  
        }
        else
        {
            lblerror.Visible = false;  
            Int32 i;
            if (ds.Tables["table1"] != null)
            {
                i = Convert.ToInt32(TxtRows.Text) - Convert.ToInt32(ds.Tables["table1"].Rows.Count);
                if (i > 0)
                {
                    for (Int32 j = i; j > 0; j--)
                    {
                        drow = ds.Tables["table1"].NewRow();
                        ds.Tables["table1"].Rows.Add(drow);
                    }
                }
            }
            //GrdPaidFollow.DataSource = null; 
            GrdPaidFollow.DataSource = ds.Tables["table1"];  
            GrdPaidFollow.DataBind();
            btnSubmit.Visible = true;
        }
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        SqlCommand cmd;
        foreach (GridViewRow dr in GrdPaidFollow.Rows)   
        {
            string godown_name, godown_desc;
            godown_name = ((TextBox)dr.FindControl("txtgname")).Text.Replace("'","''").Trim();
            godown_desc = ((TextBox)dr.FindControl("txtgdesc")).Text.Replace("'","''").Trim();
            
            if ((godown_name != "") && (godown_name != null))            
            {
                SqlCommand cmd1 = new SqlCommand("Select count(*) from webx_Godownmst where spdbrcd='" + Convert.ToString(cboLocationCode.Text) + "' AND godown_name='" + godown_name.Trim() + "'", conn);
                object obj = cmd1.ExecuteScalar();

                if (obj != null)
                {
                    if (Convert.ToInt32(obj) > 0)
                    {
                        cmd = new SqlCommand("Update webx_godownmst set godown_desc='" + godown_desc + "' where SPDBRCD='" + cboLocationCode.Text + "' AND godown_name = '" + godown_name + "'", conn);
                        cmd.ExecuteNonQuery();
                    }
                    else
                    {
                        cmd = new SqlCommand("insert into webx_godownmst(SPDBRCD,godown_name,godown_desc,UPDTBY,UPDTON) values('" + cboLocationCode.Text + "' ,'" + godown_name + "','" + godown_desc + "','" + Convert.ToString(Session["empcd"]) + "',getdate())", conn);
                        cmd.ExecuteNonQuery();
                    }
                }                         
            }        
        }
        Response.Redirect("~/GUI/admin/operations.aspx");  
    }
    protected void GrdPaidFollow_RowCreated(object sender, GridViewRowEventArgs e)
    {
    }
    protected void GrdPaidFollow_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            ((TextBox)e.Row.FindControl("txtgname")).Attributes.Add("onfocus", "return getvalue(this)");//'" + ((TextBox)e.Row.FindControl("txtgname")).ClientID + "'
            ((TextBox)e.Row.FindControl("txtgdesc")).Attributes.Add("onblur", "return uppercase(this)");//'" + ((TextBox)e.Row.FindControl("txtgdesc")).ClientID + "'
            ((TextBox)e.Row.FindControl("txtgname")).Attributes.Add("onchange", "return uppercase(this),chkgodawn(this)");//'" + ((TextBox)e.Row.FindControl("txtgname")).ClientID + "'
        }
    }
}
