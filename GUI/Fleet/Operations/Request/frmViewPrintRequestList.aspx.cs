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
using System.Text; // added for Export to Excel
using System.IO; //added for Export to Excel
using System.Reflection; //added for Export to Excel


public partial class Request_frmViewPrintRequestList : System.Web.UI.Page
{
    //SqlConnection conn = new SqlConnection(System.Configuration.ConfigurationManager.AppSettings["dbConnection"]);

    public MyFleetDataSet _dataSet = new MyFleetDataSet();
    int _lastEditedPage;
    MyFleetDataSet.RequestDetRow datarow;

    Hashtable htControls = new Hashtable();////added for Export to Excel

    protected void Page_Load(object sender, EventArgs e)
    {

        htControls.Add("LinkButton", "Text"); //added for Export to Excel
        htControls.Add("HyperLink", "Text"); //added for Export to Excel
        htControls.Add("DropDownList", "SelectedItem"); //added for Export to Excel
        htControls.Add("CheckBox", "Checked"); //added for Export to Excel


        
        if (!IsPostBack)
        {
            BindGrid();
        }

    }


    private void BindGrid()
    {
        lblError.Text = "";
        //string DataFound = "N";



        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();


        string sql = "usp_RequestViewPrintList";
        SqlCommand cmd = new SqlCommand(sql, conn);
        cmd.CommandType = CommandType.StoredProcedure;


        string strReqId = Request.QueryString["RequestId"].ToString().Trim();
        string strReqFromDt = Request.QueryString["FromDt"].ToString().Trim();
        string strReqToDt = Request.QueryString["ToDt"].ToString().Trim();

        cmd.Parameters.AddWithValue("@ReqId", strReqId);
        cmd.Parameters.AddWithValue("@ReqFromDt", strReqFromDt);
        cmd.Parameters.AddWithValue("@ReqToDt", strReqToDt);


        DataGrid1.DataSource = cmd.ExecuteReader(CommandBehavior.CloseConnection);
        DataGrid1.DataBind();


        conn.Close();
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

    


    protected void DataGrid1_ItemCommand(object source, DataGridCommandEventArgs e)
    {

    }

    protected void DataGrid1_ItemDataBound(object sender, DataGridItemEventArgs e)
    {

      
    }



    protected void Button1_Click(object sender, EventArgs e)
    {

        //Export the GridView to Excel

        PrepareGridViewForExport(DataGrid1);

        ExportGridView();

    }


    private void ExportGridView()
    {

        string attachment = "attachment; filename=RequestList.xls";

        Response.ClearContent();

        Response.AddHeader("content-disposition", attachment);

        Response.ContentType = "application/ms-excel";

        StringWriter sw = new StringWriter();

        HtmlTextWriter htw = new HtmlTextWriter(sw);

        DataGrid1.RenderControl(htw);

        Response.Write(sw.ToString());

        Response.End();

    }



    public override void VerifyRenderingInServerForm(Control control)
    {

    }

    private void PrepareGridViewForExport(Control gv)
    {

        Literal l = new Literal();

        for (int i = 0; i < gv.Controls.Count; i++)
        {

            if ((null != htControls[gv.Controls[i].GetType().Name]) || (null != htControls[gv.Controls[i].GetType

               ().BaseType.Name]))
            {

                l.Text = GetControlPropertyValue(gv.Controls[i]);

                gv.Controls.Remove(gv.Controls[i]);

                gv.Controls.AddAt(i, l);

            }

            if (gv.Controls[i].HasControls())
            {

                PrepareGridViewForExport(gv.Controls[i]);

            }

        }

    }

    private string GetControlPropertyValue(Control control)
    {

        Type controlType = control.GetType();

        string strControlType = controlType.Name;

        string strReturn = "Error";

        bool bReturn;



        PropertyInfo[] ctrlProps = controlType.GetProperties();

        string ExcelPropertyName = (string)htControls[strControlType];

        if (ExcelPropertyName == null)
        {

            ExcelPropertyName = (string)htControls[control.GetType().BaseType.Name];

            if (ExcelPropertyName == null)

                return strReturn;

        }

        foreach (PropertyInfo ctrlProp in ctrlProps)
        {

            if (ctrlProp.Name == ExcelPropertyName &&

            ctrlProp.PropertyType == typeof(String))
            {

                try
                {

                    strReturn = (string)ctrlProp.GetValue(control, null);

                    break;

                }

                catch
                {

                    strReturn = "";

                }

            }

            if (ctrlProp.Name == ExcelPropertyName &&

            ctrlProp.PropertyType == typeof(bool))
            {

                try
                {

                    bReturn = (bool)ctrlProp.GetValue(control, null);

                    strReturn = bReturn ? "True" : "False";

                    break;

                }

                catch
                {

                    strReturn = "Error";

                }

            }

            if (ctrlProp.Name == ExcelPropertyName &&

            ctrlProp.PropertyType == typeof(ListItem))
            {

                try
                {

                    strReturn = ((ListItem)(ctrlProp.GetValue(control, null))).Text;

                    break;

                }

                catch
                {

                    strReturn = "";

                }

            }

        }

        return strReturn;

    }


}
