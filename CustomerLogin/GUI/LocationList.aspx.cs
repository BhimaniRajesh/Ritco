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
using System.IO;
public partial class GUI_LocationList : System.Web.UI.Page
{
    string title = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        BindGrid();
    }
     public void BindGrid()
    {

        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
        string sql_st = "select loc=loccode+' : '+Locname,REport_loc=(select top 1 loccode+' : '+Locname from webx_location where loccode=l.report_loc),LocAddr,Loccity,LocPincode,LocSTDCODE,LocTelno,LocFaxNo,LocMobile,LocEmail,locstr=('<table border=0 CellPadding=0 CellSpacing=0><tr><td><u><B>Code</B></u> :-</td><td>'+convert(varchar,loccode)+'</td></tr><tr><td><u><B>Name</B></u> :-</td><td>'+convert(varchar,locname)+'  </td></tr><tr><td><u><B>Address</B></u> :-</td><td>'+convert(varchar,isnull(Locaddr,'NA'))+' </td></tr><tr><td><u><B>PH No.</B></u> :-</td><td>'+convert(varchar,(case when isnull(LocTelno,'')='' then 'NA' else LocTelno end ))+' </td></tr><tr><td><u><B>MOB No.</B></u> :-</td><td>'+convert(varchar,(case when isnull(locmobile,'')='' then 'NA' else locmobile end ))+'</td></tr><tr><td><u><B>Fax</B></u> :-</td><td>'+convert(varchar,(case when isnull(locfaxno,'')='' then 'NA' else locfaxno end ))) +'</td></tr></table>' from webx_location l with(NOLOCK)  where activeflag='Y'  order by report_loc,Loccode";
        //  Response.Write("<br>sql_st : " + sql_st);

        SqlCommand sqlcmd12 = new SqlCommand(sql_st, conn);
        //SqlDataReader dr = sqlcmd12.ExecuteReader();
        SqlDataAdapter da = new SqlDataAdapter(sqlcmd12);
        DataSet ds = new DataSet();

        da.Fill(ds);

        dgDocket.DataSource = ds;
        dgDocket.DataBind();
        // lblflow.Text = dkt_call;
        dgDocket.Visible = true;
        conn.Close();

    }
    protected void dgDocket_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            Label titleLabel = (Label)e.Row.FindControl("lblRO");
            string strval = ((Label)(titleLabel)).Text;

            title = (string)ViewState["lblRO"];
            if (title == strval && e.Row.RowIndex > 0)
            {
                titleLabel.Visible = false;
                titleLabel.Text = string.Empty;
            }
            else
            {
                title = strval;
                ViewState["lblRO"] = title;
                titleLabel.Visible = true;
                titleLabel.Text = "<b>" + title + "</b>";
            }
        }
    }
    public void XLS_DWN()
    {

        //TBL_CRI.Border = 1;

        //dgDocket.PageSize = 10000;
        dgDocket.AllowPaging = false;
        dgDocket.BorderWidth = 1;
        dgDocket.BorderColor = System.Drawing.Color.Gray;
        dgDocket.Font.Name = "verdana";
        dgDocket.Font.Size = 8;

        BindGrid();
        StringWriter stringWrite;
        HtmlTextWriter htmlWrite;
        HtmlForm frm = new HtmlForm();
        frm.Attributes.Add("runat", "server");
        Response.Clear();
        Response.AddHeader("content-disposition", "attachment;filename=LocationListing.xls");
        Response.Charset = "";

        Response.ContentType = "application/vnd.ms-xls";
        stringWrite = new System.IO.StringWriter();
        htmlWrite = new HtmlTextWriter(stringWrite);

        this.Controls.Add(frm);


        //TBL_CRI.RenderControl(htmlWrite);
        //dgDocket.RenderControl(htmlWrite);
        // frm.Controls.Add(TBL_CRI);
        frm.Controls.Add(dgDocket);
        frm.RenderControl(htmlWrite);
        Response.Write(stringWrite.ToString());
        Response.End();
    }


    protected void btn_csv_Click(object sender, EventArgs e)
    {
        XLS_DWN();
    }
}
