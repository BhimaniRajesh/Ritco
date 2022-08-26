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
 

public partial class GUI_admin_CustomerGroupMaster_CustomerGroupMasterAdd : System.Web.UI.Page
{
    SqlConnection cn;  // = new SqlConnection(ConfigurationManager.AppSettings["dbConn"].ToString());
    SqlCommand cmd = new SqlCommand();
    SqlDataReader drGrpcd, drBrcd;
    string grpcd = "";
    object[] b = null;
    protected void Page_Load(object sender, EventArgs e)
    {
        getstring();
        cn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
    }
    protected void chk1_CheckedChanged(object sender, EventArgs e)
    {
        if (chk1.Checked == true)
        {
            txtActFlag.Text = "Y";
        }
        else
        {
            txtActFlag.Text = "N";
        }
    }


    private void getstring()
    {
        //holidaystr = "";
        SqlConnection cn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        cn.Open();
        string sql = "SELECT GRPNM  FROM  webx_GRPMST";
        SqlCommand sqlCommand = new SqlCommand(sql, cn);
        SqlDataReader dr_Location;
        dr_Location = sqlCommand.ExecuteReader();
        while (dr_Location.Read())
        {
            Page.RegisterArrayDeclaration("str", "'" + Convert.ToString(dr_Location["GRPNM"] + "'"));
        }
        dr_Location.Close();
    }
    

    public string getNewCd(string mPrfx)
    {
        string myNewCd = null;
        string val = null;
        int valLength = 0;
        string vLength;
        // cn.Open();
        //SqlCommand cmdGet = new SqlCommand("select max(right(grpcd, 4)) from webx_GRPMST  where locregion=''", cn);
        SqlCommand cmdGet = new SqlCommand("select max(right(grpcd, 4)) from webx_GRPMST where len(grpcd)=5", cn);
        SqlDataReader drGet = cmdGet.ExecuteReader();
        if (drGet.Read())
        {
            val = drGet[0].ToString();
            if (val == null || val == "")
            {
                valLength = 0;
            }
            else
            {
                valLength = Convert.ToInt32(val);
            }
            //valLength = Convert.ToInt32(val);
            valLength = valLength + 1;
        }

        drGet.Close();
        //cn.Close();
        vLength = Convert.ToString(valLength);
        //vLength = vLength.Length + "1";
        if (vLength.Length == 1)
        {
            myNewCd = mPrfx + "000" + vLength;
        }
        if (vLength.Length == 2)
        {
            myNewCd = mPrfx + "00" + vLength;
        }
        if (vLength.Length == 3)
        {
            myNewCd = mPrfx + "0" + vLength;
        }
        if (vLength.Length == 4)
        {
            myNewCd = mPrfx + vLength;
        }

        return myNewCd;
    }

    public object[] find()
    {
        SqlCommand cm = new SqlCommand("select GRPCD from webx_GRPMST", cn);
        //object v = null;
        
        //v = cm.ExecuteScalar();
        object[] b = null;
        //cn.Open();
        SqlDataReader dr = cmd.ExecuteReader();
        if (dr.Read())
        {
            b = new object[dr.FieldCount];
            dr.GetValues(b);
        }
        dr.Close();
        cn.Close();
        return b;

    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        cn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        cn.Open();
        //if (HiddenField1.Value == "")
        //{
            string strGrpcd;
            string strRgLoc = "";// ddRgLoc.SelectedValue;
            string strOldgcd = "";

            if (b != null)
            {
                //cn.Open();
                SqlCommand bcmd = new SqlCommand("select GRPCD from webx_GRPMST where GRPCD = '" + b + "'", cn);
                SqlDataReader drfind = bcmd.ExecuteReader();
                if (drfind.Read())
                {
                    strOldgcd = drfind[0].ToString();
                }
                drfind.Close();

                //cn.Close();
            }
            else
            {
                strOldgcd = "";
            }
            //strOldgcd = "Null";

            strGrpcd = getNewCd("C"); 
            //strGrpcd = getNewCode("webx_GRPMST", "GRPCD", strRgLoc, 5);
            cmd.Connection = cn;
            cmd.CommandText = "insert into webx_GRPMST(GRPCD,GRPNM,GRP_Pwd,locregion,ActiveFlag,OLD_GRPCD)values('" + strGrpcd + "','" + txtGroupName.Text + "','" + txtpass.Text + "','','" + txtActFlag.Text + "','" + strOldgcd + "')";
            cmd.ExecuteNonQuery();
        //}
            
        //}
        //else
        //{
        //    cmd.Connection = cn;
        //    cmd.CommandText = "update WEBX_EMPMST set EMPRFX='" + cboPrefix.SelectedItem + "', EMPNM='" + txtName.Text.Trim() + "',PWD='" + txtPassword.Text.Trim() + "',GENDER='" + strGender + "',EMPST='" + strEmpStatus + "',PREVBRCD='" + txtPreviousLocation.Text.Trim() + "',DOL_PREVBRCD='" + txtDateLeavPreLoc.Text + "',CURRBRCD='" + txtCurrentLocationCode.Text.Trim() + "',DOS_CURRBRCD='" + txtDateStartCurrLoc.Text + "',QUALI='" + txtQualification.Text.Trim() + "',DOJ_ORG='" + txtDateJoinOrg.Text + "',DOL_ORG='" + txtDateLeaveOrg.Text + "',RESI_ADDR='" + txtResidentialAddress.Text.Trim() + "',RESI_TELNO='" + txtResidentialPhoneNo.Text.Trim() + "',EMAILID='" + txtEmailId.Text.Trim() + "',MOBILENO='" + txtMobileNo.Text.Trim() + "',ADD_MOBILENO='" + txtAdditionalMobileNo.Text.Trim() + "',DOB='" + txtDateOfBirth.Text + "',ACTIVEFLAG='" + mActiveFlag + "',EMPDESIG='" + txtDesignation.Text.Trim() + "',UPDTBY='" + Session["EmpCd"].ToString() + "',UPDTON=  getdate()  where EMPCD='" + HiddenField1.Value.Trim() + "'";
        //    cmd.ExecuteNonQuery();
        //}
        cn.Close();

        

        Response.Redirect("../business_partners.aspx");

    }
}
