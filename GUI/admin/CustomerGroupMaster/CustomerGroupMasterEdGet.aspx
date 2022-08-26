<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="CustomerGroupMasterEdGet.aspx.cs" Inherits="GUI_admin_CustomerGroupMaster_CustomerGroupMasterEdGet"
    Title="Untitled Page" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script language="javascript" type="text/javascript">

function ValidateData()
   {
       if(document.getElementById("ctl00_MyCPH1_txtPwd"))
        {
            if(document.getElementById("ctl00_MyCPH1_txtPwd").value == "")
            {
                alert("Enter Password");
                document.getElementById("ctl00_MyCPH1_txtPwd").focus();
                return false;
            }
            if(document.getElementById("ctl00_MyCPH1_txtPwd").value.length <= 5 )
            {
                alert("Enter Password more than 5 digit length");
                document.getElementById("ctl00_MyCPH1_txtPwd").focus();
                return false;
            }
        }
       if(document.getElementById("ctl00_MyCPH1_txtGroupName"))
        {
            if(document.getElementById("ctl00_MyCPH1_txtGroupName").value == "")
            {
                alert("Enter Group Name");
                document.getElementById("ctl00_MyCPH1_txtGroupName").focus();
                return false;
            }
        }
//       if(document.getElementById("ctl00_MyCPH1_ddRgLoc"))
//        {
//            if(document.getElementById("ctl00_MyCPH1_ddRgLoc").value == "--Select--")
//            {
//                alert("Enter Region Location");
//                document.getElementById("ctl00_MyCPH1_ddRgLoc").focus();
//                return false;
//            }
//        }
        if(document.getElementById("ctl00_MyCPH1_txtActFlag"))
        {
            if(document.getElementById("ctl00_MyCPH1_txtActFlag").value == "")
            {
                alert("Enter Active Flag");
                document.getElementById("ctl00_MyCPH1_txtActFlag").focus();
                return false;
            }
        }
                
        return true;
    }
    
    
    
