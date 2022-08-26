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


public partial class GUI_WebAdmin_Vehicle_Doc_master_Vehicle_doc_step1 : System.Web.UI.Page
{
    SqlConnection cn;
    public DataSet1 _dataSet = new DataSet1();
    int _lastEditedPage;
    //public static string City_str = "",edit_yn="",Stateid="",txtstateid="";
    public static string strInsuarnce_details,abc ,Editflag="";
   //  doctype;
    Int32 a,b;
    String doctype1=""; 

    protected void Page_Load(object sender, EventArgs e)
    {
         doctype1 = ddVeh_doctype.SelectedValue.ToString();

        Editflag = Request.QueryString["Editflag"]; 
        //Response.Write(" <br> Editflag : " + Editflag);
        if (!(Page.IsPostBack))
        {
            // Stateid = Request.QueryString["id"];
            cn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
            cn.Open();
            // ddVeh_doctype.Items.Clear();
            string sqlstr = "select '--Select--' as doc_type_name,'' as docid from WEBX_VEHDOCTYPMST  union select docid+':'+doc_type_name,docid from WEBX_VEHDOCTYPMST where activeflag='Y'";
            SqlCommand cmd = new SqlCommand(sqlstr, cn);
            SqlDataReader dr = cmd.ExecuteReader();
            // ddVeh_doctype.Items.Clear();
            while (dr.Read())
            {

                ddVeh_doctype.Items.Add(new ListItem(dr.GetValue(0).ToString(), dr.GetValue(1).ToString()));
            }

            dr.Close();

            sqlstr = "select '--Select--' as type_name,0 as type_code from webx_vehicle_type  union select type_name,type_code from webx_vehicle_type where activeflag='Y'";
            cmd = new SqlCommand(sqlstr, cn);
            dr = cmd.ExecuteReader();

            while (dr.Read())
            {

                DDveytype.Items.Add(new ListItem(dr.GetValue(0).ToString(), dr.GetValue(1).ToString()));
            }

            dr.Close();

            flaggupdate(false);
            cn.Close();

            DDVehicle.Items.Add(new ListItem("--Select--", ""));
            roww.Text = "1";
        }
        flaggupdate(false);

               btnSubmit.Attributes.Add("onclick", "javascript:return Submitdata(" + DDveytype.ClientID + "," + DDVehicle.ClientID + "," + ddVeh_doctype.ClientID + "," + btnSubmit.ClientID + ")");
    }

    private void Inetialized()
    {
        _dataSet.WorkExperianceData.AddWorkExperianceDataRow("", "", "", "", "", "", "", "", "", "", "");
      

    }
    protected void roww_TextChanged(object sender, EventArgs e)
    {
        
        if (doctype1 == "VD01")
        {
            GV_D1.Visible = true;
            GV_D2.Visible = false;
            GV_D3.Visible = false;
            ROW_ID.Visible = true;
           // BindGrid();
            
        }
        if (doctype1 == "VD02")
        {

            GV_D1.Visible = false;
            GV_D2.Visible = true;
            GV_D3.Visible = false;
            ROW_ID.Visible = true;
            //BindGrid();
        }
        if (doctype1 == "VD03")
        {
            GV_D1.Visible = false;
            GV_D2.Visible = false;
            GV_D3.Visible = true;
            ROW_ID.Visible = true;
            //BindGrid();
            //  ROW_ID.Visible = true;
        }
        int rowno, rowno1;
        rowno = Convert.ToInt32(roww.Text);

        Records();
        _dataSet.WorkExperianceData.Clear();
       
       
        if (a < rowno)
        {
            rowno1 = rowno - a;
        }
        else
        {
            if (Editflag == "Y")
            {
                rowno1 = rowno;
            }
            else
            {
                rowno1 = rowno-1;
            }
        }

        for (int i = 0; i < rowno1; i++)
        {
            _dataSet.WorkExperianceData.AddWorkExperianceDataRow("", "", "", "", "", "", "", "", "", "", "");
            //Inetialized();
            BindGrid1();
           intetilisedrows();
        }
        Rowdatadisplq();
        roww.Text =Convert.ToString(rowno);
     // Validation();
    }

    public void Validation()
    {
        foreach (GridViewRow gridrow in GV_D3.Rows)
        {
            DropDownList St = (DropDownList)gridrow.FindControl("ddState");
            TextBox txtPERMIT_NO = (TextBox)gridrow.FindControl("txtPERMIT_NO");
            TextBox txtPERMIT_DATE = (TextBox)gridrow.FindControl("txtPERMIT_DATE");
            TextBox txtEXPIRY_DATE = (TextBox)gridrow.FindControl("txtEXPIRY_DATE");


            txtPERMIT_NO.Attributes.Add("onblur", "javascript:this.value=this.value.toUpperCase()");
            txtPERMIT_DATE.Attributes.Add("onblur", "javascript:return ValidateForm(this)");
            txtEXPIRY_DATE.Attributes.Add("onblur", "javascript:return ValidateForm(this)");

            cn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
            cn.Open();

            string sqlstr = "select '--Select--' as stnm,'' as stcd from WEBX_STATE  union Select stnm,stcd from WEBX_STATE  with(NOLOCK)  order by stnm";
            SqlCommand cmd = new SqlCommand(sqlstr, cn);
            SqlDataReader dr = cmd.ExecuteReader();

            while (dr.Read())
            {

                St.Items.Add(new ListItem(dr.GetValue(0).ToString(), dr.GetValue(1).ToString()));
            }

            dr.Close();

        }
    }


