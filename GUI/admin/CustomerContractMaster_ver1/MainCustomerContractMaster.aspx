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
    <asp:UpdateProgress ID="ProgressIndicator" runat="server">
        <ProgressTemplate>
            <div id="progressArea">
                <asp:Label ID="lblLS" runat="server" Text="Please wait..." CssClass="blackfnt" Font-Bold="true"></asp:Label>
                <asp:Image ID="LoadingImage" runat="server" ImageUrl="~/GUI/images/indicator.gif" />
            </div>
        </ProgressTemplate>
    </asp:UpdateProgress>
</asp:Content>
