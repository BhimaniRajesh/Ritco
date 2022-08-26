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

public partial class GUI_Operations_GatePass_UpdateGatePassDone : System.Web.UI.Page
{


    protected void Page_Load(object sender, EventArgs e)
    {

        string gatepassnos = "";
        try
        {
            gatepassnos = Request.QueryString["gatepassnos"].ToString();
        }
        catch (Exception ex) { }

        DataTable dt = new DataTable();
        dt.Columns.Add("gatepassno", typeof(string));


        string[] arrgatepass;
        arrgatepass = gatepassnos.Split(',');

        for (int i = 0; i < arrgatepass.Length - 1; i++)
        {
            DataRow tr = dt.NewRow();
            tr["gatepassno"] = arrgatepass[i];
            dt.Rows.Add(tr);
        }

        grvdoc.DataSource = dt;
        grvdoc.DataBind();

    }
}
