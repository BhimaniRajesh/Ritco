<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="Query.aspx.cs" Inherits="GUI_UNI_NET_MIS_STOCK_SSRS_Query" %>

<%@ Register TagName="LH" TagPrefix="Location" Src="~/GUI/Common_UserControls/LOC_HRCHY.ascx" %>
<%@ Register TagName="FRM" TagPrefix="Location_frm" Src="~/GUI/Common_UserControls/LOC_HRCHY_TO.ascx" %>
<%@ Register TagName="DT" TagPrefix="Date" Src="~/GUI/Common_UserControls/RPT_Date.ascx" %>


<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <asp:SqlDataSource ID="MySQLDataSource_GeneralMaster" runat="server" SelectCommand="Select CodeID='All', CodeDesc='--All--'  union select codeid,codedesc from webx_master_general where codetype='BILLTYP' and statuscode='Y'"
        SelectCommandType="Text"></asp:SqlDataSource>

    <script language="JavaScript" type="text/javascript" src="./../../Images/CalendarPopup.js"></script>

    <script language="javascript" type="text/javascript" src="./../../images/commonJs.js"></script>

    <script language="JavaScript" type="text/javascript">
var cal = new CalendarPopup("testdiv1"); 
	cal.setCssPrefix("TEST");
	cal.showNavigationDropdowns();

    </script>
   <input type="hidden" id="hdnRptId" runat="server" /> <%-- added by Manisha 26/5/2014 --%>

    <div align="left">
        <table style="width: 10.5in" border="0" align="left" cellpadding="0" cellspacing="0">
            <tr>
                <td height="30">
                    <font class="bluefnt"><strong>&gt; </strong><strong>Stock Report </strong></font>
                </td>
            </tr>
            <tr>
                <td class="horzblue">
                    <img src="./../../images/clear.gif" width="2" height="1" /></td>
            </tr>
            <tr>
                <td align="right">
                    <div align="center">
                        <asp:UpdateProgress ID="uppMain" runat="server">
                            <ProgressTemplate>
                                <table style="border: solid #8ba0e5 2px; z-index: 98; position: fixed; width: 200px;
                                    -left: -60px; top: 50%; left: 40%;" width="190px" cellpadding="0" bgcolor="white">
                                    <tr>
                                        <td align="right">
                                            <img id="Img1" src="./../../images/loading.gif" runat="server" />
                                        </td>
                                        <td>
                                            <font face="verdana" color="#0000ff" size="2">&nbsp;&nbsp;&nbsp;<b>Please Wait ...</b></font>
                                        </td>
                                    </tr>
                                </table>
                                <asp:Panel ID="Panel1" Style="position: fixed; z-index: 97; top: 0px; left: 0px;
                                    background-color: #FFFFFF; width: 100%; height: 100%; filter: Alpha(Opacity=50);
                                    opacity: .50; -moz-opacity: .50;" runat="server">
                                    <asp:Panel Style="z-index: 98; position: fixed; width: 120px; -left: -60px; top: 50%;
                                        left: 50%;" ID="Panel2" runat="server">
                                    </asp:Panel>
                                </asp:Panel>
                            </ProgressTemplate>
                        </asp:UpdateProgress>
                    </div>
                    <a href="javascript:window.history.go(-1)" title="back">
                        <img alt="Back" src="./../../images/back.gif" border="0" />
                    </a>
                </td>
            </tr>
            <tr>
                <td valign="top">
                    <table cellspacing="1" style="width: 9.0in" class="boxbg" align="left">
                        <tr class="bgbluegrey">
                            <td align="center" colspan="2">
                                <font class="blackfnt"><b>Select  Criteria</b></font>
                            </td>
                        </tr>
                         
                        <tr style="background-color: white">
                            <td align="left">
                                <font class="blackfnt">Select
                                    <asp:DropDownList ID="RPT_LOC" RepeatDirection="horizontal" CssClass="blackfnt" runat="server">
                                        <asp:ListItem Text="Origin Location"  Value="orgncd"></asp:ListItem>
                                        <asp:ListItem Text="Current Location" Selected="true" Value="curr_loc"></asp:ListItem>
                                      
                                    </asp:DropDownList></font></td>
                            <td align="left">
                                <Location:LH ID="Fromlc" runat="server" />
                            </td>
                        </tr>
                         <tr style="background-color: white">
                            <td align="left">
                                <font class="blackfnt">Select Desination  </font></td>
                            <td align="left">
                                <Location_frm:FRM ID="FRM" runat="server" />
                            </td>
                        </tr>
                          <tr id="TR_3" runat="server" style="background-color: white">
                            <td align="left">
                                <font class="blackfnt">Select
                                    <asp:DropDownList ID="RPT_DATE" RepeatDirection="horizontal" CssClass="blackfnt"
                                        runat="server">
                                        <asp:ListItem Text="Booking Date" Selected="true" Value="dockdt"></asp:ListItem>
                                        <asp:ListItem Text="Arrived Date" Value="Arrived_dt"></asp:ListItem>
                                        
                                    </asp:DropDownList>
                                </font>
                            </td>
                            <td align="left">
                                <Date:DT ID="DT" runat="server" />
                            </td>
                        </tr>
                         
                        <tr align="center" bgcolor="white">
                            <td align="left">
                                <asp:Label ID="Label4" CssClass="blackfnt" Text="Select Reprot Type " runat="server"></asp:Label>
                            </td>
                            <td align="left">
                                <asp:RadioButtonList ID="RPT_TYP" RepeatDirection="horizontal" CssClass="blackfnt"
                                     runat="server">
                                    <asp:ListItem Text="Region Wise Location Wise" Selected="True" Value="1"></asp:ListItem>
                                    <asp:ListItem Text="Location Wise Godown Wise " Value="2"></asp:ListItem>
                                </asp:RadioButtonList>
                            </td>
                        </tr>
                        <tr align="center" bgcolor="white">
                            <td align="left">
                                <asp:Label ID="Label1" CssClass="blackfnt" Text="Select Format Type " runat="server"></asp:Label>
                            </td>
                            <td align="left">
                                <asp:RadioButtonList ID="RPT_FORTYP" RepeatDirection="horizontal" CssClass="blackfnt"
                                     runat="server">
                                    <asp:ListItem Text="Register" Selected="True" Value="1"></asp:ListItem>
                                    <asp:ListItem Text="Summary" Value="2"></asp:ListItem>
                                </asp:RadioButtonList>
                            </td>
                        </tr>
                         <tr align="center" bgcolor="white">
                            <td align="left">
                                <asp:Label ID="Label2" CssClass="blackfnt" Text="Select Suffix " runat="server"></asp:Label>
                            </td>
                            <td align="left">
                                <asp:RadioButtonList ID="RPT_SFTYP" RepeatDirection="horizontal" CssClass="blackfnt"
                                     runat="server">
                                    <asp:ListItem Text="Yes"  Value="Y"></asp:ListItem>
                                    <asp:ListItem Text="No" Selected="True" Value="N"></asp:ListItem>
                                </asp:RadioButtonList>
                            </td>
                        </tr>
                        <tr align="center" bgcolor="white">
                            <td colspan="2">
                                <asp:Button ID="btnShow" OnClientClick="Javascript:return OnSub_DATACHECK();" OnClick="btnShow_Click"
                                    runat="server" Text="Show" Width="75px" />
                                <%--OnClientClick="Javascript: return DateCheck();"--%>
                            </td>
                        </tr>
                </td>
            </tr>
        </table>
    </div>
    <div id="testdiv1" style="position: absolute; visibility: hidden; background-color: white;
        layer-background-color: white; z-index: 99;">
    </div>
</asp:Content>
