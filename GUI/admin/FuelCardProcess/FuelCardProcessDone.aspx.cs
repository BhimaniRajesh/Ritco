using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class GUI_admin_FuelCardProcess_FuelCardProcessDone : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

        if (!IsPostBack)
        {
            string[] VoucherArray = Request.QueryString["VoucherNo"].ToString().Split(',');
            DataTable dt = new DataTable();
            dt.Columns.Add("VoucherNo", typeof(string));
            for (int i = 0; i < VoucherArray.Length; i++)
            {
                dt.Rows.Add(VoucherArray[i].ToString().Trim());
            }

            if (dt.Rows.Count > 0)
            {
                grdVoucher.DataSource = dt;
                grdVoucher.DataBind();
            }
        }
    }

}