using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Collections.Generic;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Data.SqlClient;
using WebX.Entity;
using WebX.Controllers;

public partial class PasswordPolicy_PassPolicy_AddEdit : System.Web.UI.Page
{  
    private List<PasswordPolicy> ListPP
    {
        get 
        {
            if (ViewState["ListPP"] != null)
                return ViewState["ListPP"] as List<PasswordPolicy>;
            else
                return new List<PasswordPolicy>();
        }
        set { ViewState["ListPP"] = value; }
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        lblMsg.Visible = false;
        if (!IsPostBack)
        {
            ListPP = PasswordPolicyController.GetAll();
            InitData();
        }
        tblCompx.Style["display"] = chkPassCompx.Checked ? "block" : "none";
    }
   
    protected void btnUpdate_Click(object sender, EventArgs e)
    {
        try
        {
            SqlConnection cn = new SqlConnection(SessionUtilities.ConnectionString);
            cn.Open();
            SqlTransaction trans = cn.BeginTransaction();
            PasswordPolicy pp = ListPP.Find(delegate(PasswordPolicy p) { return p.CodeID == PasswordPolicy.USE_ENCRYPTED_PASSWORD; });            
            try
            {
                if (pp.SetValue != (chkEncry.Checked ? "Y" : "N"))
                {
                    pp.SetValue = chkEncry.Checked ? "Y" : "N";
                    pp.Active = chkEncry.Checked ? "Y" : "N";
                    pp = SetUpdatedBy(pp);
                    if (PasswordPolicyController.EncryptDecryptPass(chkEncry.Checked, trans))
                    {
                        PasswordPolicyController.Update(pp, trans);
                    }
                    else
                        chkEncry.Checked = false;
                }            

                pp = ListPP.Find(delegate(PasswordPolicy p) { return p.CodeID == PasswordPolicy.ENABLE_PASSWORD_COPLEXCITY; });
                if (pp.SetValue != (chkPassCompx.Checked ? "Y" : "N"))
                {
                    pp.SetValue = chkPassCompx.Checked ? "Y" : "N";
                    pp.Active = chkPassCompx.Checked ? "Y" : "N";
                    pp = SetUpdatedBy(pp);
                    PasswordPolicyController.Update(pp, trans);
                }
                if (chkPassCompx.Checked)
                {
                    bool bChk = false;
                    pp = ListPP.Find(delegate(PasswordPolicy p) { return p.CodeID == PasswordPolicy.MAXIMUM_LENGTH; });
                    if (pp.SetValue != txtMaxLenght.Text.Trim())
                    {
                        pp.SetValue = txtMaxLenght.Text.Trim();
                        pp = SetUpdatedBy(pp);
                        PasswordPolicyController.Update(pp, trans);
                        bChk = true;
                    }
                    pp = ListPP.Find(delegate(PasswordPolicy p) { return p.CodeID == PasswordPolicy.MINIMUM_LENGTH; });
                    if (pp.SetValue != txtMinLength.Text.Trim())
                    {
                        pp.SetValue = txtMinLength.Text.Trim();
                        pp = SetUpdatedBy(pp);
                        PasswordPolicyController.Update(pp, trans);
                        bChk = true;
                    }
                    pp = ListPP.Find(delegate(PasswordPolicy p) { return p.CodeID == PasswordPolicy.NUMBER_REQUIRED; });
                    if (pp.SetValue != (chkNumeric.Checked ? "Y" : "N"))
                    {
                        pp.SetValue = chkNumeric.Checked ? "Y" : "N";
                        pp = SetUpdatedBy(pp);
                        PasswordPolicyController.Update(pp, trans);
                        bChk = true;
                    }

                    pp = ListPP.Find(delegate(PasswordPolicy p) { return p.CodeID == PasswordPolicy.ALPHA_REQUIRED; });
                    if (pp.SetValue != (chkAlpha.Checked ? "Y" : "N"))
                    {
                        pp.SetValue = chkAlpha.Checked ? "Y" : "N";
                        pp = SetUpdatedBy(pp);
                        PasswordPolicyController.Update(pp, trans);
                        bChk = true;
                    }

                    pp = ListPP.Find(delegate(PasswordPolicy p) { return p.CodeID == PasswordPolicy.SP_CHAR_REQUIRED; });
                    if (pp.SetValue != (chkSChar.Checked ? "Y" : "N"))
                    {
                        pp.SetValue = chkSChar.Checked ? "Y" : "N";
                        pp = SetUpdatedBy(pp);
                        PasswordPolicyController.Update(pp, trans);
                        bChk = true;
                    }
                    pp = ListPP.Find(delegate(PasswordPolicy p) { return p.CodeID == PasswordPolicy.COMPLEXITY_EXPRESSION; });
                    if (bChk)
                    {
                        pp.SetValue = GenerateRegex();
                        pp = SetUpdatedBy(pp);
                        PasswordPolicyController.Update(pp, trans);
                    }
                }
                trans.Commit();
            }
            catch (Exception ex)
            {
                trans.Rollback();
                throw ex;
            }
            finally
            {
                if (cn.State == ConnectionState.Open)
                    cn.Close();
            }
            pp = ListPP.Find(delegate(PasswordPolicy p) { return p.CodeID == PasswordPolicy.EXPIRE_AFTER; });
            if (pp.SetValue != txtExpireAfter.Text.Trim())
            {
                pp.SetValue = txtExpireAfter.Text.Trim();
                pp.Active = chkPassExpiry.Checked ? "Y" : "N";
                pp = SetUpdatedBy(pp);
                PasswordPolicyController.Update(pp);
            }            
            pp = ListPP.Find(delegate(PasswordPolicy p) { return p.CodeID == PasswordPolicy.REMEMBER_LAST_PASSWORD; });
            if (pp.SetValue != (chkRemLastPass.Checked ? "Y" : "N"))
            {
                pp.SetValue = chkRemLastPass.Checked ? "Y" : "N";
                pp.Active = chkRemLastPass.Checked ? "Y" : "N";
                pp = SetUpdatedBy(pp);
                PasswordPolicyController.Update(pp);
            }
            lblMsg.Text = "Password policy updated successfully";
            lblMsg.Visible = true;
        }
        catch (Exception exce)
        {
            lblMsg.Text = exce.Message;
            lblMsg.Visible = true;
        } 
    }

