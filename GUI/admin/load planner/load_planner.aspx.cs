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

public partial class GUI_admin_VehicleMaster_VehicleMasterAdd : System.Web.UI.Page
{
    public static SqlConnection cn; // = new SqlConnection(ConfigurationManager.AppSettings["dbConn"].ToString());

    public static string strToday;
    public byte byteRadButtonSelection;
    public static Double cap = 0, cap2 = 0;

    protected void Page_Load(object sender, EventArgs e)
    {
        cn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        cn.Open();
        //getstring();
        //getallvehno();

        if (!IsPostBack)
        {
            strToday = System.DateTime.Today.ToString("dd/MM/yyyy");
            txtDateFrom.Text = System.DateTime.Now.ToString("dd/MM/yyyy");
            txtDateTo.Text = txtDateFrom.Text;

            // ddVehicleType.Items.Clear();
            string strSQL = "Select Type_Code, [Type_Name] AS VehicleType From webx_vehicle_type";
            SqlCommand cmdVhclType = new SqlCommand(strSQL, cn);
            SqlDataAdapter daVhclType = new SqlDataAdapter(cmdVhclType);
            DataSet dsVehicleType = new DataSet();
            daVhclType.Fill(dsVehicleType);
            //if (dsVehicleType.Tables[0].Rows.Count > 0)
            //{

            ddVehicleType.DataTextField = "VehicleType";
            ddVehicleType.DataValueField = "Type_Code";
            ddVehicleType.DataSource = dsVehicleType;
            ddVehicleType.DataBind();
            //}
            ddVehicleType.Items.Insert(0, new ListItem("--Select--", ""));



            cn.Close();

           

        }
        

    }

    protected void radDate_SelectedIndexChanged(object sender, EventArgs e)
    {
        RadioButtonList rbl = new RadioButtonList();
        rbl = (RadioButtonList)sender;

        byteRadButtonSelection = Convert.ToByte(rbl.SelectedItem.Value);

        if (rbl.Items[0].Selected)
        {
            txtDateFrom.ReadOnly = false;
            txtDateTo.ReadOnly = false;
        }
        else
        {
            txtDateFrom.ReadOnly = true;
            txtDateTo.ReadOnly = true;
        }

        if (rbl.Items[1].Selected)
        {
            txtDateFrom.ReadOnly = true;
            txtDateTo.ReadOnly = true;
            txtDateFrom.Text = System.DateTime.Today.AddDays(-7).ToString("dd/MM/yyyy");
            txtDateTo.Text = System.DateTime.Today.ToString("dd/MM/yyyy");
        }
        else if (rbl.Items[2].Selected)
        {
            txtDateFrom.ReadOnly = true;
            txtDateTo.ReadOnly = true;
            txtDateFrom.Text = System.DateTime.Now.ToString("dd/MM/yyyy");
            txtDateTo.Text = txtDateFrom.Text;
        }


    }

    public void daterange(object source, ServerValidateEventArgs value)
    {

        string[] strDtFrom = txtDateFrom.Text.Split('/');
        DateTime dt1 = new DateTime(Convert.ToInt16(strDtFrom[2]), Convert.ToInt16(strDtFrom[1]), Convert.ToInt16(strDtFrom[0]));
        string[] strDtTo = txtDateTo.Text.Split('/');
        DateTime dt2 = new DateTime(Convert.ToInt16(strDtTo[2]), Convert.ToInt16(strDtTo[1]), Convert.ToInt16(strDtTo[0]));

        System.TimeSpan diffResult = dt2.Subtract(dt1);
        if (diffResult.Days > 31)
        {
            value.IsValid = false;
        }

        else if (dt1 > dt2)
        {
            value.IsValid = false;
            CustomValidator1.ErrorMessage = "From Date Can not Be Greter Than To Date.";
        }
        else
        {
            value.IsValid = true;

        }
    }






