<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="MailSettings.aspx.cs" Inherits="GUI_Fleet_Webadmin_Job_MailSettings" Title="Untitled Page" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">
  <script language="javascript" type="text/javascript">

    var prefix= "ctl00_MyCPH1_";
        
    function OnCancel()
    {
        var txtSMTPServer = document.getElementById(prefix +"txtSMTPServer");
        var txtFrom = document.getElementById(prefix +"txtFrom");
        var txtTo = document.getElementById(prefix +"txtTo");
        var lbl_Err_SMTPSrv = document.getElementById(prefix +"lbl_Err_SMTPSrv");
        var lbl_Err_From = document.getElementById(prefix +"lbl_Err_From");
        var lbl_Err_To = document.getElementById(prefix +"lbl_Err_To");
            
//            txtSMTPServer.value="";
//            txtFrom.value="";
//            txtTo.value="";
//            lbl_Err_SMTPSrv.innerText="";
//            lbl_Err_From.innerText="";
//            lbl_Err_To.innerText="";
    }
    function CheckSMTP(txtSMTPServer,lbl_Err_SMTPSrv)
    {
        var hfSMTPSrv = document.getElementById(prefix +"hfSMTPSrv");       
        if(txtSMTPServer.value == "")
        {
            lbl_Err_SMTPSrv.innerText = "*";
            txtSMTPServer.focus();
            return false;
        }
        else
        {
            lbl_Err_SMTPSrv.innerText = "";
        }
        hfSMTPSrv.value=txtSMTPServer.value;
    }
    function OnOk()
    {
        var txtSMTPServer = document.getElementById(prefix +"txtSMTPServer");
        var txtFrom = document.getElementById(prefix +"txtFrom");
        var txtTo = document.getElementById(prefix +"txtTo");
        var lbl_Err_SMTPSrv = document.getElementById(prefix +"lbl_Err_SMTPSrv");
        var lbl_Err_From = document.getElementById(prefix +"lbl_Err_From");
        var lbl_Err_To = document.getElementById(prefix +"lbl_Err_To");
        
        var bool="true";
        
        if(txtSMTPServer.value == "")
        {
            lbl_Err_SMTPSrv.innerText="*";
            bool="false";
        }
        else
        {
            lbl_Err_SMTPSrv.innerText="";
            bool="true";
        }
        
        if(txtFrom.value == "")
        {
            lbl_Err_From.innerText="*";
            bool="false";
        }
        else
        {
            lbl_Err_SMTPSrv.innerText="";
            bool="true";
        }
        
        if(txtTo.value == "")
        {
            lbl_Err_To.innerText="*";
            bool="false";
        }
        else
        {
            lbl_Err_SMTPSrv.innerText="";
            bool="true";
        }
        if(lbl_Err_SMTPSrv.innerText=="" && lbl_Err_From.innerText=="" && lbl_Err_To.innerText=="")
        {
            bool="true";
        }
        else
        {
            bool="false";
        }
        if(bool=="false")
        {
            return false;
        }
    }      
    function isValidEmail(strEmail)
    {
        var validRegExp = /^[^@]+@[^@]+.[a-z]{2,}$/i;
        if (strEmail.search(validRegExp) == -1) 
        {
            return false;
        }
        return true; 
    }
    function validateMultipleEmailsCommaSeparated(strEmail,lbl_Err,hf) 
    {
        if(strEmail.value == "")
        {
            lbl_Err.innerText = "*";
            strEmail.focus();
            return false;
        }
        else
        {
            lbl_Err.innerText = "";
        }
        var result = strEmail.value.split(",");
        for(var i = 0;i < result.length;i++)
        {
            if(!isValidEmail(result[i])) 
            {
                lbl_Err.innerText = "Invalid E-mail address !!!";
                strEmail.focus();
                return false;               
            }
            else
            {
                lbl_Err.innerText = "";
            }
        }
        hf.value=strEmail.value;
    }
    function fnClickUpdate(sender, e)
    {
        __doPostBack(sender,e);
    }
</script>
    
    
    
     <table  cellspacing="1" cellpadding="2" style="width: 100%" class="boxbg">
      <tr style="background-color: white">
          <table width="100%" border="0" align="left" cellpadding="0" cellspacing="0">
            <tr>
                <td height="30">
                    <font class="blklnkund"><strong>Fleet</strong></font> <strong>&gt; </strong>
                    <font class="blklnkund"><strong>Job Order</strong></font><strong>&gt; </strong>
                    <font class="bluefnt"><strong>Mail Settings</strong></font>&nbsp;</td>
            </tr>
            <tr>
                <td class="horzblue">
                    <img src="../../../images/clear.gif" width="2" height="1"></td>
            </tr>
            <tr>
                <td>
                    <img src="../../../images/clear.gif" width="15" height="10"></td>
            </tr>
            <tr>
                <td>
                <font class="redfnt"><strong>(Use (,) to separate multiple e-mail addresses.)</strong></font>
                      <table cellpadding="2" cellspacing="1" style="width: 500px" class="boxbg">

 <tr class="bgbluegrey">
    <td  colspan="2">
                  
                    <font class="bluefnt"><strong>Mail Settings</strong></font>&nbsp;</td>
 </tr>

            <tr  style="background-color: white">
            <td style="width: 20%; height: 11px">
            <asp:HiddenField ID="hfSMTPSrv" runat="server" />
            <asp:HiddenField ID="hfFrom" runat="server" />
            <asp:HiddenField ID="hfTo" runat="server" />

            <asp:Label ID="Label64" runat="server" Text="SMTP Server:"></asp:Label></td>
            <td style="width: 80%; height: 11px">
            <asp:TextBox ID="txtSMTPServer" Font-Names="Verdana" Font-Size="8pt" runat="server" CssClass="input" Width="200px"></asp:TextBox>
            <asp:Label ID="lbl_Err_SMTPSrv" CssClass="redfnt"  runat="server" ></asp:Label></td>

            </td>
            </tr>
            <tr  style="background-color: white">
            <td style="width: 20%; height: 11px">
            <asp:Label ID="Label2" runat="server" Text="From:"></asp:Label></td>
            <td style="width: 80%; height: 11px">
            <asp:TextBox ID="txtFrom" runat="server" CssClass="input" Width="200px" 
            Font-Names="Verdana" Font-Size="8pt"></asp:TextBox>
            <asp:Label ID="lbl_Err_From" CssClass="redfnt"  runat="server" ></asp:Label></td>
            </td>
            </tr>
            <tr  style="background-color: white">
                <td style="width: 20%; height: 11px">
                    <asp:Label ID="Label7" runat="server" Text="To:"></asp:Label></td>
                    <td style="width: 80%; height: 11px">
                    <asp:TextBox ID="txtTo" Font-Names="Verdana" Font-Size="8pt" runat="server" CssClass="input" Width="200px"></asp:TextBox>
                    <asp:Label ID="lbl_Err_To" CssClass="redfnt"  runat="server" ></asp:Label></td>
                </td>
            </tr>
                <tr class="bgbluegrey">
                    <td colspan="2" align="center" width="100%">
                        <asp:Button ID="btnMailSave"  runat="server" OnClick="btnMailSave_Click"  Text="Save" />
                    </td>
                </tr>
            </table>
        </tr>
    </table>   
  
</asp:Content>

