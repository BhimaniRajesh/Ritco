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
using Microsoft.ApplicationBlocks.Data;
using System.Web.SessionState;

public partial class UserControls_UCMrChq : System.Web.UI.UserControl
{   
    string sChqNo1,sChqDate1,sBankName1,sBankBrn1,sPartyCode,sPartyName;
    double sChqAmt1, sOnAcct1, sAcctAmt1;
    MyFunctions fn = new MyFunctions();
    string connStr = System.Configuration.ConfigurationManager.AppSettings["dbWebxConnection"];


    public string PartyCode
    {
        get {
            return sPartyCode; 
        }
        
        set {
            sPartyCode = value;
        }
    }

    public string PartyName
    {
        get
        {
            return sPartyName;
        }

        set
        {
            sPartyName = value;
        }
    }
    public string ChqNo1
    {
        get
        {
            return sChqNo1;
        }

        set
        {
            sChqNo1 = value;
        }
    }

    public string ChqDate1
    {
        get
        {
            return sChqDate1;
        }

        set
        {
            sChqDate1 = value;
        }
    }

    public string BankName1
    {
        get
        {
            return sBankName1;
        }

        set
        {
            sBankName1 = value;
        }
    }
    public string BankBrn1
    {
        get
        {
            return sBankBrn1;
        }

        set
        {
            sBankBrn1 = value;
        }
    }

    public double OnAcct1
    {
        get
        {
            return sOnAcct1;
        }

        set
        {
            sOnAcct1 = value;
        }
    }
    public double ChqAmt1
    {
        get
        {
            return sChqAmt1;
        }

        set
        {
            sChqAmt1 = value;
        }
    }
    public double AcctAmt1
    {
        get
        {
            return sAcctAmt1;
        }

        set
        {
            sAcctAmt1 = value;
        }
    }
    
    protected override void OnPreRender(EventArgs e)
    {
        //If the developer specifies the username in the public property,
        //use that one. Otherwise, we could get the username from 
        //another source (i.e. A cookie on the client or a context 
        //object attached to the user).
        if (sChqNo1 != null)
        {
            txtChqNo.Text = sChqNo1;
        }
        else
        {
            //Logic to get the username goes here.
        }
        if (sChqDate1 != null)
        {
            txtChqDt.Text = sChqDate1;
        }
        else
        {
            //Logic to get the username goes here.
        }
        
        if (sChqAmt1  != 0)
        {
            txtChqAmt.Text = sChqAmt1.ToString(); 
        }
        else
        {
            //Logic to get the username goes here.
        }
        if (sOnAcct1 != 0)
        {
            txtOnAcctAmt.Text = sOnAcct1.ToString(); 
        }
        else
        {
            //Logic to get the username goes here.
        }
        if (sAcctAmt1  != 0)
        {
            txtIndClAmt.Text = sAcctAmt1.ToString(); 
        }
        else
        {
            //Logic to get the username goes here.
        }


        if (sBankName1 != null)
        {
            txtBankName.Text = sBankName1.ToString();
        }
        else
        {
            //Logic to get the username goes here.
        }
        if (sBankBrn1 != null)
        {
            txtBankBranch.Text = sBankBrn1.ToString();
        }
        else
        {
            //Logic to get the username goes here.
        }
        
    }

    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void getChqInfo(object sender, EventArgs e)
    {
       ChqNo1=txtChqNo.Text.ToString();
       ChqDate1 = fn.Mydate1(txtChqDt.Text.ToString());
       double adjustamt;

       string sql = "Select chqamt,adjustamt,ptmsptcd,ptmsptnm,banknm,BANKBRN from webx_chq_det with (NOLOCK) where chqno='" + ChqNo1 + "' and Chqdate='" + ChqDate1 + "' ";//and ownCust='C'
       SqlDataReader rdr = SqlHelper.ExecuteReader(connStr, CommandType.Text, sql);

       BankName1 = "";
       BankBrn1="";
       AcctAmt1=0;
       ChqAmt1=0;
       OnAcct1 = 0;
       adjustamt = 0; 
       
       if (rdr.Read())
       {
           ChqAmt1 = Math.Round(Convert.ToDouble(rdr[0]),2);
           adjustamt = Math.Round(Convert.ToDouble(rdr[1]),2);
           PartyCode = rdr[2].ToString();
           PartyName=rdr[3].ToString();
           BankName1 = rdr[4].ToString();
           BankBrn1 =rdr[5].ToString();

           OnAcct1 = Math.Round(ChqAmt1 - adjustamt,2);
        }
        rdr.Close();
    }
}
