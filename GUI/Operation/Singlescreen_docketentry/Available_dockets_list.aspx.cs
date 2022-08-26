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

public partial class GUI_Operation_Singlescreen_docketentry_Available_dockets_list : System.Web.UI.Page
{
    SqlConnection conn;
    public static string dockno, fromdt, todt, brcd, dkt_call;
    protected void Page_Load(object sender, EventArgs e)
    {
        conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();

        if (!IsPostBack)
        {
            txtDateFrom.Text = System.DateTime.Now.ToString("dd/MM/yyyy");
            txtDateTo.Text = txtDateFrom.Text;
        }
        brcd = Session["brcd"].ToString();
        dkt_call = Session["DocketCalledAs"].ToString();
        conn.Close();
    }
    protected void btnShowList_Click(object sender, EventArgs e)
    {
        dockno = txtdockno.Text.ToString();
        string[] strArrDtFrom = txtDateFrom.Text.Split('/');
        string[] strArrDtTo = txtDateTo.Text.Split('/');
        
        fromdt = Convert.ToDateTime(strArrDtFrom[1] + "/" + strArrDtFrom[0] + "/" + strArrDtFrom[2]).ToString("dd MMM yy");
        todt = Convert.ToDateTime(strArrDtTo[1] + "/" + strArrDtTo[0] + "/" + strArrDtTo[2]).ToString("dd MMM yy");
     
        BindGrid();
    }

    protected void pgChange(object sender, GridViewPageEventArgs e)
    {

        dgDocket.PageIndex = e.NewPageIndex;

        BindGrid();

    }
    public void BindGrid()
    {
        //
        String SQL_grid = "";
        if (dockno == "")
        {
            SQL_grid = "select * from VW_Avil_dkts where Book_Curr_Loc='" + brcd + "' and  convert(varchar,allocated_date,106) between convert(datetime,'" + fromdt + "',106) and  convert(datetime,'" + todt + "',106) ";
        }
        else
        {
            SQL_grid = "select * from VW_Avil_dkts where Book_Curr_Loc='" + brcd + "' and '" + dockno + "' between Series_From and Series_To";
        }

        //Response.Write("<br> SQL_grid : " + SQL_grid);

        SqlCommand sqlcmd12 = new SqlCommand(SQL_grid, conn);
        SqlDataAdapter da = new SqlDataAdapter(sqlcmd12);

        DataSet ds = new DataSet();
        dgDocket.Visible = true;
        da.Fill(ds);

        dgDocket.DataSource = ds;
        dgDocket.DataBind();
        dgDocket.Style["display"] = "block";
    }
}
