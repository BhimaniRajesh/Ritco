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
using Microsoft.ApplicationBlocks.Data;
public partial class GUI_admin_commonPopUp : System.Web.UI.Page
{
    string connStr;
    string CodeFieldName, DescFieldName, TableName;
    //string ctrCode, ctrName;
    string popuptype = "";
    SqlDataReader rdr;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            //ctrCode = "";
            //ctrName = "";
            connStr = Session["SqlProvider"].ToString().Trim();
            popuptype = Request.QueryString["popuptype"];
            /////////////////////////////On Load Data////////////////////////////////////////////////////////////////
            //string sql;
            //SqlDataReader rdr;
            switch (popuptype)
            {
                case "1" :
                    lblpoptype1.Text = " Account ";
                    lblpoptype2.Text = " Account ";

                    lblCode.Text = "Account Code :";
                    lblName.Text = "Account Name :";
                    CodeFieldName = " Company_Acccode";
                    DescFieldName = " Accdesc";
                    TableName = " WebX_Acctinfo";

            //        sql = "select " + CodeFieldName + " as code," + DescFieldName + " as Name from  " + TableName + " order by " + CodeFieldName;

            //        rdr = SqlHelper.ExecuteReader(connStr, CommandType.Text, sql);
            //        dgGeneral.DataSource = rdr;
            //        dgGeneral.DataBind();
            //        rdr.Close();
                    break;
                case "2":
                    lblpoptype1.Text = " Vendor ";
                    lblpoptype2.Text = " Vendor ";

                    lblCode.Text = "Vendor Code :";
                    lblName.Text = "vendor Name :";
                    CodeFieldName = " VENDORCODE";
                    DescFieldName = " VENDORNAME";
                    TableName = " webx_vendor_hdr";

            //        sql = "select " + CodeFieldName + " as code," + DescFieldName + " as Name from  " + TableName + " order by " + CodeFieldName;
            //        // string sql = "select " + CodeFieldName + " as code," + DescFieldName + " as Name from  " + TableName + " order by " + CodeFieldName;


            //        rdr = SqlHelper.ExecuteReader(connStr, CommandType.Text, sql);
            //        dgGeneral.DataSource = rdr;
            //        dgGeneral.DataBind();
            //        rdr.Close();
                    break;
                case "3":
                    lblpoptype1.Text = " Customer ";
                    lblpoptype2.Text = " Customer ";

                    lblCode.Text = "Customer Code :";
                    lblName.Text = "Customer Name :";
                    CodeFieldName = " CUSTCD";
                    DescFieldName = " CUSTNM";
                    TableName = " webx_custhdr";

            //        sql = "select " + CodeFieldName + " as code," + DescFieldName + " as Name from  " + TableName + " order by " + CodeFieldName;
            //        // string sql = "select " + CodeFieldName + " as code," + DescFieldName + " as Name from  " + TableName + " order by " + CodeFieldName;


            //        rdr = SqlHelper.ExecuteReader(connStr, CommandType.Text, sql);
            //        dgGeneral.DataSource = rdr;
            //        dgGeneral.DataBind();
            //        rdr.Close();
                    break;
                case "4": // Branch Master 
                    lblpoptype1.Text = " Location ";
                    lblpoptype2.Text = " Location ";

                    lblCode.Text = "Location Code :";
                    lblName.Text = "Location Name :";
                    CodeFieldName = " loccode";
                    DescFieldName = " locName";
                    TableName = " webx_location";

            //        sql = "select " + CodeFieldName + " as code," + DescFieldName + " as Name from  " + TableName + " order by " + CodeFieldName;
            //        // string sql = "select " + CodeFieldName + " as code," + DescFieldName + " as Name from  " + TableName + " order by " + CodeFieldName;


            //        rdr = SqlHelper.ExecuteReader(connStr, CommandType.Text, sql);
            //        dgGeneral.DataSource = rdr;
            //        dgGeneral.DataBind();
            //        rdr.Close();
                    break;
                 }
        }
    }
    public void submitData(object sender, EventArgs e)
    {
        connStr = Session["SqlProvider"].ToString().Trim();
        popuptype = Request.QueryString["popuptype"];
        if (txtCode.Text != "" || txtName.Text != "")
        {
            
            switch (popuptype)
            {
                case "1":
                    lblpoptype1.Text = " Account ";
                    lblpoptype2.Text = " Account ";

                    lblCode.Text = "Account Code :";
                    lblName.Text = "Account Name :";
                    CodeFieldName = " Company_Acccode";
                    DescFieldName = " Accdesc";
                    TableName = " WebX_Acctinfo";
                    break;
                case "2":
                    lblpoptype1.Text = " Vendor ";
                    lblpoptype2.Text = " Vendor ";

                    lblCode.Text = "Vendor Code :";
                    lblName.Text = "vendor Name :";
                    CodeFieldName = " VENDORCODE";
                    DescFieldName = " VENDORNAME";
                    TableName = " webx_vendor_hdr";
                    break;
                case "3":
                    lblpoptype1.Text = " Customer ";
                    lblpoptype2.Text = " Customer ";

                    lblCode.Text = "Customer Code :";
                    lblName.Text = "Customer Name :";
                    CodeFieldName = " CUSTCD";
                    DescFieldName = " CUSTNM";
                    TableName = " webx_custhdr";
                    break;
                case "4":
                    lblpoptype1.Text = " Location ";
                    lblpoptype2.Text = " Location ";

                    lblCode.Text = "Location Code :";
                    lblName.Text = "Location Name :";
                    CodeFieldName = " loccode";
                    DescFieldName = " locName";
                    TableName = " webx_location";
                    break;
            }

            string codeCls, DescCls;
            codeCls = "";
            DescCls = "";
            if (txtCode.Text != "")
                codeCls = CodeFieldName + " like '" + txtCode.Text + "%'";
            else
            {
                if (txtName.Text != "")
                    DescCls = DescFieldName + " like '" + txtName.Text + "%'";
            }

            string sql = "select " + CodeFieldName + " as code," + DescFieldName + " as Name from  " + TableName + " where " + codeCls + DescCls + " order by " + CodeFieldName;

            SqlDataReader rdr = SqlHelper.ExecuteReader(connStr, CommandType.Text, sql);

            dgGeneral.DataSource = rdr;
            dgGeneral.DataBind();
            rdr.Close();
        }
        else
        {
            switch (popuptype)
            {
                case "1":
                    lblpoptype1.Text = " Account ";
                    lblpoptype2.Text = " Account ";

                    lblCode.Text = "Account Code :";
                    lblName.Text = "Account Name :";
                    CodeFieldName = " Company_Acccode";
                    DescFieldName = " Accdesc";
                    TableName = " WebX_Acctinfo";

                    string sql = "select " + CodeFieldName + " as code," + DescFieldName + " as Name from  " + TableName + " order by " + CodeFieldName;

                    rdr = SqlHelper.ExecuteReader(connStr, CommandType.Text, sql);
                    dgGeneral.DataSource = rdr;
                    dgGeneral.DataBind();
                    rdr.Close();
                    break;
                case "2":
                    lblpoptype1.Text = " Vendor ";
                    lblpoptype2.Text = " Vendor ";

                    lblCode.Text = "Vendor Code :";
                    lblName.Text = "vendor Name :";
                    CodeFieldName = " VENDORCODE";
                    DescFieldName = " VENDORNAME";
                    TableName = " webx_vendor_hdr";

                    string sql1 = "select " + CodeFieldName + " as code," + DescFieldName + " as Name from  " + TableName + " order by " + CodeFieldName;
                    // string sql = "select " + CodeFieldName + " as code," + DescFieldName + " as Name from  " + TableName + " order by " + CodeFieldName;


                    rdr = SqlHelper.ExecuteReader(connStr, CommandType.Text, sql1);
                    dgGeneral.DataSource = rdr;
                    dgGeneral.DataBind();
                    rdr.Close();
                    break;
                case "3":
                    lblpoptype1.Text = " Customer ";
                    lblpoptype2.Text = " Customer ";

                    lblCode.Text = "Customer Code :";
                    lblName.Text = "Customer Name :";
                    CodeFieldName = " CUSTCD";
                    DescFieldName = " CUSTNM";
                    TableName = " webx_custhdr";

                    string sql2 = "select " + CodeFieldName + " as code," + DescFieldName + " as Name from  " + TableName + " order by " + CodeFieldName;
                    // string sql = "select " + CodeFieldName + " as code," + DescFieldName + " as Name from  " + TableName + " order by " + CodeFieldName;


                    rdr = SqlHelper.ExecuteReader(connStr, CommandType.Text, sql2);
                    dgGeneral.DataSource = rdr;
                    dgGeneral.DataBind();
                    rdr.Close();
                    break;
                case "4": // Branch Master 
                    lblpoptype1.Text = " Location ";
                    lblpoptype2.Text = " Location ";

                    lblCode.Text = "Location Code :";
                    lblName.Text = "Location Name :";
                    CodeFieldName = " loccode";
                    DescFieldName = " locName";
                    TableName = " webx_location";

                    string sql3 = "select " + CodeFieldName + " as code," + DescFieldName + " as Name from  " + TableName + " order by " + CodeFieldName;
                    // string sql = "select " + CodeFieldName + " as code," + DescFieldName + " as Name from  " + TableName + " order by " + CodeFieldName;


                    rdr = SqlHelper.ExecuteReader(connStr, CommandType.Text, sql3);
                    dgGeneral.DataSource = rdr;
                    dgGeneral.DataBind();
                    rdr.Close();
                    break;
            }
        }

    }
    protected void dgGeneral_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            string strScript;
            LinkButton l1;
            switch (popuptype)
            {
                case "1":
                    strScript = "javascrit:window.opener.document.forms[0]." +
                                   Request.QueryString["ctrCodeName"] + ".value = '";
                    strScript += e.Row.Cells[1].Text.ToString() + "';";
                    strScript += "window.opener.document.forms(0)." +
                                    Request.QueryString["ctrDescName"].ToString() + ".value = '";
                    strScript += e.Row.Cells[2].Text.ToString() + "';";
                    l1 = (LinkButton)e.Row.FindControl("selectCode");
                    l1.Attributes.Add("onclick", strScript);
                    
                    break;
                case "2":
                    strScript = "javascrit:window.opener.document.forms[0]." +
                                  Request.QueryString["ctrCodeName"] + ".value = '";
                    strScript += e.Row.Cells[1].Text.ToString() + "';";
                    l1 = (LinkButton)e.Row.FindControl("selectCode");
                    l1.Attributes.Add("onclick", strScript);
                    break;
                case "3":
                    strScript = "javascrit:window.opener.document.forms[0]." +
                                  Request.QueryString["ctrCodeName"] + ".value = '";
                    strScript += e.Row.Cells[1].Text.ToString() + "';";
                    l1 = (LinkButton)e.Row.FindControl("selectCode");
                    l1.Attributes.Add("onclick", strScript);
                    break;
                case "4":
                    strScript = "javascrit:window.opener.document.forms[0]." +
                                  Request.QueryString["ctrCodeName"] + ".value = '";
                    strScript += e.Row.Cells[1].Text.ToString() + "';";
                    l1 = (LinkButton)e.Row.FindControl("selectCode");
                    l1.Attributes.Add("onclick", strScript);
                    break;
            }
            
        }
    }
}
