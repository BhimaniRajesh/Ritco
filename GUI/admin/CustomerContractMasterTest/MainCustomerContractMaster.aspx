<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="MainCustomerContractMaster.aspx.cs" Inherits="MainCustomerContractMaster"
    EnableEventValidation="false" %>

<%@ OutputCache Location="none" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script type="text/javascript" language="javascript">
           
     function btnnext()
     {     
        var btnnext = document.getElementById("ctl00_MyCPH1_btnnext");
        var btnnext1 = document.getElementById("ctl00_MyCPH1_btnnext1");
        btnnext.style.display="none";
        btnnext1.style.display="block";
        return true;
     }         
            
    </script>

    <br /><br /><br /><br />
    <asp:Panel runat="server" Width="10in">
    <asp:Table runat="server" HorizontalAlign="Center" CellSpacing="1" CssClass="boxbg" Style="width: 70%">
        <asp:TableRow CssClass="bgbluegrey" runat="server">
            <asp:TableCell Font-Bold="true" HorizontalAlign="center">
                  Customer Contract Master
            </asp:TableCell>
        </asp:TableRow>
        <asp:TableRow BackColor="White">
            <asp:TableCell>
            <asp:DropDownList ID="cmbeditcustomer" runat="Server" BackColor="White" DataValueField="custcd"
                    DataTextField="custnm" CssClass="blackfnt" Width="500px">
                </asp:DropDownList>
            </asp:TableCell>
        </asp:TableRow>
        <asp:TableRow CssClass="bgbluegrey">
            <asp:TableCell HorizontalAlign="Right">
             <asp:Button ID="btnnext" Text="Next >>" CssClass="blackfnt" runat="server"
                    ToolTip="Click here to edit contract details for the selected customer" OnClientClick="javascript:return btnnext();"
                    OnClick="btnnext_Click" />
                    <asp:Button ID="btnnext1" Text="Next >>" Enabled="false" style="display:none;" CssClass="blackfnt" runat="server"
                    ToolTip="Click here to edit contract details for the selected customer" OnClientClick="javascript:return btnnext();"
                    OnClick="btnnext_Click" />
            </asp:TableCell>
        </asp:TableRow>
    </asp:Table>
      </asp:Panel>
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
</asp:Content>
