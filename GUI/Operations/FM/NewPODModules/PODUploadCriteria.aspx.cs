using System;
using WebX.Controllers;

public partial class GUI_Operations_FM_NewPODModules_PODUploadCriteria : System.Web.UI.Page
{
    public string brcd, empcd, selyear, dkt_Call;

    protected void Page_Load(object sender, EventArgs e)
    {
        brcd = Session["brcd"].ToString();
        empcd = Session["empcd"].ToString();
        dkt_Call = Session["DocketCalledAs"].ToString();


        if (!IsPostBack && !IsCallback)
        {
            //ddlLocation.DataSource = SqlHelper.ExecuteDataset(Session["SqlProvider"].ToString().Trim(), CommandType.StoredProcedure, "usp_locations_all_ver1").Tables[0];
            //ddlLocation.DataBind();
            var obj = new NewPODModuleController();
            ddlLocation.DataSource = obj.GetAllLocationLoginBranchWise(Session["brcd"].ToString(), Session["mainbrcd"].ToString());
            ddlLocation.DataBind();
        }
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        string QS = "PODUploadMain.aspx?";
        QS += "FromDate=" + DT.DateFrom.ToString("dd MMM yyyy");
        QS += "&ToDate=" + DT.DateTo.ToString("dd MMM yyyy");
        QS += "&Location=" + ddlLocation.SelectedValue;
        QS += "&DocketNo=" + txtdocno.Text;
        Response.Redirect(QS, false);
    }
}
