<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="LoadingUnLoadingSundryFTLSelection.aspx.cs" Inherits="LoadingUnLoadingSundryFTLSelection" EnableEventValidation="false" %>

<%@ OutputCache Location="none" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script language="javascript" type="text/javascript">

            function btnsubmitClick()
            {
                var optsundry = document.getElementById("ctl00_MyCPH1_optsundry");
                var optftl = document.getElementById("ctl00_MyCPH1_optftl");
                
                if(optsundry.checked==false && optftl.checked==false)
                {
                    alert("No option is Selected. Please select any one Option");
                    return false;
                }
                
                return true;
            }
            
    </script>

    <br />
    <br />
    <asp:Panel runat="server" Width="10in">
    <asp:UpdateProgress ID="uppMain" runat="server">
                <ProgressTemplate>
                    <table style="border: solid #8ba0e5 2px; z-index: 98; position: fixed; width: 200px; -left: -60px; top: 50%;
                            left: 40%;" width="190px" cellpadding="0"
                        bgcolor="white">
                        <tr>
                            <td align="right">
                                <img src="../../images/loading.gif" alt="" />
                            </td>
                            <td>
                                <font face="verdana" color="#0000ff" size="2">&nbsp;&nbsp;&nbsp;<b>Please Wait ...</b></font>
                            </td>
                        </tr>
                    </table>
                    <asp:Panel ID="Panel1" Style="position: fixed; z-index: 97; top: 0px; left: 0px; background-color: #FFFFFF;
                        width: 100%; height: 100%; filter: Alpha(Opacity=50); opacity: .50; -moz-opacity: .50;"
                        runat="server">
                        <asp:Panel Style="z-index: 98; position: fixed; width: 120px; -left: -60px; top: 50%;
                            left: 50%;" ID="Panel2" runat="server">
                        </asp:Panel>
                    </asp:Panel>
                </ProgressTemplate>
            </asp:UpdateProgress>
        <asp:Table runat="server" Width="100%">
            <asp:TableRow>
                <asp:TableCell>
                    <asp:Table ID="Table1" HorizontalAlign="Left" runat="server" CssClass="blackfnt">
                        <asp:TableRow BackColor="White">
                            <asp:TableCell>
				       &nbsp;ContractID  
                            </asp:TableCell>
                            <asp:TableCell>
                                :
                                <asp:Label ID="lblcontractid" runat="server" onmouseover="this.style.cursor='pointer'"
                                    CssClass="redfnt" Font-Bold="true"></asp:Label>
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow BackColor="White">
                            <asp:TableCell>
				       &nbsp;Customer Code & Name &nbsp;
                            </asp:TableCell>
                            <asp:TableCell>
                                :
                                <asp:Label ID="lblcustcodename" runat="server" onmouseover="this.style.cursor='pointer'"
                                    CssClass="blackfnt" Font-Bold="true"></asp:Label>
                            </asp:TableCell>
                        </asp:TableRow>
                    </asp:Table>
                </asp:TableCell>
            </asp:TableRow>
            <asp:TableRow>
                <asp:TableCell HorizontalAlign="Center">
                <br /><br />
                    <asp:Table CellSpacing="1" Width="60%" CellPadding="0" runat="server" CssClass="boxbg">
                        <asp:TableRow CssClass="bgbluegrey">
                            <asp:TableCell ColumnSpan="2" Font-Bold="true">
                                <asp:Label ID="lblheader" Font-Bold="true" runat="server" CssClass="blackfnt"></asp:Label>
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow CssClass="bgwhite">
                            <asp:TableCell HorizontalAlign="Center">
                                <asp:RadioButton ID="optsundry" runat="server" GroupName="grpsundry" />
                            </asp:TableCell>
                            <asp:TableCell HorizontalAlign="left">
                                Sundry
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow CssClass="bgwhite">
                            <asp:TableCell HorizontalAlign="Center">
                                <asp:RadioButton ID="optftl" runat="server" GroupName="grpsundry" />
                            </asp:TableCell>
                            <asp:TableCell HorizontalAlign="left">
                                FTL
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow CssClass="bgbluegrey">
                            <asp:TableCell ColumnSpan="2">
                                <asp:Button ID="btnsubmit" Text="Submit" runat="server" CssClass="blackfnt" OnClientClick="javascript:return btnsubmitClick()"
                                    OnClick="btnsubmit_Click" />
                            </asp:TableCell>
                        </asp:TableRow>
                    </asp:Table>
                </asp:TableCell>
            </asp:TableRow>
        </asp:Table>
    </asp:Panel>
    <br />
    <br />
    <br />
    <br />
    <br />
</asp:Content>
