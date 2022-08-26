<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="CustomerGroupMasterAdd.aspx.cs" Inherits="GUI_admin_CustomerGroupMaster_CustomerGroupMasterAdd"
    Title="Untitled Page" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script language="javascript" type="text/javascript">


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


function ValidateData()
{
 if(document.getElementById("ctl00_MyCPH1_ddRgLoc"))
        {
            if(document.getElementById("ctl00_MyCPH1_ddRgLoc").value == "--Select--")
            {
                alert("Enter Region Location");
                document.getElementById("ctl00_MyCPH1_ddRgLoc").focus();
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
        
        
         if(document.getElementById("ctl00_MyCPH1_txtpass"))
        {
        
            if(document.getElementById("ctl00_MyCPH1_txtpass").value == "")
            {
                alert("Enter Password....");
                document.getElementById("ctl00_MyCPH1_txtpass").focus();
                return false;
            }
             if(document.getElementById("ctl00_MyCPH1_txtpass").value.length < 4 )
            {
                alert("Password Length Can not be Less Then 4");
                document.getElementById("ctl00_MyCPH1_txtpass").focus();
                return false;
            }
        }
        return true;
}
    </script>
<br />
        <br />
        <br />
    <table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 100%;">
        <tr>
            <td colspan="2" style="height: 36px">
                <a href=""><font class="blklnkund"><strong>Module</strong></font></a> &gt; <a href="">
                    <font class="blklnkund"><strong>Administrator </strong></font></a>&gt; <a href=""><font
                        class="blklnkund"><strong>Business Partners</strong></font></a> <font class="bluefnt">
                            <strong>&gt; Customer Group Master</strong> </font>
            </td>
        </tr>
    </table>
    <div style="width: 9.5in">
        <table align="center" border="0" cellpadding="3" cellspacing="1" class="boxbg" style="width: 93%">
            <tr class="bgbluegrey">
                <td colspan="4" align="center">
                    <font class="blackfnt"><b />CUSTOMER GROUP MASTER SCREEN </font>
                </td>
            </tr>
            <tr bgcolor="white" >
                <td style="width: 161px; height: 21px;">
                    <font class="blackfnt">Group Code</font></td>
                <td style="width: 231px; height: 21px;">
                    <font class="blackfnt">&nbsp;<font class="blackfnt" color="red">&lt; System Generated
                        ... &gt;</font> </font>
                </td>
                <td style="width: 244px; height: 21px;">
                    <font class="blackfnt">Password</font></td>
                <td style="height: 21px">
                    <asp:TextBox ID="txtpass" MaxLength="10" TextMode="password" runat="server"></asp:TextBox>
                </td>
            </tr>
            <tr bgcolor="white" >
                <td style="width: 161px">
                    <font class="blackfnt">Group Name</font></td>
                <td style="width: 231px">
                    <font class="blackfnt">
                        <asp:TextBox ID="txtGroupName" MaxLength="30" onblur="javascript:return checklocation(this)" runat="server"></asp:TextBox></font><%--onChange="javascript:this.value=this.value.toUpperCase();">--%></td>
                <td style="width: 244px">
                </td>
                <td>
                </td>
            </tr>
            <tr bgcolor="white" >
                <td  valign="top">
                    <font class="blackfnt">Active Flag</td>
                <td colspan="3"  valign="top">
                    <asp:UpdatePanel ID="upChkActFlag" runat="server">
                        <ContentTemplate>
                            <asp:CheckBox ID="chk1" runat="server" AutoPostBack="True" OnCheckedChanged="chk1_CheckedChanged"
                                Checked="True" />
                            <asp:TextBox ID="txtActFlag" runat="server" MaxLength="1" Width="40px">Y</asp:TextBox>
                        </ContentTemplate>
                        <Triggers>
                            <asp:AsyncPostBackTrigger ControlID="chk1" EventName="CheckedChanged" />
                        </Triggers>
                    </asp:UpdatePanel>
                </td>
            </tr>
        </table>
        <br />
        <br />
        <br />
        <center>
            <asp:Button ID="btnSubmit" runat="server" Width="100" Text="Submit" OnClientClick="javascript:return ValidateData()"
                OnClick="btnSubmit_Click" />
            <asp:Button ID="btnReset" runat="server" Visible="false" Text="Reset" />
        </center>
    </div>
</asp:Content>
