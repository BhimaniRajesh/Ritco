<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="MVKupdate.aspx.cs" Inherits="GUI_Fleet_MVK_MVKupdate" Title="Untitled Page" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">

 <script type="text/javascript" language="javascript" src="MVKupdate.js"></script>

<table cellspacing="1" style="width: 100%">
        <tr style="background-color: white">
            <td align="left">
                <asp:Label ID="Label1" CssClass="blackfnt" Font-Bold="True" runat="server">Month Vehicle KM. Update Upload Utility</asp:Label>
                <hr align="center" size="1" color="#8ba0e5" />
            </td>
        </tr>
    </table>

    <table class="boxbg" cellspacing="1" style="width:100%; font-size: 8pt; font-family: Verdana;">
    <tr  class="bgwhite">
            <td colspan="3" align="right"  class="blackfnt" style="width: 20%">
        
                <asp:HyperLink ID="HyperLink1" runat="server" Font-Underline="True" ForeColor="Blue"
                                    NavigateUrl="~/GUI/Fleet/Document/DownloadFile.aspx?FileName=Month_Vehicle_KM.xls"
                                    Target="_blank">Format of Month Vehicle KM </asp:HyperLink>
            </td>
            </tr>
                                    
        <tr  class="bgwhite">
            <td  class="blackfnt" style="width: 20%">
               <b><asp:Label ID="Label2" runat="server" Text="Select MVK Master File : "></asp:Label>
               </b>
            </td>
            <td  class="blackfnt" style="width: 50%">
                <input id="FileUpload_MVK" runat="server" type="file" style="width: 350px; border-right: green 1px solid; border-top: green 1px solid; border-left: green 1px solid; border-bottom: green 1px solid;" onchange="ValidFile(this)" onclick="ValidFile(this)" name="elementName" />
                <asp:Button ID="btn_GetData" runat="server" Text="Get Data" OnClientClick="javascript:return CheckValid()" OnClick="btn_GetData_Click"  />
            </td>
            <td style="width: 30%">
                <asp:Label ID="lbl_Error_Msg"  Visible="True" runat="server" ForeColor="Red"></asp:Label>
                <asp:Label ID="lbl_Duplicate_Error"  Visible="False" runat="server" ForeColor="Red"></asp:Label>
                
            </td>
        </tr>
    </table>  

    <div id="div_Invalid_Data" runat="server" visible="false">
        <br />

        <table class="boxbg" visible="true" cellspacing="1" style="width:100%; font-size: 8pt; font-family: Verdana;">
            <tr class="bgwhite">
                <td>
                    <asp:Label ID="lbl_Invalid_Data" runat="server" CssClass="blackfnt" Font-Bold="True" Text="The following MVKs found to be holding invalid data....<br />!! The rest MVKs, don't have such problem, have been uploaded successfully !!"></asp:Label>
                </td>
            </tr>
            <tr class="bgwhite">
                <td>
                    <asp:GridView ID="gv_Invalid_Data" runat="server" AutoGenerateColumns="True" 
                        Style="text-align: center" HeaderStyle-CssClass="blackfnt" 
                        BackColor="White" BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px" 
                        CellPadding="3" AllowSorting="False" CssClass="blackfnt" Width="100%">

                        <HeaderStyle CssClass="GridHeader" />
                        <RowStyle CssClass="GridRow" HorizontalAlign="Center" />
                        <AlternatingRowStyle CssClass="GridAlternatingRow" />
                    </asp:GridView>
                </td>
            </tr>
        </table>
    </div>

    <div id="div_New_Data" runat="server" visible="false">
        <br />

        <table class="boxbg" visible="true" cellspacing="1" style="width:100%; font-size: 8pt; font-family: Verdana;">
            <tr class="bgwhite">
                <td>
                    <asp:Label ID="Label3" runat="server" CssClass="blackfnt" Font-Bold="True" Text="The following MVKs Related data are invalid....<br />!! The rest MVKs have been uploaded successfully !!"></asp:Label>
                </td>
            </tr>
            <tr class="bgwhite">
                <td>
                    <asp:GridView ID="gv_New_Data" runat="server" AutoGenerateColumns="True" 
                        Style="text-align: center" HeaderStyle-CssClass="blackfnt" 
                        BackColor="White" BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px" 
                        CellPadding="3" AllowSorting="False" CssClass="blackfnt" Width="100%">

                        <HeaderStyle CssClass="GridHeader" />
                        <RowStyle CssClass="GridRow" HorizontalAlign="Center" />
                        <AlternatingRowStyle CssClass="GridAlternatingRow" />
                    </asp:GridView>
                </td>
            </tr>
        </table>
    </div>
    <div id="div_Not_In_Master" runat="server" visible="false">
        <br />
        
        <table class="boxbg" visible="true" cellspacing="1" style="width:100%; font-size: 8pt; font-family: Verdana;">
            <tr class="bgwhite">
                <td>
                    <asp:Label ID="lbl_Not_In_Master" runat="server" CssClass="blackfnt" Font-Bold="True" Text="The following MVKs found, holding the information not found in Master....<br />!! The rest MVKs, don't have such problem, have been uploaded successfully !!"></asp:Label>
                </td>
            </tr>
            <tr class="bgwhite">
                <td>
                    <asp:GridView ID="gv_Not_In_Master" runat="server" AutoGenerateColumns="True" 
                        Style="text-align: center" HeaderStyle-CssClass="blackfnt" 
                        BackColor="White" BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px" 
                        CellPadding="3" AllowSorting="False" CssClass="blackfnt" Width="100%">

                        <HeaderStyle CssClass="GridHeader" />
                        <RowStyle CssClass="GridRow" HorizontalAlign="Center" />
                        <AlternatingRowStyle CssClass="GridAlternatingRow" />
                    </asp:GridView>
                </td>
            </tr>
        </table>
    </div>

    <div id="div_Duplicate_MVK" runat="server" visible="false">
        <br />
        
        <table class="boxbg" visible="true" cellspacing="1" style="width:100%; font-size: 8pt; font-family: Verdana;">
            <tr class="bgwhite">
                <td>
                    <asp:Label ID="lbl_Duplicate_MVK" runat="server" CssClass="blackfnt" Font-Bold="True" Text="The following MVKs already uploded....<br />!! The rest MVKs, don't have such problem, have been uploaded successfully !!"></asp:Label>
                </td>
            </tr>
            <tr class="bgwhite">
                <td>
                    <asp:GridView ID="gv_Duplicate_MVK" runat="server" AutoGenerateColumns="True" 
                        Style="text-align: center" HeaderStyle-CssClass="blackfnt" 
                        BackColor="White" BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px" 
                        CellPadding="3" AllowSorting="False" CssClass="blackfnt" Width="100%">

                        <HeaderStyle CssClass="GridHeader" />
                        <RowStyle CssClass="GridRow" HorizontalAlign="Center" />
                        <AlternatingRowStyle CssClass="GridAlternatingRow" />
                    </asp:GridView>
                </td>
            </tr>
        </table>
    </div>
    <%--
    <div id="div_Duplicate_MVK" runat="server" visible="false">
        <br />

        <table class="boxbg" visible="true" cellspacing="1" style="width:100%; font-size: 8pt; font-family: Verdana;">
            <tr class="bgwhite">
                <td>
                    <asp:Label ID="lbl_Duplicate_MVK" runat="server" CssClass="blackfnt" Font-Bold="True" Text="The following MVKs contain duplicate MVKs. Please Provide merged MVKs....<br />!! The rest MVKs, don't have such problem, have been uploaded successfully !!"></asp:Label>
                </td>
            </tr>
            <tr class="bgwhite">
                <td>
                    <asp:GridView ID="gv_Duplicate_MVK" runat="server" AutoGenerateColumns="True" 
                        Style="text-align: center" HeaderStyle-CssClass="blackfnt" 
                        BackColor="White" BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px" 
                        CellPadding="3" AllowSorting="False" CssClass="blackfnt" Width="100%">

                        <HeaderStyle CssClass="GridHeader" />
                        <RowStyle CssClass="GridRow" HorizontalAlign="Center" />
                        <AlternatingRowStyle CssClass="GridAlternatingRow" />
                    </asp:GridView>
                </td>
            </tr>
        </table>
    </div>--%>

    <br />

    <center>
        <b><asp:Label ID="lbl_Page_Error" runat="server" CssClass="bluefnt" Font-Size="Medium"></asp:Label></b>
    </center>
  

</asp:Content>

