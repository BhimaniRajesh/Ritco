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



    public static string strDateRange, strloc, stremp, strlogininstence, strreptype;
    public DataTable dt = new DataTable();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            //Date Range display preparation
            strDateRange = Request.QueryString["strDateRange"].ToString();
            strloc = Request.QueryString["strloc"].ToString();
            stremp = Request.QueryString["stremp"].ToString();
            strlogininstence = Request.QueryString["strlogininstence"].ToString();
            strreptype = Request.QueryString["strreptype"].ToString();


        }


        // lables......


        //  global

        lblseldet.Text = strDateRange;
        lblloc.Text = strloc;
        lblemp.Text = stremp;
        lblli.Text = strlogininstence;

        DipsplayReport();


    }
    /*
     * uni_mis/login_view/login_view.aspx
     * */

    public void DipsplayReport()
    {

        string[] strArrDtFromTo = strDateRange.Split('-');
        string strfrmdt = strArrDtFromTo[0];
        string strtodt = strArrDtFromTo[1];
        string locval = "";
        string empval = "";
        string lival = "";
        if (strloc != "")
        {

            locval = "and CURRBRCD=" + strloc;
        }
        else
        {
            lblloc.Text = "All";
        }

        if (stremp != "")
        {

            empval = "and empcd='" + stremp + "'";
        }
        else
        {
            lblemp.Text = "All";

        }


        if (strlogininstence != "")
        {
            lblli.Text = strlogininstence;
            lival = "and Duration >=" + strlogininstence + "";

        }
        else
        {
            lblli.Text = "0";

        }



        //  SqlConnection conn = new SqlConnection("data source=202.87.45.71;UID=sa;PWD=eCfY$@p@$$;Database=RCPL_Ver2_Live;");

         SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

        // SqlConnection conn = new SqlConnection("data source=202.87.45.71;UID=sa;PWD=$rcpl@@p@$$;Database=RCPL_Ver2_Live;");


      //  SqlConnection conn = new SqlConnection("data source=202.87.45.71;UID=sa;PWD=$rcpl@@p@$$;Database=RCPL_Ver2_Live;");
        /// /uni_mis/login_view/login_view.aspx
        string sql = "";
        //int li;
        //li= Convert(Int32,strlogininstence.ToString());

        if (strreptype == "A")
        {
            sql = "select EMPCD,EMPNM,LocName,CURRBRCD,LASTLOGINDT,LOGOUTDT,Duration  from webx_login where  convert(varchar,LASTLOGINDT,106)  between convert(datetime,'" + strfrmdt + "',106) and convert(datetime,'" + strtodt + "',106) " + locval + empval + lival + " " + "order by EMPNM,LocName";

            conn.Open();

            SqlCommand sqlCommand = new SqlCommand(sql, conn);

            dt = new DataTable();

            dt.Columns.Add("SRNO", typeof(string));
            dt.Columns.Add("emp", typeof(string));
            dt.Columns.Add("loc", typeof(string));
            dt.Columns.Add("login", typeof(string));
            dt.Columns.Add("logout", typeof(string));
            dt.Columns.Add("Duration", typeof(string));

            DataRow dr;




            try
            {

                SqlDataAdapter sqlDA = new SqlDataAdapter(sqlCommand);

                DataSet ds1 = new DataSet();
                sqlDA.Fill(ds1);
                int sno = 1;


                foreach (DataRow drRows in ds1.Tables[0].Rows)
                {

                    dr = dt.NewRow();

                    dr["SRNO"] = sno;
                    sno++;

                    dr["emp"] = drRows["EMPCD"].ToString() + " : " + drRows["EMPNM"].ToString();

                    dr["loc"] = drRows["CURRBRCD"].ToString() + " : " + drRows["LocName"].ToString();



                    if (drRows["LASTLOGINDT"] is DBNull)
                    {
                        dr["login"] = "";
                    }
                    else
                    {
                        dr["login"] = Convert.ToDateTime(drRows["LASTLOGINDT"]).ToString("dd MMM yyyy hh:mm");
                    }

                    if (drRows["LOGOUTDT"] is DBNull)
                    {
                        dr["logout"] = "";
                    }
                    else
                    {
                        dr["logout"] = Convert.ToDateTime(drRows["LOGOUTDT"]).ToString("dd MMM yyyy hh:mm");
                    }

                    dr["duration"] = drRows["Duration"].ToString();


                    dt.Rows.Add(dr);


                }




                GV_D.DataSource = dt;


            }

            catch (Exception eee)
            {
                Label1.Visible = true;
                Label1.Text = eee.Message;

            }



            GV_D.DataBind();
            if (GV_D.Rows.Count == 0)
            {
                lblnull.Visible = true;
                lblnull.Text = "No Records Found For Given Criteria";
            }




        }


        else
        {

            sql = "select EMPCD,EMPNM,LocName,CURRBRCD,LASTLOGINDT,LOGOUTDT,Duration  from webx_login where  convert(varchar,LASTLOGINDT,106)  between convert(datetime,'" + strfrmdt + "',106) and convert(datetime,'" + strtodt + "',106) " + locval + empval + lival + " " + "order by EMPNM,LocName";

            conn.Open();

            SqlCommand sqlCommand = new SqlCommand(sql, conn);

            dt = new DataTable();

            dt.Columns.Add("SRNO", typeof(string));
            dt.Columns.Add("emp", typeof(string));
            dt.Columns.Add("loc", typeof(string));
            dt.Columns.Add("login", typeof(string));
            dt.Columns.Add("logout", typeof(string));
            dt.Columns.Add("Duration", typeof(string));

            DataRow dr;




            try
            {

                SqlDataAdapter sqlDA = new SqlDataAdapter(sqlCommand);

                DataSet ds1 = new DataSet();
                sqlDA.Fill(ds1);
                int sno = 1;
                GV_D.AllowPaging = false;

                foreach (DataRow drRows in ds1.Tables[0].Rows)
                {

                    dr = dt.NewRow();

                    dr["SRNO"] = sno;
                    sno++;

                    dr["emp"] = drRows["EMPCD"].ToString() + " : " + drRows["EMPNM"].ToString();

                    dr["loc"] = drRows["CURRBRCD"].ToString() + " : " + drRows["LocName"].ToString();



                    if (drRows["LASTLOGINDT"] is DBNull)
                    {
                        dr["login"] = "";
                    }
                    else
                    {
                        dr["login"] = Convert.ToDateTime(drRows["LASTLOGINDT"]).ToString("dd MMM yyyy hh:mm");
                    }

                    if (drRows["LOGOUTDT"] is DBNull)
                    {
                        dr["logout"] = "";
                    }
                    else
                    {
                        dr["logout"] = Convert.ToDateTime(drRows["LOGOUTDT"]).ToString("dd MMM yyyy hh:mm");
                    }

                    dr["duration"] = drRows["Duration"].ToString();


                    dt.Rows.Add(dr);


                }




                GV_D.DataSource = dt;


            }

            catch (Exception eee)
            {
                Label1.Visible = true;
                Label1.Text = eee.Message;

            }



            GV_D.DataBind();
            if (GV_D.Rows.Count == 0)
            {
                lblnull.Visible = true;
                lblnull.Text = "No Records Found For Given Criteria";
            }

            int ind = 0;
            int a = 0;
            try
            {
                GV_D.AllowPaging = false;

                Response.Clear();
                Response.AddHeader("Content-Disposition", "attachment;Filename=Login_view.xls");
                Response.Charset = "";
                Response.ContentType = "application/vnd.xls";
                System.IO.StringWriter tw = new System.IO.StringWriter();
                System.Web.UI.HtmlTextWriter hw = new System.Web.UI.HtmlTextWriter(tw);

                //DipsplayReport();
                GV_D.RenderControl(hw);


                Response.Write(tw.ToString());
                Response.End();
            }
            catch (Exception ex1)
            {
                throw ex1;
                // lblloc.Text = ex1.Message;
            }

        }


    }
    public void pgChange(object sender, GridViewPageEventArgs e)
    {
        GV_D.PageIndex = e.NewPageIndex;

        DipsplayReport();


    }

    public void lst(object sender, EventArgs e)
    {
        int i = GV_D.PageCount;
        GV_D.PageIndex = i;

        DipsplayReport();


    }
    public void fst(object sender, EventArgs e)
    {
        GV_D.PageIndex = 0;

        DipsplayReport();


    }
    private void helper_GroupHeader(string groupName, object[] values, GridViewRow row)
    {
        if (groupName == "LocName")
        {
            //row.BackColor = System.Drawing.Color.FromName("#D4E0E7");
            row.Cells[0].Text = "&nbsp;&nbsp;" + row.Cells[0].Text;
            row.Font.Name = "blackfnt";


        }
    }


    public override void VerifyRenderingInServerForm(Control control)
    {
    }
    protected void btn_csv_Click(object sender, EventArgs e)
    {
        int ind = 0;
        int a = 0;
        try
        {
            GV_D.AllowPaging = false;

            Response.Clear();
            Response.AddHeader("Content-Disposition", "attachment;Filename=Login_View.xls");
            Response.Charset = "";
            Response.ContentType = "application/vnd.xls";
            System.IO.StringWriter tw = new System.IO.StringWriter();
            System.Web.UI.HtmlTextWriter hw = new System.Web.UI.HtmlTextWriter(tw);

            DipsplayReport();
            GV_D.RenderControl(hw);


            Response.Write(tw.ToString());
            Response.End();
        }
        catch (Exception ex1)
        {
            throw ex1;
            // lblloc.Text = ex1.Message;
        }

    }
}
