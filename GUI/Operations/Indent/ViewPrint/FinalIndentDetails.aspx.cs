using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class GUI_Operations_Indent_IndentView_FinalIndentDetails : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            BindRept();
        }
    }

    public void BindRept()
    {
        var objIndent = new Indent();
        var objIndentController = new IndentController();

        var IndentNo = Request.QueryString["IndentNo"].ToString();
        objIndent.IndentNumber = IndentNo;

        DataTable dt = objIndentController.FinalIndentPendingDoketDetails(objIndent);
        if (dt.Rows.Count > 0)
        {
            rptFinnalIndentPendingdocketList.DataSource = dt;
            rptFinnalIndentPendingdocketList.DataBind();
        }

    }
}