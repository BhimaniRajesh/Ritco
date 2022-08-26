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
public partial class GUI_UNI_Net_MIS_QAStep1 : System.Web.UI.Page
{
    SqlConnection Conn;
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    public bool isNumeric(string val, System.Globalization.NumberStyles NumberStyle)
    {
        Double result;
        return Double.TryParse(val, NumberStyle,
            System.Globalization.CultureInfo.CurrentCulture, out result);
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        Conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        Conn.Open();
        try
        {
            string SQL_PNL = "";//exec WEbxNet_ProfitLoss '" + RO + "','" + Cumulative + "','" + fromdt + "','" + todt + "','" + RPT + "','" + GRPWISE + "','CR1-DR1','" + yearSuffix + "'  ";
            SQL_PNL = txtquery.Text.ToString();
            SqlCommand sqlcmd12_PNL = new SqlCommand(SQL_PNL, Conn);
            // Response.Write("<BR> SQL_TB : " + SQL_PNL);
            SqlDataAdapter da = new SqlDataAdapter(sqlcmd12_PNL);
            DataSet ds = new DataSet();
            
            da.Fill(ds);
            GRVPNL.DataSource = ds;
            if (ds.Tables.Count > 0)
            {
                GRVPNL.DataBind();
                GRVPNL.Style["display"] = "block";
            }
            lable11.Text = "Done";
            
        }
        catch (Exception e1)
        {
            ///Response.Write("<br><br><br><font class='redfnt' >Error : " + e1.Message + "</font>");
            lable11.Text = "<br><br><br><font class='redfnt' >Error : " + e1.Message + "</font>";
            GRVPNL.Style["display"] = "none";
        }
        finally
        {
            Conn.Close();
        }
    }

    protected void dgDocket_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            int i = 0;
            for (int ic = 0; ic < e.Row.Cells.Count; ic++)
            {

                if (isNumeric(e.Row.Cells[ic].Text.ToString(), System.Globalization.NumberStyles.Number) == true)
                {
                    e.Row.Cells[ic].HorizontalAlign = HorizontalAlign.Right;
                }
                else
                {
                     e.Row.Cells[ic].HorizontalAlign = HorizontalAlign.Left;
                }
                e.Row.Cells[ic].Wrap = false;
            }
        }
    }
}
