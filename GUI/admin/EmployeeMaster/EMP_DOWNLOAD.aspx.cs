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

public partial class GUI_UNI_MIS_Login_View_Login_2 : System.Web.UI.Page
{

    public static string strDateRange, strloc, strro, strloc2, strro2, strlogininstence, strreptype, reppara;

    public DataSet ds = new DataSet();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            //Date Range display preparation
            ForCSV();
        }
    }

    private void DisplayDtl()
    {
        DataSet ds = new DataSet();
        SqlConnection sqlConn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

        sqlConn.Open();

        SqlCommand sqlCommand = new SqlCommand("Select *, ActiveFlag = CASE status WHEN '100' THEN 'Y' ELSE 'N' END from webx_master_users", sqlConn);
        SqlDataAdapter sqlDA = new SqlDataAdapter(sqlCommand);
        sqlDA.Fill(ds);
        GV_Dtl.DataSource = ds;
        GV_Dtl.DataBind();
    }

    private void ForCSV()
    {
       
        try
        {
            GV_Dtl.AllowPaging = false;

            Response.Clear();
            Response.AddHeader("Content-Disposition", "attachment;Filename=Employee_List.xls");
            Response.Charset = "";
            Response.ContentType = "application/vnd.xls";
            System.IO.StringWriter tw = new System.IO.StringWriter();
            System.Web.UI.HtmlTextWriter hw = new System.Web.UI.HtmlTextWriter(tw);

            DisplayDtl();
            GV_Dtl.RenderControl(hw);
            Response.Write(tw.ToString());
            Response.End();
        }
        catch (Exception ex1)
        {
            throw ex1;
            // lblloc.Text = ex1.Message;
        }
    }


    public void pgChange(object sender, GridViewPageEventArgs e)
    {
        GV_Dtl.PageIndex = e.NewPageIndex;
        //  DisplayDtl();
    }

    public void lst(object sender, EventArgs e)
    {
        int i = GV_Dtl.PageCount;
        GV_Dtl.PageIndex = i;
        // DisplayDtl();
    }
    public void fst(object sender, EventArgs e)
    {
        GV_Dtl.PageIndex = 0;
        //   DisplayDtl();
    }
    public override void VerifyRenderingInServerForm(Control control)
    {
    }  
}
