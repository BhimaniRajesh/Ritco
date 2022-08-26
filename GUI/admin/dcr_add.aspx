<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="dcr_add.aspx.cs" Inherits="GUI_admin_dcr_add" Title="Untitled Page" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">
    <script type="text/javascript" language="javascript">
        function MakeUpper(objRef)
        {
            // This gets the value for the textbox that was focussed
            var curValue = objRef.value;     
            //Assign the suggested value to the box
            objRef.value = curValue.toUpperCase();
        }

        function Check() {

            var dgGeneral = document.getElementById("ctl00_MyCPH1_dgGeneral");

            if (dgGeneral != null) {
                if (dgGeneral.rows.length != 0) {
                    for (i = 0; i < dgGeneral.rows.length - 2; i++) {
                        j = i + 2;
                        var pref = "";
                        if (j < 10) {
                            pref = "ctl00$MyCPH1$dgGeneral$ctl0" + j + "$";
                        }
                        else {
                            pref = "ctl00$MyCPH1$dgGeneral$ctl" + j + "$";
                        }
                        var txtBookCode = document.getElementById(pref + "txtBookCode");
                        var txtSeriesFrom = document.getElementById(pref + "txtSeriesFrom");
                        var txtAlloteTo = document.getElementById(pref + "txtAlloteTo");

                        if (txtBookCode.value == "") {
                            alert("Enter Book Code!!!");
                            txtBookCode.focus();
                            return false;
                        }
                        if (txtSeriesFrom.value == "") {
                            alert("Enter Series From!!!");
                            txtSeriesFrom.focus();
                            return false;
                        }
                        if (txtAlloteTo.value == "") {
                            alert("Enter Allote To!!!");
                            txtAlloteTo.focus();
                            return false;
                        }
                       
                    }
                }
            }


        }
        
    </script>
    <table cellspacing="1" style="width: 100%">
        <tr style="background-color: white">
            <td align="left">
                <asp:Label ID="lblPageHead" CssClass="blackfnt" Font-Bold="true" runat="server">Add DCR Series</asp:Label>
                <hr align="center" size="1" color="#8ba0e5" />
            </td>
        </tr>
    </table>
    <br />
    
    <table cellspacing="1" style="width: 75%">
    
        <tr>
            <td align="left">
                <asp:UpdatePanel ID="UPAddRow" runat="server"    UpdateMode="Conditional" RenderMode="Inline">
                    <ContentTemplate>
                        <asp:LinkButton ID="AddRow" runat="server" Text="+" CssClass="blackfnt" Font-Bold="true"
                            CausesValidation="false" OnClick="AddNewRow">
                        </asp:LinkButton>&nbsp;
                    </ContentTemplate>
                </asp:UpdatePanel>
                <asp:Label ID="lblAddRec" runat="server" Text="Add Row" CssClass="bluefnt"></asp:Label>
                <asp:Label ID="lblNB" runat="server" Text="[Max 10 Series]" Font-Italic="true" CssClass="redfnt"></asp:Label>
                
            </td>
        </tr>
   
    
        <tr style="background-color: white">
            <td align="left">
                <asp:UpdatePanel ID="UpdatePanel1"   UpdateMode="Conditional" RenderMode="Inline" runat="server">
                    <ContentTemplate>
                        <asp:GridView EnableViewState="true" ID="dgGeneral" runat="server" BorderWidth="1"
                            HeaderStyle-CssClass="dgHeaderStyle" AllowSorting="true" AutoGenerateColumns="false"
                            CssClass="dgRowStyle" EmptyDataText="No Records Found..." BorderColor="#8ba0e5" CellSpacing="2" CellPadding="2"
                            OnRowDataBound="dg_RowDataBound" OnRowCommand="dg_RowCommand" OnRowCreated="dg_RowCreated">
                            <%--DataKeyNames="ProductCode,Classification,Quantity,BasicValue,CustomDutyRate,CVDRate,EduCESSRate,CustomEduCESSRate,AddImportDutyRate"--%>
                            <Columns>
                                <asp:TemplateField>
                                    <ItemTemplate>
                                        <asp:LinkButton ID="DeleteRow" ToolTip="Delete This Row" runat="server" CausesValidation="false"
                                            Text="X"></asp:LinkButton>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <%-- Sr No. --%>
                                <asp:TemplateField HeaderText="Sr.No" ItemStyle-HorizontalAlign="left" ItemStyle-Wrap="false">
                                    <ItemTemplate>
                                        <asp:Label EnableViewState="true" ID="lblSrNo" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "SrNo")%>' />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <%-- Document Type --%>
                                <asp:TemplateField HeaderText="Doc. Type" ItemStyle-HorizontalAlign="left" ItemStyle-Wrap="false">
                                    <ItemTemplate>
                                        <asp:DropDownList ID="cboDocType" runat="server" Visible="true" DataTextField="CodeDesc" DataValueField="CodeID" AutoPostBack="true" OnSelectedIndexChanged="cboDocType_OnSelectedIndexChanged"/>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                
                                <%-- Book Code --%>
                                <asp:TemplateField HeaderText="Book Code" ItemStyle-HorizontalAlign="center" ItemStyle-Wrap="false">
                                    <ItemTemplate>
                                        <asp:TextBox EnableViewState="true" ID="txtBookCode" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "BookCode")%>'
                                            Width="80" MaxLength="10"  CssClass="input" onchange="javascript:MakeUpper(this)"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RFVBookCode" ControlToValidate="txtBookCode" runat="server" CssClass="redfnt" ErrorMessage="*"></asp:RequiredFieldValidator>    
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <%-- Series From --%>
                                <asp:TemplateField HeaderText="Series From" ItemStyle-HorizontalAlign="center" ItemStyle-Wrap="false">
                                    <ItemTemplate>
                                        <asp:TextBox EnableViewState="true" ID="txtSeriesFrom" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "SeriesFrom")%>'
                                            Width="80" MaxLength="25" CssClass="input" onchange="javascript:MakeUpper(this)" ></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RFVSeriesFrom" ControlToValidate="txtSeriesFrom"  runat="server" CssClass="redfnt" ErrorMessage="*"></asp:RequiredFieldValidator>    
                                    </ItemTemplate>
                                </asp:TemplateField>
                                
                                <%-- Business Type --%>
                                <asp:TemplateField HeaderText="Business Type" ItemStyle-HorizontalAlign="left" ItemStyle-Wrap="false">
                                    <ItemTemplate>
                                        <asp:DropDownList ID="cboBusType" runat="server" />
                                        <asp:Label ID="lblNA" runat="server" Text="N/A" Visible="false"></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>

                                <%-- Total Leafs --%>
                                <asp:TemplateField HeaderText="Total Leafs" ItemStyle-HorizontalAlign="right" ItemStyle-Wrap="false">
                                    <ItemTemplate>
                                        <asp:DropDownList ID="cboTotalLeafs" runat="server">
											<asp:ListItem Enabled="true" Text="25" Value="25"></asp:ListItem>
                                            <asp:ListItem Enabled="true" Text="50" Value="50" Selected="True"></asp:ListItem>
                                            <asp:ListItem Enabled="true" Text="100" Value="100"></asp:ListItem>
                                        </asp:DropDownList>
                                    </ItemTemplate>
                                </asp:TemplateField>

                                <%-- Allote To --%>
                                <asp:TemplateField HeaderText="Allote To" ItemStyle-HorizontalAlign="center" ItemStyle-Wrap="false">
                                    <ItemTemplate>
                                        <asp:TextBox EnableViewState="true" ID="txtAlloteTo" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "AlloteTo")%>'
                                            Width="80" MaxLength="10" onchange="javascript:MakeUpper(this)" ></asp:TextBox>
                                            <asp:RequiredFieldValidator ID="RFVSeriesFrom33" ControlToValidate="txtAlloteTo"  runat="server" CssClass="redfnt" ErrorMessage="*"></asp:RequiredFieldValidator>    
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                            <RowStyle BorderColor="Black" BorderStyle="None" BorderWidth="1px" />
                            <HeaderStyle CssClass="dgHeaderStyle" />
                        </asp:GridView>
                    </ContentTemplate>
                    <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="AddRow" EventName="Click" />
                        <asp:AsyncPostBackTrigger ControlID="btnSaveSeries" EventName="Click" />
                    </Triggers>
                </asp:UpdatePanel>
             </td>
        </tr>
        
        <tr>
            <td align="left">
                <asp:UpdatePanel ID="UPStockEntry" runat="server"  UpdateMode="Conditional" RenderMode="Inline">
                    <ContentTemplate>
                        <asp:Button ID="btnSaveSeries" runat="server" Text="Save Series >>" OnClick="btnSaveSeries_Click" 
                        OnClientClick="javascript:Check()"/>

                        <br /> <br />
                        <asp:Label runat="server" ID="lblResultHdr" CssClass="bluefnt" Font-Bold="true" Text=""></asp:Label>
                        <br />
                        <asp:GridView ID="dgResult" runat="server" BorderWidth="1" HeaderStyle-CssClass="dgHeaderStyle"
                            AllowSorting="true" AutoGenerateColumns="false" CssClass="dgRowStyle" 
                            BorderColor="#8ba0e5" CellSpacing="2" CellPadding="2">
                            <Columns>
                                <asp:BoundField DataField="doc_type" HeaderText="Doc. Type">
                                    <ItemStyle HorizontalAlign="center" />
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" />
                                </asp:BoundField>
                                <asp:BoundField DataField="series_from" HeaderText="Series From">
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" />
                                </asp:BoundField>
                                <asp:BoundField DataField="leafs" HeaderText="Leafs">
                                    <ItemStyle HorizontalAlign="right" />
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" />
                                </asp:BoundField>
                                <asp:BoundField DataField="allote_to" HeaderText="Allote To">
                                    <ItemStyle HorizontalAlign="center" />
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" />
                                </asp:BoundField>
                                <asp:BoundField DataField="trans_status" HeaderText="Trnasaction Status">
                                    <ItemStyle HorizontalAlign="center" />
                                    <HeaderStyle HorizontalAlign="center" Wrap="false" />
                                </asp:BoundField>
                                <asp:BoundField DataField="trans_description" HeaderText="Description">
                                    <ItemStyle HorizontalAlign="Left" Wrap="false"/>
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" />
                                </asp:BoundField>
                            </Columns>
                            <RowStyle BorderColor="Black" BorderStyle="None" BorderWidth="1px" />
                            <HeaderStyle CssClass="dgHeaderStyle" />
                        </asp:GridView>

                    </ContentTemplate>
                </asp:UpdatePanel>
                &nbsp;
                <asp:UpdateProgress runat="server" ID="Prog1">
                    <ProgressTemplate>
                        <asp:Image ID="imgWait" ImageUrl="~/GUI/images/indicator.gif" runat="server" BorderStyle="none" />
                        <asp:Label ID="lblWait" runat="server" Text="Please Wait..." CssClass="blackfnt"
                            ForeColor="red"></asp:Label>
                    </ProgressTemplate>
                </asp:UpdateProgress>
            </td>
        </tr>        
    </table>
</asp:Content>

