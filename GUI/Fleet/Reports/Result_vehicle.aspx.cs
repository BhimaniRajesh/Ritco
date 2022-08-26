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
using System.ComponentModel;
using System.Drawing;
using System.Web.SessionState;
using System.Security;
using System.Globalization;
using System.IO;
using System.Text;


public partial class GUI_MIS_Vehicle_Register_Default : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        BindGrid();
    }


    private void BindGrid()
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();

        SqlConnection conn1 = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn1.Open();

        SqlConnection conn2 = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn2.Open();
        //string sql = "webx_sales_register";
        //SqlCommand sqlcmd = new SqlCommand(sql, conn);
        //sqlcmd.CommandType = CommandType.StoredProcedure;
        SqlCommand sqlcmd = new SqlCommand();

        sqlcmd.Connection = conn;
        sqlcmd.CommandType = CommandType.StoredProcedure;
        sqlcmd.CommandText = "webx_vehicle_register";

        SqlDataAdapter da = new SqlDataAdapter(sqlcmd);

        string location = Request.QueryString.Get("location");
        string vehicle = Request.QueryString.Get("vehicle");
        string vehlist = Request.QueryString.Get("vehlist");


        Session["location"]=location;
        Session["vehicle"]=vehicle;
        Session["vehlist"] = vehlist;


        lblloc.Text = location;

        if (vehlist!="")
        {
            lbVehnolist.Text = vehlist;
        }
        else
        {
            lbVehnolist.Text = vehicle;
        }

        sqlcmd.Parameters.AddWithValue("@location", location);
        sqlcmd.Parameters.AddWithValue("@vehicleno", vehicle);
        sqlcmd.Parameters.AddWithValue("@vehlist", vehlist);

        DataSet ds = new DataSet();

        da.Fill(ds,"Main");

       // ds.Tables[0].Columns.Add("vehno");
      //  ds.Tables[0].Columns.Add("vehicle_type");
        //ds.Tables[0].Columns.Add("Sno");

        int sno = 0;

        //foreach (DataRow dr in ds.Tables[0].Rows)
        //{
          //  dr["Sno"] = sno;
           // sno++;

            //String vehnum = dr["Vehno"].ToString();

            //dr["Vehno"] = dr["Vehno"].ToString();
            //dr["vehicle_type"] = dr["vehicle_type"].ToString();
            //dr["Vehicle_Size"] = dr["Vehicle_Size"].ToString();
            //dr["Capacity"] = dr["Capacity"].ToString();
            //dr["Manufacturer"] = dr["Manufacturer"].ToString();
            //dr["Model"] = dr["Model"].ToString();
            //dr["Capacity"] = dr["Capacity"].ToString();
            //dr["Total_Kms"] = dr["Total_Kms"].ToString();
            DataTable dt = new DataTable();
            //DataColumn dcSr = new DataColumn("Srno", typeof(String)); 
            DataColumn dcSN = new DataColumn("Sno", typeof(String)); 
            DataColumn dc0 = new DataColumn("Vehno",typeof (String)); 
            DataColumn dc1 = new DataColumn("vehicle_type",typeof (String));
            DataColumn dc2 = new DataColumn("Vehicle_Size", typeof(String));
            DataColumn dc3 = new DataColumn("Capacity", typeof(String));
            DataColumn dc4 = new DataColumn("Manufacturer", typeof(String));
            DataColumn dc6= new DataColumn("Model", typeof(String));
            DataColumn dc7 = new DataColumn("Total_Kms", typeof(String));
            DataColumn dc8 = new DataColumn("vd01c001", typeof(String));
            DataColumn dc9 = new DataColumn("vd01c002", typeof(String));
            DataColumn dc10 = new DataColumn("vd01c003", typeof(String));
            DataColumn dc11 = new DataColumn("vd02c001", typeof(String));
            DataColumn dc12 = new DataColumn("vd02c002", typeof(String));
            DataColumn dc13 = new DataColumn("vd02c003", typeof(String));
            DataColumn dc14 = new DataColumn("vd03c001", typeof(String));
            DataColumn dc15 = new DataColumn("vd03c002", typeof(String));
            DataColumn dc16 = new DataColumn("vd03c003", typeof(String));
            DataColumn dc17 = new DataColumn("vd03c004", typeof(String));

            DataColumn dc18 = new DataColumn("Conrtl_branch", typeof(String));


            dt.Columns.Add(dcSN);
            dt.Columns.Add(dc0);
            dt.Columns.Add(dc1);
            dt.Columns.Add(dc2);
            dt.Columns.Add(dc3);
            dt.Columns.Add(dc4);
           // dt.Columns.Add(dc5);
            dt.Columns.Add(dc6);
            dt.Columns.Add(dc7);
            dt.Columns.Add(dc8);
            dt.Columns.Add(dc9);
            dt.Columns.Add(dc10);
            dt.Columns.Add(dc11);
            dt.Columns.Add(dc12);
            dt.Columns.Add(dc13);
            dt.Columns.Add(dc14);
            dt.Columns.Add(dc15);
            dt.Columns.Add(dc16);
            dt.Columns.Add(dc17);
            dt.Columns.Add(dc18);
           
            DataRow drow;
            for (int a=0;a<ds.Tables["main"].Rows.Count;a++)
            {

                
                 sno++;
                 string SQL_count = "select count(vd01c001) as a from WEBX_VEHDOCMST where vehno='" + ds.Tables["Main"].Rows[a]["Vehno"].ToString().Trim() + "' and vd01c001 is not null and veh_doc_type='vd01' ";
                SqlCommand cmd1 = new SqlCommand(SQL_count, conn);
                Int32 b = Convert.ToInt32(cmd1.ExecuteScalar());
                string SQL_count1 = "select count(vd02c001) as a from WEBX_VEHDOCMST where vehno='" + ds.Tables["Main"].Rows[a]["Vehno"].ToString().Trim() + "' and vd02c001 is not null and veh_doc_type='vd02' ";
                SqlCommand cmd11 = new SqlCommand(SQL_count1, conn);
                Int32 b1 = Convert.ToInt32(cmd11.ExecuteScalar());
                string SQL_count2 = "select count(vd03c001) as a from WEBX_VEHDOCMST where vehno='" + ds.Tables["Main"].Rows[a]["Vehno"].ToString().Trim() + "' and vd03c001 is not null and veh_doc_type='vd03' ";
                SqlCommand cmd12 = new SqlCommand(SQL_count2, conn);
                Int32 b2 = Convert.ToInt32(cmd12.ExecuteScalar());


                Int32 cnt1;
                if (b > b1)
                {
                    cnt1 = b;
                }
                else
                {
                    cnt1 = b1;
                }
                if (b1 > b2)
                {
                    cnt1 = b1;
                }
                else
                {
                    cnt1 = b2;
                }
                if (b > b2)
                {
                    cnt1 = b;
                }
                else
                {
                    cnt1 = b2;
                }

                if (cnt1 == 0)
                {
                    cnt1 = 1;
                }


                SqlDataReader dreader;
                string SQL_validate = "select vd01c001,vd01c002=convert(varchar,vd01c002,106),vd01c003=convert(varchar,vd01c002,106)  from WEBX_VEHDOCMST where vehno='" + ds.Tables["Main"].Rows[a]["Vehno"].ToString().Trim() + "'  and vd01c001 is not null  and veh_doc_type='vd01' ";
                SqlCommand cmd2 = new SqlCommand(SQL_validate, conn);
                dreader = cmd2.ExecuteReader();

                SqlDataReader dreader1;
                string SQL_validate1 = "select vd02c001,vd02c002=convert(varchar,vd02c002,106),vd02c003=convert(varchar,vd02c002,106)  from WEBX_VEHDOCMST where vehno='" + ds.Tables["Main"].Rows[a]["Vehno"].ToString().Trim() + "'  and vd02c001 is not null  and veh_doc_type='vd02' ";
                SqlCommand cmd21 = new SqlCommand(SQL_validate1, conn1);
                dreader1 = cmd21.ExecuteReader();

                SqlDataReader dreader2;
                string SQL_validate2 = "select vd03c001=(select top 1  stnm from webx_state where stcd=vd03c001),vd03c002,vd03c003=convert(varchar,vd03c003,106),vd03c004=convert(varchar,vd03c004,106)  from WEBX_VEHDOCMST where vehno='" + ds.Tables["Main"].Rows[a]["Vehno"].ToString().Trim() + "'  and vd03c001 is not null  and veh_doc_type='vd03' ";
                SqlCommand cmd22 = new SqlCommand(SQL_validate2, conn2);
                dreader2 = cmd22.ExecuteReader();

                int vehint = 0;
                for (Int32 c = 0; c < cnt1; c++)
                {
                    vehint++;

                    drow = dt.NewRow();

                    if ((cnt1 == b || cnt1 > b) &&  b!=0  && c<b )
                    {
                        dreader.Read();
                    }
                    if ((cnt1 == b1 || cnt1 > b1) && b1 != 0 && c < b1)
                    {
                        dreader1.Read();
                    }
                    if ((cnt1 == b2 || cnt1 > b2) && b2 != 0 && c < b2)
                    {
                        dreader2.Read();
                    }
                    if (vehint == 1)
                    {
                        drow["Sno"] = sno;
                        drow["vehno"] = ds.Tables["Main"].Rows[a]["Vehno"];
                        drow["vehicle_type"] = ds.Tables["Main"].Rows[a]["vehicle_type"];
                        drow["Vehicle_Size"] = ds.Tables["Main"].Rows[a]["Vehicle_Size"];
                        drow["Capacity"] = ds.Tables["Main"].Rows[a]["Capacity"];
                        drow["Manufacturer"] = ds.Tables["Main"].Rows[a]["Manufacturer"];
                        drow["Model"] = ds.Tables["Main"].Rows[a]["Model"];
                        drow["Total_Kms"] = ds.Tables["Main"].Rows[a]["Total_Kms"];
                       
                    }
                    drow["Conrtl_branch"] = ds.Tables["Main"].Rows[a]["Conrtl_branch"];

                    if ((cnt1 == b || cnt1 > b) && b != 0 && c < b)
                    {
                        drow["vd01c001"] = dreader["vd01c001"];
                        drow["vd01c002"] = dreader["vd01c002"];
                        drow["vd01c003"] = dreader["vd01c003"];
                    }
                    if ((cnt1 == b1 || cnt1 > b1) && b1 != 0 && c < b1)
                    {
                        drow["vd02c001"] = dreader1["vd02c001"];
                        drow["vd02c002"] = dreader1["vd02c002"];
                        drow["vd02c003"] = dreader1["vd02c003"];
                    }
                    if ((cnt1 == b2 || cnt1 > b2) && b2 != 0 && c < b2)
                    {
                        drow["vd03c001"] = dreader2["vd03c001"];
                        drow["vd03c002"] = dreader2["vd03c002"];
                        drow["vd03c003"] = dreader2["vd03c003"];
                        drow["vd03c004"] = dreader2["vd03c004"];
                    }
                   
                    dt.Rows.Add(drow);  
                }
                dreader.Close();
                dreader1.Close();
                dreader2.Close();  
            }
            //DataColumn dc0 = new DataColumn("vd01c001",typeof (String));
            //ds.Tables[0].Columns.Add(dc0);
            
            //string SQL_count = "select count(vd01c001) as a from WEBX_VEHDOCMST where vehno='" + vehnum + "' and vd01c001 is not null  ";
            //SqlCommand cmd1 = new SqlCommand(SQL_count, conn);
            //Int32 i = Convert.ToInt32(cmd1.ExecuteScalar());

            ////////////////////SqlDataReader dreader;
            ////////////////////string SQL_validate = "select vd01c001  from WEBX_VEHDOCMST where vehno='UP16H9265' and vd01c001 is not null  ";
            ////////////////////SqlCommand cmd2 = new SqlCommand(SQL_validate, conn);
            ////////////////////dreader = cmd2.ExecuteReader();
            //////////////////////DataRow drow;
            ////////////////////drow = ds.Tables[0].NewRow();
            ////////////////////while (dreader.Read())
            ////////////////////{
            ////////////////////    //for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
            ////////////////////    //{
                    
            ////////////////////        drow = ds.Tables[0].NewRow();
            ////////////////////        //string SQL_validate = "select vd01c001  from WEBX_VEHDOCMST where vehno='" + Convert.ToString(drow["vehno"]) + "' and vd01c001 is not null  ";
            ////////////////////        drow["vd01c001"] = dreader["vd01c001"].ToString();
            ////////////////////        ds.Tables[0].Rows.Add(drow);
            ////////////////////    //}
            ////////////////////}
               


            //string SQL_validate = "select vd01c001  from WEBX_VEHDOCMST where vehno='" + vehnum + "' and vd01c001 is not null  ";
            ////Response.Write("<br> SQL_validate : " + SQL_validate);

            //SqlCommand cmd1 = new SqlCommand(SQL_validate, conn);
            //SqlDataAdapter veh = new SqlDataAdapter(cmd1);

            //DataSet ds_veh = new DataSet();

            //veh.Fill(ds_veh);
            //foreach (DataRow dr_veh in ds_veh.Tables[0].Rows)
            //{
            //    dr_veh["vd01c001"] = dr_veh["vd01c001"].ToString();
            //}
        ////////////////}


            GridViewHelper helper = new GridViewHelper(this.GV_Veh);
            string[] cols = new string[1];
            cols[0] = "Conrtl_branch";
            //cols[1] = "ShipName";
            // cols[0].cs
            helper.RegisterGroup(cols, true, true);
            helper.GroupHeader += new GroupEvent(helper_GroupHeader);
            sno = 1;
            //helper.RegisterSummary("vehno", SummaryOperation.Sum);
            //helper.RegisterSummary("vehicle_type", SummaryOperation.Sum);

            //helper.RegisterSummary("vehno", SummaryOperation.Sum, "Conrtl_branch");
            //helper.RegisterSummary("vehicle_type", SummaryOperation.Sum, "Conrtl_branch");
            //helper.GroupSummary += new GroupEvent(helper_GroupSummary);

       GV_Veh.DataSource = dt;
       
       GV_Veh.DataBind();

        //if (GV_Veh.Rows.Count == 0)
        //{

        //}
        //if (GV_Veh.Rows.Count <= 10)
        //{
        //    LinkButton1.Visible = false;
        //    LinkButton2.Visible = false;

        //}
       conn.Close();

       if (GV_Veh.Rows.Count == 0)
       {
           btnEmail.Visible = false;
           btnPrint.Visible = false;
           btnXML.Visible = false;

         

       }
       else
       {
           btnEmail.Visible = false;
           btnPrint.Visible = true;
           btnXML.Visible = true;
           

       }



    }


    protected void btnXML_ServerClick(object sender, EventArgs e)
    {
        //Response.Clear();
        //Response.AddHeader("content-disposition", "attachment;filename=test.xls");
        //Response.Charset = "";
        //Response.ContentType = "application/vnd.xls";
        //System.IO.StringWriter stringWrite = new System.IO.StringWriter();
        //System.Web.UI.HtmlTextWriter htmlWrite = new HtmlTextWriter(stringWrite);

        //Response.Write(stringWrite.ToString());
        //Response.End();

        //GridViewExportUtil.Export("Customers.xls", this.GV_Veh);


        GV_Veh.AllowPaging = false;
        GV_Veh.BorderWidth = 1;
        GV_Veh.CssClass = "blackfnt";
        GV_Veh.Font.Size = 10;

        BindGrid();
        StringWriter stringWrite;
        HtmlTextWriter htmlWrite;
        HtmlForm frm = new HtmlForm();
        Response.Clear();
        Response.AddHeader("content-disposition", "attachment;filename=Vehicle_report.xls");
        Response.Charset = "";
        Response.ContentType = "application/vnd.ms-xls";
        stringWrite = new System.IO.StringWriter();
        htmlWrite = new HtmlTextWriter(stringWrite);
        Controls.Add(frm);

        frm.Controls.Add(GV_Veh);

        frm.RenderControl(htmlWrite);
        Response.Write(stringWrite.ToString());
        Response.End();




    }

    public void CustomersGridView_RowDataBound(Object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.Header)
        {
            //Build custom header.


            GridView oGridView = (GridView)sender;
            // Label billamt = (Label)oGridView.FindControl("billamt");

            GridViewRow oGridViewRow = new GridViewRow(2, 2, DataControlRowType.Header, DataControlRowState.Insert);
            TableCell oTableCell = new TableCell();
            TableCell oTableCell1 = new TableCell();
            //Add Department
            //for first row *************
            oTableCell = new TableCell();
            oTableCell.Text = " Srno";
            oTableCell.CssClass = "blackfnt";
            oTableCell.RowSpan = 2;
            oGridViewRow.Cells.Add(oTableCell);

            oTableCell = new TableCell();
            oTableCell.Text = "Vehicle no.";
            oTableCell.CssClass = "blackfnt";
            //oTableCell.ColumnSpan = 1;
            oTableCell.RowSpan = 2;
            oGridViewRow.Cells.Add(oTableCell);

            oTableCell = new TableCell();
            oTableCell.Text = "Vehicle Type";
            oTableCell.CssClass = "blackfnt";
            //oTableCell.ColumnSpan = 1;
            oTableCell.RowSpan = 2;
            oGridViewRow.Cells.Add(oTableCell);

            oTableCell = new TableCell();
            oTableCell.Text = "Vehicle Size";
            oTableCell.CssClass = "blackfnt";
            //oTableCell.ColumnSpan = 1;
            oTableCell.RowSpan = 2;
            oGridViewRow.Cells.Add(oTableCell);

            oTableCell = new TableCell();
            oTableCell.Text = "Capacity";
            oTableCell.CssClass = "blackfnt";
            //oTableCell.ColumnSpan = 1;
            oTableCell.RowSpan = 2;
            oGridViewRow.Cells.Add(oTableCell);

            oTableCell = new TableCell();
            oTableCell.Text = "Manufacturer";
            oTableCell.CssClass = "blackfnt";
            //oTableCell.ColumnSpan = 1;
            oTableCell.RowSpan = 2;
            oGridViewRow.Cells.Add(oTableCell);

            
            oTableCell = new TableCell();
            oTableCell.Text = "Model";
            oTableCell.CssClass = "blackfnt";
            //oTableCell.ColumnSpan = 1;
            oTableCell.RowSpan = 2;
            oGridViewRow.Cells.Add(oTableCell);

            oTableCell = new TableCell();
            oTableCell.Text = "Total Kms ";
            oTableCell.CssClass = "blackfnt";
            //oTableCell.ColumnSpan = 1;
            oTableCell.RowSpan = 2;
            oGridViewRow.Cells.Add(oTableCell);

            oTableCell = new TableCell();
           oTableCell.Text = "Insurance Details";
           // oTableCell.Font.Bold = true;
            oTableCell.HorizontalAlign = HorizontalAlign.Center;
            oTableCell.ColumnSpan = 3;

            oTableCell.CssClass = "blackfnt";
            oGridViewRow.Cells.Add(oTableCell);

            oTableCell = new TableCell();
            oTableCell.Text = "Registration  Details";
           // oTableCell.Font.Bold = true;
            oTableCell.HorizontalAlign = HorizontalAlign.Center;
            oTableCell.ColumnSpan = 3;

            oTableCell.CssClass = "blackfnt";
            oGridViewRow.Cells.Add(oTableCell);

            oTableCell = new TableCell();
            oTableCell.Text = "Permit  Details";
            //oTableCell.Font.Bold = true;
            oTableCell.HorizontalAlign = HorizontalAlign.Center;
            oTableCell.ColumnSpan = 4;

            oTableCell.CssClass = "blackfnt";
            oGridViewRow.Cells.Add(oTableCell);


            oGridView.Controls[0].Controls.AddAt(0, oGridViewRow);
            oGridView.Controls[0].Controls.RemoveAt(1);
        }
        if (e.Row.RowType == DataControlRowType.Footer)
        {
            //Build custom header.


            GridView oGridView = (GridView)sender;
            // Label billamt = (Label)oGridView.FindControl("billamt");

            GridViewRow oGridViewRow1 = new GridViewRow(2, 2, DataControlRowType.Footer, DataControlRowState.Insert);

            TableCell oTableCell1 = new TableCell();
            //***************************
            //*****for second row *************

            oTableCell1 = new TableCell();
            oTableCell1.Text = "Policy No.";
            oTableCell1.Width =200;
            oTableCell1.Wrap = false;
           // oTableCell.Font.Bold = true;
            //oTableCell.HorizontalAlign = HorizontalAlign.Center;
            //oTableCell1.ColumnSpan = 7;

            oTableCell1.CssClass = "blackfnt";
            oGridViewRow1.Cells.Add(oTableCell1);
            oTableCell1 = new TableCell();
            oTableCell1.Text = "Start Date";
            oTableCell1.CssClass = "blackfnt";
            //oTableCell.ColumnSpan = 1;
            oGridViewRow1.Cells.Add(oTableCell1);

            oTableCell1.CssClass = "blackfnt";
            oGridViewRow1.Cells.Add(oTableCell1);
            oTableCell1 = new TableCell();
            oTableCell1.Text = "End Date";
            oTableCell1.CssClass = "blackfnt";
            //oTableCell.ColumnSpan = 1;
            oGridViewRow1.Cells.Add(oTableCell1);


            oTableCell1 = new TableCell();
            oTableCell1.Text = "Reg. No.";
            // oTableCell.Font.Bold = true;
            //oTableCell.HorizontalAlign = HorizontalAlign.Center;
            //oTableCell1.ColumnSpan = 7;

            oTableCell1.CssClass = "blackfnt";
            oGridViewRow1.Cells.Add(oTableCell1);
            oTableCell1 = new TableCell();
            oTableCell1.Text = "Reg. Date";
            oTableCell1.CssClass = "blackfnt";
            //oTableCell.ColumnSpan = 1;
            oGridViewRow1.Cells.Add(oTableCell1);

            oTableCell1.CssClass = "blackfnt";
            oGridViewRow1.Cells.Add(oTableCell1);
            oTableCell1 = new TableCell();
            oTableCell1.Text = "Fitness Validity Date";
            oTableCell1.CssClass = "blackfnt";
            //oTableCell.ColumnSpan = 1;
            oGridViewRow1.Cells.Add(oTableCell1);

            
            oTableCell1 = new TableCell();
            oTableCell1.Text = "State";
            oTableCell1.CssClass = "blackfnt";
            //oTableCell.ColumnSpan = 1;
            oGridViewRow1.Cells.Add(oTableCell1);

            oTableCell1 = new TableCell();
            oTableCell1.Text = "Permit No.";
            // oTableCell.Font.Bold = true;
            //oTableCell.HorizontalAlign = HorizontalAlign.Center;
            //oTableCell1.ColumnSpan = 7;
            oTableCell1.CssClass = "blackfnt";
            oGridViewRow1.Cells.Add(oTableCell1);
           

            oTableCell1.CssClass = "blackfnt";
            oGridViewRow1.Cells.Add(oTableCell1);
            oTableCell1 = new TableCell();
            oTableCell1.Text = "Permit Date";
            oTableCell1.CssClass = "blackfnt";
            //oTableCell.ColumnSpan = 1;
            oGridViewRow1.Cells.Add(oTableCell1);

            oTableCell1.CssClass = "blackfnt";
            oGridViewRow1.Cells.Add(oTableCell1);
            oTableCell1 = new TableCell();
            oTableCell1.Text = "Expiry Date";
            oTableCell1.CssClass = "blackfnt";
            //oTableCell.ColumnSpan = 1;
            oGridViewRow1.Cells.Add(oTableCell1);

            oGridView.Controls[0].Controls.AddAt(1, oGridViewRow1);
            oGridViewRow1.CssClass = "bgbluegrey";
            //******************************************
        }
       
    }

    private void helper_GroupHeader(string groupName, object[] values, GridViewRow row)
    {
        if (groupName == "Conrtl_branch")
        {
           
            row.Cells[0].Text = "&nbsp;&nbsp; Location : " + row.Cells[0].Text;
            row.Font.Name = "blackfnt";
            row.BackColor = System.Drawing.Color.White;
            row.Font.Bold = true;
            row.CssClass = "blackfnt";
                   }
    }
}
