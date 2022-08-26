
<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPageReport.master" AutoEventWireup="true" CodeFile="Result.aspx.cs" Inherits="GUI_UNI_Net_MIS_Trip_Profitablility_Report_Result" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
 <table style="width: 10.5in" border="0" align="left" cellpadding="0" cellspacing="0">
        <tr>
            <td height="30">
                <font class="bluefnt"><strong><u>&gt;&gt;&gt;Trip Profitablity Report
</u></strong></font>
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
                                        <img id="Img1" src="./../../images/loading.gif"  runat="server" />
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
            <td valign="top" align="left">

                            <%--Reports--%>
                          
<rsweb:ReportViewer ExportContentDisposition="AlwaysAttachment" ID="rvDocuments"
                                runat="server" Font-Names="Verdana" CssClass="blackfnt" Height="600px"  ShowBackButton="true" 
                                ShowPromptAreaButton="true" ToolBarItemHoverBackColor="Aqua" ToolBarItemPressedHoverBackColor="BlueViolet"
                                ProcessingMode="Remote" width="1200px"  ShowParameterPrompts="false" ShowPageNavigationControls="true" >
                                <ServerReport DisplayName="Trip Profitablity Report" ></ServerReport>
                            </rsweb:ReportViewer>
                       
                    
                     </td>
        </tr>
        
    </table>
</asp:Content>



