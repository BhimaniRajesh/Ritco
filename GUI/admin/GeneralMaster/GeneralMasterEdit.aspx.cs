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
using Microsoft.ApplicationBlocks.Data;

public partial class GUI_admin_GeneralMaster_GeneralMasterEdit : System.Web.UI.Page
{

    string mastercode = ""; //, statuscode, mastertype, headeraccess;
    int i = 0;
    SqlConnection con;

    protected void Page_Load(object sender, EventArgs e)
    {

        mastercode = Request.QueryString["mastercode"].ToString();
        con = new SqlConnection(Session["SqlProvider"].ToString().Trim());

        //string s = "SELECT * FROM webx_master_codetypes WHERE headercode='" + mastercode + "' AND activeflag_YN='Y'";
        //con.Open();
        //SqlCommand cd = new SqlCommand(s, con);
        //SqlDataReader dr = cd.ExecuteReader();
        //dr.Read();
        //lblmasterheader.Text = dr["headerdesc"].ToString();
        //lblheadcode.Text = dr["id_desc"].ToString();
        //lblheaddesc.Text = dr["name_desc"].ToString();
        //dr.Close();

        if (!IsPostBack)
        {
            bindgrid();
        }
        //cd = new SqlCommand(s, con);
        //dr = cd.ExecuteReader();

        //while (dr.Read())
        //{
        //    TableRow tr = new TableRow();

        //    TableCell tccode = new TableCell();
        //    TableCell tcdesc = new TableCell();
        //    TableCell tcedit = new TableCell();
        //    TableCell tcdele = new TableCell();

        //    Label lblcode = new Label();
        //    Label lbldesc = new Label();
        //    TextBox txtdesc = new TextBox();
        //    Button btnedit = new Button();
        //    Button btnsave = new Button();
        //    Button btndele = new Button();

        //    lblcode.ID = "lblcode" + dr["codeid"].ToString();
        //    lbldesc.ID = "lbldesc" + dr["codeid"].ToString();
        //    txtdesc.ID = "txtdesc" + dr["codeid"].ToString();
        //    btnedit.ID = "btnedit" + dr["codeid"].ToString();
        //    btnsave.ID="btnsave" + dr["codeid"].ToString();
        //    btndele.ID = "btndele" + dr["codeid"].ToString();

        //    btndele.Attributes.Add("onclick", "javascript:return confirmDel()");
        //    btndele.Style["cursor"] = "pointer";
        //    btnedit.Style["cursor"] = "pointer";
        //    btnsave.Style["cursor"] = "pointer";

        //    lblcode.Text = dr["codeid"].ToString();
        //    lbldesc.Text = dr["codedesc"].ToString();
        //    btnedit.Text = "Edit";
        //    btnsave.Text = "Save";
        //    btndele.Text = "Delete";

        //    lblcode.CssClass = "blackfnt";
        //    lbldesc.CssClass = "blackfnt";
        //    txtdesc.CssClass = "blackfnt";
        //    btnedit.CssClass = "blackfnt";
        //    btnsave.CssClass = "blackfnt";
        //    btndele.CssClass = "redfnt";

        //    btnedit.Click += new System.EventHandler(editClick);
        //    btnsave.Click += new System.EventHandler(saveClick);
        //    btndele.Click += new System.EventHandler(deleClick);

        //    txtdesc.Style["display"] = "none";
        //    btnsave.Style["display"] = "none";

        //    tccode.Controls.Add(lblcode);
        //    tcdesc.Controls.Add(lbldesc);
        //    tcdesc.Controls.Add(txtdesc);
        //    tcedit.Controls.Add(btnedit);
        //    tcedit.Controls.Add(btnsave);
        //    tcdele.Controls.Add(btndele);

        //    tr.BackColor = System.Drawing.Color.White;

        //    tr.Cells.Add(tccode);
        //    tr.Cells.Add(tcdesc);
        //    tr.Cells.Add(tcedit);
        //    tr.Cells.Add(tcdele);

        //    tblitemlist.Rows.Add(tr);
        //}
        //dr.Close();       
    }