    protected void ddVehicleType_SelectedIndexChanged(object sender, EventArgs e)
    {
        string sql = "SELECT vehno FROM webx_VEHICLE_HDR where vehicle_type ='" + ddVehicleType.SelectedValue.ToString() + "'";
        SqlDataAdapter da = new SqlDataAdapter(sql, cn);
        DataSet ds = new DataSet();
        da.Fill(ds);
        ddlvehno.DataSource = ds;
        ddlvehno.DataTextField = "vehno";
        ddlvehno.DataValueField = "vehno";
        ddlvehno.DataBind();
        ddlvehno.Items.Insert(0, new ListItem("--Select--", ""));



    }
    protected void GV_D_OnRowDataBound(object sender, GridViewRowEventArgs e)
    {

        if (e.Row.RowType == DataControlRowType.DataRow)
        {

            CheckBox chk = (CheckBox)(e.Row.FindControl("chsrno"));
            double wt = Convert.ToDouble(e.Row.Cells[4].Text);



            chk.Attributes.Add("onclick", "javascript:san('" + chk.ClientID + "','" + wt + "')");


        }


    }
    protected void ddlvehno_SelectedIndexChanged(object sender, EventArgs e)
    {
        string sql = "select * from webx_VEHICLE_HDR where vehno='" + ddlvehno.SelectedValue.ToString() + "'";
        SqlCommand sqlCommand = new SqlCommand(sql, cn);
        SqlDataReader dr;
        dr = sqlCommand.ExecuteReader();
        while (dr.Read())
        {
            lblcapacity.Text = dr["capacity"].ToString();
            txtcap.Text = dr["capacity"].ToString();
            if (dr["capacity"] is DBNull)
            {
            }
            else
            {
                cap = Convert.ToDouble(dr["capacity"].ToString());
            }
            lblpayload.Text = dr["Payload"].ToString();
            lblgvw.Text = dr["GVW"].ToString();
            lblUnladen.Text = dr["Unld_Wt"].ToString();

        }
        dr.Close();
        pnl1.Visible = true;
        //pnl3.Visible = true;


    }

    public void disp()
    {
//        btn_csv.Visible = true;
        pnl2.Visible = true;
        //        pnl3.Visible = true;
    
        
        
     /*   string[] strArrDtFrom = txtDateFrom.Text.Split('/');

        string frm = strArrDtFrom[1] + "/" + strArrDtFrom[0] + "/" + strArrDtFrom[2];

        string[] strArrDtto = txtDateTo.Text.Split('/');

        string to = strArrDtto[1] + "/" + strArrDtto[0] + "/" + strArrDtto[2];



        string sql = "SELECT dockno,(convert(VARCHAR,dockdt,106)) AS DT,actuwt,chrgwt FROM webx_master_docket where dockdt between '" + frm + "' and '" + to + "' and deliverd='N' and cancelled='N'";
        SqlDataAdapter da = new SqlDataAdapter(sql, cn);   */




      //  SqlConnection sqlConn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

        // SqlConnection sqlConn = new SqlConnection("Data Source=202.87.45.69;Initial Catalog=RLL.Net;UID=sa;pwd=!@ecfy#$");


        string[] strArrDtFrom = txtDateFrom.Text.Split('/');
        string[] strArrDtTo = txtDateTo.Text.Split('/');

        DateTime dtFrom = Convert.ToDateTime(strArrDtFrom[1] + "/" + strArrDtFrom[0] + "/" + strArrDtFrom[2]);
        DateTime dtTo = Convert.ToDateTime(strArrDtTo[1] + "/" + strArrDtTo[0] + "/" + strArrDtTo[2]);

        string strDate = Convert.ToDateTime(strArrDtFrom[1] + "/" + strArrDtFrom[0] + "/" + strArrDtFrom[2]).ToString("dd MMM yy") + " - " + Convert.ToDateTime(strArrDtTo[1] + "/" + strArrDtTo[0] + "/" + strArrDtTo[2]).ToString("dd MMM yy");


        SqlCommand sqlCommand = new SqlCommand();

        sqlCommand.Connection = cn;
        sqlCommand.CommandType = CommandType.StoredProcedure;


        sqlCommand.CommandText = "WebxNet_loadPlanner";




        // Managing Date Range for input parameters to SP
        string[] strArrDtFromTo = strDate.Split('-');

        sqlCommand.Parameters.AddWithValue("@FROMDT", strArrDtFromTo[0]);
        sqlCommand.Parameters.AddWithValue("@TODT", strArrDtFromTo[1]);
       // sqlCommand.Parameters.AddWithValue("@from_lo", "All");
        sqlCommand.Parameters.AddWithValue("@from_lo", Session["brcd"].ToString());
        sqlCommand.Parameters.AddWithValue("@to_lo", "All");


        SqlDataAdapter sqlDA = new SqlDataAdapter(sqlCommand);


    DataSet ds = new DataSet();
        sqlDA.Fill(ds);
    
        
        GV_Booking.DataSource = ds;
        GV_Booking.DataBind();

    }
    protected void btnsubmit_Click(object sender, EventArgs e)
    {
        if (Page.IsValid == true)
        {

            disp();



        }
    }