    private void intetilisedrows()
    {
         doctype1 = ddVeh_doctype.SelectedValue.ToString();
        if (doctype1 == "VD03")
        {
            foreach (GridViewRow gridrow in GV_D3.Rows)
            {
                DropDownList St = (DropDownList)gridrow.FindControl("ddState");
                TextBox txtPERMIT_NO = (TextBox)gridrow.FindControl("txtPERMIT_NO");
                TextBox txtPERMIT_DATE = (TextBox)gridrow.FindControl("txtPERMIT_DATE");
                TextBox txtEXPIRY_DATE = (TextBox)gridrow.FindControl("txtEXPIRY_DATE");

                txtPERMIT_NO.Attributes.Add("onblur", "javascript:this.value=this.value.toUpperCase()");
                txtPERMIT_DATE.Attributes.Add("onblur", "javascript:return ValidateForm(this)");
                txtEXPIRY_DATE.Attributes.Add("onblur", "javascript:return ValidateForm(this)");

                cn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
                cn.Open();

                string sqlstr = "select '--Select--' as stnm,'' as stcd from WEBX_STATE  union Select stnm,stcd from WEBX_STATE  with(NOLOCK)  order by stnm";
                SqlCommand cmd = new SqlCommand(sqlstr, cn);
                SqlDataReader dr = cmd.ExecuteReader();

                while (dr.Read())
                {

                    St.Items.Add(new ListItem(dr.GetValue(0).ToString(), dr.GetValue(1).ToString()));
                }

                dr.Close();
            }
        }
        if (doctype1 == "VD01")
        {
            foreach (GridViewRow gridrow in GV_D1.Rows)
            {


                TextBox txtPOLICY_NO = (TextBox)gridrow.FindControl("txtPOLICY_NO");

                TextBox txtSTART_DATE = (TextBox)gridrow.FindControl("txtSTART_DATE");
                TextBox txtEND_DATE = (TextBox)gridrow.FindControl("txtEND_DATE");

                txtPOLICY_NO.Attributes.Add("onblur", "javascript:this.value=this.value.toUpperCase()");
                txtSTART_DATE.Attributes.Add("onblur", "javascript:return ValidateForm(this)");
                txtEND_DATE.Attributes.Add("onblur", "javascript:return ValidateForm(this)");
            }
        }

        if (doctype1 == "VD02")
        {
            foreach (GridViewRow gridrow in GV_D2.Rows)
            {


                TextBox txtREG_NO = (TextBox)gridrow.FindControl("txtREG_NO");

                TextBox txtREG_DATE = (TextBox)gridrow.FindControl("txtREG_DATE");
                TextBox txtFITNESS_VALIDITY_DATE = (TextBox)gridrow.FindControl("txtFITNESS_VALIDITY_DATE");

                txtREG_NO.Attributes.Add("onblur", "javascript:this.value=this.value.toUpperCase()");
                txtREG_DATE.Attributes.Add("onblur", "javascript:return ValidateForm(this)");
                txtFITNESS_VALIDITY_DATE.Attributes.Add("onblur", "javascript:return ValidateForm(this)");
            }
        }


    }

    private void BindGrid1()
    {

        //Inetialized();
         doctype1 = ddVeh_doctype.SelectedValue.ToString();

        if (doctype1 == "VD01")
        {
            GV_D1.DataSource = _dataSet.WorkExperianceData;
            GV_D1.DataBind();
            _lastEditedPage = GV_D1.PageIndex;
        }
        if (doctype1 == "VD02")
        {
            GV_D2.DataSource = _dataSet.WorkExperianceData;
            GV_D2.DataBind();
            _lastEditedPage = GV_D2.PageIndex;
        }
        if (doctype1 == "VD03")
        {
            GV_D3.DataSource = _dataSet.WorkExperianceData;
            GV_D3.DataBind();
            _lastEditedPage = GV_D3.PageIndex;
        }
    }

    


    protected void vType_SelectedIndexChanged(object sender, EventArgs e)
    {
        
        cn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        cn.Open();
        string vehicletype = DDveytype.SelectedValue.ToString();
        DDVehicle.Items.Clear();
        string strSQL = "select top 1 '--Select--' as vehno,'' as vehno1 From webx_vehicle_hdr Union   Select vehno ,vehno as  vehno1  From webx_vehicle_hdr where vehicle_type ='" + vehicletype + "'";
        SqlCommand cmdVhclType = new SqlCommand(strSQL, cn);
        SqlDataAdapter daVhclType = new SqlDataAdapter(cmdVhclType);
        DataSet dsVehicleType = new DataSet();
        daVhclType.Fill(dsVehicleType);
        if (dsVehicleType.Tables[0].Rows.Count > 0)
        {

            DDVehicle.DataTextField = "vehno";
            DDVehicle.DataValueField = "vehno1";
            DDVehicle.DataSource = dsVehicleType;
            DDVehicle.DataBind();
        }
        cn.Close();
        BindGrid1();
    }
    public void flaggupdate(bool flag)
    {
        if (flag == false)
        {
            flag = false;
        }
        else
        {
            flag = true;
        }

        ROW_ID.Visible = flag;

        GV_D1.Visible = flag;
        GV_D2.Visible = flag;
        GV_D3.Visible = flag;       

    }

   
  

