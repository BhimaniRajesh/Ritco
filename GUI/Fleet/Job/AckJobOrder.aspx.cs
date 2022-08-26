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
public partial class GUI_Fleet_Job_AckJobOrder : System.Web.UI.Page
{
    public MyFleetDataSet _dataSet = new MyFleetDataSet();
    Int32 nullvalue = 0;
    int _lastEditedPage;
    MyFleetDataSet.AckJobRow datarow_AJodr;
    string Type_Code = "";
     

    protected void Page_Load(object sender, EventArgs e)
    {
        string pagetitle = System.Configuration.ConfigurationManager.AppSettings["PageTitle"];
        Response.Cache.SetCacheability(HttpCacheability.NoCache);
        Response.Cache.SetNoStore();
        Response.Cache.SetExpires(DateTime.MinValue);

        Common objCommon = new Common();
        objCommon.doCacheRoutine();

        this.Title = pagetitle;


        System.DateTime righnow = System.DateTime.Today;
        string strrightnow = righnow.ToString("dd/MM/yyyy");

        if (!IsPostBack)
        {
            Bind();

        }
    }


    protected override void LoadViewState(object savedState)
    {
        base.LoadViewState(savedState);
        if ((!(this.ViewState["Data"] == null)))
        {
            _dataSet = ((MyFleetDataSet)(this.ViewState["Data"]));
        }
        if ((!(this.ViewState["LastEditedPage"] == null)))
        {
            _lastEditedPage = ((int)(this.ViewState["LastEditedPage"]));
        }
    }

    protected override object SaveViewState()
    {
        this.ViewState["Data"] = _dataSet;
        this.ViewState["LastEditedPage"] = _lastEditedPage;
        return (base.SaveViewState());
    }

    public void Bind()
    {

        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();

        string str = "usp_Job_JobOrderList";

        SqlCommand cmd = new SqlCommand(str, conn);

        cmd.CommandType = CommandType.StoredProcedure;


        cmd.Parameters.Add("@VEHNO", SqlDbType.VarChar).Value = "";
        cmd.Parameters.Add("@OrderNo", SqlDbType.VarChar).Value = "";
        cmd.Parameters.Add("@Flag", SqlDbType.VarChar).Value = "S";
        SqlDataReader dr = cmd.ExecuteReader();
        if (dr.HasRows)
        {
            while (dr.Read())
            {
                string VehicleNo = Convert.ToString(dr["VEHNO"]);
                string VehArrStatus = Convert.ToString(dr["VEH_ARRV_STATUS"]);
             //   string VehArrDt = Convert.ToString(dr["VEH_ARRV_DT"]);
                string OrderNo = Convert.ToString(dr["JOB_ORDER_NO"]);
                string OrderDate = Convert.ToString(dr["OrderDt1"]);
                string OrderType = Convert.ToString(dr["ORDER_TYPE"]);
                string OrderStatus = Convert.ToString(dr["ORDER_STATUS"]);

                if (VehArrStatus == "A")
                {
                    VehArrStatus = "Arrived";
                }

                _dataSet.AckJob.AddAckJobRow(false, VehicleNo, VehArrStatus, "", OrderNo, OrderDate, OrderType, OrderStatus);


            }

        }

        dr.Close();
        conn.Close();

        BindGrid();



    }

    public void BindGrid()
    {

        dgAck.DataSource = _dataSet.AckJob;
        dgAck.DataBind();

        _lastEditedPage = dgAck.CurrentPageIndex;

    }


    protected void cmdSubmit_Click(object sender, EventArgs e)
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
        string OrderNo = "";
        System.Globalization.DateTimeFormatInfo dtfi = new System.Globalization.DateTimeFormatInfo();
        dtfi.ShortDatePattern = "dd/MM/yyyy";
        dtfi.DateSeparator = "/";
        int count = 0;
        foreach (DataGridItem gridrow in dgAck.Items)
        {


            if (((RadioButton)gridrow.FindControl("radSel")).Checked == true)
            {
               
                count = count + 1;


            }
         


        }

        if (count < 1)
        {
            lblError.Visible = true;

            lblError.Text = "Select Atleast One Record!";



        }
        else
        {
            lblError.Visible = false;
            lblError.Text = "";

        }
                