    private PasswordPolicy SetUpdatedBy(PasswordPolicy p)
    {
        p.UpdateBy = SessionUtilities.CurrentEmployeeID;
        p.UpdateDate = DateTime.Now;
        return p;
    }
        
    private void InitData()
    {
        try
        {
            PasswordPolicy pp = ListPP.Find(delegate(PasswordPolicy p) { return p.CodeID == PasswordPolicy.USE_ENCRYPTED_PASSWORD; });
            //trEncry.Style["display"] = (pp.Active == "Y") ? "block" : "none";
            chkEncry.Checked = (pp.SetValue == "Y" && pp.Active == "Y") ? true : false;

            pp = ListPP.Find(delegate(PasswordPolicy p) { return p.CodeID == PasswordPolicy.ENABLE_PASSWORD_COPLEXCITY; });
            //trPassCompx.Style["display"] = (pp.Active == "Y") ? "block" : "none";
            chkPassCompx.Checked = (pp.SetValue == "Y" && pp.Active == "Y") ? true : false;
            chkPassCompx.Attributes.Add("onclick", "javasctipt:return showHideCmpxParams(this,'" + tblCompx.ClientID + "')");
            tblCompx.Style["display"] = (pp.SetValue == "Y" && pp.Active == "Y") ? "block" : "none";

            pp = ListPP.Find(delegate(PasswordPolicy p) { return p.CodeID == PasswordPolicy.MAXIMUM_LENGTH; });
            txtMaxLenght.Text = pp.SetValue;
            //trMaxLength.Style["display"] = (pp.Active == "Y") ? "block" : "none";

            pp = ListPP.Find(delegate(PasswordPolicy p) { return p.CodeID == PasswordPolicy.MINIMUM_LENGTH; });
            txtMinLength.Text = pp.SetValue;
            //trMinLength.Style["display"] = (pp.Active == "Y") ? "block" : "none";

            pp = ListPP.Find(delegate(PasswordPolicy p) { return p.CodeID == PasswordPolicy.NUMBER_REQUIRED; });
            chkNumeric.Checked = (pp.SetValue == "Y" && pp.Active == "Y") ? true : false;
            //chkNumeric.Style["display"] = (pp.Active == "Y") ? "block" : "none";

            pp = ListPP.Find(delegate(PasswordPolicy p) { return p.CodeID == PasswordPolicy.ALPHA_REQUIRED; });
            chkAlpha.Checked = (pp.SetValue == "Y" && pp.Active == "Y") ? true : false;
            //chkAlpha.Style["display"] = (pp.Active == "Y") ? "block" : "none";

            pp = ListPP.Find(delegate(PasswordPolicy p) { return p.CodeID == PasswordPolicy.SP_CHAR_REQUIRED; });
            chkSChar.Checked = (pp.SetValue == "Y" && pp.Active == "Y") ? true : false;
            //chkSChar.Style["display"] = (pp.Active == "Y") ? "block" : "none";

            pp = ListPP.Find(delegate(PasswordPolicy p) { return p.CodeID == PasswordPolicy.EXPIRE_AFTER; });
            chkPassExpiry.Checked = (pp.Active == "Y") ? true : false;
            txtExpireAfter.Text = pp.SetValue;
            //trPassExpiry.Style["display"] = (pp.Active == "Y") ? "block" : "none";

            pp = ListPP.Find(delegate(PasswordPolicy p) { return p.CodeID == PasswordPolicy.REMEMBER_LAST_PASSWORD; });
            chkRemLastPass.Checked = (pp.SetValue == "Y" && pp.Active == "Y") ? true : false;
        }
        catch (Exception exce)
        {
            lblMsg.Text = exce.Message;
            lblMsg.Visible = true;
        } 
    }
    
    private string GenerateRegex()
    {
        //(?=^\S{2,10}$)(?=\S{1,}[!@#$%^&amp;*()_+}{&quot;:;'?/&gt;.&lt;,~\?\-\]\[\\])(?=\S{1,}?[a-zA-Z])(?=\S{1,}?[0-9])\S*
        string strReg = "";        
        if (txtMinLength.Text.Trim() == "")
            strReg += @"(?=^\S{1,";
        else
            strReg += @"(?=^\S{" + txtMinLength.Text.Trim() + ",";
        if (txtMaxLenght.Text.Trim() == "")
            strReg += "}$)";
        else
            strReg += txtMaxLenght.Text.Trim() + "}$)";

        if (chkSChar.Checked)
            strReg += @"(?=\S{1,}[!@#$%^&amp;*()_+}{&quot;:;'?/&gt;.&lt;,~\?\-\]\[\\])";
        if (chkAlpha.Checked)
            strReg += @"(?=\S{1,}?[a-zA-Z])";
        if (chkNumeric.Checked)
            strReg += @"(?=\S{1,}?[0-9])";
        strReg += @"\S*";
        
        
        //strReg += @"\z";
        return strReg;
    }
}