    protected void ch_chg(object sender, EventArgs e)
    {
        CheckBox ch_hdr = (CheckBox)GV_Booking.HeaderRow.FindControl("hdr_chsrno");
        double chwgt = 0;
        if (ch_hdr.Checked == true)
        {
            int i = 0;

            foreach (GridViewRow gridrow in GV_Booking.Rows)
            {
                CheckBox chk1 = (CheckBox)gridrow.FindControl("chsrno");
                chk1.Checked = true;

                chwgt += Convert.ToDouble(GV_Booking.Rows[i].Cells[4].Text);
                i++;

            }

            txttot.Text = chwgt.ToString();
            h_cap.Value = cap.ToString();
            h_tot.Value = chwgt.ToString(); 


        }
        else
        {
            int i = 0;

            foreach (GridViewRow gridrow in GV_Booking.Rows)
            {
                CheckBox chk1 = (CheckBox)gridrow.FindControl("chsrno");
                chk1.Checked = false;
                i++;


            }

            txttot.Text = "0";

        }
        string res = "";
        if (cap < chwgt)
        {
            txtop.Text = "Truck is Overloaded";
            res = "Truck is Overloaded";
        }
        else
        {
            txtop.Text = "Truck is Underloaded";
            res = "Truck is Underloaded";
        }

        h_res.Value =res;





    }
    public override void VerifyRenderingInServerForm(Control control)
    {
    }
    protected void btn_csv_Click(object sender, EventArgs e)
    { 
        int i = 0;

        string docno="";

            foreach (GridViewRow gridrow in GV_Booking.Rows)
            {
                CheckBox chk1 = (CheckBox)gridrow.FindControl("chsrno");
                Label l = (Label)gridrow.FindControl("Label32");
                
                
                string d =Convert.ToString(l.Text);
                
                docno+="'"+d+"',";

                 
                i++;

            }

            Response.Redirect("load_planner2.aspx?dno=" + docno + "&cap=" + h_cap.Value + "&tot=" + h_tot.Value + "&res=" + h_res.Value);


           

        }





       /* int ind = 0;
        int a = 0;
        //try
        //{
        GV_Booking.AllowPaging = false;
        Response.Clear();
        Response.AddHeader("Content-Disposition", "attachment;Filename=LoadPlanner.xls");
        Response.Charset = "";
        Response.ContentType = "application/vnd.xls";
        System.IO.StringWriter tw = new System.IO.StringWriter();
        System.Web.UI.HtmlTextWriter hw = new System.Web.UI.HtmlTextWriter(tw);
        txtcap.Visible = false;
        lblvehcap.Text += " " + txtcap.Text;
        txttot.Visible = false;
        lblwht.Text += " " + h_cap.Value;
        txtop.Visible = false;
        lblload.Text = h_res.Value;
        //  txtop.Visible = false;

        // disp();
        pnl2.RenderControl(hw);
        Response.Write(tw.ToString());
        Response.End();
        // }
        //catch (Exception ex1)
        //{
        //    throw ex1;
        //    btn_csv.Text = ex1.Message;
        //}*/






     
}


