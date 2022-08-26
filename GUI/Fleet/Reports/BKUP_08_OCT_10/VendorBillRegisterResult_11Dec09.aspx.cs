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
using System.Text;
using System.IO;



public partial class GUI_Fleet_Reports_VendorBillReg : System.Web.UI.Page
{

    string strCreatedFrom = "";
    string strCreatedTo = "";
    string strStatus = "";
    string strVendorType = "";
    string strVendorName = "";
    string strAgingAnlysisB = "";
    string strAgingAnlysisD = "";
    string strDtF = "";
    string strDtT = "";
    protected void Page_Load(object sender, EventArgs e)
    {
       


        if (!IsPostBack)
        {
            
           
            if (Request.QueryString["CreatedFrom"] != null)
            {
                strCreatedFrom = Request.QueryString["CreatedFrom"].ToString(); 
            }
            if (Request.QueryString["CreatedTo"] != null)
            {
                strCreatedTo = Request.QueryString["CreatedTo"].ToString(); 
            }
            if (Request.QueryString["Status"] != null)
            {
                strStatus = Request.QueryString["Status"].ToString(); 
            }
            if (Request.QueryString["VendorType"] != null)
            {
                strVendorType = Request.QueryString["VendorType"].ToString(); 
            }
            if (Request.QueryString["VendorName"] != null)
            {
                strVendorName = Request.QueryString["VendorName"].ToString(); 
            }
            if (Request.QueryString["AgingAnlysisB"] != null)
            {
                strAgingAnlysisB = Request.QueryString["AgingAnlysisB"].ToString(); 
            }
            if (Request.QueryString["AgingAnlysisD"] != null)
            {
                strAgingAnlysisD = Request.QueryString["AgingAnlysisD"].ToString(); 
            }
            if (Request.QueryString["DtF"] != null)
            {
                strDtF = Request.QueryString["DtF"].ToString(); 
            }
            if (Request.QueryString["DtT"] != null)
            {
                strDtT = Request.QueryString["DtT"].ToString();
            }
            BindGrid();
            //Response.Write(strCreatedFrom + "<br>");
            //Response.Write(strCreatedTo + "<br>");
            //Response.Write(strStatus + "<br>");
            //Response.Write(strVendorType + "<br>");
            //Response.Write(strVendorName + "<br>");
            //Response.Write(strAgingAnlysisB + "<br>");
            //Response.Write(strAgingAnlysisD + "<br>");
            //Response.Write(strDtF + "<br>");
            //Response.Write(strDtT + "<br>");
        }
    }


    public void BindGrid()
    {
        string sql = "usp_Vendor_Bill_Register";
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
        SqlCommand sqlcmd = new SqlCommand(sql, conn);
        sqlcmd.CommandType = CommandType.StoredProcedure;
        SqlDataAdapter da = new SqlDataAdapter(sqlcmd);

        da.SelectCommand.Parameters.Add("@CreatedFrom", SqlDbType.VarChar).Value = strCreatedFrom;
        da.SelectCommand.Parameters.Add("@CreatedTo", SqlDbType.VarChar).Value = strCreatedTo;
        if (strStatus == "ALL")
        {
            strStatus = "";
        }
        da.SelectCommand.Parameters.Add("@Status", SqlDbType.VarChar).Value = strStatus;
        if (strVendorType == "ALL")
        {
            strVendorType = "";
        }
        da.SelectCommand.Parameters.Add("@VendorType", SqlDbType.VarChar).Value = strVendorType;
        if (strVendorName == "ALL")
        {
            strVendorName = "";
        }
        da.SelectCommand.Parameters.Add("@VendorName", SqlDbType.VarChar).Value = strVendorName;
        //da.SelectCommand.Parameters.Add("@AgingAnlysisB", SqlDbType.VarChar).Value = strAgingAnlysisB;
        //da.SelectCommand.Parameters.Add("@AgingAnlysisD", SqlDbType.VarChar).Value = strAgingAnlysisD;
        //da.SelectCommand.Parameters.Add("@DtF", SqlDbType.VarChar).Value = strDtF;
        //da.SelectCommand.Parameters.Add("@DtT", SqlDbType.VarChar).Value = strDtT;
        sqlcmd.ExecuteReader();
        conn.Close();

        DataSet ds = new DataSet();
        da.Fill(ds);
        GridView1.DataSource = ds;
        GridView1.DataBind();
    }

    protected void pgChange(object sender, GridViewPageEventArgs e)
    {
        GridView1.PageIndex = e.NewPageIndex;
        BindGrid();
    }


    protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            // reference the Delete Link Command Column.
            //LinkButton db = (LinkButton)e.Row.Cells[6].Controls[0];
            //db.OnClientClick = string.Format("return confirm('Are you want to delete the Order?');");
        }
    }





    protected void btnXML_Click(object sender, EventArgs e)
    {


        GridView1.AllowPaging = false;
        GridView1.BorderWidth = 1;
        GridView1.CssClass = "blackfnt";
        GridView1.Font.Size = 10;

        BindGrid();
        StringWriter stringWrite;
        HtmlTextWriter htmlWrite;
        HtmlForm frm = new HtmlForm();
        Response.Clear();
        Response.AddHeader("content-disposition", "attachment;filename=TripsheetRegister.xls");
        Response.Charset = "";
        Response.ContentType = "application/vnd.ms-xls";
        stringWrite = new System.IO.StringWriter();
        htmlWrite = new HtmlTextWriter(stringWrite);


        Controls.Add(frm);

        frm.Controls.Add(GridView1);

        frm.RenderControl(htmlWrite);

        Response.Write(stringWrite.ToString());
        Response.End();

    }   
}
