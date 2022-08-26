<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master"
    AutoEventWireup="true" CodeFile="VehicleLogBookReport.aspx.cs"
    Inherits="GUI_Fleet_Reports_VehicleLogBookReport"
    Title="Untitled Page" %>

<%@ Register TagName="DT" TagPrefix="Date" Src="~/GUI/Common_UserControls/RPT_Date.ascx" %>
<%@ Register TagName="popUp" TagPrefix="popUp" Src="~/GUI/Common_UserControls/PopUpControl.ascx" %>
<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=14.0.0.0, Culture=neutral, PublicKeyToken=89845DCD8080CC91"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1"
    runat="Server">

    <script src="../../images/commonJs.js" language="javascript"
        type="text/javascript"></script>

    <script src="../../images/DateControl.js" language="javascript"
        type="text/javascript"></script>

    <script src="../../images/CalendarPopup.js" language="javascript"
        type="text/javascript"></script>

    <script language="javascript" type="text/javascript">
        var cal = new CalendarPopup("testdiv1"); 
        cal.setCssPrefix("TEST");
        cal.showNavigationDropdowns();
    </script>

    <script language="javascript" type="text/javascript">  
   function nwOpen(mNo)
    {
        window.open("popup-CUST.aspx?mNo=" + mNo,"pbr","menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=387,height=220,status=no,left=220,top=70")
    }
     function OnSub_DATACHECK()
    {
//      var txtTripsheetNo=document.getElementById("ctl00_MyCPH1_txtTripsheetNo");
//      var txtCustCode=document.getElementById("ctl00_MyCPH1_txtCustCode");
//      var txtVehNo=document.getElementById("ctl00_MyCPH1_txtVehNo");
//      var ddlcategory=document.getElementById("ctl00_MyCPH1_ddlcategory");
//       var ddlprodtype=document.getElementById("ctl00_MyCPH1_ddlprodtype");
//      var txtDateFrom=document.getElementById("ctl00$MyCPH1$DT$txtDateFrom");
//       var txtDateTo=document.getElementById("ctl00$MyCPH1$DT$txtDateTo");
//      var ddlCompanyList=document.getElementById("ctl00$MyCPH1$CMPFT1$ddlCompanyList");
   
     window.open("VehicleLogBookReportResult.aspx","");

      //return false;

        
    }
    
    function OnSub_DATACHECK1()
    {
//        var txtTripsheetNo=document.getElementById("ctl00_MyCPH1_txtTripsheetNo");
//        var txtCustCode=document.getElementById("ctl00_MyCPH1_txtCustCode");
//        var txtVehNo=document.getElementById("ctl00_MyCPH1_txtVehNo");
//        var ddlcategory=document.getElementById("ctl00_MyCPH1_ddlcategory");
//        var ddlprodtype=document.getElementById("ctl00_MyCPH1_ddlprodtype");
//        var txtDateFrom=document.getElementById("ctl00$MyCPH1$DT$txtDateFrom");
//        var txtDateTo=document.getElementById("ctl00$MyCPH1$DT$txtDateTo");
//        var ddlCompany=document.getElementById("ctl00_MyCPH1_ddlCompany");
//        
      

        window.open("VehicleLogBookReportResult.aspx","");

    //return false;


    }
    </script>

    <div id="testdiv1" style="position: absolute; visibility: hidden;
        background-color: white; layer-background-color: white;
        z-index: 99;">
    </div>
    <asp:UpdateProgress ID="uppMain" runat="server">
        <ProgressTemplate>
            <iframe frameborder="0" src="about:blank" style="border: 0px;
                position: absolute; z-index: 9; left: 0px; top: 0px;
                width: expression(this.offsetParent.scrollWidth);
                height: expression(this.offsetParent.scrollHeight);
                filter: progid:DXImageTransform.Microsoft.Alpha(Opacity=75, FinishOpacity=0, Style=0, StartX=0, FinishX=100, StartY=0, FinishY=100);">
            </iframe>
            <div style="position: absolute; z-index: 10; left: expression((this.offsetParent.clientWidth/2)-(this.clientWidth/2)+this.offsetParent.scrollLeft);
                top: expression((this.offsetParent.clientHeight/2)-(this.clientHeight/2)+this.offsetParent.scrollTop);">
                <img src="../../images/loading.gif" /><font face="verdana"
                    color="blue" size="4">&nbsp;<b>Please Wait...</b></font>
            </div>
        </ProgressTemplate>
    </asp:UpdateProgress>
    <table cellspacing="1" style="width: 100%">
        <tr style="background-color: white">
            <td align="left">
                <asp:Label ID="lblPageHead" CssClass="blackfnt" Font-Bold="True"
                    runat="server">Fleet Module  > Reports >Vehicle LogBook Report</asp:Label>
            </td>
            <td align="right">
            </td>
        </tr>
    </table>
    <hr align="center" size="1" color="#8ba0e5">
    <br>
    <table cellspacing="1" cellpadding="2" style="width: 700px"
        class="boxbg">
        <tr class="bgbluegrey">
            <td colspan="3" align="center">
                <asp:Label ID="Label3" CssClass="blackfnt" Font-Bold="true"
                    runat="server">Search Criteria</asp:Label>
            </td>
        </tr>
        <tr style="background-color: white">
            <td align="right" valign="center" style="width: 154px;
                text-align: left;">
                <asp:Label ID="Label4" CssClass="blackfnt" runat="server"
                    Font-Bold="True">Tripsheet No</asp:Label>
            </td>
            <td align="left" colspan="2">
                <asp:TextBox ID="txtTripsheetNo" runat="server" CssClass="input"
                    Width="200px" Style="font-size: 8pt; font-family: Verdana"
                    BorderStyle="Groove"></asp:TextBox>
                <ajaxToolkit:AutoCompleteExtender runat="server" BehaviorID="AutoCompleteEx2"
                    ID="autoComplete5" TargetControlID="txtTripsheetNo"
                    ServicePath="~/services/FleetAutoComplet.asmx"
                    ServiceMethod="GetTripsheetNo" MinimumPrefixLength="1"
                    CompletionInterval="1000" EnableCaching="true"
                    CompletionSetCount="20" CompletionListCssClass="autocomplete_completionListElement"
                    CompletionListItemCssClass="autocomplete_listItem"
                    CompletionListHighlightedItemCssClass="autocomplete_highlightedListItem"
                    DelimiterCharacters=";, :" ShowOnlyCurrentWordInCompletionListItem="true">
                    <Animations>
                                    <OnShow>
                                    <Sequence>
                                    <%-- Make the completion list transparent and then show it --%>
                                    <OpacityAction Opacity="0" />
                                    <HideAction Visible="true" />

                                    <%--Cache the original size of the completion list the first time
                                    the animation is played and then set it to zero --%>
                                    <ScriptAction Script="
                                    // Cache the size and setup the initial size
                                    var behavior = $find('AutoCompleteEx2');
                                    if (!behavior._height) {
                                    var target = behavior.get_completionList();
                                    behavior._height = target.offsetHeight - 2;
                                    target.style.height = '0px';
                                    }" />

                                    <%-- Expand from 0px to the appropriate size while fading in --%>
                                    <Parallel Duration=".4">
                                    <FadeIn />
                                    <Length PropertyKey="height" StartValue="0" EndValueScript="$find('AutoCompleteEx2')._height" />
                                    </Parallel>
                                    </Sequence>
                                    </OnShow>
                                    <OnHide>
                                    <%-- Collapse down to 0px and fade out --%>
                                    <Parallel Duration=".4">
                                    <FadeOut />
                                    <Length PropertyKey="height" StartValueScript="$find('AutoCompleteEx2')._height" EndValue="0" />
                                    </Parallel>
                                    </OnHide>
                    </Animations>
                </ajaxToolkit:AutoCompleteExtender>
            </td>
        </tr>
        <tr style="background-color: white">
            <td align="right" style="vertical-align: top; width: 154px;
                text-align: left">
            </td>
            <td align="left" colspan="2" style="text-align: right">
                <asp:UpdatePanel ID="UpdatePanel1" UpdateMode="Conditional"
                    RenderMode="Inline" runat="server">
                    <ContentTemplate>
                        <%-- <asp:Button ID="btnShow" runat="server" Text="Submit" OnClientClick="javascript:return Validation()"  OnClick="btnShow_Click" /> --%>
                        <asp:Button ID="btnShow1" runat="server" Text="Submit"
                            OnClientClick="Javascript: return OnSub_DATACHECK();" />
                    </ContentTemplate>
                </asp:UpdatePanel>
            </td>
        </tr>
        <tr style="background-color: white">
            <td align="right" colspan="3" style="font-weight: bold;
                font-size: 10pt; vertical-align: middle; font-family: Verdana;
                text-align: center">
                OR
            </td>
        </tr>
        <tr style="background-color: white">
            <td align="right" valign="center" style="width: 154px;
                text-align: left;">
                <asp:Label ID="Label2" CssClass="blackfnt" runat="server"
                    Font-Bold="True">Date Range</asp:Label>
            </td>
            <td align="left" colspan="2">
                <Date:DT ID="DT" EnableTillDate="false" runat="server" />
            </td>
        </tr>
        <tr style="background-color: white">
            <td align="right" valign="center" style="width: 154px;
                text-align: left;">
                <asp:Label ID="Label5" CssClass="blackfnt" runat="server"
                    Font-Bold="True">Customer</asp:Label>
            </td>
            <td align="left" colspan="2">
                <asp:TextBox ID="txtCustCode" runat="server"></asp:TextBox>&nbsp;
                <asp:Label ID="lblPopup" runat="server" BorderStyle="Groove"
                    TabIndex="18" Text='<a href="javascript:nwOpen(1)">...</a>'></asp:Label>
            </td>
        </tr>
        <tr style="background-color: white">
            <td align="right" valign="center" style="width: 154px;
                text-align: left;">
                <asp:Label ID="Label10" CssClass="blackfnt" runat="server"
                    Font-Bold="True">VehicleNo</asp:Label>
            </td>
            <td align="left" colspan="2">
                <asp:TextBox ID="txtVehNo" runat="server" CssClass="input"
                    Width="100px" Style="font-size: 8pt; font-family: Verdana"
                    BorderStyle="Groove"></asp:TextBox>
                <ajaxToolkit:AutoCompleteExtender runat="server" BehaviorID="AutoCompleteEx3"
                    ID="AutoCompleteExtender1" TargetControlID="txtVehNo"
                    ServicePath="~/services/FleetAutoComplet.asmx"
                    ServiceMethod="GetVehNo" MinimumPrefixLength="1"
                    CompletionInterval="1000" EnableCaching="true"
                    CompletionSetCount="20" CompletionListCssClass="autocomplete_completionListElement"
                    CompletionListItemCssClass="autocomplete_listItem"
                    CompletionListHighlightedItemCssClass="autocomplete_highlightedListItem"
                    DelimiterCharacters=";, :" ShowOnlyCurrentWordInCompletionListItem="true">
                    <Animations>
                                    <OnShow>
                                    <Sequence>
                                    <%-- Make the completion list transparent and then show it --%>
                                    <OpacityAction Opacity="0" />
                                    <HideAction Visible="true" />

                                    <%--Cache the original size of the completion list the first time
                                    the animation is played and then set it to zero --%>
                                    <ScriptAction Script="
                                    // Cache the size and setup the initial size
                                    var behavior = $find('AutoCompleteEx3');
                                    if (!behavior._height) {
                                    var target = behavior.get_completionList();
                                    behavior._height = target.offsetHeight - 2;
                                    target.style.height = '0px';
                                    }" />

                                    <%-- Expand from 0px to the appropriate size while fading in --%>
                                    <Parallel Duration=".4">
                                    <FadeIn />
                                    <Length PropertyKey="height" StartValue="0" EndValueScript="$find('AutoCompleteEx3')._height" />
                                    </Parallel>
                                    </Sequence>
                                    </OnShow>
                                    <OnHide>
                                    <%-- Collapse down to 0px and fade out --%>
                                    <Parallel Duration=".4">
                                    <FadeOut />
                                    <Length PropertyKey="height" StartValueScript="$find('AutoCompleteEx3')._height" EndValue="0" />
                                    </Parallel>
                                    </OnHide>
                    </Animations>
                </ajaxToolkit:AutoCompleteExtender>
            </td>
        </tr>
        <tr style="background-color: white">
            <td align="right" valign="center" style="width: 154px;
                text-align: left;">
                <asp:Label ID="Label6" CssClass="blackfnt" runat="server"
                    Font-Bold="True">Category</asp:Label>
            </td>
            <td align="left" colspan="2" style="width: 73%">
                <asp:DropDownList ID="ddlcategory" runat="server" Width="100px">
                </asp:DropDownList>
            </td>
        </tr>
        <tr style="background-color: white">
            <td align="right" valign="center" style="width: 154px;
                text-align: left;">
                <asp:Label ID="Label7" CssClass="blackfnt" runat="server"
                    Font-Bold="True">Product Type</asp:Label>
            </td>
            <td align="left" colspan="2" style="width: 73%">
                <asp:DropDownList ID="ddlprodtype" runat="server" Width="100px">
                </asp:DropDownList>
            </td>
        </tr>
        <tr style="background-color: white">
            <td align="right" valign="center" style="width: 154px;
                text-align: left;">
                <asp:Label ID="Label1" CssClass="blackfnt" runat="server"
                    Font-Bold="True">Company Name</asp:Label>
            </td>
            <td align="left" colspan="2" style="width: 73%">
                <asp:DropDownList ID="ddlCompany" runat="server" Width="100px">
                </asp:DropDownList>
            </td>
        </tr>
        <tr style="background-color: white">
            <td align="right" style="vertical-align: top; width: 154px;
                text-align: left">
            </td>
            <td align="left" colspan="2" style="text-align: right">
                <asp:UpdatePanel ID="UpdatePanel8" UpdateMode="Conditional"
                    RenderMode="Inline" runat="server">
                    <ContentTemplate>
                        <%-- <asp:Button ID="btnShow" runat="server" Text="Submit" OnClientClick="javascript:return Validation()"  OnClick="btnShow_Click" /> --%>
                        <asp:Button ID="btnShow" runat="server" Text="Submit"
                            OnClientClick="Javascript: return OnSub_DATACHECK1();" />
                    </ContentTemplate>
                </asp:UpdatePanel>
            </td>
        </tr>
    </table>
    <br />
</asp:Content>
