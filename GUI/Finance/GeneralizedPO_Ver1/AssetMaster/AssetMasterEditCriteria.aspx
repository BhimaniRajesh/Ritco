<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master"
    CodeFile="AssetMasterEditCriteria.aspx.cs" Inherits="GUI_Finance_GeneralizedPO_AssetMaster_AssetMasterEditCriteria" %>

<%@ Register TagName="LH" TagPrefix="Location" Src="~/GUI/Common_UserControls/LocationHirarchy.ascx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script type="text/javascript" language="javascript" src="../FA.js"></script>

    <script language="JavaScript" type="text/javascript">

        function Check_Submit_Data() 
        {            
            if (document.getElementById('ctl00$MyCPH1$txtassetcd').value != "") 
            {
                var Search_Char = "~"
                if (document.getElementById('ctl00$MyCPH1$txtassetcd').value.indexOf(Search_Char) == -1) 
                {
                    alert("Invalid  Asset  Name~Code Format");
                    document.getElementById('ctl00$MyCPH1$txtassetcd').focus();
                    return false
                }
            }
        }
        function nwOpen(mNo) 
        {
            window.open("../setting_cust_opn_bal/popupbranch.aspx?mNo=" + mNo, "pbr", "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=387,height=220,status=no,left=220,top=70")
        }
    </script>

    <div align="left">
        <table style="width: 10.5in" border="0" align="left" cellpadding="0" cellspacing="0">                        
            <tr>
                <td align="right">
                    <div align="center">
                        <asp:UpdateProgress ID="ProgressIndicator" runat="server">
                            <ProgressTemplate>
                                <div id="progressArea">                              
                                    <asp:Table ID="Table1" runat="server">
                                        <asp:TableRow>
                                            <asp:TableCell>
                                                <asp:Image ID="imgwaiting" runat="server" ImageUrl="~/GUI/images/loading.gif" /></asp:TableCell>
                                            <asp:TableCell CssClass="blackfnt" Font-Bold="true">&nbsp; Please Wait</asp:TableCell>
                                        </asp:TableRow>
                                    </asp:Table>                          
                                </div>
                            </ProgressTemplate>
                        </asp:UpdateProgress>
                    </div>                    
                </td>
            </tr>
            <tr>
                <td valign="top">
                    <table cellspacing="1" style="width: 8.0in" class="boxbg" align="left">
                        <tr class="bgbluegrey">
                            <td align="center" colspan="3">
                                <font class="blackfnt"><b>Updation of General Asset</b></font>
                            </td>
                        </tr>
                        <tr style="background-color: white">
                            <td align="left">
                                <font class="blackfnt"><b>Select AssetCode</b></font>
                            </td>
                            <td align="left" colspan="2">
                                <div id="Dic_POCODE" runat="server" class="boxbg" />
                                <ajaxToolkit:AutoCompleteExtender ID="Ext1" runat="server" Enabled="True" CompletionListItemCssClass="autocomplete_listItem"
                                    CompletionListHighlightedItemCssClass="autocomplete_highlightedListItem" MinimumPrefixLength="1"
                                    ServiceMethod="Get_GeneralAsset" ServicePath="~/GUI/Finance/GeneralizedPO/AtlasAutoComplete.asmx" TargetControlID="txtassetcd">
                                </ajaxToolkit:AutoCompleteExtender>                               
                                <asp:TextBox ID="txtassetcd" Width="400" runat="server" onchange="javascript:this.value=this.value.toUpperCase()"
                                    onblur="javascript:Show_assetNM(this)" BorderStyle="Groove" CssClass="blackfnt"></asp:TextBox>
                            </td>
                        </tr>
                        
                        <tr align="center" class="bgbluegrey">
                            <td colspan="3">
                                <asp:Button ID="btnShow" OnClick="btnShow_Click" runat="server" Text="Show" Width="75px" />                                
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    </div>
    <div id="testdiv1" style="position: absolute; visibility: hidden; background-color: white;
        layer-background-color: white; z-index: 99;">
    </div>
</asp:Content>
