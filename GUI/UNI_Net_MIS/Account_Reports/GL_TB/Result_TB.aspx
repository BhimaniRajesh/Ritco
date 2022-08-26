<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="Result_TB.aspx.cs" Inherits="GUI_UNI_Net_MIS_Account_Reports_GL_TB_Result_TB" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
<table style="width: 10.5in" border="0" align="left" cellpadding="0" cellspacing="0">
        <tr>
            <td height="30">
                <font class="bluefnt"><strong> <u>&gt;&gt;&gt;Trail Balance</u></strong></font>
            </td>
        </tr>
         <tr>
                <td class="horzblue">
                    <img src="../../../images/clear.gif" width="2" height="1" /></td>
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
                                        <img src="../../../images/loading.gif" alt="" />
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
                    <img alt="Back" src="../../../images/back.gif" border="0" />
                </a>
            </td>
        </tr>
        <tr>
            <td>
                <br />
               
                <table border="0" horizontalalign="left" cellpadding="3" cellspacing="1" style="width: 5.5in;"
                    class="boxbg">
                    <tr bgcolor="white" class="blackfnt">
                        <td>
                            Date</td>
                        <td>
                            <asp:Label runat="server" ID="LBLDATE"></asp:Label></td>
                    </tr>
                    <tr bgcolor="white" class="blackfnt">
                        <td>
                            Branch</td>
                        <td>
                            <asp:Label runat="server" ID="LBLBRANCH"></asp:Label></td>
                    </tr>
                    <tr bgcolor="white" class="blackfnt">
                        <td>
                            Report Type</td>
                        <td>
                            <asp:Label runat="server" ID="LBLRPT"></asp:Label></td>
                    </tr>
                    <tr bgcolor="white" class="blackfnt">
                        <td>
                            Report Sub Type</td>
                        <td>
                            <asp:Label runat="server" ID="LBLSUBRPT"></asp:Label></td>
                    </tr>
                </table>
                <br />
                
            </td>
        </tr>
        <tr bgcolor="white">
        <br />
            <td colspan="2" align="left">
                <asp:Button ID="Button1" Text="DownLoad XLS" runat="server" Width="170" OnClick="btn_csv_Click" />
            </td>
        </tr>
        <tr>
        <td>
            <br />
            <asp:Table ID="TBL_TB" border="0" HorizontalAlign="left" runat="server" CellPadding="3"
                CellSpacing="1" Style="width: 8.5in;" CssClass="boxbg">
            </asp:Table>
            <br />
        </td>
        </tr>
        <tr bgcolor="white">
       
            <td colspan="2" align="left"> <br />
                <asp:Button ID="Button2" Text="DownLoad XLS" runat="server" Width="170" OnClick="btn_csv_Click" />
            </td>
        </tr>
    </table>
</asp:Content>
