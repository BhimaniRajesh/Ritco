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

public partial class GUI_Finance_re_assign_vendor_code_Main : System.Web.UI.Page
{
    public DataSet1 _dataSet = new DataSet1();
    int _lastEditedPage;
    SqlConnection conn;
    public string edit_yn = "", editcodeid = "", sql;
    public string sqlChange, VendorCode, VendorName, sqlAccount = "";
    MyFunctions fn = new MyFunctions();


    protected void Page_Load(object sender, EventArgs e)
    {
        lblError.Visible = false;
        try
        {
            if (!IsPostBack && !IsCallback)
            {
                roww.Text = "1";
                Inetialized();
            }
        }
        catch (Exception ex)
        {
            throw;
        }
    }

    protected void roww_TextChanged(object sender, EventArgs e)
    {
        _dataSet.WorkExperianceData.Clear();
        int rowno;
        if ((roww.Text == "") || (roww.Text == "0"))
        {
            roww.Text = "1";
        }
        rowno = Convert.ToInt32(roww.Text);
        for (int i = 0; i < rowno; i++)
        {
            _dataSet.WorkExperianceData.AddWorkExperianceDataRow("", "", "", "", "", "", "", "", "", "", "");
            BindGrid();
        }

    }
    private void BindGrid()
    {
        btnSubmit.Visible = true;
        GridVendor.DataSource = _dataSet.WorkExperianceData;
        GridVendor.DataBind();
        _lastEditedPage = GridVendor.PageIndex;
    }
    private void Inetialized()
    {
        _dataSet.WorkExperianceData.AddWorkExperianceDataRow("", "", "", "", "", "", "", "", "", "", "");
    }
    protected void GridVendor_OnRowDataBound(object sender, GridViewRowEventArgs e)
    {

        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            TextBox txtNewVendor = (TextBox)(e.Row.FindControl("txtNewVendor"));
            ((Button)(e.Row.FindControl("btncodepopup"))).Attributes.Add("onclick", "javascript:return nwOpen2('" + txtNewVendor.ClientID.ToString() + "')");
        }
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();

        SqlTransaction trn;
        trn = conn.BeginTransaction();

        try
        {
            foreach (GridViewRow gridrow in GridVendor.Rows)
            {
                TextBox txtDocumentNo = (TextBox)gridrow.FindControl("txtDocumentNo");
                TextBox txtNewVendor = (TextBox)gridrow.FindControl("txtNewVendor");
                TextBox txtNewVehNo = (TextBox)gridrow.FindControl("txtNewVehNo");

                VendorCode = txtNewVendor.Text;
                VendorName = fn.GetVendor(VendorCode.ToString().Trim());


                if (txtDocumentNo.Text != "")
                {
                    if (VendorName != "")
                    {
                        string[] Split = VendorName.Split(new Char[] { ':' });
                        VendorName = Convert.ToString(Split[1]);
                    }
                    if (cboDocumentType.SelectedItem.Text == "THC")
                    {
                        sqlChange = "update webx_THC_Summary set vendor_code='" + VendorCode.ToString() + "',vendorcode='" + VendorCode.ToString() + "',vendor_name='" + VendorName.ToString().Trim() + "',vehno='" + txtNewVehNo.Text + "' where thcno='" + txtDocumentNo.Text + "'";
                    }
                    else
                    {
                        sqlChange = "update webx_PDCHDR set vendorcode='" + VendorCode.ToString() + "',vendorname='" + VendorName.ToString().Trim() + "',vehno='" + txtNewVehNo.Text + "' where PDCNO='" + txtDocumentNo.Text + "'";
                    }
                    //SqlCommand cmd = new SqlCommand(sqlChange, conn, trn);
                    //cmd.ExecuteNonQuery();

                    SqlHelper.ExecuteNonQuery(trn, CommandType.Text, sqlChange);

                    sqlAccount = "update webx_acctrans_09_10 set PBOV_CODE='" + VendorCode.ToString() + "',PBOV_NAME='" + VendorName.ToString().Trim() + "' where DOCNO='" + txtDocumentNo.Text + "'";
                    //cmd = new SqlCommand(sqlAccount, conn);
                    //cmd.ExecuteNonQuery();
                    SqlHelper.ExecuteNonQuery(trn, CommandType.Text, sqlAccount);

                    sqlAccount = "update webx_acctrans_10_11 set PBOV_CODE='" + VendorCode.ToString() + "',PBOV_NAME='" + VendorName.ToString().Trim() + "' where DOCNO='" + txtDocumentNo.Text + "'";
                    //cmd = new SqlCommand(sqlAccount, conn);
                    //cmd.ExecuteNonQuery();
                    SqlHelper.ExecuteNonQuery(trn, CommandType.Text, sqlAccount);

                    trn.Commit();
                    //trn.Rollback();  
                    if (conn.State == ConnectionState.Open)
                        conn.Close();
                    Response.Redirect("./VendorCodeDone.aspx",false);
                }
            }
        }
        catch (Exception ex)
        {
            //Response.Write("<br><br><br><center><font class='blackboldfnt' color='red'><b>Error : " + ex.Message + "</b></font></center>");
            string msg = ex.Message.ToString();
            msg = msg.Replace('\n', ' ');
            trn.Rollback();
            if (conn.State == ConnectionState.Open)
                conn.Close();
            lblError.Text = msg;
            lblError.Visible = true;
        }
    }
}
