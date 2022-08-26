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

public partial class octroi_OctCustBillStep2 : System.Web.UI.Page
{
  
   //SqlConnection conn = new SqlConnection(System.Configuration.ConfigurationManager.AppSettings["dbConnection"]);
   

    

    public DataSet1 _dataSet = new DataSet1();
    int _lastEditedPage;
    string custcd, octroipaid_by;
    string custcls = "";
    MyFunctions fn = new MyFunctions();
    public DataSet1.WorkExperianceDataRow datarow;
    public string dockno;
    public string bno = "";

    public string s1, s2, s3;

    protected void Page_Load(object sender, EventArgs e)
    {

        
        string billdate;

        getstring();
         
        btnSubmit.Attributes.Add("onclick", "javascript:return fsubmit(" + PanNo.ClientID + "," + servtaxno.ClientID + "," + vendorbstno.ClientID + "," + vendorcstno.ClientID + "," + txtContractStartDate.ClientID + "," + txtContractEndDt.ClientID + "," + txtOpenDt.ClientID + "," + txtOpnCrdt.ClientID + "," + ddVendorType.ClientID + "," + txtvenname.ClientID + ")");


        txtContractStartDate.Attributes.Add("onblur", "javascript:return ValidateForm(" + txtContractStartDate.ClientID + ")");
        txtContractEndDt.Attributes.Add("onblur", "javascript:return ValidateForm(" + txtContractEndDt.ClientID + ")");

        if (!IsPostBack)
        {


          


          //  txtagnttax.Text = "0";
            roww.Text = "5";
            Inetialized();
          
            BindGrid();
            popVentype();
            Validation();
        }
        else
        {
            //ReverseBind();
        }
       

    }
    protected void BlankRow()
    {

        
    }

    private void getstring()
    {
        //holidaystr = "";
        SqlConnection cn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        cn.Open();
        string sql = "SELECT loccode FROM  webx_location";
        SqlCommand sqlCommand = new SqlCommand(sql, cn);
        SqlDataReader dr_Location;
        dr_Location = sqlCommand.ExecuteReader();
        while (dr_Location.Read())
        {
            Page.RegisterArrayDeclaration("str", "'" + Convert.ToString(dr_Location["loccode"] + "'"));
        }
        dr_Location.Close();
    }

