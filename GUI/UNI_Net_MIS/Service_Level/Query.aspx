<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="Query.aspx.cs" Inherits="GUI_UNI_NET_MIS_Location_Combination_Query" %>

<%@ Register TagName="LH" TagPrefix="Location" Src="~/GUI/Common_UserControls/LOC_HRCHY.ascx" %>
<%@ Register TagName="FRM" TagPrefix="Location_frm" Src="~/GUI/Common_UserControls/LOC_HRCHY_TO.ascx" %>
<%@ Register TagName="DT" TagPrefix="Date" Src="~/GUI/Common_UserControls/RPT_Date.ascx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script type="text/javascript" language="JavaScript" src="./../../Images/CalendarPopup.js"></script>

    <script type="text/javascript" language="javascript" src="./../../images/commonJs.js"></script>

    <script language="JavaScript" type="text/javascript">
        var cal = new CalendarPopup("testdiv1");
        cal.setCssPrefix("TEST");
        cal.showNavigationDropdowns();

      
    </script>

    <div align="left">
        <table style="width: 8.5in" border="0" align="left" cellpadding="0" cellspacing="0">
            <tr>
                <td height="30">
                    <strong>Service Level Report</strong>
                </td>
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
                                            <img src="./../../images/loading.gif" alt="" />
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
                </td>
            </tr>
            <tr>
                <td class="horzblue">
                    <img src="./../../images/clear.gif" width="2" height="1"></td>
            </tr>
            <tr class="hrow">
           <td colspan="2" align="center">
           <asp:Label ID="Label1" CssClass="blackfnt" Font-Bold="true" runat="server">Service Level Criteia</asp:Label>
           </td> 
            </tr>
            <tr>
                <td height="300" valign="top">
                    <table cellspacing="1" cellpadding="3" style="width: 8.5in" class="stbl" align="left">
                        <tr class="nrow">
                            <td align="left">
                                Select From Location
                            </td>
                            <td align="left">
                                <Location:LH ID="Fromlc" runat="server" />
                            </td>
                            
                        </tr>
                        <tr class="nrow">
                            <td align="left">
                                Select To Location
                            </td>
                            <td align="left">
                             <Location_frm:FRM ID="Toloc" runat="server" />
                            </td>
                            
                        </tr>
                        <tr class="nrow">
                            <td align="center">
                                Select Date
                            </td>
                            <td align="left">
                                 <Date:DT ID="DT" runat="server" />
                            </td>
                        </tr>
                       
                        <tr align="left" class="hrow" >
                            <td colspan="2" align="center">
                                <asp:Button ID="btnShow" runat="server" OnClick="btnShow_Click" CssClass="fbtn" Text="Submit" Width="75px" />
                                 &nbsp;&nbsp;
                                <asp:Button ID="btnDownload" runat="server" Text="Download XLS" Width="85px" OnClick="btnDownload_Click" />
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