        foreach (DataGridItem gridrow in dgAck.Items)
        {
            if (((RadioButton)gridrow.FindControl("radSel")).Checked == true && lblError.Text=="")
                {

                    DateTime VehDt = new DateTime();
                    string VehArrDt = ((TextBox)gridrow.FindControl("txtVArrDate")).Text;


                    if (VehArrDt.Trim() == "")
                    {

                        lblError.Visible = true;

                        lblError.Text = " Arrived Date  should be entered  for selected record";



                    }
                    else
                    {

                        VehDt = Convert.ToDateTime(VehArrDt, dtfi);

                        DateTime mServerDt = DateTime.Now;
                        if (VehDt > mServerDt)
                        {

                            lblError.Visible = true;
                            lblError.Text = " Arrived Date  should not be greater than today's date!";
                        }
                        else
                        {
                            lblError.Visible = false;
                            lblError.Text = "";

                        }

                    }
                 
            }
        }


        if(lblError.Text=="")

        {

           foreach (DataGridItem gridrow in dgAck.Items)
           {

               if(((RadioButton)gridrow.FindControl("radSel")).Checked==true)
               {
                   OrderNo = "";

                   string VehicleNo = ((Label)gridrow.FindControl("lblVehicleNo")).Text.Trim();
                   string VehArrStatus = ((Label)gridrow.FindControl("lblVArrStatus")).Text.Trim();

                   if (VehArrStatus.Trim() == "Arrived")
                   {

                       VehArrStatus = "A";
                   }

                   string VehArrDt = ((TextBox)gridrow.FindControl("txtVArrDate")).Text;
                   OrderNo = ((Label)gridrow.FindControl("lblOrderNo")).Text.Trim();


              string str = "usp_JobAckJobOrder";

              SqlCommand cmd = new SqlCommand(str, conn);
              cmd.CommandType = CommandType.StoredProcedure;


              cmd.Parameters.Add("@OrderNo", SqlDbType.VarChar).Value = OrderNo;
              cmd.Parameters.Add("@VehArrStatus", SqlDbType.VarChar).Value = VehArrStatus;
              cmd.Parameters.Add("@VehArrDt", SqlDbType.DateTime).Value = Convert.ToDateTime(VehArrDt, dtfi);
      
               cmd.ExecuteNonQuery();
            
               
               
               }
           }



           Response.Redirect("AckJobNext.aspx?OrderNo=" + OrderNo);




    }


    }
    protected void dgAck_ItemDataBound(object sender, DataGridItemEventArgs e)
    {



        if ((e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem))
        {
            datarow_AJodr = ((MyFleetDataSet.AckJobRow)((DataRowView)e.Item.DataItem).Row);

        }



        if ((e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem))
        {
            
            datarow_AJodr = ((MyFleetDataSet.AckJobRow)((DataRowView)e.Item.DataItem).Row);
            if (e.Item.ItemIndex >= -1)
            {
                string strSelRadio = ((RadioButton)e.Item.FindControl("radSel")).ClientID;
                ((RadioButton)e.Item.FindControl("radSel")).Attributes.Add("onClick", "fnCheckSel('" + strSelRadio + "')");
            }

            ((RadioButton)e.Item.FindControl("radSel")).Checked = datarow_AJodr.radSel;
            ((Label)e.Item.FindControl("lblVehicleNo")).Text = datarow_AJodr.VehicleNo;
            ((Label)e.Item.FindControl("lblVArrStatus")).Text = datarow_AJodr.VehArrStatus;
            ((TextBox)e.Item.FindControl("txtVArrDate")).Text = datarow_AJodr.VehArrDt;

            ((Label)e.Item.FindControl("lblOrderNo")).Text = datarow_AJodr.OrderNo;
            ((Label)e.Item.FindControl("lblODate")).Text = datarow_AJodr.OrderDt;
            ((Label)e.Item.FindControl("lblOType")).Text = datarow_AJodr.OrderType;
            ((Label)e.Item.FindControl("lblStatus")).Text = datarow_AJodr.OrderStatus;

        }
    }
}