    private void Inetialized()
    {
        _dataSet.WorkExperianceData.AddWorkExperianceDataRow("", "", "", "", "", "", "", "", "", "", "");
        _dataSet.WorkExperianceData.AddWorkExperianceDataRow("", "", "", "", "", "", "", "", "", "", "");
        _dataSet.WorkExperianceData.AddWorkExperianceDataRow("", "", "", "", "", "", "", "", "", "", "");
        _dataSet.WorkExperianceData.AddWorkExperianceDataRow("", "", "", "", "", "", "", "", "", "", "");
        _dataSet.WorkExperianceData.AddWorkExperianceDataRow("", "", "", "", "", "", "", "", "", "", "");
        

    }
    private void BindGrid()
    {
        GV_D.DataSource = _dataSet.WorkExperianceData;
        GV_D.DataBind();
        _lastEditedPage = GV_D.PageIndex;
    }
    protected override void LoadViewState(object savedState)
    {
        base.LoadViewState(savedState);
        if ((!(this.ViewState["Data"] == null)))
        {
            _dataSet = ((DataSet1)(this.ViewState["Data"]));
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

    private void GV_D_PageIndexChanged(object source, System.Web.UI.WebControls.DataGridPageChangedEventArgs e)
    {
        GV_D.PageIndex = e.NewPageIndex;
        BindGrid();
    }
    private void GV_D_ItemCommand(object source, System.Web.UI.WebControls.DataGridCommandEventArgs e)
    {
        if (((System.Web.UI.Control)(e.CommandSource)).ID == "DeleteRow")
        {
            _dataSet.WorkExperianceData.RemoveWorkExperianceDataRow(_dataSet.WorkExperianceData[e.Item.DataSetIndex]);
            if (((GV_D.PageCount - GV_D.PageIndex) == 1 & GV_D.Rows.Count == 1))
            {
                if ((GV_D.PageCount > 1))
                {
                    _lastEditedPage -= 1;
                }
                else
                {
                    _lastEditedPage = 0;
                }
            }
            GV_D.PageIndex = _lastEditedPage;
            BindGrid();
        }
    }

    
    private void ReverseBind()
    {
        DataSet1.WorkExperianceDataRow datarow;// = null;

        foreach (GridViewRow gridrow in GV_D.Rows)
        {
            
            datarow = _dataSet.WorkExperianceData[gridrow.DataItemIndex];
           //// datarow.DOCKNO = ((TextBox)gridrow.FindControl("txtdockno")).Text;
           // //datarow.DECLVAL = ((TextBox)gridrow.FindControl("txtdockno")).Text;
           // datarow.OCTAMT = ((0)gridrow.FindControl("txtoctamt")).Text;
           // datarow.OCTAMT_PER = ((TextBox)gridrow.FindControl("txtrcpno")).Text;
           // datarow.CLEAR_CHRG = ((TextBox)gridrow.FindControl("txtrcpdt")).Text;
           // _dataSet.WorkExperianceData[gridrow.DataSetIndex].ItemArray = datarow.ItemArray;
        }
    }
    void GV_D_ItemDataBound(object sender, System.Web.UI.WebControls.DataGridCommandEventArgs e)
    {
        DataSet1.WorkExperianceDataRow datarow;
        if ((e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem))
        {
            datarow = ((DataSet1.WorkExperianceDataRow)((DataRowView)e.Item.DataItem).Row);

            ((TextBox)e.Item.FindControl("txtdockno")).Text = datarow.DOCKNO;
            ((TextBox)e.Item.FindControl("txtdockno")).Text = datarow.DECLVAL;
            ((TextBox)e.Item.FindControl("txtoctamt")).Text = datarow.OCTAMT;
            ((TextBox)e.Item.FindControl("txtrcpno")).Text = datarow.OCTAMT_PER;
            ((TextBox)e.Item.FindControl("txtrcpdt")).Text = datarow.CLEAR_CHRG; 
        }
    }
    protected void roww_TextChanged(object sender, EventArgs e)
    {
        _dataSet.WorkExperianceData.Clear();
        int rowno;
        rowno = Convert.ToInt32(roww.Text);
        for (int i = 0; i < rowno; i++)
        {
            _dataSet.WorkExperianceData.AddWorkExperianceDataRow("", "", "", "", "", "", "", "", "", "", "");
            BindGrid();
        }
        Validation();
    }

    public void Validation()
    {
        foreach (GridViewRow gridrow in GV_D.Rows)
        {
            TextBox txtblack = ((TextBox)gridrow.FindControl("txtblack"));
            CheckBox chkblk = ((CheckBox)gridrow.FindControl("chkblk"));
            TextBox txtactflag = ((TextBox)gridrow.FindControl("txtactflag"));
            CheckBox chkact = ((CheckBox)gridrow.FindControl("chkact"));


            chkact.Checked = true;
            chkblk.Checked = true;
            txtactflag.Text = "Y";
            txtblack.Text = "Y";
            TextBox txtloc = (TextBox)gridrow.FindControl("txtloc");
            TextBox txtcontper = (TextBox)gridrow.FindControl("txtcontper");
            TextBox txtadr = (TextBox)gridrow.FindControl("txtadr");
            TextBox txtcity = (TextBox)gridrow.FindControl("txtcity");
            TextBox txtpin = (TextBox)gridrow.FindControl("txtpin");
            TextBox txttel = (TextBox)gridrow.FindControl("txttel");
            TextBox txtmob = (TextBox)gridrow.FindControl("txtmob");
            TextBox txtemail = (TextBox)gridrow.FindControl("txtemail");

            txtpin.Attributes.Add("onblur", "javascript:check(" + txtpin.ClientID + "," + txttel.ClientID + "," + txtmob.ClientID + "," + txtemail.ClientID + ")");
            txttel.Attributes.Add("onblur", "javascript:check(" + txtpin.ClientID + "," + txttel.ClientID + "," + txtmob.ClientID + "," + txtemail.ClientID + ")");
            txtmob.Attributes.Add("onblur", "javascript:check(" + txtpin.ClientID + "," + txttel.ClientID + "," + txtmob.ClientID + "," + txtemail.ClientID + ")");
            txtemail.Attributes.Add("onblur", "javascript:check(" + txtpin.ClientID + "," + txttel.ClientID + "," + txtmob.ClientID + "," + txtemail.ClientID + ")");

            
            //TextBox txtactflag = (TextBox)gridrow.FindControl("txtactflag");
            //TextBox txtblack = (TextBox)gridrow.FindControl("txtblack");





        }
    }
    public void popGrd(object sender, EventArgs e)
    {
        _dataSet.WorkExperianceData.Clear();
        int rowno;
        rowno = Convert.ToInt32(roww.Text);
        for (int i = 0; i < rowno; i++)
        {
            _dataSet.WorkExperianceData.AddWorkExperianceDataRow("", "", "", "", "", "", "", "", "", "", "");
            BindGrid();
        }
    }

    

    public void btnAdd_Grid(object sender, EventArgs e)
    {
        _dataSet.WorkExperianceData.Clear();
        int rowno;
        rowno = Convert.ToInt32(roww.Text);       
        for (int i = 0; i < rowno; i++)
        {
            _dataSet.WorkExperianceData.AddWorkExperianceDataRow("", "", "", "", "", "", "", "", "", "", "");
            BindGrid();
        }
    }
    protected void BindGrid1()
    {
      

        DataView dv = _dataSet.WorkExperianceData.DefaultView;
        GV_D.DataSource = dv;
        GV_D.DataBind();
    }


    protected void OnchkChange(object sender, EventArgs e)
    {

        foreach (GridViewRow gridrow in GV_D.Rows)
        {

            TextBox txtactflag = ((TextBox)gridrow.FindControl("txtactflag"));
            CheckBox chkact = ((CheckBox)gridrow.FindControl("chkact"));

            if (chkact.Checked == true)
            {
                txtactflag.Text = "Y";

            }
            else
            {
                txtactflag.Text = "N";

            }



        }
    }

        protected void Onchk2Change(object sender, EventArgs e)
    {

        foreach (GridViewRow gridrow in GV_D.Rows)
        {

            TextBox txtblack = ((TextBox)gridrow.FindControl("txtblack"));
            CheckBox chkblk = ((CheckBox)gridrow.FindControl("chkblk"));

            if (chkblk.Checked == true)
            {
                txtblack.Text = "Y";

            }
            else
            {
                txtblack.Text = "N";
            
            }
        
        
        
        }

        
 

    }



    
    private DataSet1.WorkExperianceDataRow GetDataRow(int rowIndex)
    {

       // foreach (DataGridItem gridrow in GV_D.Rows)
        //{

            DataSet1.WorkExperianceDataRow datarow;
            datarow = _dataSet.WorkExperianceData[rowIndex];
            //datarow.DOCKNO = ((TextBox)GV_D.Rows[rowIndex].FindControl("txtdockno")).Text;
            //datarow.DECLVAL = ((TextBox)GV_D.Rows[rowIndex].FindControl("txtdockno")).Text;
            //datarow.OCTAMT = ((TextBox)GV_D.Rows[rowIndex].FindControl("txtoctamt")).Text;
            //datarow.OCTAMT_PER = ((TextBox)GV_D.Rows[rowIndex].FindControl("txtrcpno")).Text;
            //datarow.CLEAR_CHRG = ((TextBox)GV_D.Rows[rowIndex].FindControl("txtrcpdt")).Text;
          
        
       
        
        // _dataSet.WorkExperianceData[gridrow.ItemIndex].ItemArray = datarow.ItemArray;

            return datarow;
        //}
    }
    
     
   

    
     
    public void popVentype()
    {
        SqlConnection cn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        if (IsPostBack == false)
        {
            ddVendorType.Items.Add("--Select--");
            cn.Open();
            string sqldd = "select type_name, type_code from webx_VENDOR_type";
            SqlCommand cmd = new SqlCommand(sqldd, cn);
            SqlDataReader dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                ddVendorType.Items.Add(new ListItem(dr.GetValue(0).ToString(), dr.GetValue(1).ToString()));
            }
            dr.Close();
            cn.Close();

        }
    }
    public string getNewCd()
    {
        int intCustCode = 1;
        SqlConnection cn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

        cn.Open();

        SqlCommand cmdGet = new SqlCommand("select cast(right(max(vendorcode), 5) as numeric(18, 0)) + 1 from webx_VENDOR_DET", cn);
        SqlDataReader drGet = cmdGet.ExecuteReader();

        if (drGet.Read())
        {
            intCustCode = Convert.ToInt32(drGet[0].ToString());
        }

        drGet.Close();

        return "V" + intCustCode.ToString().PadLeft(5, '0');
        cn.Close();
    }

    protected void Button11_Click(object sender, EventArgs e)
    {
    }


    protected void btnSubmit_Click(object sender, EventArgs e)
    {

        string venno = getNewCd();

        Session["billno"] = venno;



        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
        foreach (GridViewRow gridrow in GV_D.Rows)
        { 
            TextBox txtloc = (TextBox)gridrow.FindControl("txtloc");
            TextBox txtcontper = (TextBox)gridrow.FindControl("txtcontper");
            TextBox txtadr = (TextBox)gridrow.FindControl("txtadr");
            TextBox txtcity = (TextBox)gridrow.FindControl("txtcity");
            TextBox txtpin = (TextBox)gridrow.FindControl("txtpin");
            TextBox txttel = (TextBox)gridrow.FindControl("txttel");
            TextBox txtmob = (TextBox)gridrow.FindControl("txtmob");
            TextBox txtemail = (TextBox)gridrow.FindControl("txtemail");
            TextBox txtactflag = (TextBox)gridrow.FindControl("txtactflag");
            TextBox txtblack = (TextBox)gridrow.FindControl("txtblack");
              
            if (txtloc.Text=="")
            {

            }
            else
            {  

                try
                {
                     
                    string sql = "";
 

                    sql = "insert into webx_VENDOR_DET(VENDORCODE, VENDORBRCD,VENDORCONTACT, VENDORADDRESS, VENDORCITY, VENDORPIN, VENDORPHONE,VENDORMOBILE, VENDOREMAIL, ACTIVEFLAG, BLACKLISTED) values('" + venno + "','" + txtloc.Text + "','" + txtcontper.Text + "','" + txtadr.Text + "','" + txtcity.Text + "','" + txtpin.Text + "','" + txttel.Text + "','" + txtmob.Text + "','" + txtemail.Text + "','" + txtactflag.Text + "','" + txtblack.Text + "')";
            
                    SqlCommand cmdd = new SqlCommand(sql, conn);

                    cmdd.ExecuteNonQuery();

 
                }
                catch (Exception ee1)
                {
                    lblQry.Text = ee1.Message;


                }

            }


        }


        string sql3 = "insert into webx_VENDOR_HDR(vendor_type,VENDORCODE,VENDORNAME,CONTRACTSTDT," +
        "CONTRACTENDDT,VENDORREMARKS,UPDTBY,UPDTON,VENDCAT,servtaxno,pan_no,vendorbstno," +
        "vendorcstno,opencredit,opendebit) values('" +
        Convert.ToInt32(ddVendorType.SelectedValue) + "','" + venno + "','" + txtvenname.Text +
        "','" + txtContractStartDate.Text + "','" + txtContractEndDt.Text + "','" + txtRemarks.Text +
        "','" + Session["empcd"].ToString().Trim() + "','" + System.DateTime.Now.ToShortDateString() +
        "','" + Convert.ToInt32(ddVendorType.SelectedValue) + "','" + servtaxno.Text + "','" +
        PanNo.Text + "','" + vendorbstno.Text + "','" + vendorcstno.Text + "','" +
        txtOpenDt.Text + "','" + txtOpnCrdt.Text + "')";



        SqlCommand cmdd3 = new SqlCommand(sql3, conn);

        cmdd3.ExecuteNonQuery();
        Response.Redirect("../business_partners.aspx");
    }

    public void filldata()
    {

        string msg;
      //  SqlConnection conn = new SqlConnection("data source=202.87.45.67;UID=sa;PWD=s@lc0nnect$;Database=UFL_VER2_TEST3;");

        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());


        string dno = dockno;

        string sql = "select * from webx_oct_det where dockno='" + dno + "'";

        SqlCommand cmd = new SqlCommand(sql, conn);

        string dno2;
        conn.Open();

        //dno2= cmd.ExecuteScalar().ToString();
        SqlDataAdapter da = new SqlDataAdapter(cmd);

        DataSet ds = new DataSet();

        da.Fill(ds);


        foreach (DataRow ddr in ds.Tables[0].Rows)
        {
            s1 = ddr["octamt"].ToString();
            s2 = ddr["recptno"].ToString();
            s3 = ddr["recptdt"].ToString();
            
        }

 

    }

     
}
