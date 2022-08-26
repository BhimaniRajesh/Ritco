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
public partial class GUI_admin_RoleMaster_RoleMaster_Step1 : System.Web.UI.Page
{
    SqlConnection Conn;
    MyFunctions fn = new MyFunctions();
    DataTable dt = new DataTable("table1");
    public static string ROLE_str = "", edit_yn = "", roleid = "", txtroleid = "", roleFlg = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        roleid = Request.QueryString["id"];
        if (!IsPostBack)
        {
            txtRows.Text = "1";
            ADDRow();
        }

        foreach (GridViewRow gridrow in grvcontrols.Rows)
        {
            TextBox txtDesignation = (TextBox)gridrow.FindControl("txtDesignation");
            if (!(Page.IsPostBack))
            {
                roleid = Request.QueryString["id"];
                if (roleid == null)
                {
                    roleid = "";
                }

                if (roleid != "" )
                {
                    RetriveData();
                    roleFlg = "Y";
                    txtDesignation.Text = roleid;
                    txtroleid = txtDesignation.Text;
                }
            }
        }
             //SqlConnection Conn;
            Conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
            Conn.Open();
            string SQLSTR = "exec Webx_CHKRole";
            SqlCommand cmd = new SqlCommand(SQLSTR, Conn);
            ROLE_str = cmd.ExecuteScalar().ToString();

    }
    private void RetriveData()
    {
        Conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        Conn.Open();

        foreach (GridViewRow gridrow in grvcontrols.Rows)
        {
            TextBox Desig = (TextBox)gridrow.FindControl("txtDesignation");
            DropDownList DLHY = (DropDownList)gridrow.FindControl("DLHY");
            CheckBox ChkId1 = (CheckBox)gridrow.FindControl("ChkId1");
            CheckBox ChkMul = (CheckBox)gridrow.FindControl("ChkMul");
            CheckBox ChkActive = (CheckBox)gridrow.FindControl("ChkActive");

            string sql = "select HYC=(select top 1 codedesc from webx_master_general where codetype='HRCHY' and codeid=Roleid),Roleid,ROledesc,Multiple,ACTIVEFLAG from Webx_Master_Role where ROledesc='" + roleid + "' ";
            SqlCommand cmd1 = new SqlCommand(sql, Conn);
               SqlDataReader dr = cmd1.ExecuteReader();

               while (dr.Read())
               {
                   Desig.Text = dr["ROledesc"].ToString();
                   DLHY.SelectedValue = dr["Roleid"].ToString();
                   if (dr["Multiple"].ToString() == "Y")
                       ChkMul.Checked = true;
                   else
                       ChkMul.Checked = false;

                   if (dr["ACTIVEFLAG"].ToString() == "Y")
                       ChkActive.Checked = true;
                   else
                       ChkActive.Checked = false;

                   ChkId1.Checked = true;
                   
               }

               dr.Close();
        }
    }
    public void ADDRow()
    {
        dt = new DataTable();


        Int16 maxrows = 0;
        if (txtRows.Text.ToString().CompareTo("") != 0)
        {
            try
            {
                maxrows = Convert.ToInt16(txtRows.Text);
            }
            catch (Exception ex)
            {
                txtRows.Text = "";
                txtRows.Focus();
            }
        }
        else
        {
            maxrows = 5;
        }
        for (int i = 0; i < maxrows; i++)
        {
            dt.Rows.Add();
        }

        grvcontrols.DataSource = dt;
        grvcontrols.DataBind();

    }
    protected void btnAdd_Click(object sender, EventArgs e)
    {


        ADDRow();
    }
    protected void grvcontrols_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
           // SqlConnection Conn;
            Conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
            Conn.Open();
            DropDownList DLHY = (DropDownList)e.Row.FindControl("DLHY");
            string SQL = "select codeid,codedesc from webx_master_general where codetype='HRCHY' and statuscode='Y'";
            SqlCommand cmd1 = new SqlCommand(SQL, Conn);
            SqlDataReader dread = cmd1.ExecuteReader();
            DLHY.Items.Clear();
            //DLHY.Items.Add(new ListItem("--Select--", ""));

                while (dread.Read())
                {
                    DLHY.Items.Add(new ListItem(dread.GetValue(1).ToString(), dread.GetValue(0).ToString()));
                }

           
            dread.Close();
            //((TextBox)e.Row.FindControl("txtAccCode")).Attributes.Add("onblur", "AccBlur('" + ((TextBox)e.Row.FindControl("txtAccCode")).ClientID.ToString() + "')");
            //((Button)e.Row.FindControl("btnAccCode")).Attributes.Add("onclick", "popuplist('AccCode','" + ((TextBox)e.Row.FindControl("txtAccCode")).ClientID.ToString() + "','none')");
            //((TextBox)e.Row.FindControl("txtAmt")).Attributes.Add("onblur", "GetTot()");
        }
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
       // SqlConnection Conn;
        Conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        Conn.Open();
        SqlTransaction trans;
        trans = Conn.BeginTransaction();
        try
        {
            foreach (GridViewRow gridrow in grvcontrols.Rows)
            {
                TextBox Desig = (TextBox)gridrow.FindControl("txtDesignation");
                DropDownList DLHY = (DropDownList)gridrow.FindControl("DLHY");
                CheckBox ChkId1 = (CheckBox)gridrow.FindControl("ChkId1");
                CheckBox ChkMul = (CheckBox)gridrow.FindControl("ChkMul");
                CheckBox ChkActive = (CheckBox)gridrow.FindControl("ChkActive");
                
                if (ChkId1.Checked = true)
                {
                    string strMul = "";
                    if (ChkMul.Checked = true)
                        strMul = "Y";
                    else
                        strMul = "N";

                          string strActive = "";
                          if (ChkActive.Checked = true)
                              strActive = "Y";
                          else
                              strActive = "N";


                    string SQLInsUpdateData="";
                    if (roleFlg != "Y")
                        SQLInsUpdateData = "insert into Webx_Master_Role(Roleid,ROledesc,Multiple,ACTIVEFLAG) values('" + DLHY.SelectedValue + "','" + Desig.Text.ToString() + "','" + strMul.ToString() + "','" + strActive + "')";
                    else
                        SQLInsUpdateData = "Update Webx_Master_Role set ROledesc='" + Desig.Text.ToString() + "',Roleid='" + DLHY.SelectedValue + "',Multiple='" + strMul.ToString() + "',ACTIVEFLAG='" + strActive + "'  where ROledesc='" + Desig.Text.ToString() + "'";
                    SqlCommand cmdIns = new SqlCommand(SQLInsUpdateData, Conn);
                    cmdIns.Transaction = trans;
                    cmdIns.ExecuteNonQuery();
                }

            }
            trans.Commit();
            Conn.Close();
            Response.Redirect("./RoleListing.aspx");
            //trans.Rollback();
            //conn.Close();
        }
        catch (Exception e1)
        {
            Response.Write("<br><br><br><font class='blackboldfnt' >Error : " + e1.Message + "</font>");
            if (e1.Message == "")
            {
                // abc = "Insert Susccessfully !!!!!!!";
            }

            trans.Rollback();


            //  conn.Close();
            Response.End();
        }
        finally
        {
            Conn.Close();
            Response.Redirect("./RoleListing.aspx");

        }
    }
}
