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
public partial class admin_TyreSizeDet : System.Web.UI.Page
{
   // SqlConnection conn = new SqlConnection(System.Configuration.ConfigurationManager.AppSettings["dbConnection"]);

    string SIZE_ID = "", AddEditMode = "";

    protected void Page_Load(object sender, EventArgs e)
    {
        string pagetitle = System.Configuration.ConfigurationManager.AppSettings["PageTitle"];
        Response.Cache.SetCacheability(HttpCacheability.NoCache);
        Response.Cache.SetNoStore();
        Response.Cache.SetExpires(DateTime.MinValue);

        Common objCommon = new Common();
        objCommon.doCacheRoutine();
        this.Title = pagetitle;

        SIZE_ID = Request.QueryString["id"];
        if (!IsPostBack)
        {
            BindTyreType();
            if (SIZE_ID != "" && SIZE_ID != null)
            {
                lblDriverIDVal.Text = SIZE_ID;
                Inetialiazed();
                AddEditMode = "U";
                ViewState["AddEditMode"] = AddEditMode;
            }
            else
            {
                AddEditMode = "I";
                ViewState["AddEditMode"] = AddEditMode;
            }
            
            //BindTyrePattern();
        }
        txtSizeName.Attributes.Add("OnBlur", "javascript:checkTyreSize(" + txtSizeName.ClientID.ToString() + ");");
    }
    public void BindTyreType()
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        string STR = "USP_TYRETYPE";
        conn.Open();
        SqlCommand cmd = new SqlCommand(STR, conn);
        cmd.CommandType = CommandType.StoredProcedure;  
        SqlDataReader dr = cmd.ExecuteReader();
        //        ddlTyreDescription.Items.Add(new ListItem("Select", ""));

        if (dr.HasRows)
        {
            while (dr.Read())
            {
                ddlTyreType.Items.Add(new ListItem(Convert.ToString(dr["CodeDesc"]), Convert.ToString(dr["CodeId"])));
            }
        }

        dr.Close();
        conn.Close();

    }
    //public void BindTyrePattern()
    //{
    //    SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
    //    string STR = "USP_TYREPATTERN";
    //    conn.Open();
    //    SqlCommand cmd = new SqlCommand(STR, conn);
    //    cmd.CommandType = CommandType.StoredProcedure;
    //    SqlDataReader dr = cmd.ExecuteReader();

    //    //        ddlTyreDescription.Items.Add(new ListItem("Select", ""));

    //    if (dr.HasRows)
    //    {
    //        while (dr.Read())
    //        {
    //            ddlTyrePattern.Items.Add(new ListItem(Convert.ToString(dr["TYREPAT_CODE"]), Convert.ToString(dr["TYRE_PATTERNID"])));
    //        }
    //    }

    //    dr.Close();
    //    conn.Close();

    //}



    public void Inetialiazed()
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
        SqlCommand cmd2 = new SqlCommand("usp_TyreSizeData_List1", conn);

        SqlDataAdapter da = new SqlDataAdapter(cmd2);
        cmd2.CommandType = CommandType.StoredProcedure;
        cmd2.Parameters.Add("@SIZEID", SqlDbType.VarChar).Value = SIZE_ID.ToString().Trim();
        SqlDataReader dr = cmd2.ExecuteReader();
        if (dr.HasRows)
        {
            while (dr.Read())
            {

                txtSizeName.Text = dr["TYRE_SIZENAME"].ToString().Trim();
                //txtTypeEntryBy.Text = dr["TYPE_ENTRYBY"].ToString().Trim();

                ddlTyreType.SelectedValue = dr["TYRE_TYPEID"].ToString().Trim();
                string mActive = dr["SIZE_ACTIVEFLAG"].ToString();
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

        string DataFound = "N";

        string STR = "select TYRE_SIZENAME  from WEBX_FLEET_TYRESIZEMST  where TYRE_SIZENAME='" + txtSizeName.Text.ToString().Trim() + "'";
        SqlCommand cmd = new SqlCommand(STR, conn);
        SqlDataReader dr = cmd.ExecuteReader();
        if (dr.HasRows)
        {
            while (dr.Read())
            {

                DataFound = "Y";

            }

        }
        dr.Close();


        lblErrMsg.Text = "";
        AddEditMode = ViewState["AddEditMode"].ToString();

        if (AddEditMode.ToString().Trim() == "I")
        {
            SqlCommand cmd3 = new SqlCommand("usp_CreateSizeID", conn);
            cmd3.CommandType = CommandType.StoredProcedure;
            SqlDataReader dr3 = cmd3.ExecuteReader();
            if (dr3.HasRows)
            {
                while (dr3.Read())
                {
                    SIZE_ID = Convert.ToString(dr3[0]);

                }

            }

            dr3.Close();

        }




         
        if (DataFound == "Y" && AddEditMode.ToString().Trim() == "I")
        {
            lblErrMsg.Visible = true;
            lblErrMsg.Text = "This Size Name already Exists!";

        }
        else
        {

            SqlCommand cmd1 = new SqlCommand("usp_TyreS_InsertUpdate", conn);
            cmd1.CommandType = CommandType.StoredProcedure;
            SqlDataAdapter da = new SqlDataAdapter(cmd1);
            System.Globalization.DateTimeFormatInfo dtfi = new System.Globalization.DateTimeFormatInfo();
            dtfi.ShortDatePattern = "dd/MM/yyyy";
            dtfi.DateSeparator = "/";

            da.SelectCommand.Parameters.Add("@AddEditMode", SqlDbType.VarChar).Value = AddEditMode.ToString().Trim();
            da.SelectCommand.Parameters.Add("@SIZE_ID", SqlDbType.VarChar).Value = SIZE_ID.ToString().Trim();
            da.SelectCommand.Parameters.Add("@SizeName", SqlDbType.VarChar,100).Value = txtSizeName.Text.ToString().Trim();

            //  da.SelectCommand.Parameters.Add("@EntryBy", SqlDbType.VarChar).Value = txtTypeEntryBy.Text.ToString().Trim();
            da.SelectCommand.Parameters.Add("@ActiveFlag", SqlDbType.VarChar).Value = cboActive.Text.ToString().Trim();
            da.SelectCommand.Parameters.Add("@TYRE_TYPEID", SqlDbType.VarChar).Value = ddlTyreType.SelectedValue;
            //da.SelectCommand.Parameters.Add("@TYRE_PATTERNID", SqlDbType.VarChar).Value = ddlTyrePattern.SelectedValue;
            cmd1.ExecuteNonQuery();

            conn.Close();
            string SizeName = txtSizeName.Text;
            Response.Redirect("TyreSize.aspx");
            //Response.Redirect("TyreSizeResult.aspx?SizeName=" + SizeName + "&SIZE_ID=" + SIZE_ID, true);

        }


    }

}
