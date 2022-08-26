<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="dcr_allot.aspx.cs" Inherits="GUI_admin_dcr_allot" Title="Untitled Page" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <table cellspacing="1" style="width: 100%">
        <tr style="background-color: white">
            <td align="left">
                <asp:Label ID="lblPageHead" CssClass="blackfnt" Font-Bold="true" runat="server">DCR Allotment of Series: <%=DCRSeries%></asp:Label>
                <hr align="center" size="1" color="#8ba0e5">
            </td>
        </tr>
    </table>
    <br />
    <table cellspacing="1" cellpadding="1" border="0" runat="server" style="width: 50%" class="boxbg" id="tblAllotTo" visible="true">
        <tr class="bgbluegrey">
            <td align="center" colspan="2">
                <asp:Label ID="lblAllot" CssClass="blackfnt" Font-Bold="True" runat="server">Allot DCR Series: <%=DCRSeries%></asp:Label>
            </td>
        </tr>
        <tr style="background-color: white">
            <td align="left" width="10%">
                <asp:Label ID="Label1" CssClass="blackfnt" Font-Bold="false" runat="server">To:</asp:Label>
            </td>
            <td align="left">
                <asp:ListBox SelectionMode="Single" runat="server" ID="cboAllotTo" Rows="1" ValidationGroup="grpDCR">
                    <%--                    <asp:ListItem Text="-Select-" Selected="true" Value=""></asp:ListItem>
                    <asp:ListItem Text="Bombay" Selected="true" Value="BLR"></asp:ListItem>
--%>
                </asp:ListBox>
                <asp:RequiredFieldValidator ID="RFV" runat="server" ControlToValidate="cboAllotTo"
                    ErrorMessage="*" CssClass="redfnt" ValidationGroup="grpDCR"></asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr style="background-color: white">
            <td align="right" colspan="2">
                <asp:Button ID="btnSubmit" runat="server" ValidationGroup="grpDCR" Text="<< Allot Series >>" OnClick="btnAllotSeries_Click"/>
            </td>
        </tr>
    </table>
    <br />
    <table border="0" class="boxbg" cellpadding="1" cellspacing="1" width="70%">
        <tr runat="server" bgcolor="white" id="ResultHdr" visible="false">
            <td align="center" colspan="3">
                <asp:Label ID="lblResultHdr" runat="server" CssClass="blackfnt" Font-Bold="true">Result</asp:Label>
            </td>
        </tr>
        <tr runat="server" class="bgbluegrey" id="AllotResult" visible="false">
            <td align="center" style="width: 10%">
                <asp:Label ID="Label2" runat="server" CssClass="blackfnt" Font-Bold="true">Type</asp:Label>
            </td>
            <td align="center" style="width: 40%">
                <asp:Label ID="lblBookCode" runat="server" CssClass="blackfnt" Font-Bold="true">Series</asp:Label>
            </td>
            <td align="center" style="width: 20%">
                <asp:Label ID="lblAllocate" runat="server" CssClass="blackfnt" Font-Bold="true">Alloted To</asp:Label>
            </td>
            <td align="center" style="width: 30%">
                <asp:Label ID="lblTrans" runat="server" CssClass="blackfnt" Font-Bold="true">&nbsp;</asp:Label>
            </td>
        </tr>
        
        <asp:Repeater ID="rptSeriesAllotResult" runat="server" Visible="false">
            <ItemTemplate>
                <tr runat="server" bgcolor="white" id="SeriesAllot" visible="true">
                    <td align="center" style="width: 10%">
                        <asp:Label ID="lblType" runat="server" CssClass="blackfnt"><%#DataBinder.Eval(Container.DataItem, "Type")%></asp:Label>
                    </td>
                    <td align="left" style="width: 40%">
                        <asp:Label ID="lblSreries" runat="server" CssClass="blackfnt"><%#DataBinder.Eval(Container.DataItem, "Series")%></asp:Label>
                    </td>
                    <td align="center" style="width: 20%">
                        <asp:Label ID="lblAllocTo" runat="server" CssClass="blackfnt"><%#DataBinder.Eval(Container.DataItem, "AllotedTo")%></asp:Label>
                    </td>

                    <td align="center" style="width: 30%">
                        <asp:Label ID="lblTrn" runat="server" CssClass="blackfnt"><%#DataBinder.Eval(Container.DataItem, "IsSucessful")%></asp:Label>
                    </td>
                </tr>
            </ItemTemplate>
        </asp:Repeater>        
    </table>


    <br />
    <br />    
    <br />
        <table border="0" class="boxbg" cellpadding="1" cellspacing="1" width="30%">
        <tr runat="server" class="bgbluegrey"  id="NextStepHdr" visible="true">
            <td align="left">
                <asp:Label ID="Label3" runat="server" CssClass="blackfnt" Font-Bold="true">Your Next Step:</asp:Label>
            </td>
        </tr>
        <tr runat="server" bgcolor="white" id="Step1" visible="true">
            <td align="left">
                <li>
                <asp:LinkButton ID="lnk1" runat="server" Text="Allot More Series" PostBackUrl="~/GUI/admin/dcr_series_to_be_alloted.aspx" CssClass="blackfnt"></asp:LinkButton>
                </li>
            </td>
        </tr>
        <tr runat="server" bgcolor="white" id="Step2" visible="false">
            <td align="left">
                <li>
                <asp:LinkButton ID="lnk2" runat="server" Text="Add More Series" PostBackUrl="~/GUI/admin/dcr_add.aspx" CssClass="blackfnt"></asp:LinkButton>
                </li>
            </td>
        </tr>
    </table>

</asp:Content>
