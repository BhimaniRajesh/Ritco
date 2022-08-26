<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="PendingFillingDate.aspx.cs" Inherits="GUI_admin_FuelSlipMaster_PendingFillingDate" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <%--<script language="javascript" type="text/javascript" src="VendorPayment.js"></script>
    <script language="javascript" type="text/javascript" src="../../../GUI/images/CommonJS.js"></script>
    <script language="javascript" type="text/javascript" src="../../../admin/FuelSlipMaster/FuelSlipMaster_JS.js"></script>
    <script language="javascript" type="text/javascript" src="FuelRateMaster.js"></script>--%>


    <script type="text/javascript" language="javascript">
        function OpenRate() {

            var ddVendorName = $("#ctl00_MyCPH1_ddVendorName")

            window.open("../../Fleet/Webadmin/FuelRateMaster/FuelRateUpdation_SubmitForValidation.aspx?VendorCode=" + ddVendorName.val(), "_blank");
        }
        function ValidateDate(obj) {
            if (obj.value != "") {
                if (isDate(obj.value) == false) {
                    obj.focus()
                    return false
                }

            }
        }

        function GetRateFillingDateWise(ctrl) {

            var txtFillingDate = $(ctrl);

            if (txtFillingDate.val() != "") {
                if (isDate(txtFillingDate.val()) == false) {
                    obj.focus()
                    return false
                }

            }

            var txtFillingDateID = $(ctrl).attr("id");
            var lblRateAsPerFillingDate = $("#" + txtFillingDateID.replace("txtFillingDate", "lblRateAsPerFillingDate"));
            var lblFinalAmount = $("#" + txtFillingDateID.replace("txtFillingDate", "lblFinalAmount"));
            var lblTotalAmount = $("#" + txtFillingDateID.replace("txtFillingDate", "lblTotalAmount"));            

            var hdnRateAsPerFillingDate = $("#" + txtFillingDateID.replace("txtFillingDate", "hdnRateAsPerFillingDate"));
            var hdnFinalAmount = $("#" + txtFillingDateID.replace("txtFillingDate", "hdnFinalAmount"));
            var hdnTotalAmount = $("#" + txtFillingDateID.replace("txtFillingDate", "hdnTotalAmount"));            

            var lblQuantity = $("#" + txtFillingDateID.replace("txtFillingDate", "lblQuantity"));
            var hdnVendorCode = $("#" + txtFillingDateID.replace("txtFillingDate", "hdnVendorCode"));
            var lblFuelType = $("#" + txtFillingDateID.replace("txtFillingDate", "lblFuelType"));
            var txtIGST = $("#" + txtFillingDateID.replace("txtFillingDate", "txtIGST"));
            var txtSGST = $("#" + txtFillingDateID.replace("txtFillingDate", "txtSGST"));
            var txtCGST = $("#" + txtFillingDateID.replace("txtFillingDate", "txtCGST"));

            if (txtFillingDate.val() != '') {
                var EndArray = txtFillingDate.val().split("/");
                var startDt = new Date();
                var endDt = new Date(EndArray[2], EndArray[1] - 1, EndArray[0]);
                if (endDt > startDt) {
                    alert('Filling date Can not be greater than Today !!');
                    txtFillingDate.focus();
                    txtFillingDate.val("");
                    return false;
                }
            }


            var obj = {};
            obj.VendorCode = hdnVendorCode.val();
            obj.FuelType = lblFuelType.text();
            obj.FillingDate = txtFillingDate.val();


            if (txtFillingDate.val() != "") {
                $.ajax({
                    type: 'POST',
                    contentType: 'application/json; charset=utf-8',
                    url: "PendingFillingDate.aspx/GetRateFillingDateWise",
                    dataType: 'json',
                    data: JSON.stringify(obj),
                    async: false,
                    success: function (data) {
                        var rate = data.d;
                        if (rate == "") {
                            alert("No contract found on selected filling date");
                            txtFillingDate.val("");
                            txtFillingDate.focus();
                        }
                        else {
                            if (parseFloat(rate) > 0) {
                                lblRateAsPerFillingDate.text(rate);
                                hdnRateAsPerFillingDate.val(rate);
                                lblFinalAmount.text((parseFloat(lblQuantity.text()) * parseFloat(lblRateAsPerFillingDate.text())).toFixed(2));
                                hdnFinalAmount.val((parseFloat(lblQuantity.text()) * parseFloat(lblRateAsPerFillingDate.text())).toFixed(2));
                                lblTotalAmount.text((parseFloat(lblQuantity.text()) * parseFloat(lblRateAsPerFillingDate.text()) + parseFloat(txtIGST.val()) + parseFloat(txtSGST.val()) + parseFloat(txtCGST.val())).toFixed(2));
                                hdnTotalAmount.val((parseFloat(lblQuantity.text()) * parseFloat(lblRateAsPerFillingDate.text()) + parseFloat(txtIGST.val()) + parseFloat(txtSGST.val()) + parseFloat(txtCGST.val())).toFixed(2));
                            }
                        }
                    },
                    error: function (e) {
                        alert(e);
                    }
                });
            }

        }
        //Filling date is not fill then total amount not change also gst not include in amont so add if else condition
        function SetFinalAmount(ctrl,id) {            
            var txtGST = $(ctrl).attr("id");
            var lblRateAsPerFillingDate = "";
            var txtFillingDate = $("#" + txtGST.replace(id, "txtFillingDate"));
            var lblFinalAmount = $("#" + txtGST.replace(id, "lblFinalAmount"));    
            var lblTotalAmount = $("#" + txtGST.replace(id, "lblTotalAmount"));    
            var hdnFinalAmount = $("#" + txtGST.replace(id, "hdnFinalAmount"));
            var hdnTotalAmount = $("#" + txtGST.replace(id, "hdnTotalAmount"));
            var lblQuantity = $("#" + txtGST.replace(id, "lblQuantity"));
            var txtIGST = $("#" + txtGST.replace(id, "txtIGST"));
            var txtSGST = $("#" + txtGST.replace(id, "txtSGST"));
            var txtCGST = $("#" + txtGST.replace(id, "txtCGST"));   
            if (txtFillingDate.val() == "") {
                lblRateAsPerFillingDate = $("#" + txtGST.replace(id, "lblWithoutFillingDateRate"));
            }
            else {
                lblRateAsPerFillingDate = $("#" + txtGST.replace(id, "lblRateAsPerFillingDate"));
                lblTotalAmount.text((parseFloat(lblQuantity.text()) * parseFloat(lblRateAsPerFillingDate.text()) + parseFloat(txtIGST.val()) + parseFloat(txtSGST.val()) + parseFloat(txtCGST.val())).toFixed(2));                    
                hdnTotalAmount.val(lblTotalAmount.text());
            }       
            lblFinalAmount.text((parseFloat(lblQuantity.text()) * parseFloat(lblRateAsPerFillingDate.text())).toFixed(2));                   
            hdnFinalAmount.val(lblFinalAmount.text());           
        }
    </script>

    <asp:UpdateProgress ID="UpdateProgress1" runat="server">
        <ProgressTemplate>
            <table style="border: solid #8ba0e5 2px; z-index: 98; position: fixed; width: 200px; -left: -60px; top: 50%; left: 40%;" width="190px" cellpadding="0" bgcolor="white">
                <tr>
                    <td align="right">
                        <img src="../../images/loading.gif" alt="" /></td>
                    <td><font face="verdana" color="#0000ff" size="2">&nbsp;&nbsp;&nbsp;<b>Please Wait ...</b></font></td>
                </tr>
            </table>
            <asp:Panel ID="Panel1" Style="position: fixed; z-index: 97; top: 0px; left: 0px; background-color: #FFFFFF; width: 100%; height: 100%; filter: Alpha(Opacity=50); opacity: .50; -moz-opacity: .50;"
                runat="server">
                <asp:Panel Style="z-index: 98; position: fixed; width: 120px; -left: -60px; top: 50%; left: 50%;"
                    ID="Panel2" runat="server">
                </asp:Panel>
            </asp:Panel>
        </ProgressTemplate>
    </asp:UpdateProgress>

    <div align="left" style="width: 75%">

        <asp:UpdatePanel ID="UP1" runat="Server">
            <ContentTemplate>
                <table cellspacing="1" border="0" style="width: 100%">
                    <tr align="left">
                        <td colspan="3">
                            <table cellspacing="1" style="width: 90%" class="boxbg" border="0">
                                <tr class="bgbluegrey">
                                    <td colspan="3" align="left" style="height: 21px">
                                        <asp:Label ID="Label5" CssClass="blackfnt" Font-Bold="true" runat="server">
                                                    Pending Filling Date
                                        </asp:Label>
                                    </td>
                                </tr>
                                <tr bgcolor="#ffffff" style="font-size: 12pt; font-family: Times New Roman">
                                    <td valign="top" align="left">
                                        <asp:Label ID="Label6" CssClass="blackfnt" Text="Select Date Range" runat="server"
                                            Width="145px"></asp:Label>
                                    </td>
                                    <td align="left" style="width: 259px" valign="top">
                                        <asp:RadioButtonList ID="radDate" runat="server" ValidationGroup="VGDtFromTo" CssClass="blackfnt"
                                            AutoPostBack="true" OnSelectedIndexChanged="radDate_SelectedIndexChanged" RepeatColumns="1"
                                            Width="244px">
                                            <asp:ListItem Value="0" Text=" Date Range [dd/mm/yyyy]"></asp:ListItem>
                                            <asp:ListItem Value="1" Text=" Last Week (Including Today)"></asp:ListItem>
                                            <asp:ListItem Selected="True" Value="2" Text=" Today:"></asp:ListItem>
                                            <asp:ListItem Value="3" Text=" Till Date:"></asp:ListItem>
                                        </asp:RadioButtonList></td>
                                    <td valign="top" align="left" style="width: 359px">
                                        <asp:Label ID="lblFrom" CssClass="blackfnt" runat="server" Text=" From: "></asp:Label>
                                        <asp:TextBox ID="txtDateFrom" runat="server" CssClass="input" BorderStyle="Groove" onblur="return ValidateDate(this)" Width="80px" TabIndex="3"></asp:TextBox></font>
                                        <ajaxToolkit:CalendarExtender ID="CalendarExtender1" Format="dd/MM/yyyy" TargetControlID="txtDateFrom" runat="server" />

                                        </a>
                                        <asp:Label ID="lblTo" CssClass="blackfnt" runat="server" Text=" To: "></asp:Label>
                                        <asp:TextBox ID="txtDateTo" runat="server" CssClass="input" BorderStyle="Groove" onblur="return ValidateDate(this)" Width="80px" TabIndex="3"></asp:TextBox></font>
                                        <ajaxToolkit:CalendarExtender ID="CalendarExtender2" Format="dd/MM/yyyy" TargetControlID="txtDateTo" runat="server" />

                                        <br />
                                        <asp:CustomValidator ID="CustomValidator1" runat="server" ErrorMessage="Date Range Must Be 1 month Only"
                                            OnServerValidate="daterange"></asp:CustomValidator>
                                    </td>
                                </tr>
                                <tr style="background-color: white">


                                    <td valign="top" align="left">
                                        <asp:Label ID="Label1" CssClass="blackfnt" Text="Select Vendor" runat="server"
                                            Width="145px"></asp:Label>
                                    </td>

                                    <td align="left" valign="top">
                                        <asp:DropDownList ID="ddVendorName" AutoPostBack="True" runat="server" Width="261px" CssClass="input">
                                        </asp:DropDownList>
                                    </td>
                                    <td align="left" valign="top">
                                        <asp:Button ID="btnRateHistory" Text="Rate history" runat="server" OnClientClick="javascript:OpenRate();" />
                                    </td>
                                </tr>
                                <tr style="background-color: white">
                                    <td colspan="4">
                                        <asp:Button ID="btnSubmit" ValidationGroup="grpQuery" runat="server" Text="Submit" OnClick="ShowPendingBills" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
                <%--*************************** Gridarea ****************************--%>
                <table border="0" cellspacing="1" cellpadding="3" width="900px">
                    <tr>
                        <td align="center">
                            <asp:UpdateProgress ID="UpdateProgress2" runat="server">
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

                <table border="0" cellspacing="1" cellpadding="3" width="900px" runat="server" id="tblDCR">
                    <tr style="background-color: white">
                        <td align="center" width="100%">
                            <asp:UpdatePanel ID="u1" UpdateMode="Conditional" runat="server">
                                <ContentTemplate>
                                    <asp:GridView ID="dgGeneral" runat="server" AutoGenerateColumns="False"
                                        CellSpacing="1" CellPadding="3" HeaderStyle-CssClass="bgbluegrey"
                                        CssClass="dgRowStyle" Width="100%" AllowPaging="false" PagerStyle-CssClass="pager" PageSize="20"
                                        PagerSettings-Mode="NumericFirstLast" EmptyDataText="No Records Found" OnRowDataBound="dgGeneral_RowDataBound">
                                        <Columns>
                                            <asp:TemplateField HeaderText="Sr No.">
                                                <ItemTemplate><%#Container.DataItemIndex+1 %></ItemTemplate>
                                            </asp:TemplateField>

                                            <asp:TemplateField runat="server" HeaderText="Filling Date" ItemStyle-HorizontalAlign="center" ItemStyle-Wrap="false">
                                                <ItemTemplate>
                                                    <asp:TextBox ID="txtFillingDate" CssClass="input" BorderStyle="Groove" runat="server" Width="86px" onblur="return GetRateFillingDateWise(this);"></asp:TextBox></font>
                                                    <ajaxToolkit:CalendarExtender ID="calExtenderStatrtDt" Format="dd/MM/yyyy" TargetControlID="txtFillingDate" runat="server" />
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:BoundField DataField="VendorName" ItemStyle-HorizontalAlign="Left" HeaderText="Vendor Name" InsertVisible="false"
                                                ReadOnly="True" HeaderStyle-HorizontalAlign="Left" SortExpression="VendorName" />
                                            <asp:BoundField DataField="VehicleNo" ItemStyle-HorizontalAlign="Left" HeaderText="Vehicle No" InsertVisible="false"
                                                ReadOnly="True" HeaderStyle-HorizontalAlign="Left" SortExpression="VendorName" />
                                            <asp:BoundField DataField="TripsheetNo" HeaderText="Tripsheet No" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" ReadOnly="True" SortExpression="Vendor Code" />
                                            <asp:BoundField DataField="TripsheetOpenDate" HeaderText="Tripsheet Open Date" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" ReadOnly="True" SortExpression="City" />
                                            <asp:BoundField DataField="VendorCity" HeaderText="Vendor City" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" ReadOnly="True" SortExpression="PeriodTo" />
                                            <%--<asp:BoundField DataField="FuelType" HeaderText="Fuel Type" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" ReadOnly="false" />--%>
                                            <asp:TemplateField HeaderText="Fuel Type">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblFuelType" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"FuelType") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="User Slip No">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblUserSlipNo" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"UserSlipNo") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <%--<asp:BoundField DataField="UserSlipNo" HeaderText="User Slip No" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" ReadOnly="true" />--%>
                                            <asp:BoundField DataField="UserSlipDate" HeaderText="User Slip Date" ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left" ReadOnly="true" />
                                            <%--<asp:BoundField DataField="Quantity" HeaderText="Quantity" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" ReadOnly="true" />--%>
                                            <asp:TemplateField HeaderText="Quantity">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblQuantity" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"Quantity") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Rate">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblWithoutFillingDateRate" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"Rate")%>' />                                                    
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <%--<asp:BoundField DataField="Rate" HeaderText="Rate" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" ReadOnly="true" />--%>
                                            <asp:TemplateField HeaderText="Rate As per Filling Date">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblRateAsPerFillingDate" runat="server" Text='0'></asp:Label>
                                                    <asp:HiddenField ID="hdnRateAsPerFillingDate" runat="server" Value='0' />
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="IGST">                                              
                                                <ItemTemplate>
                                                    <asp:TextBox ID="txtIGST" Text='<%# DataBinder.Eval(Container.DataItem,"IGST")%>' Style="text-align: right" runat="server" Width="100px" MaxLength="10" onkeypress="javascript:validFloat(event,this.getAttribute('id'))" onblur="return SetFinalAmount(this,'txtIGST')"></asp:TextBox>
                                                </ItemTemplate>                                               
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="SGST">                                                
                                                <ItemTemplate>
                                                    <asp:TextBox ID="txtSGST" Text='<%# DataBinder.Eval(Container.DataItem,"SGST")%>' Style="text-align: right" runat="server" Width="100px" MaxLength="10" onkeypress="javascript:validFloat(event,this.getAttribute('id'))" onblur="return SetFinalAmount(this,'txtSGST')"></asp:TextBox>
                                                </ItemTemplate>                                                
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="CGST">                                                
                                                <ItemTemplate>
                                                    <asp:TextBox ID="txtCGST" Text='<%# DataBinder.Eval(Container.DataItem,"CGST")%>' Style="text-align: right" runat="server" Width="100px" MaxLength="10" onkeypress="javascript:validFloat(event,this.getAttribute('id'))" onblur="return SetFinalAmount(this,'txtCGST')"></asp:TextBox>
                                                </ItemTemplate>                                               
                                            </asp:TemplateField>
                                            <%--<asp:TemplateField HeaderText="IGST">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblIGST" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"IGST")%>' />
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="SGST">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblSGST" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"SGST")%>' />
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="CGST">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblCGST" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"CGST")%>' />
                                                </ItemTemplate>
                                            </asp:TemplateField>--%>
                                             <asp:TemplateField HeaderText="Amount">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblFinalAmount" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"Amount") %>'></asp:Label>
                                                    <asp:HiddenField ID="hdnFinalAmount" runat="server" Value='<%# DataBinder.Eval(Container.DataItem,"Amount") %>' />
                                                    <asp:HiddenField ID="hdnSrNo" runat="server" Value='<%# DataBinder.Eval(Container.DataItem,"srno") %>' />
                                                    <asp:HiddenField ID="hdnVendorCode" runat="server" Value='<%# DataBinder.Eval(Container.DataItem,"VendorCode") %>' />
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Total Amount">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblTotalAmount" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"TotalAmount")%>' />
                                                    <asp:HiddenField ID="hdnTotalAmount" runat="server" Value='<%# DataBinder.Eval(Container.DataItem,"TotalAmount") %>' />
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                           

                                            <%--<asp:BoundField DataField="Amount" HeaderText="Amount" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" ReadOnly="true" />--%>
                                        </Columns>
                                    </asp:GridView>

                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </td>
                    </tr>


                    <tr id="trCancel">
                        <td align="right">
                            <asp:Button runat="server" Text="Submit" ID="btnSubmitBills" OnClick="btnSubmitBills_Click" />
                        </td>
                    </tr>

                    <tr>
                        <td align="right">
                            <asp:Label runat="server" ID="lblSuccess" ForeColor="Blue" Text=""></asp:Label>
                        </td>
                    </tr>
                </table>

                <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConflictDetection="CompareAllValues"></asp:SqlDataSource>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
</asp:Content>








