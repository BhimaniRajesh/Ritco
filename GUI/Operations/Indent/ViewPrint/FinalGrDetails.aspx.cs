using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class GUI_Operations_Indent_ViewPrint_FinalGrDetails : System.Web.UI.Page
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
        var objGR = new Indent();
        var objIndentController = new IndentController();

        var GrNumber = Request.QueryString["GrNumber"].ToString();
        var IndentNumber = Request.QueryString["IndentNo"].ToString();
        objGR.GrNumber = GrNumber;

        DataTable dt = objIndentController.FinalGRPendingDoketDetails(objGR);
        if (dt.Rows.Count > 0)
        {
            rptFinnalIndentPendingdocketList.DataSource = dt;
            rptFinnalIndentPendingdocketList.DataBind();
        }

    }
}