    protected void DOC_TYPE_SelectedIndexChanged(object sender, EventArgs e)
    {
        SqlConnection cn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        cn.Open();

         doctype1 = ddVeh_doctype.SelectedValue.ToString();
      
        if (doctype1 == "VD01")
        {
            GV_D1.Visible = true;
            GV_D2.Visible = false;
            GV_D3.Visible = false;
            ROW_ID.Visible = true;

            //if (Editflag == "")
            //{
            //    Inetialized();
                
            //}
            //else
            //{

            //}
            //BindGrid1();
        }
        if (doctype1 == "VD02")
        {

            GV_D1.Visible = false;
            GV_D2.Visible = true;
            GV_D3.Visible = false;
            ROW_ID.Visible = true;
            //Inetialized();
           //BindGrid1();
        }
        if (doctype1 == "VD03")
        {
            GV_D1.Visible = false;
            GV_D2.Visible = false;
            GV_D3.Visible = true;
            ROW_ID.Visible = true;
            //intetilisedrows();
           
         //  ROW_ID.Visible = true;
        }



        //Inetialized();
        //BindGrid1();
        if (Editflag == "Y")
        {
            Rowdatadisplq();
            
        }
        else
        {
            Inetialized();
            BindGrid1();
            intetilisedrows();
        }

        //BindGrid1();
       // intetilisedrows();
       
    }