    private void bindgrid()
    {
        DataTable dtgeneral;

        try
        {
            string strsql = "SELECT CodeId, CodeDesc, StatusCode FROM webx_master_general WHERE codetype='" + mastercode + "' order by CodeDesc";
            dtgeneral = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, strsql).Tables[0];

            grvgeneral.DataSource = dtgeneral;
            grvgeneral.DataBind();
        }
        catch (Exception exp)
        {
            throw exp;
        }
    }

    public void grvgeneral_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            DataRow dr = (e.Row.DataItem as DataRowView).Row as DataRow;

            CheckBox chkactive = (CheckBox)e.Row.FindControl("chkactive");
            HiddenField hdnactive = (HiddenField)e.Row.FindControl("hdnactive");

            //HiddenField hdnoriginalactive = (HiddenField)e.Row.FindControl("hdnoriginalactive");
            HiddenField hdnoriginalcodedesc = (HiddenField)e.Row.FindControl("hdnoriginalcodedesc");

            hdnactive.Value = (WebXConvert.ToBoolean(dr["statuscode"].ToString()).ToString().ToLower());

            //hdnoriginalactive.Value = dr["statuscode"].ToString();
            hdnoriginalcodedesc.Value = dr["codedesc"].ToString();

            if (dr["statuscode"].ToString() == "Y")
            {
                chkactive.Checked = true;
            }

            Label lblcodedesc = (Label)e.Row.FindControl("lblcodedesc");
            TextBox txtcodedesc = (TextBox)e.Row.FindControl("txtcodedesc");
            Label lblmodified = (Label)e.Row.FindControl("lblmodified");
            HiddenField hdnchange = (HiddenField)e.Row.FindControl("hdnchanged");

            txtcodedesc.Style["display"] = "none";

            txtcodedesc.Attributes.Add("onblur", "javascript:return alterDisplay('0','" + txtcodedesc.ClientID + "','" + lblcodedesc.ClientID + "','" + chkactive.ClientID + "','" + hdnactive.ClientID + "','" + hdnoriginalcodedesc.ClientID + "','" + lblmodified.ClientID + "','" + hdnchange.ClientID + "')");
            lblcodedesc.Attributes.Add("onclick", "javascript:return alterDisplay('0','" + txtcodedesc.ClientID + "','" + lblcodedesc.ClientID + "','" + chkactive.ClientID + "','" + hdnactive.ClientID + "','" + hdnoriginalcodedesc.ClientID + "','" + lblmodified.ClientID + "','" + hdnchange.ClientID + "')");

            chkactive.Attributes.Add("onclick", "javascript:return alterDisplay('1','" + txtcodedesc.ClientID + "','" + lblcodedesc.ClientID + "','" + chkactive.ClientID + "','" + hdnactive.ClientID + "','" + hdnoriginalcodedesc.ClientID + "','" + lblmodified.ClientID + "','" + hdnchange.ClientID + "')");
        }
    }

    protected void submit_Click(object sender, EventArgs e)
    {
        string strsql = "";

        try
        {
            foreach (GridViewRow gvrow in grvgeneral.Rows)
            {
                HiddenField hdn = (HiddenField)gvrow.FindControl("hdnchanged");
                if (hdn.Value.ToString() == "1")
                {
                    CheckBox chkactive = (CheckBox)gvrow.FindControl("chkactive");
                    TextBox txtcodedesc = (TextBox)gvrow.FindControl("txtcodedesc");
                    Label lblcodeid = (Label)gvrow.FindControl("lblcodeid");
                    strsql = "UPDATE webx_master_general ";
                    strsql = strsql + "SET codedesc = '" + txtcodedesc.Text.Trim() + "',";
                    strsql = strsql + "statuscode = '" + WebXConvert.ToY_N(chkactive.Checked) + "' ";
                    strsql = strsql + "WHERE codeid = '" + lblcodeid.Text + "' AND codetype = '" + mastercode + "'";

                    SqlHelper.ExecuteNonQuery(SessionUtilities.ConnectionString, CommandType.Text, strsql);
                }
            }
            Response.Redirect("MasterList.aspx");
        }
        catch (Exception exp)
        {
            throw exp;
        }
    }
   
}
