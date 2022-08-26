<%@ Page Language="C#" AutoEventWireup="true"  CodeFile="ExecutionServiceResult.aspx.cs" Inherits="GUI_UNI_Net_MIS_ExecutionService_ExecutionServiceResult" %>

<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=14.0.0.0, Culture=neutral, PublicKeyToken=89845DCD8080CC91"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Expense Register</title>
    <meta http-equiv="X-UA-Compatible" content="IE=EmulateIE9" />
</head>
<body>
    <form id="form1" runat="server">
        <table width="100%" border="0" align="left" cellpadding="0" cellspacing="0"> <%--style="width: 10.5in"--%>
            
            <tr>
                <td align="right">
                   
                    <div align="Left">
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
                        &nbsp;&nbsp;&nbsp;
                    </div>
                </td>
            </tr>        
            <tr>
                <td valign="top" style="height:100%">
                    <asp:UpdatePanel ID="UP" runat="server">
                        <ContentTemplate>                           
                          
<%--<rsweb:ReportViewer  ShowBackButton="true" ExportContentDisposition="AlwaysAttachment" ID="rvExecutionServiceReport"
                                runat="server" Font-Names="Verdana" CssClass="blackfnt" ProcessingMode="Remote" Height="600px"  width="100%" ShowParameterPrompts="False">
                                
                            </rsweb:ReportViewer>--%>
<asp:ScriptManager ID="scriptmanager1" runat="server"/>
<rsweb:ReportViewer ExportContentDisposition="AlwaysAttachment" ID="rvExecutionServiceReport"
                            runat="server" Font-Names="Verdana" CssClass="blackfnt" Height="600px" ShowBackButton="true"
                            ShowPromptAreaButton="true" ToolBarItemHoverBackColor="Aqua" ToolBarItemPressedHoverBackColor="BlueViolet" ShowParameterPrompts="False"
                            ProcessingMode="Remote" Width="100%">
                        </rsweb:ReportViewer>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                    <br />
                    <br />
                </td>
            </tr>          
        </table>
    </form>
</body>
</html>
