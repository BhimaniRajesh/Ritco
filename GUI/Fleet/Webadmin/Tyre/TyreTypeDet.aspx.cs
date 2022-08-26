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
public partial class admin_TyreTypeDet : System.Web.UI.Page
{
  //  SqlConnection conn = new SqlConnection(System.Configuration.ConfigurationManager.AppSettings["dbConnection"]);
 
    string   TYPE_ID = "", AddEditMode = "";

    protected void Page_Load(object sender, EventArgs e)
    {
        string pagetitle = System.Configuration.ConfigurationManager.AppSettings["PageTitle"];
        Response.Cache.SetCacheability(HttpCacheability.NoCache);
        Response.Cache.SetNoStore();
        Response.Cache.SetExpires(DateTime.MinValue);

        Common objCommon = new Common();
        objCommon.doCacheRoutine();
        this.Title = pagetitle;

        TYPE_ID = Request.QueryString["id"];
        if (!IsPostBack)
        {

            if (TYPE_ID != "" && TYPE_ID != null)
            {
              Inetialiazed();
                AddEditMode = "U";
                ViewState["AddEditMode"] = AddEditMode;
                
            }
            else
            {
                AddEditMode = "I";
                ViewState["AddEditMode"] = AddEditMode;
            }
            BindTypeDesc();
            
        }
        
    }
    public void BindTypeDesc()
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        string STR = "SELECT  CodeId,CodeDesc FROM Webx_Master_General WHERE CODETYPE ='TYTYP' UNION SELECT  '00','Select' FROM Webx_Master_General";
        conn.Open();
        SqlCommand cmd = new SqlCommand(STR, conn);
        SqlDataReader dr = cmd.ExecuteReader();
        //        ddlTyreDescription.Items.Add(new ListItem("Select", ""));

        if (dr.HasRows)
        {
            while (dr.Read())
            {
                ddlTyreDescription.Items.Add(new ListItem(Convert.ToString(dr["CodeDesc"]), Convert.ToString(dr["CodeId"])));
            }
        }

        dr.Close();
        conn.Close();

    }
    public void Inetialiazed()
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
        SqlCommand cmd2 = new SqlCommand("usp_TyreTData_List1", conn);

        SqlDataAdapter da = new SqlDataAdapter(cmd2);
        cmd2.CommandType = CommandType.StoredProcedure;
        cmd2.Parameters.Add("@TYPE_ID", SqlDbType.VarChar).Value = TYPE_ID.ToString().Trim();
        SqlDataReader dr = cmd2.ExecuteReader();
        if (dr.HasRows)
        {
            while (dr.Read())
            {

                txtTypeName.Text = dr["TYRE_TYPENAME"].ToString().Trim();
                //txtTypeEntryBy.Text = dr["TYPE_ENTRYBY"].ToString().Trim();
                
               
                string mActive = dr["TYPE_ACTIVEFLAG"].ToString();
                for (int i = 0; i < cboActive.Items.Count; i++)
                {
                    if (mActive == cboActive.Items[i].Value)
                    {
                        cboActive.SelectedIndex = i;
                    }

                }
            }
        }



        dr.Close();

        conn.Close();



    }


    protected void cmdSubmit_Click(object sender, EventArgs e)
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();

        string DataFound="N";

        string STR = "select TYRE_TYPENAME  from WEBX_FLEET_TYRETYPEMST  where TYRE_TYPENAME='" + txtTypeName.Text.ToString().Trim() + "'";
           SqlCommand cmd= new SqlCommand(STR,conn);
        SqlDataReader  dr= cmd.ExecuteReader();
        if(dr.HasRows)
        {
            while(dr.Read())
            {

                DataFound="Y";

            }

        }
        dr.Close();


        lblErrMsg.Text="";
        AddEditMode = ViewState["AddEditMode"].ToString();

        if (AddEditMode.ToString().Trim() == "I")
        {
            SqlCommand cmd3 = new SqlCommand("usp_CreateTypeID", conn);
            cmd3.CommandType = CommandType.StoredProcedure;
            SqlDataReader dr3 = cmd3.ExecuteReader();
            if (dr3.HasRows)
            {
                while (dr3.Read())
                {
                    TYPE_ID = Convert.ToString(dr3[0]);

                }

            }

            dr3.Close();

        }


        //if(DataFound=="N")
        //{


    
        //}
        if (DataFound == "Y" && AddEditMode.ToString().Trim() == "I")
        {
            lblErrMsg.Visible = true;
            lblErrMsg.Text = "This Type Name Already Exists!";

        }

        else
        {

            SqlCommand cmd1 = new SqlCommand("usp_TyreT_InsertUpdate", conn);
            cmd1.CommandType = CommandType.StoredProcedure;
            SqlDataAdapter da = new SqlDataAdapter(cmd1);
            System.Globalization.DateTimeFormatInfo dtfi = new System.Globalization.DateTimeFormatInfo();
            dtfi.ShortDatePattern = "dd/MM/yyyy";
            dtfi.DateSeparator = "/";


            da.SelectCommand.Parameters.Add("@AddEditMode", SqlDbType.VarChar).Value = AddEditMode.ToString().Trim();
            da.SelectCommand.Parameters.Add("@TYPE_ID", SqlDbType.VarChar).Value = TYPE_ID.ToString().Trim();
            da.SelectCommand.Parameters.Add("@TypeName", SqlDbType.VarChar).Value = txtTypeName.Text.ToString().Trim();

            //  da.SelectCommand.Parameters.Add("@EntryBy", SqlDbType.VarChar).Value = txtTypeEntryBy.Text.ToString().Trim();
            da.SelectCommand.Parameters.Add("@ActiveFlag", SqlDbType.VarChar).Value = cboActive.Text.ToString().Trim();
            da.SelectCommand.Parameters.Add("@TYPE_DESC", SqlDbType.VarChar).Value = ddlTyreDescription.SelectedValue;


            cmd1.ExecuteNonQuery();



            conn.Close();
            string TypeName = txtTypeName.Text;

            Response.Redirect("TypeResult.aspx?TypeName=" + TypeName + "&TYPE_ID=" + TYPE_ID, true);
        }
    
    }

}
