<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master"
    CodeFile="AssetMasterAdd.aspx.cs" Inherits="GUI_Finance_GeneralizedPO_AssetMaster_AssetMasterAdd" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script type="text/javascript" language="javascript" src="../FA.js"></script>

    <script language="javascript" type="text/javascript">

        function ValidateData() {
            // debugger
            if (document.getElementById("ctl00_MyCPH1_txtdesc")) 
            {
                if (document.getElementById("ctl00_MyCPH1_txtdesc").value == "") 
                {
                    alert("Enter Asset Description  ");
                    document.getElementById("ctl00_MyCPH1_txtdesc").focus();
                    return false;
                }
            }

            if (document.getElementById("ctl00_MyCPH1_txtprefix")) 
            {
                if (document.getElementById("ctl00_MyCPH1_txtprefix").value == "") 
                {
                    alert("Enter Asset Pre-fix");
                    document.getElementById("ctl00_MyCPH1_txtprefix").focus();
                    return false;
                }
            }
            if (document.getElementById("ctl00_MyCPH1_ddlassetgrp")) 
            {
                if (document.getElementById("ctl00_MyCPH1_ddlassetgrp").value == "--Select--") 
                {
                    alert("Select Asset Group ");
                    document.getElementById("ctl00_MyCPH1_ddlassetgrp").focus();
                    return false;
                }
            }
            if (document.getElementById("ctl00_MyCPH1_ddlunit")) 
            {
                if (document.getElementById("ctl00_MyCPH1_ddlunit").value == "0") 
                {
                    alert("Select Asset Unit");
                    document.getElementById("ctl00_MyCPH1_ddlunit").focus();
                    return false;
                }
            }            
        }    
    </script>
    <br />
    <br />
    <div style="width: 10in">
        <table align="left" cellspacing="1" style="width: 60%" class="boxbg" border="0">
            <tr class="bgbluegrey">
                <td colspan="2" align="center" style="height: 21px">
                    <asp:Label ID="lblQry" CssClass="blackfnt" Font-Bold="true" runat="server">
                                       Add General Asset Details
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
                        CssClass="blackfnt"></asp:Label>
                </td>
            </tr>
            <tr style="background-color: #FFFFFF">
                <td>
                    <label class="blackfnt">
                        Assets Description :</label>
                </td>
                <td>
                    <asp:TextBox ID="txtdesc" CssClass="blackfnt" Width="300" Onblur="Javascript:this.value=this.value.toUpperCase();"
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
                    <asp:TextBox ID="txtprefix" CssClass="blackfnt" Onblur="Javascript:this.value=this.value.toUpperCase();"
                        MaxLength="5" runat="server"></asp:TextBox>
                </td>
            </tr>            
            <tr style="background-color: #FFFFFF">
                <td>
                    <label class="blackfnt">
                        Crredit Account:
                    </label>
                </td>
                <td>
                    <asp:DropDownList ID="ddlCreditAccount" runat="server">
                    </asp:DropDownList>
                </td>
            </tr>
             <tr style="background-color: #FFFFFF">
                <td>
                    <label class="blackfnt">
                        Active:
                    </label>
                </td>
                <td>
                    <asp:CheckBox ID="ChkActive" runat="server" Checked="true"></asp:CheckBox>
                </td>
            </tr>                         
            <tr class="bgbluegrey">
                <td colspan="2" align="center" style="height: 21px">
                    <asp:Button ID="btn_submit" CssClass="blackfnt" Text="Submit" OnClick="btn_submit_Click"
                        runat="server" />
                </td>
            </tr>
        </table>
    </div>
</asp:Content>
