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



public partial class Reports_VehicleOccupancyReport : System.Web.UI.Page
{
  //  SqlConnection conn = new SqlConnection(System.Configuration.ConfigurationManager.AppSettings["dbConnection"]);
    
    protected void Page_Load(object sender, EventArgs e)
    {
        string pagetitle = System.Configuration.ConfigurationManager.AppSettings["PageTitle"];
        Response.Cache.SetCacheability(HttpCacheability.NoCache);
        Response.Cache.SetNoStore();
        Response.Cache.SetExpires(DateTime.MinValue);

        Common objCommon = new Common();
        objCommon.doCacheRoutine();
        this.Title = pagetitle;





        addVehType();

        if (!IsPostBack)
        {

            //Do Work
        }

    }

    public void BindGrid()
    {



    }





    public void addVehType()
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

        conn.Open();
        string sql = "select Distinct Type_NAme ,Type_COde from webx_Vehicle_Type where ActiveFlag='Y' ";
        SqlCommand cmd = new SqlCommand(sql, conn);
        SqlDataReader dr = cmd.ExecuteReader();

        lstVehicleType.Items.Clear();
        lstVehicleType.Items.Add( new ListItem("All","0"));
        if (dr.HasRows)
        {
            while (dr.Read())
            {
                lstVehicleType.Items.Add(new ListItem(dr["Type_Name"].ToString(),dr["Type_Code"].ToString()));
            }
        }
        dr.Close();
        conn.Close();

    }

    protected void btnShow_Click(object sender, EventArgs e)
    {

        //if (rbtn1.Checked == true)
        //{

        //    GridView1.Columns.Add("Date", Type.GetType("System.String"));

        //}
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        if (rbtn2.Checked == true)
        {                                   
        //     int List1=0,list2=0;          
        //string[] selvaluesArr;
        //string[] selvaluesArr1; 

        //selvaluesArr = txtDateFrom.Text.Split(new char[] { '/' });
        //int maxarr = selvaluesArr.GetUpperBound(0);
       
        //for (int i = 0; i <= maxarr; i++)
        //{
        //     List1 = selvaluesArr[0].ToString().Trim();
            
        //}


        //selvaluesArr1 = txtDateTo.Text.Split(new char[] { '/' });
        //int maxarr1 = selvaluesArr1.GetUpperBound(0);
        //for (int i = 0; i <= maxarr1; i++)
        //{
        //      List2 = selvaluesArr1[0].ToString().Trim();
            
        //}















              DataSet ds = new DataSet();
             DataTable dt = new DataTable();



             dt.Columns.Add("Vehiclen Type", Type.GetType("System.String"));
             dt.Columns.Add("Vehicle Nos", Type.GetType("System.String"));
            //for (int i = List1; i <= list2; i++)
            //{
            //    dt.Columns.Add(i, Type.GetType("System.Int32"));

            //}


            DataRow newRow;
            newRow = dt.NewRow();

            DateTime dtFrom = new DateTime();
            DateTime dtTo = new DateTime();

            System.Globalization.DateTimeFormatInfo dtfi = new System.Globalization.DateTimeFormatInfo();
            dtfi.ShortDatePattern = "dd/MM/yyyy";
            dtfi.DateSeparator = "/";
            // if (usercode == "")
            {
                dtFrom = Convert.ToDateTime(txtDateFrom.Text, dtfi);
                dtTo = Convert.ToDateTime(txtDateTo.Text, dtfi);
            }


            conn.Open();
            SqlCommand sqlcmd = new SqlCommand("usp_GetVehicleOccupancy_List", conn);
            sqlcmd.CommandType = CommandType.StoredProcedure;
          //  sqlcmd1.CommandType = CommandType.StoredProcedure;
            sqlcmd.Parameters.Add("@createdfrom", SqlDbType.DateTime).Value = dtFrom;
            sqlcmd.Parameters.Add("@createdto", SqlDbType.DateTime).Value = dtTo;
            sqlcmd.Parameters.Add("@VehicleType", SqlDbType.VarChar).Value = lstVehicleType.Text;



            //SqlDataReader sqldr1 = sqlcmd.ExecuteReader();
            //if (sqldr1.HasRows)
            //{
            //    while (sqldr1.Read())
            //    {
                     //    if(dt.Columns.Count!=0)
                       //  {
                             
            //        dt.Columns.Add(sqldr1["date"].ToString(), Type.GetType("System.String"));
            //           
                          //   }
            
            
            
                      //newRow[sqldr["date"].ToString()] = sqldr["Req"].ToString();
            //        //newRow["Vehiclen Type"] = sqldr["VehicleType"].ToString();
            //        //newRow["Vehicle Nos"] = sqldr["vehno"].ToString();

            //        //dt.Rows.Add(newRow);
            //    }
            //}
            //sqldr1.Close();




            SqlDataReader sqldr = sqlcmd.ExecuteReader();
            if (sqldr.HasRows)
            {
                while (sqldr.Read())
                {

                    dt.Columns.Add(sqldr["date"].ToString(), Type.GetType("System.String"));
                    newRow[sqldr["date"].ToString()] = sqldr["Req"].ToString();
                    newRow["Vehiclen Type"] = sqldr["VehicleType"].ToString();
                    newRow["Vehicle Nos"] = sqldr["vehno"].ToString();
                 
                    dt.Rows.Add(newRow);
                }
            }
            sqldr.Close();
            conn.Close();







         

        //   newRow["Vehiclen Type"] = str1;
        //    newRow["Vehicle Nos"] = str2;

            //for (int i = List1; i <= list2; i++)
            //{
            //    newRow[i] = str1;
            //    dt.Rows.Add(newRow);
            //}
            ds.Tables.Add(dt);
            GridView1.DataSource = ds.Tables["GridView1"];
            GridView1.DataBind();
            //DateWiseRecord();

        }
        
                 

        BindGrid();


        //if (GridView1.Rows.Count != 0)
        //{
        //    LinkButton1.Visible = true;

        //}

        //else
        //{
        //    LinkButton1.Visible = false;
        //}
    }


    


  




    protected void radDate_OnSelectedIndexChange(object sender, EventArgs e)
    {
        txtDateFrom.ReadOnly = false;
        txtDateTo.ReadOnly = false;

        System.DateTime righnow = System.DateTime.Today;
        string strrightnow = righnow.ToString("dd/MM/yyyy");

        RadioButtonList rbl = new RadioButtonList();
        rbl = (RadioButtonList)sender;
        if (!(rbl.Items[0].Selected))
        {
            txtDateFrom.Text = strrightnow;
            txtDateTo.Text = strrightnow;
            txtDateFrom.ReadOnly = true;
            txtDateTo.ReadOnly = true;
        }
        if (rbl.Items[1].Selected)
        {
            righnow = righnow.AddDays(-7);
            strrightnow = righnow.ToString("dd/MM/yyyy");
            txtDateFrom.Text = strrightnow;
        }

        if (rbl.Items[3].Selected)
        {
            //righnow = righnow.AddMonths(-12);
            strrightnow = "01/01/1950";
            txtDateFrom.Text = strrightnow;
        }
    }

    protected void pgChange(object sender, GridViewPageEventArgs e)
    {
        GridView1.PageIndex = e.NewPageIndex;
        BindGrid();
    }

   
}
