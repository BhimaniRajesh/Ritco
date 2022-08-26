<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="HierarchyMaster.aspx.cs" Inherits="GUI_admin_HierarchyMaster_HierarchyMaster" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">

<%--<script language = "javascript" type="text/javascript">
    
    function ValidateLevel(objLevel)
    {
        if(objLevel.value == "")
        {
            alert("Please enter the Level");
            objLevel.focus();
            return false;
        }
        else if(isNaN(objLevel.value))
        {
            alert("Please enter the Level in numeric format");
            objLevel.value = "";
            objLevel.focus();
            return false;
        }
        else if(parseFloat(objLevel.value) < 0)
        {
            alert("Please enter the Level in positive numeric format");
            objLevel.value = "";
            objLevel.focus();
            return false;
        }
    }
</script>--%>

 <table style="width: 100%">

        <tr>
            <td align="left"  colspan="3">
                <asp:Label ID="lblWelcome" runat="server" Text="Hierarchy Master Entry" CssClass="blackfnt" Font-Bold="true"></asp:Label>
                <hr align="center" size="1" color="#8ba0e5" />
            </td>
        </tr>
        </table>
    <div>
         <table align="center" border="0" cellpadding="0" cellspacing="0" width="95%">
            <tr>
                <td align="right" style="height: 30px">
                    <a href="javascript:window.history.go(-1)" title="back">
                        <img border="0" src="../../images/back.gif" alt="" /></a></td>
            </tr>  
            </table>  
            
            <table align="center" border="0" cellpadding="2" cellspacing="1" class="boxbg" width="65%">
                                                <tr class="bgbluegrey">
                                                    <td align="center" >
                                                        <font class="blackfnt"><b>HIERARCHY MASTER SCREEN</b></font></td>
                                                </tr>
                                                <tr>
                                                    <td bgcolor="#ffffff">
                                                        <table border="0" cellpadding="3" cellspacing="1" width="75%">
                                                            <tr>
                                                                <td>
                                                                    <font class="blackfnt">Level</font></td>
                                                                <td style="font-weight: bold">
                                                                   
                                                                    <font class="blackfnt" color="red"><asp:Label ID="lblLevel" runat="server" Text="System Generated...." Font-Names="Verdana" Font-Size="Smaller" style="left: 2px; position: relative; top: 0px"></asp:Label>
                                                                   </font>
                                                                </td>
                                                            </tr>
                                                           
                                                            <tr>
                                                                <td>
                                                                    <font class="blackfnt">Type of Location</font></td>
                                                                <td>
                                                                    <font class="blackfnt">
                                                                        <asp:TextBox ID="TextBox2" runat="server" Width="224px" ></asp:TextBox></font></td>
                                                            </tr>
                                                            
                                                            <tr>
                                                                <td align="left">
                                                                </td>
                                                                <td>
                                                                    &nbsp;<asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="Submit" />&nbsp;
                                                                   <asp:Button ID="Button2" runat="server" Text="Reset" OnClick="Button2_Click" />
                                                                </td>
                                                            </tr>
                                                        </table>
                                                       
                                                        </td>
                                                </tr>
                                            </table>
                                            <asp:HiddenField ID="HiddenField1" runat="server" />
    </div>
    </asp:Content>
