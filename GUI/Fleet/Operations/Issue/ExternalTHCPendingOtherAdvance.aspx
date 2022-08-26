<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="ExternalTHCPendingOtherAdvance.aspx.cs" Inherits="GUI_Fleet_Operations_Issue_ExternalTHCPendingOtherAdvance" %>

<%@ Register TagPrefix="UC5" TagName="UCMyPaymentControl" Src="~/UserControls/Webx_PaymentControl.ascx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <script language="JavaScript" type="text/javascript">
        var cal = new CalendarPopup("testdiv1");
        cal.setCssPrefix("TEST");
        cal.showNavigationDropdowns();


    </script>
    <script language="JavaScript" src="../../../images/CalendarPopup.js"></script>
    <script language="javascript" src="../../../images/commonJs.js"></script>
    <script language="javascript" src="../../../images/DateControl.js"></script>
    <script language="JavaScript" type="text/javascript">
      

        function CheckValidate(check) {
            var PaidAmount= $(check).closest("tr").find($("[id*=txtPaid]")).val();
            var lblOtherPandingAmount = $(check).closest("tr").find($("[id*=lblOtherPandingAmount]")).text();
            var lblTotalAmount = $("#ctl00_MyCPH1_lblTotalAmount").val();
           // var txtTDS = $("#ctl00_MyCPH1_txtTDS").val();
            var lblNetAmount = $("#ctl00_MyCPH1_lblNetAmount").val();
            var txtPaid = $(check).closest("tr").find($("[id*=txtPaid]")).val();
            
            if ($(check).is(":checked") == true) {
                if (PaidAmount == "" || PaidAmount == 0) {
                    $(check).prop('checked', false);
                    alert("Paid amount can not be blank or zero.!, Please enter amount");
                    $(check).closest("tr").find($("[id*=txtPaid]")).focus();
                    return false;
                } else if (parseFloat(PaidAmount) > parseFloat(lblOtherPandingAmount)) {
                    $(check).prop('checked', false);
                    alert("Paid amount can not be greater than Balance amount.!");
                    $(check).closest("tr").find($("[id*=txtPaid]")).focus();
                    return false;
                } else {
                    lblTotalAmount = parseFloat(lblTotalAmount) +parseFloat(txtPaid)
                    lblNetAmount = parseFloat(lblNetAmount) + parseFloat(txtPaid) ;
                    $("#ctl00_MyCPH1_lblTotalAmount").val(lblTotalAmount);
                    $("#ctl00_MyCPH1_lblNetAmount").val(lblNetAmount);
                    $(check).closest("tr").find($("[id*=txtPaid]")).attr('readOnly', 'readonly');
                }
            } else {
                lblTotalAmount = parseFloat(lblTotalAmount) - parseFloat(txtPaid)
                lblNetAmount = parseFloat(lblNetAmount) - parseFloat(txtPaid);
                $("#ctl00_MyCPH1_lblTotalAmount").val(lblTotalAmount);
                $("#ctl00_MyCPH1_lblNetAmount").val(lblNetAmount);
                $(check).closest("tr").find($("[id*=txtPaid]")).removeAttr('readOnly');
            }
            if (document.getElementById('ctl00$MyCPH1$UCMyPaymentControl1$ddlPayMode').value == "Cash") {
                {
                    document.getElementById('ctl00$MyCPH1$UCMyPaymentControl1$txtCashAmt').value = lblNetAmount;//CurrPayment;
                }
            }

            if (document.getElementById('ctl00$MyCPH1$UCMyPaymentControl1$ddlPayMode').value == "Bank") {
                {
                    document.getElementById('ctl00$MyCPH1$UCMyPaymentControl1$txtChqAmt').value = lblNetAmount;//CurrPayment;
                }
            }
            document.getElementById('ctl00$MyCPH1$UCMyPaymentControl1$txtAmtApplA').value = lblNetAmount;//CurrPayment;
            document.getElementById('ctl00$MyCPH1$UCMyPaymentControl1$txtNetPay').value = lblNetAmount;//CurrPayment;
        }
        function OnTDSChange() {
            
            var txtTDS = $("#ctl00_MyCPH1_txtTDS").val();
            if (txtTDS == "") {
                $("#ctl00_MyCPH1_txtTDS").val(0);
                txtTDS=0;
            }
            var lblTotalAmount = $("#ctl00_MyCPH1_lblTotalAmount").val();
            if (lblTotalAmount != 0 && parseFloat(lblTotalAmount) > 0) {
                lblTotalAmount = parseFloat(lblTotalAmount) - parseFloat(txtTDS);
                $("#ctl00_MyCPH1_lblNetAmount").val(lblTotalAmount);
                var lblNetAmount = $("#ctl00_MyCPH1_lblNetAmount").val();
                if (document.getElementById('ctl00$MyCPH1$UCMyPaymentControl1$ddlPayMode').value == "Cash") {
                    {
                        document.getElementById('ctl00$MyCPH1$UCMyPaymentControl1$txtCashAmt').value = lblNetAmount;//CurrPayment;
                    }
                }

                if (document.getElementById('ctl00$MyCPH1$UCMyPaymentControl1$ddlPayMode').value == "Bank") {
                    {
                        document.getElementById('ctl00$MyCPH1$UCMyPaymentControl1$txtChqAmt').value = lblNetAmount;//CurrPayment;
                    }
                }
                document.getElementById('ctl00$MyCPH1$UCMyPaymentControl1$txtAmtApplA').value = lblNetAmount;//CurrPayment;
                document.getElementById('ctl00$MyCPH1$UCMyPaymentControl1$txtNetPay').value = lblNetAmount;//CurrPayment;
            }
            
            
        }
        function ValidateSubmit() {
            var cnt = 0;
            $("[id*=gvETHCPayment] tr").each(function () {
                if ($(this).find("input[id$=chkSelect]").is(":checked") == true) {
                    cnt += 1;
                }
               
            });
            if (cnt == 0) {
                alert("Please select atleast one ETHC no. for payment!");
                return false;
            }
            return CheckData();
            if (!confirm("Are you sure you want to submit data?")) {
                return false;
            }
            return true;
        }
       
    </script>

    <div align="left">
        <table  width="100%" border="0" align="left" cellpadding="0" cellspacing="0">
            <tr>
                <td height="30">
                    <font class="blklnkund"><strong>Module</strong></font> <strong>&gt; </strong>
                    <font class="blklnkund"><strong>Fleet </strong></font><font class="bluefnt">
                        <strong>&gt;</strong>
                        <strong>External THC Pending Other Advance  </strong></font><font class="bluefnt">
                            <strong>&gt;</strong>
                            <strong>Payment</strong> </font>
                </td>
            </tr>

            <tr>
                <td valign="top">
                    <table cellspacing="1" width="100%" class="boxbg" align="left">
                        <tr class="bgbluegrey">
                            <td  align="center">
                                <asp:Label ID="lblHeader" CssClass="blackfnt" Font-Bold="true" runat="server">External THC Pending Other Advance Payment</asp:Label>
                            </td>
                        </tr>
                       <tr>
                           <td>
                              <asp:GridView ID="gvETHCPayment" runat="server" CellPadding="2" CellSpacing="1"
                                        AutoGenerateColumns="False" SelectedIndex="1" ShowFooter="false" OnRowDataBound="gvETHCPayment_RowDataBound"
                                        width="100%"  BorderColor="#006699" BorderStyle="None" BorderWidth="3px" HeaderStyle-CssClass="bgbluegrey"
                                        CssClass="dgRowStyle" OnRowCreated="gvETHCPayment_RowCreated">
                                        <Columns>
                                            <asp:TemplateField HeaderText="Select">
                                                <HeaderStyle HorizontalAlign="Center" Wrap="False" />
                                                <ItemTemplate>
                                                    <asp:CheckBox Text="" ID="chkSelect" runat="server" onclick="javascript: CheckValidate(this);" />
                                                </ItemTemplate>
                                                <ItemStyle Width="10%" HorizontalAlign="Center" VerticalAlign="Middle" CssClass="bgwhite" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Sr. No.">
                                                <HeaderStyle HorizontalAlign="Center" Wrap="False" />
                                                <ItemTemplate>
                                                    <asp:Label ID="lbl_Sr_No" Text="<%#Container.DataItemIndex + 1%>" runat="server"></asp:Label>
                                                </ItemTemplate>
                                                <ItemStyle Width="10%" HorizontalAlign="Left" VerticalAlign="Middle" CssClass="bgwhite" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="External THC No">
                                                <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                                <ItemTemplate>
                                                    <asp:Label ID="lblExternalTHCNo" Text='<%# DataBinder.Eval(Container.DataItem,"ExternalTHCNo")%>' runat="server"></asp:Label>
                                                </ItemTemplate>
                                                <ItemStyle  HorizontalAlign="Left" VerticalAlign="Middle" CssClass="bgwhite" />
                                            </asp:TemplateField>
                                             <%--<asp:BoundField NullDisplayText="NA" DataField="ExternalTHCNo" HeaderText="External THC No" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" />--%>
                                            <asp:BoundField NullDisplayText="NA" DataField="ContractAmount" HeaderText="Contract Amount" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left"  />
                                            <asp:BoundField NullDisplayText="NA" DataField="AdvanceAmount" HeaderText="Advance Amount" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left"  />
                                            <asp:BoundField NullDisplayText="NA" DataField="AdvanceAmountDriver" HeaderText="Driver" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left"  />
                                            <asp:BoundField NullDisplayText="NA" DataField="AdvanceAmountBranch" HeaderText="Branch" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left"  />
                                            <asp:BoundField NullDisplayText="NA" DataField="Deduction" HeaderText="Deduction" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left"  />
                                            <asp:BoundField NullDisplayText="NA" DataField="AdvanceAmountTDS" HeaderText="TDS" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left"  />
                                            <%--<asp:BoundField NullDisplayText="NA" DataField="AdvanceAmountByOther" HeaderText="Other Advance" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left"  />--%>
                                             <asp:TemplateField HeaderText="Other Advance">
                                                <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                                <ItemTemplate>
                                                   <asp:Label ID="lblAdvanceAmountByOther" Text='<%# DataBinder.Eval(Container.DataItem,"AdvanceAmountByOther") %>' runat="server"></asp:Label>
                                                </ItemTemplate>
                                                <ItemStyle Width="15%" HorizontalAlign="Left" VerticalAlign="Middle" CssClass="bgwhite" />
                                            </asp:TemplateField>
                                            <%--<asp:BoundField NullDisplayText="NA" DataField="OtherPandingAmount" HeaderText="OtherPandingAmount" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left"  />--%>
                                            <asp:TemplateField HeaderText="Panding Amount">
                                                <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                                <ItemTemplate>
                                                   <asp:Label ID="lblOtherPandingAmount" Text='<%# DataBinder.Eval(Container.DataItem,"OtherPandingAmount") %>' runat="server"></asp:Label>
                                                </ItemTemplate>
                                                <ItemStyle Width="15%" HorizontalAlign="Left" VerticalAlign="Middle" CssClass="bgwhite" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Paid">
                                                <HeaderStyle HorizontalAlign="Center" Wrap="False" />
                                                <ItemTemplate>
                                                    <asp:TextBox runat="server" ID="txtPaid" CssClass="ltxtm" Text='<%# DataBinder.Eval(Container.DataItem,"OtherPandingAmount") %>' onkeypress="javascript:return validFloat(event,this.getAttribute('id'))"/>
                                                    
                                                </ItemTemplate>
                                                <ItemStyle Width="20%" HorizontalAlign="Left" VerticalAlign="Middle" CssClass="bgwhite" />
                                            </asp:TemplateField>
                                             
                                            <asp:BoundField NullDisplayText="NA" DataField="BalanceAmount" HeaderText="Balance Amount" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left"  />
                                            <asp:BoundField NullDisplayText="NA" DataField="OTripsheetNo" HeaderText="Tripsheet No" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left"  />
                                            <asp:BoundField NullDisplayText="NA" DataField="TransporterChallanNo" HeaderText="Transporter Challan No" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left"  />
                                            <asp:BoundField NullDisplayText="NA" DataField="ChallanDate" HeaderText="Challan Date" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left"  />
                                            <asp:TemplateField HeaderText="Customer Name">
                                                <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                                <ItemTemplate>
                                                    
                                                    <asp:HiddenField ID="hdnCustomerCode" runat="server" Value='<%# DataBinder.Eval(Container.DataItem,"CustomerCode") %>' />
                                                   <asp:Label ID="lblCustomerName" Text='<%# DataBinder.Eval(Container.DataItem,"CustomerName") %>' runat="server"></asp:Label>
                                                </ItemTemplate>
                                                <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" CssClass="bgwhite" />
                                            </asp:TemplateField>
                                            
                                            <%--<asp:BoundField NullDisplayText="NA" DataField="CustomerName" HeaderText="Customer Name" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left"  />--%>
                                            <asp:BoundField NullDisplayText="NA" DataField="Remarks" HeaderText="Remarks" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left"  />
                                            </Columns>
                                 
                                  </asp:GridView>
                           </td>
                       </tr>
                        <tr class="bgbluegrey">
                          
                            <td  align="right">
                                <b>Total Amount:</b> <asp:TextBox Width="100px" ID="lblTotalAmount" onfocus="this.blur();" CssClass="blackfnt" Font-Bold="true" runat="server" Text="0"></asp:TextBox>
                            </td>
                        </tr>
                        <tr class="bgbluegrey">
                         
                            <td  align="right">
                                <b>TDS:</b> <asp:TextBox Width="100px" runat="server" ID="txtTDS" Text="0" Font-Bold="true" onblur="javascript:OnTDSChange();" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))" />
                            </td>
                        </tr>
                        <tr class="bgbluegrey">
                            
                            <td  align="right">
                                 <b>Net Amount:</b> <asp:TextBox Width="100px" ID="lblNetAmount" onfocus="this.blur();" CssClass="blackfnt" Font-Bold="true" runat="server" Text="0"></asp:TextBox>
                            </td>
                        </tr>
                         <tr class="bgbluegrey">
                             <td>
                                  <asp:UpdatePanel ID="UpdatePanePayment" UpdateMode="Conditional" RenderMode="Inline" runat="server" Visible=true >
                                    <ContentTemplate>
                                        <UC5:UCMyPaymentControl ID="UCMyPaymentControl1" runat="server" ></UC5:UCMyPaymentControl>
                                    </ContentTemplate>
                                </asp:UpdatePanel> 
                             </td>
                             
                         </tr>
                          <tr style="text-align:center">
                             <td>
                                 <asp:Button ID="btnSubmit" Text="Submit" runat="server" OnClientClick="javascript:return ValidateSubmit();" OnClick="btnSubmit_Click" />
                             </td>
                             
                         </tr>
                    </table>
                </td>
            </tr>
        </table>
    </div>
    <div id="testdiv1" style="position: absolute; visibility: hidden; background-color: white; layer-background-color: white; z-index: 99;">
    </div>

    <div id="Div1" style="position: absolute; visibility: hidden; background-color: white; layer-background-color: white; z-index: 99;">
    </div>

</asp:Content>