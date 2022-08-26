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
using System.Data.Sql;
using System.Data.SqlClient;
using Microsoft.ApplicationBlocks.Data;

public partial class frm_Popup_City : System.Web.UI.Page
{
    public string CtrlID = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        CtrlID = Request.QueryString["CtrlID"].ToString();
        if (!IsPostBack)
        {
            //hf_Opener_Location.Value = Request.QueryString["Opener_Location"].ToString();
        }
    }

    protected void btn_Submit_Click(object sender, EventArgs e)
    {
        string qry = "SELECT * FROM Webx_CityMaster Where ISNULL(ActiveFlag,'Y')='Y' AND Location like '"+ tb_Location_Name.Text.Trim() +"%' ORDER BY Location";
        DataSet ds = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, qry);
        dl_Location.DataSource = ds.Tables[0];
        dl_Location.DataBind();
    }
}
