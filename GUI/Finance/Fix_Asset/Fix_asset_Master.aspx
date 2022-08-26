<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master"
    CodeFile="Fix_asset_Master.aspx.cs" Inherits="GUI_Finance_Fix_Asset_Fix_Asset_Add" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script language="javascript" type="text/javascript">
    
//    function ValidateData(obj)
//    {
//    obj.value=
//    
//    }
    
     function ValidateData()
            {
           // debugger
                  if(document.getElementById("ctl00_MyCPH1_txtdesc"))
                {
                    if(document.getElementById("ctl00_MyCPH1_txtdesc").value == "")
                    {
                        alert("Enter Asset Description  ");
                        document.getElementById("ctl00_MyCPH1_txtdesc").focus();
                        return false;
                    }
              }   
              
              if(document.getElementById("ctl00_MyCPH1_txtprefix"))
                {
                    if(document.getElementById("ctl00_MyCPH1_txtprefix").value == "")
                    {
                        alert("Enter Asset Pre-fix");
                        document.getElementById("ctl00_MyCPH1_txtprefix").focus();
                        return false;
                    }
              }   
                if(document.getElementById("ctl00_MyCPH1_ddlassetgrp"))
                {
                    if(document.getElementById("ctl00_MyCPH1_ddlassetgrp").value == "--Select--")
                    {
                        alert("Select Asset Group ");
                        document.getElementById("ctl00_MyCPH1_ddlassetgrp").focus();
                        return false;
                    }
                }
                if(document.getElementById("ctl00_MyCPH1_ddlunit"))
                {
                    if(document.getElementById("ctl00_MyCPH1_ddlunit").value == "0")
                    {
                        alert("Select Asset Unit");
                        document.getElementById("ctl00_MyCPH1_ddlunit").focus();
                        return false;
                    }
                }
                
                
                   if(document.getElementById("ctl00_MyCPH1_ddlcat"))
                {
                    if(document.getElementById("ctl00_MyCPH1_ddlcat").value == "0")
                    {
                        alert("Select Asset Catagory");
                        document.getElementById("ctl00_MyCPH1_ddlcat").focus();
                        return false;
                    }
                }
                
                
              
              
              
              
              
              }
    
    
    
    </script>

    <table style="width: 1100px">
        <tr>
            <td align="left">
                <a><font class="blklnkund"><b>Module</b></font></a> <b>&gt; </b><a><font class="blklnkund">
                    <b>Finance</b></font></a> <b>&gt; </b><font class="bluefnt"><b>Fix Assets</b></font>
            </td>
            <td align="right">
                <a href="javascript:window.history.go(-1)" title="back">
                    <img src="../../images/back.gif" border="0" alt="" /></a>
            </td>
        </tr>
    </table>
    <br />
    <br />
    <div style="width: 10in">
        <table align="center" cellspacing="1" style="width: 60%" class="boxbg" border="0">
            <tr class="bgbluegrey">
                <td colspan="2" align="center" style="height: 21px">
                    <asp:Label ID="lblQry" CssClass="blackfnt" Font-Bold="true" runat="server">
                                       Add Master
                    </asp:Label>
                </td>
            </tr>
            <tr style="background-color: #ffffff">
                <td>
                    <label class="blackfnt">
                        Asset Code :
                    </label>
                </td>
                <td>
                    <asp:Label ID="l1" Text="< System Generated... >" runat="server" ForeColor="red"
                        CssClass="blackfnt"></asp:Label></td>
            </tr>
            <tr style="background-color: #FFFFFF">
                <td>
                    <label class="blackfnt">
                        Assets Description :</label></td>
                <td>
                    <asp:TextBox ID="txtdesc" Width="300" Onblur="Javascript:this.value=this.value.toUpperCase();"
                        runat="server"></asp:TextBox>
                </td>
            </tr>
            <tr style="background-color: #FFFFFF">
                <td>
                    <label class="blackfnt">
                        Asset PreFix:
                    </label>
                </td>
                <td>
                    <asp:TextBox ID="txtprefix" Onblur="Javascript:this.value=this.value.toUpperCase();"
                        runat="server"></asp:TextBox>
                </td>
            </tr>
            <tr style="background-color: #FFFFFF">
                <td>
                    <label class="blackfnt">
                        Asset Group:
                    </label>
                </td>
                <td>
                    <asp:DropDownList ID="ddlassetgrp" runat="server">
                    </asp:DropDownList>
                </td>
            </tr>
            <tr style="background-color: #FFFFFF">
                <td>
                    <label class="blackfnt">
                        Unit:
                    </label>
                </td>
                <td>
                    <asp:DropDownList ID="ddlunit" runat="server">
                        <asp:ListItem Text="--Select--" Value="0"></asp:ListItem>
                        <asp:ListItem Text="Nos." Value="1"></asp:ListItem>
                        <asp:ListItem Text="Kgs." Value="2"></asp:ListItem>
                        <asp:ListItem Text="Meter." Value="3"></asp:ListItem>
                        <asp:ListItem Text="Liter." Value="4"></asp:ListItem>
                    </asp:DropDownList>
                </td>
            </tr>
            <tr style="background-color: #FFFFFF">
                <td>
                    <label class="blackfnt">
                        Asset Catagory:
                    </label>
                </td>
                <td>
                    <asp:DropDownList ID="ddlcat" runat="server">
                        <asp:ListItem Text="--Select--" Value="0"></asp:ListItem>
                        <asp:ListItem Text="Movable" Value="1"></asp:ListItem>
                        <asp:ListItem Text="Non-Movable" Value="2"></asp:ListItem>
                    </asp:DropDownList>
                </td>
            </tr>
            <tr style="background-color: #FFFFFF">
                <td colspan="2" align="center" style="height: 21px">
                    <asp:Button ID="btn_submit" Text="Submit" OnClick="btn_submit_Click" runat="server" />
                </td>
            </tr>
        </table>
    </div>
</asp:Content>
