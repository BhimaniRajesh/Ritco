<%@ Page Title="" Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="GRNCriteria.aspx.cs" Inherits="GUI_Finance_GeneralizedPO_GRNGeneration_GRNCriteria" %>

<%@ Register TagName="DT" TagPrefix="Date" Src="~/GUI/Common_UserControls/RPT_Date.ascx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">

    <script src="../../../Images/CalendarPopup.js" type="text/javascript"></script>

    <script language="javascript" type="text/javascript" src="../../../images/CalendarPopup.js"></script>
    
    <script language="javascript" type="text/javascript" src="../../../images/commonJs.js"></script>

    <script language="javascript" type="text/javascript">
        var cal = new CalendarPopup("testdiv1");
        cal.setCssPrefix("TEST");
        cal.showNavigationDropdowns();
        function Validate() 
        {
            if (document.getElementById('ctl00_MyCPH1_rdDateRange').checked == true && document.getElementById('ctl00_MyCPH1_Txt_Custcd').value == '')
            {
               alert('Please Enter the Vendor Code');
               document.getElementById('ctl00_MyCPH1_Txt_Custcd').focus();
               document.getElementById('ctl00_MyCPH1_Txt_Custcd').select();
               return false;
             }
         }
         function Show_assetNM(Obj, Type) 
         {
             //debugger;
             if (Obj.value == "") {
                 return false;
             }
             var Search_Char = "~"
             if (Obj.value.indexOf(Search_Char) == -1) {
                 alert("Invalid  Vendor Name~Code Format");
                 Obj.focus();
                 return false
             }
             var TxtAssetcode = Obj.id;
             var txtastnm = TxtAssetcode.replace("txtassetcd", "txtastnm");
             var Assetcode_Arr = document.getElementById(TxtAssetcode).value.split("~");
             Assetcode = Assetcode_Arr[1]
             if (Assetcode != "") 
             {
                 var findobj = false;
                 findobj = GetXMLHttpObject();
                 if (findobj) 
                 {
                     var strpg = "CheckExist.aspx?mode=" + Type + "&Code=" + Assetcode + "&sid=" + Math.random();
                     findobj.open("GET", strpg, true);
                     findobj.onreadystatechange = function() 
                     {
                         if (findobj.readyState == 4 && findobj.status == 200) 
                         {
                             var res = findobj.responseText.split("|");
                             if (res[0] == "false") 
                             {
                                 alert("Vendor Code is not Valid... Please Enter Valid Vendor Code");
                                 document.getElementById(TxtAssetcode).value = "";
                                 document.getElementById(TxtAssetcode).focus();
                                 return false;
                             }
                         }
                     }
                     findobj.send(null);
                 }
                 return false;
             }
         }
    </script>

    <div>
        <table style="width: 10in" border="0" cellpadding="0" cellspacing="0">
            <tr>
                <td>
                    &nbsp;
                </td>
            </tr>
            <tr>
                <td>
                    <br />
                    <table border="0" cellpadding="3" cellspacing="1" class="boxbg" style="width: 75%;"
                        align="left">
                        <tr class="bgbluegrey" style="height: 25px">
                            <td align="center" colspan="3">
                                <strong><span style="font-size: 8pt; font-family: Verdana">GRN Edit Module</span></strong>
                            </td>
                        </tr>
                        <tr bgcolor="white" style="font-size: 12pt; font-family: Times New Roman;">
                            <td style="width: 10px" rowspan="2">
                                <asp:RadioButton ID="rdDateRange" GroupName="grpcri" runat="server" />
                            </td>
                            <td style="width: 122px">
                                <font class="blackfnt">Select GRN Date</font>
                            </td>
                            <td align="left">
                                <Date:DT ID="DT" runat="server" />
                            </td>
                        </tr>
                        <tr class="nrow">
                            <td style="width: 122px">
                                <asp:Label ID="lblPartyCode" runat="server" CssClass="nfnt">Select Vendor Code</asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="Txt_Custcd" runat="server" onblur="javascript:Show_assetNM(this,'Vendor')" CssClass="ltxtm" Width="270px" MaxLength="20"></asp:TextBox><br />
                                <div id="Abc" runat="server" class="boxbg" />
                                <ajaxToolkit:AutoCompleteExtender ID="ExCutomer" runat="server" CompletionListHighlightedItemCssClass="autocomplete_highlightedListItem"
                                    CompletionListItemCssClass="autocomplete_listItem" Enabled="True" MinimumPrefixLength="1"
                                    ServiceMethod="GetVendor" ServicePath="~/GUI/Finance/GeneralizedPO/AtlasAutoComplete.asmx" TargetControlID="Txt_Custcd">
                                </ajaxToolkit:AutoCompleteExtender>
                            </td>
                        </tr>
                        <tr bgcolor="white" align="center">
                            <td align="center" colspan="3">
                                <span style="font-size: 8pt; font-family: Verdana; text-align: center"><b>OR</b>
                                </span>
                            </td>
                        </tr>
                        <tr bgcolor="white">
                            <td style="width: 10px;">
                                <asp:RadioButton ID="rdDocketCri" GroupName="grpcri" runat="server" />
                            </td>
                            <td align="left" style="width: 122px">
                                <asp:Label ID="lbl_DocNo" runat="server" CssClass="blackfnt" Text="Enter GRN Number"></asp:Label>
                            </td>
                            <td style="width: 339px;">
                                <asp:TextBox ID="GRNno" runat="server" MaxLength="50" onchange="javascript:this.value=this.value.toUpperCase()"
                                    Columns="25" BorderStyle="Groove" CssClass="EntryText"></asp:TextBox>&nbsp;
                            </td>
                        </tr>
                        <tr bgcolor="white" align="center">
                            <td align="center" colspan="3">
                                <span style="font-size: 8pt; font-family: Verdana; text-align: center"><b>OR</b>
                                </span>
                            </td>
                        </tr>
                        <tr bgcolor="white">
                            <td style="width: 10px;">
                                <asp:RadioButton ID="RadioButton1" GroupName="grpcri" runat="server" />
                            </td>
                            <td align="left" style="width: 122px">
                                <asp:Label ID="lbl_DocManualNo" runat="server" CssClass="blackfnt" Text="Enter Manual GRN No"></asp:Label>
                            </td>
                            <td style="width: 339px;">
                                <asp:TextBox ID="GRNManualNo" runat="server" MaxLength="50" onchange="javascript:this.value=this.value.toUpperCase()"
                                    Columns="25" BorderStyle="Groove" CssClass="EntryText"></asp:TextBox>&nbsp;
                            </td>
                        </tr>
                        <tr class="bgbluegrey" style="font-size: 12pt; font-family: Times New Roman;">
                            <td align="center" colspan="3" style="height: 25px">
                                <asp:Button ID="ButSubmit" runat="server" Text="Submit" OnClick="ButSubmit_Click"
                                    CssClass="BtnClass" OnClientClick="javascript:return Validate();" />
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    </div>
    <div id="testdiv1" style="position: absolute; visibility: hidden; background-color: white;
        z-index: 99;">
    </div>
</asp:Content>
