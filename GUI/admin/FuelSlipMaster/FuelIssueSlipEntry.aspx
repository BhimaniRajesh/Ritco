<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master" CodeFile="FuelIssueSlipEntry.aspx.cs" Inherits="GUI_admin_FuelSlipMaster_FuelIssueSlipEntry" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <asp:UpdatePanel ID="upDCRReDeAllot" UpdateMode="Conditional" RenderMode="Inline" runat="server">
        <ContentTemplate>
            <script language="javascript" type="text/javascript" src="../../Fleet/Webadmin/FuelRateMaster/VendorPayment.js"></script>
            <script language="javascript" type="text/javascript" src="../../../GUI/images/CommonJS.js"></script>
            <script language="javascript" type="text/javascript" src="FuelSlipMaster_JS.js?V1"></script>

            <script language="javascript" type="text/javascript">
                function validFloat(event, txtid) {
                    var tb = document.getElementById(txtid);
                    var txt = tb.value;
                    if (event.keyCode == 13)
                        return true;

                    if (event.keyCode == 46)
                        if (txt.indexOf('.') != -1)
                            event.keyCode = 0;

                    if ((event.keyCode < 46 || event.keyCode > 57) || event.keyCode == 47)
                    { event.keyCode = 0; return false; }
                }
            </script>

            <script type="text/javascript">
                function blockSpecialChar(e) {
                    var k;
                    document.all ? k = e.keyCode : k = e.which;
                    return ((k > 64 && k < 91) || (k > 96 && k < 123) || k == 8 || (k >= 48 && k <= 57)); //AlphaNumeric with No Spaces
                }
            </script>

            <script type="text/javascript">
                function CheckEmpty() {
                    var EntryDate = document.getElementById("ctl00_MyCPH1_txtEntryDate").value;

                    if (EntryDate == "") {
                        alert("Please enter entry date");
                        document.getElementById("ctl00_MyCPH1_txtEntryDate").focus();
                        return false;
                    }

                    if (document.getElementById('ctl00_MyCPH1_ddVendorName').value == 0 || document.getElementById('ctl00_MyCPH1_ddVendorName').value == "") {
                        alert("Please select vendor name");
                        document.getElementById('ctl00_MyCPH1_ddVendorName').focus();
                        return false;
                    }

                }
            </script>

            <table border="0" cellspacing="1" cellpadding="3" width="900px" class="boxbg" id="tblDCRCriteria" runat="server" visible="true">
                <tr class="bgbluegrey">
                    <td colspan="6" style="text-align: left" align="center">
                        <asp:Label ID="lblTblHeader" runat="server" CssClass="blackfnt" Text="Fuel Issue Slip Entry"
                            Font-Bold="true"></asp:Label>
                    </td>
                </tr>

                <tr bgcolor="white">
                    <td align="left" width="20%">
                        <font class="blackfnt">Vendor Type</font>&nbsp;&nbsp;
                    </td>
                    <td align="left">
                        <font class="blackfnt">Fuel Vendor</font>
                    </td>
                    <td align="left" id="tdVendorlbl" width="25%">

                        <font class="blackfnt">Entry Date</font>&nbsp;&nbsp;

                    </td>
                    <td style="width: 129px">
                        <font class="blackfnt">
                            <asp:TextBox ID="txtEntryDate" runat="server" CssClass="input" BorderStyle="Groove" onblur="return ValidateDate(this)" Width="86px" Enabled="false"></asp:TextBox>

                        </font>
                        <%--onblur="return ValidateDate(this)--%>
                       <%-- <ajaxToolkit:CalendarExtender ID="calExtenderStatrtDt" Format="dd/MM/yyyy" TargetControlID="txtEntryDate" runat="server" />--%>
                    </td>
                </tr>

                <tr bgcolor="white">
                    <td align="left" width="20%">
                        <font class="blackfnt">Vendor Contact No.</font>&nbsp;&nbsp;
                    </td>
                    <td align="left">
                        <asp:Label ID="lblVendorContactNo" runat="server" Text=""></asp:Label>
                    </td>

                    <td align="left" id="tdVendor1lbl" width="25%">
                        <font class="blackfnt">Select Vendor Name</font>&nbsp;&nbsp;
                    </td>
                    <td align="left">
                        <asp:DropDownList ID="ddVendorName" AutoPostBack="True" runat="server" Width="300px" CssClass="input" OnSelectedIndexChanged="ddVendorName_SelectedIndexChanged">
                        </asp:DropDownList>
                    </td>
                </tr>


                <tr bgcolor="white">
                    <td align="right" colspan="4">
                        <asp:Button ID="btnSubmit" ValidationGroup="grpQuery" OnClick="btnSubmit_Click" OnClientClick="return CheckEmpty()" runat="server" Text="Submit" />
                        <%-- &nbsp;&nbsp;&nbsp;
                        <asp:Button ID="btnView" ValidationGroup="grpQuery" runat="server" Text="View" OnClick="Redirect" />--%>
                    </td>
                </tr>
            </table>
            <br />
            <table border="0" cellspacing="1" cellpadding="3" width="900px">
                <tr>
                    <td align="center">
                        <asp:UpdateProgress ID="UpdateProgress1" runat="server">
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

            <table align="left" cellspacing="1" runat="server" style="width: 100%" border="0">
                <tr style="background-color: white" id="trDataGrid">
                    <%--display:block"--%>
                    <td align="left" colspan="2">

                        <asp:UpdatePanel ID="UpdatePanel1" UpdateMode="Conditional" RenderMode="Inline" runat="server">
                            <ContentTemplate>
                                <table align="left" id="tblGrid" runat="server" cellspacing="1" cellpadding="2" class="boxbg">

                                    <tr style="background-color: white">
                                        <td colspan="2">
                                            <asp:Label ID="lblError" runat="server" Visible="true" CssClass="redfnt"> 
                                            </asp:Label>
                                        </td>
                                    </tr>

                                    <tr style="background-color: white" align="left">
                                        <td align="left" width="20%">
                                            <font class="blackfnt">Enter no. of rows </font>&nbsp;&nbsp;
                                        </td>
                                        <td align="left">
                                            <asp:TextBox ID="txtRow" runat="server" MaxLength="3" Width="30"
                                                onkeypress="javascript:validFloat(event,this.getAttribute('id'))"
                                                BorderStyle="Groove" Text="0" AutoPostBack="true"
                                                OnTextChanged="txtRow_TextChanged"></asp:TextBox>
                                            <asp:RegularExpressionValidator ID="RegtxtRow" runat="server"
                                                ErrorMessage="!" ValidationExpression="^\$?[+-]?[\d,]*\.?\d{0,2}$" SetFocusOnError="true"
                                                ControlToValidate="txtRow" Display="Dynamic"></asp:RegularExpressionValidator>
                                        </td>
                                    </tr>

                                    <tr style="background-color: white">
                                        <td colspan="2">
                                            <asp:UpdatePanel ID="UpdatePanel3" UpdateMode="Conditional" RenderMode="Inline" runat="server">
                                                <ContentTemplate>
                                                    <asp:GridView ID="dgWorkgroup" runat="server" PageSize="1000"
                                                        AutoGenerateColumns="False" CellPadding="2" BorderWidth="3px"
                                                        CellSpacing="1" Width="100%" Height="1px" ItemStyle-HorizontalAlign="Left" OnRowDataBound="dgWorkgroup_RowDataBound"
                                                        BorderColor="#006699" BorderStyle="None" CssClass="blackfnt">
                                                        <Columns>
                                                            <asp:TemplateField HeaderText="Sr.No.">
                                                                <ItemTemplate>
                                                                    <center>
                                                                        <%#Container.DataItemIndex + 1%>.
                                                                <asp:Label ID="count" runat="server" Visible="false" Text=' <%# Container.DataItemIndex + 1%>'></asp:Label>
                                                                        <asp:HiddenField ID="hfTaskId" runat="server" Value="" />
                                                                    </center>
                                                                </ItemTemplate>
                                                                <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                    Font-Underline="False" Wrap="False" />
                                                                <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                    Font-Underline="False" Wrap="False" />
                                                            </asp:TemplateField>
                                                            <asp:TemplateField HeaderText="Vehicle No.">
                                                                <ItemTemplate>
                                                                    <asp:TextBox ID="txtVehicleNo" CssClass="input" BorderStyle="Groove" Width="80px" runat="server"></asp:TextBox>
                                                                    <ajaxToolkit:AutoCompleteExtender ID="Ext1" runat="server"
                                                                        Enabled="True"
                                                                        CompletionListItemCssClass="autocomplete_listItem"
                                                                        CompletionListHighlightedItemCssClass="autocomplete_highlightedListItem" MinimumPrefixLength="1"
                                                                        ServiceMethod="GetVehicleOpenTripsheet" ServicePath="~/GUI/Fleet/AtlasAutoComplete.asmx" TargetControlID="txtVehicleNo">
                                                                    </ajaxToolkit:AutoCompleteExtender>
                                                                    <%--ServiceMethod="GetVehicleOpenTripsheet"/ GetVehicleMaster>--%>
                                                                </ItemTemplate>
                                                                <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                    Font-Underline="False" Wrap="False" />
                                                                <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                    Font-Underline="False" Wrap="False" />
                                                            </asp:TemplateField>
                                                            <asp:TemplateField HeaderText="Tripsheet No.">
                                                                <ItemTemplate>
                                                                    <asp:TextBox ID="txtTripsheetNo" Style="text-align: left" Enabled="false" runat="server" CssClass="input" BorderStyle="Groove" Width="80px"></asp:TextBox>
                                                                </ItemTemplate>
                                                                <HeaderStyle HorizontalAlign="Left" Font-Bold="False" />
                                                            </asp:TemplateField>
                                                            <asp:TemplateField HeaderText="Tripsheet Open Date" HeaderStyle-Width="70px">
                                                                <ItemTemplate>
                                                                    <asp:TextBox ID="txtTripsheetOpenDate" Style="text-align: left" Enabled="false" runat="server" CssClass="input" BorderStyle="Groove" Width="60px"></asp:TextBox>
                                                                </ItemTemplate>
                                                                <HeaderStyle HorizontalAlign="Left" Font-Bold="False" />
                                                            </asp:TemplateField>
                                                            <asp:TemplateField HeaderText="City">
                                                                <ItemTemplate>
                                                                    <%-- <asp:Label runat="server" ID="lblVendorCity"></asp:Label>--%>
                                                                    <asp:TextBox ID="txtVendorCity" Style="text-align: left" runat="server" Enabled="false" CssClass="input" BorderStyle="Groove" Width="60px"></asp:TextBox>
                                                                </ItemTemplate>
                                                                <HeaderStyle HorizontalAlign="Left" Font-Bold="False" />
                                                            </asp:TemplateField>

                                                            <asp:TemplateField HeaderText="Fuel Type">

                                                                <ItemTemplate>
                                                                    <asp:DropDownList ID="ddFuelType" OnSelectedIndexChanged="ddFuelType_SelectedIndexChanged1" AutoPostBack="true" runat="server" BorderStyle="Groove" Width="80px">
                                                                        <asp:ListItem Selected="True" Value="Select">-Select-</asp:ListItem>
                                                                        <asp:ListItem Value="Diesel">Diesel</asp:ListItem>
                                                                        <asp:ListItem Value="AddBlue">Add Blue</asp:ListItem>
                                                                        <asp:ListItem Value="CNG">CNG</asp:ListItem>
                                                                    </asp:DropDownList>
                                                                </ItemTemplate>

                                                                <HeaderStyle HorizontalAlign="Left" Font-Bold="False" />
                                                            </asp:TemplateField>
                                                            <asp:TemplateField HeaderText="Slip No.">
                                                                <ItemTemplate>
                                                                    <asp:TextBox ID="txtSlipNo" Style="text-align: left" MaxLength="10" runat="server" CssClass="input" onkeypress="return blockSpecialChar(event)" BorderStyle="Groove" Width="60px"></asp:TextBox>

                                                                    <%--TRY MAYANK START--%>
                                                                    <asp:Label ID="lbl_txtSlipNo_Err" runat="server" CssClass="balckfnt" ForeColor="Red"></asp:Label>
                                                                    <asp:UpdatePanel
                                                                        ID="UpdatePanel2" runat="server" RenderMode="Inline" UpdateMode="Conditional">
                                                                        <ContentTemplate>
                                                                            <asp:Label ID="lblSPN" runat="server" CssClass="balckfnt" ForeColor="red"></asp:Label>
                                                                        </ContentTemplate>
                                                                        <Triggers>
                                                                            <asp:AsyncPostBackTrigger ControlID="txtSlipNo" EventName="TextChanged" />
                                                                        </Triggers>
                                                                    </asp:UpdatePanel>
                                                                    <%--TRY MAYANK END--%>
                                                                </ItemTemplate>
                                                                <HeaderStyle HorizontalAlign="Left" Font-Bold="False" />
                                                            </asp:TemplateField>

                                                            <asp:TemplateField HeaderText="Slip Date">
                                                                <ItemTemplate>
                                                                    <asp:Label ID="lblFrom" CssClass="blackfnt" runat="server"></asp:Label>

                                                                    <asp:TextBox ID="txtSlipDate" CssClass="input" BorderStyle="Groove" runat="server" Width="86px" onblur="return ValidateDate(this)"></asp:TextBox></font>
                                                           <ajaxToolkit:CalendarExtender ID="calExtenderStatrtDt" Format="dd/MM/yyyy" TargetControlID="txtSlipDate" runat="server" />
                                                                </ItemTemplate>
                                                                <HeaderStyle HorizontalAlign="Left" Font-Bold="False" />
                                                            </asp:TemplateField>

                                                            <asp:TemplateField HeaderText="Fuel Quantity">
                                                                <ItemTemplate>
                                                                    <asp:TextBox ID="txtQtyLiter" runat="server" Style="text-align: right" CssClass="input" BorderStyle="Groove" Width="90px" onkeypress="javascript:validFloat(event,this.getAttribute('id'))"></asp:TextBox>
                                                                    <asp:RegularExpressionValidator ID="RegtxtQtyLiter" runat="server"
                                                                        ErrorMessage="!" ValidationExpression="^\$?[+-]?[\d,]*\.?\d{0,2}$" SetFocusOnError="true"
                                                                        ControlToValidate="txtQtyLiter" Display="Dynamic"></asp:RegularExpressionValidator>
                                                                </ItemTemplate>
                                                                <HeaderStyle HorizontalAlign="Left" Font-Bold="False" />
                                                            </asp:TemplateField>

                                                            <asp:TemplateField HeaderText="Rate/Ltr">
                                                                <ItemTemplate>
                                                                    <asp:TextBox ID="txtVendorRate" Enabled="false" CssClass="input" Width="50px" BorderStyle="Groove" runat="server"></asp:TextBox>
                                                                </ItemTemplate>
                                                                <HeaderStyle HorizontalAlign="Left" Font-Bold="False" />
                                                            </asp:TemplateField>


                                                            <asp:TemplateField HeaderText="Amount">
                                                                <ItemTemplate>
                                                                    <asp:TextBox ID="txtAmount" CssClass="input" BorderStyle="Groove" onkeypress="javascript:validFloat(event,this.getAttribute('id'))" Width="50px" runat="server"></asp:TextBox>
                                                                    <asp:RegularExpressionValidator ID="RegtxtAmount" runat="server"
                                                                        ErrorMessage="!" ValidationExpression="^\$?[+-]?[\d,]*\.?\d{0,2}$" SetFocusOnError="true"
                                                                        ControlToValidate="txtAmount" Display="Dynamic"></asp:RegularExpressionValidator>
                                                                </ItemTemplate>
                                                                <HeaderStyle HorizontalAlign="Left" Font-Bold="False" />
                                                            </asp:TemplateField>
                                                            <asp:TemplateField HeaderText="IGST">
                                                                <HeaderStyle HorizontalAlign="Left" Wrap="False" CssClass="blackfnt" />
                                                                <ItemTemplate>
                                                                    <asp:TextBox ID="txtIGST" Style="text-align: right" runat="server" Width="100px" MaxLength="10" onkeypress="javascript:validFloat(event,this.getAttribute('id'))" ></asp:TextBox>
                                                                </ItemTemplate>
                                                                <ItemStyle Width="15%" HorizontalAlign="Left" VerticalAlign="Middle" CssClass="bgwhite" />
                                                            </asp:TemplateField>
                                                            <asp:TemplateField HeaderText="SGST">
                                                                <HeaderStyle HorizontalAlign="Left" Wrap="False" CssClass="blackfnt" />
                                                                <ItemTemplate>
                                                                    <asp:TextBox ID="txtSGST" Style="text-align: right" runat="server" Width="100px" MaxLength="10" onkeypress="javascript:validFloat(event,this.getAttribute('id'))" ></asp:TextBox>
                                                                </ItemTemplate>
                                                                <ItemStyle Width="15%" HorizontalAlign="Left" VerticalAlign="Middle" CssClass="bgwhite" />
                                                            </asp:TemplateField>
                                                            <asp:TemplateField HeaderText="CGST">
                                                                <HeaderStyle HorizontalAlign="Left" Wrap="False" CssClass="blackfnt" />
                                                                <ItemTemplate>
                                                                    <asp:TextBox ID="txtCGST" Style="text-align: right" runat="server" Width="100px" MaxLength="10" onkeypress="javascript:validFloat(event,this.getAttribute('id'))" ></asp:TextBox>
                                                                </ItemTemplate>
                                                                <ItemStyle Width="15%" HorizontalAlign="Left" VerticalAlign="Middle" CssClass="bgwhite" />
                                                            </asp:TemplateField>
                                                            <asp:TemplateField HeaderText="Total Amount">
                                                                <HeaderStyle HorizontalAlign="Left" Wrap="False" CssClass="blackfnt" />
                                                                <ItemTemplate>
                                                                    <asp:TextBox ID="txtamounttotal" Style="text-align: right" runat="server" Width="100px" MaxLength="10" Enabled="false"></asp:TextBox>
                                                                </ItemTemplate>
                                                                <ItemStyle Width="15%" HorizontalAlign="Left" VerticalAlign="Middle" CssClass="bgwhite" />
                                                            </asp:TemplateField>
                                                            <asp:TemplateField HeaderText="Remark">
                                                                <ItemTemplate>
                                                                    <asp:TextBox ID="txtRemark" Style="text-align: right" runat="server" CssClass="input" BorderStyle="Groove" Width="120px"></asp:TextBox>
                                                                </ItemTemplate>
                                                                <HeaderStyle HorizontalAlign="Left" Font-Bold="False" />

                                                            </asp:TemplateField>
                                                            
                                                            <asp:TemplateField HeaderText="Action">
                                                                <ItemTemplate>
                                                             
                                                                    <asp:ImageButton ID="ButtonAdd" runat="server" OnClick="ButtonAdd_Click" ImageUrl="~/images/png/24/button-add.png" />
                                                                </ItemTemplate>
                                                                

                                                            </asp:TemplateField>
                                                            <asp:TemplateField HeaderText="Remove">
                                                                <ItemTemplate>
                                                                    <asp:ImageButton ID="btnRemove" runat="server" OnClick="btnRemove_Click" ImageUrl="~/images/png/24/button-cross.png" />
                                                                       
                                                                </ItemTemplate>
                                                                

                                                            </asp:TemplateField>

                                                        </Columns>
                                                    </asp:GridView>
                                                </ContentTemplate>

                                            </asp:UpdatePanel>
                                        </td>
                                    </tr>
                                    <tr style="background-color: white">
                                        <td colspan="3" align="center">
                                            <asp:Button ID="btnFinalSubmit" runat="server" Text="Submit" Visible="false" OnClick="btnFinalSubmit_Click" />
                                        </td>
                                    </tr>
                                </table>
                            </ContentTemplate>
                            <Triggers>
                                <asp:AsyncPostBackTrigger ControlID="txtRow" EventName="TextChanged" />
                            </Triggers>
                        </asp:UpdatePanel>
                    </td>
                </tr>
            </table>

            <%--*************************************************** END ***************************************************************--%>

            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConflictDetection="CompareAllValues"></asp:SqlDataSource>
        </ContentTemplate>
    </asp:UpdatePanel>

    <div id="divDate" style="position: absolute; visibility: hidden; background-color: white; z-index: 99;">
    </div>
</asp:Content>


