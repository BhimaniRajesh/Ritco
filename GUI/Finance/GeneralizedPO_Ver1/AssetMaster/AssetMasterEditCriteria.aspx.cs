using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Data.SqlClient;

public partial class GUI_Finance_GeneralizedPO_AssetMaster_AssetMasterEditCriteria : System.Web.UI.Page
{
    MyFunctions fn = new MyFunctions();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {                       
            fn.Fill_General_Asset_Dataset();
        }

        btnShow.Attributes.Add("onclick", " javascript:return Check_Submit_Data();");
    }
    protected void btnShow_Click(object sender, EventArgs e)
    {        
        string[] Asst_Arr = null;
        string Assetcd = "";
        if (txtassetcd.Text != "")
        {
            Asst_Arr = txtassetcd.Text.ToString().Split('~');
            Assetcd = Asst_Arr[1].ToString();
        }
        string final;        
        final = "?Assetcd=" + Assetcd.ToString();
        Response.Redirect("AssetMasterList.aspx" + final);
    }
}