function trimAll(strValue)
{
//Trimming left most white space characters
while (strValue.substring(0,1) == ' ')
{
strValue = strValue.substring(1, strValue.length);
}
//Trimming right most white space characters
while (strValue.substring(strValue.length-1, strValue.length) == ' ')
{
strValue = strValue.substring(0, strValue.length-1);
}

return strValue;
}
   function checklocation(obj)
    {
        
obj.value = trimAll(obj.value);
 
   obj.value = obj.value.toUpperCase()
       for(i=0;i<str.length;i++)
       {

            if(obj.value==str[i])
            {
             
                 alert("Group Name Already Exist...")
                 obj.focus();
                 return false;
                 break;
               
            }
            else
            {
                continue
            }
       }
        

}
    </script>

    <div style="width: 9.5in">
        <table width="100%" border="0" cellpadding="0" cellspacing="0">
            <tr>
                <td>
                    <table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 100%;
                        height: 228px">
                        <tr>
                            <td style="height: 36px">
                                <a href=""><font class="blklnkund"><strong>Module</strong></font></a> &gt; <a href="">
                                    <font class="blklnkund"><strong>Administrator </strong></font></a>&gt; <a href=""><font
                                        class="blklnkund"><strong>Business Partners</strong></font></a> <font class="bluefnt">
                                            <strong>&gt; Customer Group Master</strong> </font>
                            </td>
                        </tr>
                        <tr>
                            <td class="horzblue">
                                <img src="../../images/clear.gif" width="2" height="1" alt="" /></td>
                        </tr>
                        <%--<tr> 
          <td><img src="../../images/clear.gif" width="15" height="10" alt="" /></td>
        </tr>--%>
                        <tr>
                            <td align="right" style="height: 51px">
                                <a href="javascript:window.history.go(-1)" title="back">
                                    <img src="../../images/back.gif" border="0" alt="" /></a></td>
                        </tr>
                        <tr>
                            <td align="right">
                            </td>
                        </tr>
                        <tr>
                            <td align="right">
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <%--<br><table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td width="39%" valign="top"><table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr> 
                      <td height="300" valign="top">--%>
                                <!--START-->
                                <table align="center" border="0" cellpadding="3" cellspacing="1" class="boxbg" style="width: 93%">
                                    <tr class="bgbluegrey">
                                        <td colspan="3" align="center">
                                            <font class="blackfnt"><b />CUSTOMER GROUP MASTER SCREEN</font></td>
                                    </tr>
                                    <tr>
                                        <td colspan="3" bgcolor="#FFFFFF" style="height: 39px">
                                            <table border="0" cellpadding="0" cellspacing="0" width="100%">
                                                <tr>
                                                    <td style="width: 161px; height: 21px;">
                                                        <font class="blackfnt">Group Code</font></td>
                                                    <td style="width: 231px; height: 21px;">
                                                        <font class="blackfnt">: &nbsp;<asp:Label ID="lblGrpCd" runat="server" ForeColor="#FF8080"></asp:Label>&nbsp;
                                                        </font>
                                                    </td>
                                                    <td style="width: 244px; height: 21px;">
                                                        <font class="blackfnt">Password</font></td>
                                                    <td style="height: 21px">
                                                        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                                            <ContentTemplate>
                                                                <font class="blackfnt">:
                                                                    <asp:TextBox ID="txtPwd" MaxLength="10" ReadOnly="true" runat="server"></asp:TextBox>
                                                                    &nbsp;</font><asp:LinkButton ID="ln1" Font-Underline="true" ForeColor="red" Text="Edit"
                                                                        runat="server" OnClick="ln1_Click"></asp:LinkButton>
                                                            </ContentTemplate>
                                                        </asp:UpdatePanel>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td style="width: 161px">
                                                        <font class="blackfnt">Group Name</font></td>
                                                    <td style="width: 231px">
                                                        <font class="blackfnt">:
                                                            <asp:TextBox MaxLength="30" ID="txtGroupName" onblur="return checklocation(this)" runat="server"></asp:TextBox></font><%--onChange="javascript:this.value=this.value.toUpperCase();">--%>
                                                    </td>
                                                    <td style="width: 244px">
                                                    </td>
                                                    <td>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td style="width: 161px; height: 32px;" valign="top">
                                                        <font class="blackfnt">Active Flag </font>
                                                    </td>
                                                    <td style="width: 231px; height: 32px;" valign="top">
                                                        <asp:UpdatePanel ID="upChkActFlag" runat="server">
                                                            <ContentTemplate>
                                                                <asp:CheckBox ID="chk1" runat="server" AutoPostBack="True" OnCheckedChanged="chk1_CheckedChanged"
                                                                    Width="63px" Checked="True" />
                                                                <asp:TextBox ID="txtActFlag" runat="server" Width="40px">Y</asp:TextBox>&nbsp;
                                                            </ContentTemplate>
                                                            <Triggers>
                                                                <asp:AsyncPostBackTrigger ControlID="chk1" EventName="CheckedChanged" />
                                                            </Triggers>
                                                        </asp:UpdatePanel>
                                                    </td>
                                                    <td style="width: 244px; height: 32px;">
                                                    </td>
                                                    <td style="height: 32px">
                                                    </td>
                                                </tr>
                                            </table>
                                            &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                                            &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                                            &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                                            &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;
                                            <asp:Button ID="btnSubmit" runat="server" Text="Submit" OnClientClick="return ValidateData()"
                                                OnClick="btnSubmit_Click" />
                                            <asp:Button ID="btnReset" runat="server" Text="Reset" /></td>
                                    </tr>
                                    <%--<tr>
<td valign="top" style="width: 873px"><font class="blackfnt">Active Flag</font></td>
<td valign="top" colspan="3"><font class="blackfnt">: </font>
</td>
</tr>--%>
                                </table>
                            </td>
                        </tr>
                        <%--<tr align="center">
<td colspan="5">
<table border="0" cellspacing="4" cellpadding="2" width="50%">
</br>--%>
                        <tr>
                            <td align="right" style="height: 19px">
                            </td>
                            <td style="height: 19px">
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    </div>
</asp:Content>