    protected void dg_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (((Control)e.CommandSource).ID == "DeleteButton")
        {
            int thisRow = (((GridViewRow)((System.Web.UI.Control)e.CommandSource).Parent.Parent).RowIndex);
            string SRNO = GV_D3.DataKeys[thisRow].Values[0].ToString();
            SRNO = SRNO.Trim().ToString();           
               
            string Query = "Delete from  WEBX_VEHDOCMST where SRNO='" + SRNO + "'";
            //SqlConnection conn = new SqlConnection("Data Source=202.87.45.69;Initial Catalog=WEBX_FLEET;UID=sa;pwd=!@ECfy#$");
            cn.Open();
            SqlCommand Command = new System.Data.SqlClient.SqlCommand(Query, cn);
            Command.ExecuteNonQuery();
            cn.Close();
            BindGrid1();

                
        }
    }

    public void Records()
    {
        string SQL_validate = "Select count(*)  as cnt from   webx_VEHDOCMST where VEH_DOC_TYPE='" + doctype1 + "' and vehno='" + DDVehicle.SelectedValue + "'";
        SqlConnection cn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        cn.Open();
        SqlCommand validate = new SqlCommand(SQL_validate, cn);

        a = Convert.ToInt32(validate.ExecuteScalar());

        //if (roww.Text = Convert.ToString(a) || roww.Text < Convert.ToString(a))
        //{
        b = Convert.ToInt32(roww.Text);
        if (a == b)
        {

            roww.Text = Convert.ToString(a);
            a = a;
        }
        if (a > b)
        {

            roww.Text = Convert.ToString(a);
            a = a;
        }
        if (a < b)
        {
            //roww.Text = "1";
            a = a;
        }

    }

    public void Rowdatadisplq()
    {
        
        Records();

        for (int i = 0; i < a; i++)
        {
            Inetialized();

        }
        BindGrid1();
        RetriveData();
    }
    private void RetriveData()
    {
        SqlConnection cn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        cn.Open();
        doctype1 = ddVeh_doctype.SelectedValue.ToString();
        

        if (doctype1 == "VD03")
        {
            GV_D3.Visible = true;
            //string sql = "Select *  from   webx_VEHDOCMST where VEH_DOC_TYPE='" + doctype1 + "' and vehno='" + DDVehicle.SelectedValue + "'";
            string sql = "Select "
                        + " SRNO,VEHNO,VEHTYPE,VEH_DOC_TYPE,VD01C001,convert(varchar,VD01C002,103)VD01C002,convert(varchar,VD01C003,103)VD01C003,VD02C001"
                        + ",VD02C002,VD02C003,VD03C001,VD03C002,convert(varchar,VD03C003,103)VD03C003,convert(varchar,VD03C004,103)VD03C004,VD01C004,VD01C005,VD01C006,VD01C007,VD01C008,VD02C004,VD02C005,VD02C006,VD02C007,VD02C008 "
                        + ",VD03C005,VD03C006,VD03C007,VD03C008,VD03C009  from   webx_VEHDOCMST where VEH_DOC_TYPE='" + doctype1 + "' and vehno='" + DDVehicle.SelectedValue + "'";

            SqlCommand cmd1 = new SqlCommand(sql, cn);
            SqlDataReader dr = cmd1.ExecuteReader();

            string PERMIT_NO = "", PERMIT_DATE = "", EXPIRY_DATE = "", State = "",SR_no="";
            while (dr.Read())
            {
                //txtPOLICY_NO.Text = Convert.ToString(dr["VD01C001"]);
                //txtSTART_DATE.Text = Convert.ToString(dr["VD01C002"]);
                //txtEND_DATE.Text = Convert.ToString(dr["VD01C003"]);

                if (State == "")
                {
                    State = Convert.ToString(dr["VD03C001"]);
                }
                else
                {
                    State = State + "~" + Convert.ToString(dr["VD03C001"]);
                }
                if (PERMIT_NO == "")
                {
                    PERMIT_NO = Convert.ToString(dr["VD03C002"]);
                }
                else
                {
                    PERMIT_NO = PERMIT_NO + "~" + Convert.ToString(dr["VD03C002"]);
                }

                if (PERMIT_DATE == "")
                {
                    PERMIT_DATE = Convert.ToString(dr["VD03C003"]);
                }
                else
                {
                    PERMIT_DATE = PERMIT_DATE + "~" + Convert.ToString(dr["VD03C003"]);
                }

                if (EXPIRY_DATE == "")
                {
                    EXPIRY_DATE = Convert.ToString(dr["VD03C004"]);
                }
                else
                {
                    EXPIRY_DATE = EXPIRY_DATE + "~" + Convert.ToString(dr["VD03C004"]);
                }

                if (SR_no == "")
                {
                    SR_no = Convert.ToString(dr["SRNO"]);
                }
                else
                {
                    SR_no = SR_no + "~" + Convert.ToString(dr["SRNO"]);
                }

            }
            dr.Close();
            int i = 0;
            string[] State_arr = State.Split('~');
            string[] PERMIT_NO_arr = PERMIT_NO.Split('~');
            string[] PERMIT_DATE_arr = PERMIT_DATE.Split('~');
            string[] EXPIRY_DATE_arr = EXPIRY_DATE.Split('~');
             string[] SR_no_arr = SR_no.Split('~');
            
            foreach (GridViewRow gridrow in GV_D3.Rows)
            {
                DropDownList St = (DropDownList)gridrow.FindControl("ddState");
                TextBox txtPERMIT_NO = (TextBox)gridrow.FindControl("txtPERMIT_NO");
                TextBox txtPERMIT_DATE = (TextBox)gridrow.FindControl("txtPERMIT_DATE");
                TextBox txtEXPIRY_DATE = (TextBox)gridrow.FindControl("txtEXPIRY_DATE");
                HiddenField SRNO = (HiddenField)gridrow.FindControl("SRNO");

                txtPERMIT_NO.Attributes.Add("onblur", "javascript:this.value=this.value.toUpperCase()");
                txtPERMIT_DATE.Attributes.Add("onblur", "javascript:return ValidateForm(this)");
                txtEXPIRY_DATE.Attributes.Add("onblur", "javascript:return ValidateForm(this)");

                //cn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
                //cn.Open();

                string sqlstr = "select '--Select--' as stnm,'' as stcd from WEBX_STATE  union Select stnm,stcd from WEBX_STATE  with(NOLOCK)  order by stnm";
                SqlCommand cmd = new SqlCommand(sqlstr, cn);
                SqlDataReader dr1 = cmd.ExecuteReader();

                while (dr1.Read())
                {

                    St.Items.Add(new ListItem(dr1.GetValue(0).ToString(), dr1.GetValue(1).ToString()));
                }

                dr1.Close();


                if (i < a)
                {
                    St.SelectedValue = State_arr[i];
                    txtPERMIT_NO.Text = PERMIT_NO_arr[i];
                    txtPERMIT_DATE.Text = PERMIT_DATE_arr[i];
                    txtEXPIRY_DATE.Text = EXPIRY_DATE_arr[i];
                    SRNO.Value = SR_no_arr[i];
                }
                i = i + 1;
            }
        }
        if (doctype1 == "VD01")
        {
            GV_D1.Visible = true;
            //string sql = "Select *  from   webx_VEHDOCMST where VEH_DOC_TYPE='" + doctype1 + "' and vehno='" + DDVehicle.SelectedValue + "'";

            string sql = "Select SRNO,VEHNO,VEHTYPE,VEH_DOC_TYPE,VD01C001,convert(varchar,VD01C002,103)VD01C002,convert(varchar,VD01C003,103)VD01C003,VD02C001 "
                 + " ,VD02C002,VD02C003,VD03C001,VD03C002,VD03C003,VD03C004,VD01C004,VD01C005,VD01C006,VD01C007,VD01C008,VD02C004,VD02C005,VD02C006,VD02C007,VD02C008 "
                  + ",VD03C005,VD03C006,VD03C007,VD03C008,VD03C009 from   webx_VEHDOCMST where VEH_DOC_TYPE='" + doctype1 + "' and vehno='" + DDVehicle.SelectedValue + "'";

                SqlCommand cmd1 = new SqlCommand(sql, cn);
                SqlDataReader dr = cmd1.ExecuteReader();

                string POLICY_NO = "", START_DATE = "", END_DATE = "", SR_no="";
                    while (dr.Read())
                    {
                        //txtPOLICY_NO.Text = Convert.ToString(dr["VD01C001"]);
                        //txtSTART_DATE.Text = Convert.ToString(dr["VD01C002"]);
                        //txtEND_DATE.Text = Convert.ToString(dr["VD01C003"]);

                        if (POLICY_NO == "")
                        {
                            POLICY_NO = Convert.ToString(dr["VD01C001"]);
                        }
                        else
                        {
                            POLICY_NO = POLICY_NO + "~" + Convert.ToString(dr["VD01C001"]);
                        }

                        if (START_DATE == "")
                        {
                            START_DATE = Convert.ToString(dr["VD01C002"]);
                        }
                        else
                        {
                            START_DATE = START_DATE + "~" + Convert.ToString(dr["VD01C002"]);
                        }

                        if (END_DATE == "")
                        {
                            END_DATE = Convert.ToString(dr["VD01C003"]);
                        }
                        else
                        {
                            END_DATE = END_DATE + "~" + Convert.ToString(dr["VD01C003"]);
                        }

                        if (SR_no == "")
                        {
                            SR_no = Convert.ToString(dr["SRNO"]);
                        }
                        else
                        {
                            SR_no = SR_no + "~" + Convert.ToString(dr["SRNO"]);
                        }

                    }
                    dr.Close();
            int i=0;
            string[] POLICY_NO_arr = POLICY_NO.Split('~');
            string[] START_DATE_arr = START_DATE.Split('~');
            string[] END_DATE_arr = END_DATE.Split('~');
            string[] SR_no_arr = SR_no.Split('~');
            foreach (GridViewRow gridrow in GV_D1.Rows)
            {


                TextBox txtPOLICY_NO = (TextBox)gridrow.FindControl("txtPOLICY_NO");

                TextBox txtSTART_DATE = (TextBox)gridrow.FindControl("txtSTART_DATE");
                TextBox txtEND_DATE = (TextBox)gridrow.FindControl("txtEND_DATE");
                HiddenField SRNO = (HiddenField)gridrow.FindControl("SRNO");

                txtPOLICY_NO.Attributes.Add("onblur", "javascript:this.value=this.value.toUpperCase()");
                txtSTART_DATE.Attributes.Add("onblur", "javascript:return ValidateForm(this)");
                txtEND_DATE.Attributes.Add("onblur", "javascript:return ValidateForm(this)");
                if (i < a)
                {
                    txtPOLICY_NO.Text = POLICY_NO_arr[i];
                    txtSTART_DATE.Text = START_DATE_arr[i];
                    txtEND_DATE.Text = END_DATE_arr[i];
                    SRNO.Value = SR_no_arr[i];
                }
                i=i+1;
               
            }
        }

        if (doctype1 == "VD02")
        {

            GV_D2.Visible = true;
            //string sql = "Select *  from   webx_VEHDOCMST where VEH_DOC_TYPE='" + doctype1 + "' and vehno='" + DDVehicle.SelectedValue + "'";
            string sql = "Select "
                        + "SRNO, VEHNO,VEHTYPE,VEH_DOC_TYPE,VD01C001,convert(varchar,VD01C002,103)VD01C002,convert(varchar,VD01C003,103)VD01C003,VD02C001 "
                        + ",convert(varchar,VD02C002,103)VD02C002,convert(varchar,VD02C003,103)VD02C003,VD03C001,VD03C002,VD03C003,VD03C004,VD01C004,VD01C005,VD01C006,VD01C007,VD01C008,VD02C004,VD02C005,VD02C006,VD02C007,VD02C008 "
                        + ",VD03C005,VD03C006,VD03C007,VD03C008,VD03C009  from   webx_VEHDOCMST where VEH_DOC_TYPE='" + doctype1 + "' and vehno='" + DDVehicle.SelectedValue + "'";

            SqlCommand cmd1 = new SqlCommand(sql, cn);
            SqlDataReader dr = cmd1.ExecuteReader();

            string REG_NO = "", REG_DATE = "", FITNESS_VALIDITY_DATE = "", SR_no="";
            while (dr.Read())
            {
                //txtPOLICY_NO.Text = Convert.ToString(dr["VD01C001"]);
                //txtSTART_DATE.Text = Convert.ToString(dr["VD01C002"]);
                //txtEND_DATE.Text = Convert.ToString(dr["VD01C003"]);

                if (REG_NO == "")
                {
                    REG_NO = Convert.ToString(dr["VD02C001"]);
                }
                else
                {
                    REG_NO = REG_NO + "~" + Convert.ToString(dr["VD02C001"]);
                }

                if (REG_DATE == "")
                {
                    REG_DATE = Convert.ToString(dr["VD02C002"]);
                }
                else
                {
                    REG_DATE = REG_DATE + "~" + Convert.ToString(dr["VD02C002"]);
                }

                if (FITNESS_VALIDITY_DATE == "")
                {
                    FITNESS_VALIDITY_DATE = Convert.ToString(dr["VD02C003"]);
                }
                else
                {
                    FITNESS_VALIDITY_DATE = FITNESS_VALIDITY_DATE + "~" + Convert.ToString(dr["VD02C003"]);
                }

                if (SR_no == "")
                {
                    SR_no = Convert.ToString(dr["SRNO"]);
                }
                else
                {
                    SR_no = SR_no + "~" + Convert.ToString(dr["SRNO"]);
                }
            }
            dr.Close();
            int i = 0;
            string[] REG_NO_arr = REG_NO.Split('~');
            string[] REG_DATE_arr = REG_DATE.Split('~');
            string[] FITNESS_VALIDITY_DATE_arr = FITNESS_VALIDITY_DATE.Split('~');
            string[] SR_no_arr = SR_no.Split('~');

            foreach (GridViewRow gridrow in GV_D2.Rows)
            {


                TextBox txtREG_NO = (TextBox)gridrow.FindControl("txtREG_NO");

                TextBox txtREG_DATE = (TextBox)gridrow.FindControl("txtREG_DATE");
                TextBox txtFITNESS_VALIDITY_DATE = (TextBox)gridrow.FindControl("txtFITNESS_VALIDITY_DATE");
                HiddenField SRNO = (HiddenField)gridrow.FindControl("SRNO");

                txtREG_NO.Attributes.Add("onblur", "javascript:this.value=this.value.toUpperCase()");
                txtREG_DATE.Attributes.Add("onblur", "javascript:return ValidateForm(this)");
                txtFITNESS_VALIDITY_DATE.Attributes.Add("onblur", "javascript:return ValidateForm(this)");


                if (i < a)
                {
                    txtREG_NO.Text = REG_NO_arr[i];
                    txtREG_DATE.Text = REG_DATE_arr[i];
                    txtFITNESS_VALIDITY_DATE.Text = FITNESS_VALIDITY_DATE_arr[i];
                    SRNO.Value = SR_no_arr[i];
                }
                i = i + 1;
            }
        }
        


        cn.Close();
    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        if (Editflag == "Y")
        {
            Editdata();
        }
        else
        {
            Insertdata();
        }

        Response.Redirect("vehicle_doc_step1.aspx");
        //cn.Close();
    }

    public void Editdata()
    {
        SqlConnection cn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        cn.Open();
        Int32 c = 0;
        c = Convert.ToInt32(roww.Text);
            // Records();
        if (doctype1 == "VD03")
        {

            foreach (GridViewRow gridrow in GV_D3.Rows)
            {
                TextBox txtPERMIT_NO = (TextBox)gridrow.FindControl("txtPERMIT_NO");
                DropDownList ddState = (DropDownList)gridrow.FindControl("ddState");
                TextBox txtPERMIT_DATE = (TextBox)gridrow.FindControl("txtPERMIT_DATE");
                TextBox txtEXPIRY_DATE = (TextBox)gridrow.FindControl("txtEXPIRY_DATE");
                HiddenField SRNO = (HiddenField)gridrow.FindControl("SRNO");

                String PERMIT_DATE;
                if (txtPERMIT_DATE.Text == "")
                {
                    PERMIT_DATE = "";
                }
                else
                {
                    PERMIT_DATE = Mydate1(txtPERMIT_DATE.Text);
                }

                String SRN = SRNO.Value;

                String EXPIRY_DATE = "";

                if (txtEXPIRY_DATE.Text == "")
                {
                    EXPIRY_DATE = "";
                }
                else
                {
                    EXPIRY_DATE = Mydate1(txtEXPIRY_DATE.Text);
                }
                string spsql;
                if (SRN != "")
                {
                    spsql = "Update WEBX_VEHDOCMST Set VEHNO='" + DDVehicle.SelectedValue + "', VEHTYPE='" + DDveytype.SelectedValue + "', VEH_DOC_TYPE='" + ddVeh_doctype.SelectedValue + "',VD03C001='" + ddState.SelectedValue + "', VD03C002='" + txtPERMIT_NO.Text + "', VD03C003='" + PERMIT_DATE + "', VD03C004='" + EXPIRY_DATE + "' where SRNO='" + SRNO.Value + "' ";

                }
                else
                {
                    spsql = "insert into WEBX_VEHDOCMST(VEHNO, VEHTYPE, VEH_DOC_TYPE,VD03C001, VD03C002, VD03C003, VD03C004) values ";
                    spsql = spsql + "('" + DDVehicle.SelectedValue + "','" + DDveytype.SelectedValue + "','" + ddVeh_doctype.SelectedValue + "','" + ddState.SelectedValue + "','" + txtPERMIT_NO.Text + "','" + PERMIT_DATE + "','" + EXPIRY_DATE + "')";

                }
                Response.Write("<br>" + spsql);
                // Response.End();
                SqlCommand valCmd = new SqlCommand(spsql, cn);
                valCmd.ExecuteNonQuery();


            }

        }

            if (doctype1 == "VD01")
            {
                foreach (GridViewRow gridrow in GV_D1.Rows)
                {
                    TextBox txtPOLICY_NO = (TextBox)gridrow.FindControl("txtPOLICY_NO");

                    TextBox txtSTART_DATE = (TextBox)gridrow.FindControl("txtSTART_DATE");
                    TextBox txtEND_DATE = (TextBox)gridrow.FindControl("txtEND_DATE");
                    HiddenField SRNO = (HiddenField)gridrow.FindControl("SRNO");
                    String START_DATE;
                    if (txtSTART_DATE.Text == "")
                    {
                        START_DATE = "";
                    }
                    else
                    {
                        START_DATE = Mydate1(txtSTART_DATE.Text);
                    }

                    String END_DATE = "";
                    String SRN1 = SRNO.Value;

                    if (txtEND_DATE.Text == "")
                    {
                        END_DATE = "";
                    }
                    else
                    {
                        END_DATE = Mydate1(txtEND_DATE.Text);
                    }

                    string spsq2;
                     if (SRN1 != "")
                     {
                         spsq2 = "Update WEBX_VEHDOCMST Set VEHNO='" + DDVehicle.SelectedValue + "', VEHTYPE='" + DDveytype.SelectedValue + "', VEH_DOC_TYPE='" + ddVeh_doctype.SelectedValue + "',VD01C001='" + txtPOLICY_NO.Text + "', VD01C002='" + START_DATE + "', VD01C003='" + END_DATE + "' where SRNO='" + SRNO.Value + "' ";

                     }
                     else
                     {
                         spsq2 = "insert into WEBX_VEHDOCMST(VEHNO, VEHTYPE, VEH_DOC_TYPE,VD01C001, VD01C002, VD01C003) values ";
                         spsq2 = spsq2 + "('" + DDVehicle.SelectedValue + "','" + DDveytype.SelectedValue + "','" + ddVeh_doctype.SelectedValue + "','" + txtPOLICY_NO.Text + "','" + START_DATE + "','" + END_DATE + "')";
                     }
                    // Response.Write("<br>" + spsq2);
                    // Response.End();
                    SqlCommand valCmd2 = new SqlCommand(spsq2, cn);
                    valCmd2.ExecuteNonQuery();
                    // Response.Redirect("vehicle_doc.aspx");
                }

            }


            if (doctype1 == "VD02")
            {
                foreach (GridViewRow gridrow in GV_D2.Rows)
                {
                    TextBox txtREG_NO = (TextBox)gridrow.FindControl("txtREG_NO");

                    TextBox txtREG_DATE = (TextBox)gridrow.FindControl("txtREG_DATE");
                    TextBox txtFITNESS_VALIDITY_DATE = (TextBox)gridrow.FindControl("txtFITNESS_VALIDITY_DATE");
                    HiddenField SRNO = (HiddenField)gridrow.FindControl("SRNO");
                    String REG_DATE = "";

                    if (txtREG_DATE.Text == "")
                    {
                        REG_DATE = "";
                    }
                    else
                    {
                        REG_DATE = Mydate1(txtREG_DATE.Text);
                    }

                    String VALIDITY_DATE = "";
                    String SRN2 = SRNO.Value;

                    if (txtFITNESS_VALIDITY_DATE.Text == "")
                    {
                        VALIDITY_DATE = "";
                    }
                    else
                    {
                        VALIDITY_DATE = Mydate1(txtFITNESS_VALIDITY_DATE.Text);
                    }
                    string spsq3;
                    if (SRN2 != "")
                    {
                        spsq3 = "Update WEBX_VEHDOCMST Set VEHNO='" + DDVehicle.SelectedValue + "', VEHTYPE='" + DDveytype.SelectedValue + "', VEH_DOC_TYPE='" + ddVeh_doctype.SelectedValue + "',VD02C001='" + txtREG_NO.Text + "', VD02C002='" + REG_DATE + "', VD02C003='" + VALIDITY_DATE + "' where SRNO='" + SRNO.Value + "' ";

                    }
                    else
                    {
                        spsq3 = "insert into WEBX_VEHDOCMST(VEHNO, VEHTYPE, VEH_DOC_TYPE,VD02C001, VD02C002, VD02C003) values ";
                        spsq3 = spsq3 + "('" + DDVehicle.SelectedValue + "','" + DDveytype.SelectedValue + "','" + ddVeh_doctype.SelectedValue + "','" + txtREG_NO.Text + "','" + REG_DATE + "','" + VALIDITY_DATE + "')";
                    }
                    // Response.Write("<br>" + spsq3);
                    //Response.End();
                    SqlCommand valCmd3 = new SqlCommand(spsq3, cn);
                    valCmd3.ExecuteNonQuery();

                }

            }


     
    }

    public void Insertdata()
    {


        SqlConnection cn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        cn.Open();
        String doctype_st = ddVeh_doctype.SelectedValue.ToString();


        if (doctype_st == "VD03")
        {
            foreach (GridViewRow gridrow in GV_D3.Rows)
            {
                TextBox txtPERMIT_NO = (TextBox)gridrow.FindControl("txtPERMIT_NO");
                DropDownList ddState = (DropDownList)gridrow.FindControl("ddState");
                TextBox txtPERMIT_DATE = (TextBox)gridrow.FindControl("txtPERMIT_DATE");
                TextBox txtEXPIRY_DATE = (TextBox)gridrow.FindControl("txtEXPIRY_DATE");

                String PERMIT_DATE;
                if (txtPERMIT_DATE.Text == "")
                {
                    PERMIT_DATE = "";
                }
                else
                {
                    PERMIT_DATE = Mydate1(txtPERMIT_DATE.Text);
                }

                String EXPIRY_DATE = "";

                if (txtEXPIRY_DATE.Text == "")
                {
                    EXPIRY_DATE = "";
                }
                else
                {
                    EXPIRY_DATE = Mydate1(txtEXPIRY_DATE.Text);
                }


                string spsql = "insert into WEBX_VEHDOCMST(VEHNO, VEHTYPE, VEH_DOC_TYPE,VD03C001, VD03C002, VD03C003, VD03C004) values ";
                spsql = spsql + "('" + DDVehicle.SelectedValue + "','" + DDveytype.SelectedValue + "','" + ddVeh_doctype.SelectedValue + "','" + ddState.SelectedValue + "','" + txtPERMIT_NO.Text + "','" + PERMIT_DATE + "','" + EXPIRY_DATE + "')";
                Response.Write("<br>" + spsql);
                //Response.End();
                SqlCommand valCmd = new SqlCommand(spsql, cn);
                valCmd.ExecuteNonQuery();

                
            }


           
        }

        if (doctype_st == "VD01")
        {
            foreach (GridViewRow gridrow in GV_D1.Rows)
            {
                TextBox txtPOLICY_NO = (TextBox)gridrow.FindControl("txtPOLICY_NO");

                TextBox txtSTART_DATE = (TextBox)gridrow.FindControl("txtSTART_DATE");
                TextBox txtEND_DATE = (TextBox)gridrow.FindControl("txtEND_DATE");
                String START_DATE;
                if (txtSTART_DATE.Text == "")
                {
                    START_DATE = "";
                }
                else
                {
                    START_DATE = Mydate1(txtSTART_DATE.Text);
                }

                String END_DATE = "";

                if (txtEND_DATE.Text == "")
                {
                    END_DATE = "";
                }
                else
                {
                    END_DATE = Mydate1(txtEND_DATE.Text);
                }

                string spsq2 = "insert into WEBX_VEHDOCMST(VEHNO, VEHTYPE, VEH_DOC_TYPE,VD01C001, VD01C002, VD01C003) values ";
                spsq2 = spsq2 + "('" + DDVehicle.SelectedValue + "','" + DDveytype.SelectedValue + "','" + ddVeh_doctype.SelectedValue + "','" + txtPOLICY_NO.Text + "','" + START_DATE + "','" + END_DATE + "')";
                // Response.Write("<br>" + spsq2);
                // Response.End();
                SqlCommand valCmd2 = new SqlCommand(spsq2, cn);
                valCmd2.ExecuteNonQuery();
                // Response.Redirect("vehicle_doc.aspx");
            }

        }

        if (doctype_st == "VD02")
        {
            foreach (GridViewRow gridrow in GV_D2.Rows)
            {
                TextBox txtREG_NO = (TextBox)gridrow.FindControl("txtREG_NO");

                TextBox txtREG_DATE = (TextBox)gridrow.FindControl("txtREG_DATE");
                TextBox txtFITNESS_VALIDITY_DATE = (TextBox)gridrow.FindControl("txtFITNESS_VALIDITY_DATE");
                String REG_DATE = "";

                if (txtREG_DATE.Text == "")
                {
                    REG_DATE = "";
                }
                else
                {
                    REG_DATE = Mydate1(txtREG_DATE.Text);
                }

                String VALIDITY_DATE = "";

                if (txtFITNESS_VALIDITY_DATE.Text == "")
                {
                    VALIDITY_DATE = "";
                }
                else
                {
                    VALIDITY_DATE = Mydate1(txtFITNESS_VALIDITY_DATE.Text);
                }


                string spsq3 = "insert into WEBX_VEHDOCMST(VEHNO, VEHTYPE, VEH_DOC_TYPE,VD02C001, VD02C002, VD02C003) values ";
                spsq3 = spsq3 + "('" + DDVehicle.SelectedValue + "','" + DDveytype.SelectedValue + "','" + ddVeh_doctype.SelectedValue + "','" + txtREG_NO.Text + "','" + REG_DATE + "','" + VALIDITY_DATE + "')";
                // Response.Write("<br>" + spsq3);
                //Response.End();
                SqlCommand valCmd3 = new SqlCommand(spsq3, cn);
                valCmd3.ExecuteNonQuery();

            }

        }
        //Response.Redirect("vehicle_doc.aspx");
        cn.Close();
    }

    public string Mydate1(string strDate_time) //format given dd/mm/yyyy
    {
        if (strDate_time == "")
        {
            string fdt = "";
            return fdt;
        }
        else
        {
            string date_time = strDate_time;
            string[] arDate_time = new string[3];
            char[] split_arDate_time = { '/' };
            arDate_time = date_time.Split(split_arDate_time);

            string tempDate = "";
            int tempMonth, tempYear;
            tempMonth = 0;
            tempYear = 0;
            for (int x = 0; x < arDate_time.Length; x++)
            {
                tempDate = arDate_time[0].ToString().Trim();
                tempMonth = int.Parse(arDate_time[1]);
                tempYear = int.Parse(arDate_time[2]);
            }

            string fdt = System.Convert.ToString(tempDate) + " " + MonthName(tempMonth) + " " + System.Convert.ToString(tempYear);
            return fdt;
        }

    }

    public string MonthName(int month)
    {
        switch (month)
        {
            case 1: return ("Jan");
            case 2: return ("Feb");
            case 3: return ("Mar");
            case 4: return ("Apr");
            case 5: return ("May");
            case 6: return ("Jun");
            case 7: return ("Jul");
            case 8: return ("Aug");
            case 9: return ("Sep");
            case 10: return ("Oct");
            case 11: return ("Nov");
            case 12: return ("Dec");
            default: return ("Illegal month");
        }
    }

    

    protected void GV_D2_SelectedIndexChanged(object sender, EventArgs e)
    {

    }
}
