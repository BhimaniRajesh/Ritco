<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="dcr_series_to_be_alloted.aspx.cs" Inherits="GUI_admin_dcr_series_to_be_alloted"
    Title="Untitled Page" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

<asp:UpdatePanel id="UpdatePanel1" runat="server">
    <ContentTemplate>
    <table cellspacing="1" style="width: 100%">
        <tr style="background-color: white">
            <td align="left">
                <asp:Label ID="lblPageHead" CssClass="blackfnt" Font-Bold="true" runat="server">DCR Allotment</asp:Label>
                <hr align="center" size="1" color="#8ba0e5">
            </td>
        </tr>
    </table>
    <br />
    <table border="0" cellspacing="1" cellpadding="1" width="75%" class="boxbg">
        <tr class="bgbluegrey">
            <td colspan="2" style="text-align: center">
                <asp:Label ID="lblTblHeader" runat="server" CssClass="blackfnt" Text="Select DCR Criteria"
                    Font-Bold="true"></asp:Label>
            </td>
        </tr>
        <tr bgcolor="white">
            <td align="left" rowspan="4" valign="Top">
                <asp:Label ID="lblDCRDate" runat="server" CssClass="blackfnt" Text="DCR Date :">
                </asp:Label>
            </td>
            <td align="left">
                <asp:RadioButton ID="radFromToDate" GroupName="Dates" runat="server" Text="" />
                <asp:Label ID="lblFromDate" runat="server" CssClass="blackfnt" Text="From :" />
                <asp:TextBox ID="txtFrom" runat="server" MaxLength="10" Width="70"></asp:TextBox>
                <asp:Image ID="cal1" runat="server" ImageUrl="~/GUI/images/calendar.jpg" />
                <asp:RegularExpressionValidator ID="REVDtFrom" runat="server" ErrorMessage="!"
                    ControlToValidate="txtFrom" ValidationExpression="(((0[1-9]|[12][0-9]|3[01])([-./])(0[13578]|10|12)([-./])(\d{4}))|(([0][1-9]|[12][0-9]|30)([-./])(0[469]|11)([-./])(\d{4}))|((0[1-9]|1[0-9]|2[0-8])([-./])(02)([-./])(\d{4}))|((29)(\.|-|\/)(02)([-./])([02468][048]00))|((29)([-./])(02)([-./])([13579][26]00))|((29)([-./])(02)([-./])([0-9][0-9][0][48]))|((29)([-./])(02)([-./])([0-9][0-9][2468][048]))|((29)([-./])(02)([-./])([0-9][0-9][13579][26])))"></asp:RegularExpressionValidator>
                &nbsp;
                <asp:Label ID="lblToDate" runat="server" CssClass="blackfnt" Text=" To " />
                &nbsp;
                <asp:TextBox ID="txtTo" runat="server" MaxLength="10" Width="70"></asp:TextBox>
                <asp:Image ID="cal2" runat="server" ImageUrl="~/GUI/images/calendar.jpg"/>
                <asp:RegularExpressionValidator ID="REVDtTo" runat="server" ErrorMessage="!"
                    ControlToValidate="txtTo" ValidationExpression="(((0[1-9]|[12][0-9]|3[01])([-./])(0[13578]|10|12)([-./])(\d{4}))|(([0][1-9]|[12][0-9]|30)([-./])(0[469]|11)([-./])(\d{4}))|((0[1-9]|1[0-9]|2[0-8])([-./])(02)([-./])(\d{4}))|((29)(\.|-|\/)(02)([-./])([02468][048]00))|((29)([-./])(02)([-./])([13579][26]00))|((29)([-./])(02)([-./])([0-9][0-9][0][48]))|((29)([-./])(02)([-./])([0-9][0-9][2468][048]))|((29)([-./])(02)([-./])([0-9][0-9][13579][26])))"></asp:RegularExpressionValidator>
                
                <asp:Label ID="lblddmmyyyy" runat="server" CssClass="blackfnt" Text=" [dd/mm/yyyy] " />
            </td>
        </tr>
        <tr bgcolor="white">
            <td align="left">
                <asp:RadioButton ID="radToday" GroupName="Dates" runat="server" Text="" />
                <asp:Label ID="lblToday" runat="server" CssClass="blackfnt">Today's - <%=dtToday%></asp:Label>
            </td>
        </tr>
        <tr bgcolor="white">
            <td align="left">
                <asp:RadioButton ID="radLastWeek" GroupName="Dates" runat="server" Text=""  Checked="true"/>
                <asp:Label ID="lblLastWeek" runat="server" CssClass="blackfnt">Last Week's - <%=dtLastWeek%></asp:Label>
            </td>
        </tr>
        <tr bgcolor="white">
            <td align="left">
                <asp:RadioButton ID="radTillDate" GroupName="Dates" runat="server" Text="" />
                <asp:Label ID="lblTillDate" runat="server" CssClass="blackfnt">Till Date</asp:Label>
            </td>
        </tr>
        <tr bgcolor="white">
        <td align="left" rowspan="2" valign="Top">
                <asp:Label ID="Label1" runat="server" CssClass="blackfnt" Text="Business Type :">
                </asp:Label>
            </td>
        </tr>
        <tr bgcolor="white">
            <td align="left">
                <asp:DropDownList ID="ddlBusType" runat="server"></asp:DropDownList>
            </td>            
       </tr>
       
        <tr bgcolor="White">
            <td align="left" colspan="2" >
                <asp:Button ID="btnSubmit" runat="server" CssClass="blackfnt" Text="Show Series >>" OnClick="BindRepeater"/>
            </td>
        </tr>
        
    </table>
    <br />
    <table border="0" cellpadding="1" cellspacing="1" width="85%">
        <tr align="center">
            <td>
                <asp:UpdateProgress ID="ProgressIndicator" runat="server">
                    <ProgressTemplate>
                        <div id="progressArea">
                            <asp:Label ID="lblLS" runat="server" Text="Please wait..." CssClass="blackfnt" Font-Bold="true"></asp:Label>
                            <asp:Image ID="LoadingImage" runat="server" ImageUrl="~/GUI/images/indicator.gif" />
                        </div>
                    </ProgressTemplate>
                </asp:UpdateProgress>
            </td> 
        </tr>
    </table>            
    <table border="0" class="boxbg" cellpadding="1" cellspacing="1" width="85%">
        <tr runat="server" class="bgbluegrey" id="SeriesList" visible="true">
            <td align="center" style="width: 7%">
                <asp:Label ID="lblSrNo" runat="server" CssClass="blackfnt" Font-Bold="true">Sr. No</asp:Label>
            </td>
            <td align="center" style="width: 10%">
                <asp:Label ID="lblBookCode" runat="server" CssClass="blackfnt" Font-Bold="true">Book Code</asp:Label>
            </td>
            <td align="center">
                <asp:Label ID="lblSrFrom" runat="server" CssClass="blackfnt" Font-Bold="true">Series From</asp:Label>
            </td>
            <td align="center">
                <asp:Label ID="lblSrTo" runat="server" CssClass="blackfnt" Font-Bold="true">Series To</asp:Label>
            </td>
            <td align="center" style="width: 10%">
                <asp:Label ID="lblTotalLeafs" runat="server" CssClass="blackfnt" Font-Bold="true">Total Leafs</asp:Label>
            </td>
            <td align="center" style="width: 15%">
                <asp:Label ID="lblDCR_Date" runat="server" CssClass="blackfnt" Font-Bold="true">DCR Date</asp:Label>
            </td>
             <td align="center" style="width: 15%">
                <asp:Label ID="Label2" runat="server" CssClass="blackfnt" Font-Bold="true">Business Type</asp:Label>
            </td>
            <td align="center" style="width: 15%">
                <asp:Label ID="lblAllocate" runat="server" CssClass="blackfnt" Font-Bold="true">&nbsp;</asp:Label>
            </td>
        </tr>
        
        <tr runat="server" bgcolor="White" id="NoRecFound" visible="false">
            <td align="left" colspan="8">
                <asp:Label ID="lblNoRecordsFount" runat="server" CssClass="redfnt" Font-Bold="false">No Series found for given criteria...</asp:Label>
            </td>
        </tr>
        
        <asp:Repeater ID="rptSeriesList" runat="server" Visible="false">
            <ItemTemplate>
                <tr runat="server" bgcolor="white" id="Tr1" visible="true">
                    <td align="center" style="width: 7%">
                        <asp:Label ID="lblSrNo" runat="server" CssClass="blackfnt"><%# Container.ItemIndex + 1%></asp:Label>
                    </td>
                    <td align="center" style="width: 10%">
                        <asp:Label ID="lblBookCode" runat="server" CssClass="blackfnt"><%#DataBinder.Eval(Container.DataItem, "BookCode")%></asp:Label>
                    </td>
                    <td align="center">
                        <asp:Label ID="lblSrFrom" runat="server" CssClass="blackfnt"><%#DataBinder.Eval(Container.DataItem, "DOC_SR_FROM")%></asp:Label>
                    </td>
                    <td align="center">
                        <asp:Label ID="lblSrTo" runat="server" CssClass="blackfnt"><%#DataBinder.Eval(Container.DataItem, "DOC_SR_TO")%></asp:Label>
                    </td>
                    <td align="center" style="width: 10%">
                        <asp:Label ID="lblTotalLeafs" runat="server" CssClass="blackfnt"><%#DataBinder.Eval(Container.DataItem, "TOT_LEAF")%></asp:Label>
                    </td>
                    <td align="center" style="width: 15%">
                        <asp:Label ID="lblDCR_Date" runat="server" CssClass="blackfnt"><%#DataBinder.Eval(Container.DataItem, "DCR_Date")%></asp:Label>
                    </td>
                    <td align="center" style="width: 15%">
                        <asp:Label ID="Label3" runat="server" CssClass="blackfnt"><%#DataBinder.Eval(Container.DataItem, "BUSINESS_TYPE")%></asp:Label>
                    </td>
                    <td align="center" style="width: 15%">
                        <a href='./dcr_allot.aspx?DOCKey=<%#DataBinder.Eval(Container.DataItem, "DOC_KEY") %>&DCRSeriesFrom=<%#DataBinder.Eval(Container.DataItem, "DOC_SR_FROM") %>&DCRSeriesTo=<%#DataBinder.Eval(Container.DataItem, "DOC_SR_TO") %>'>Allocate</a>
                    </td>
                    
                </tr>
            </ItemTemplate>
        </asp:Repeater>
    </table>
        </ContentTemplate>
</asp:UpdatePanel>

</asp:Content>
