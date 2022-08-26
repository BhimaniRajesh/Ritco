<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master"
    CodeFile="FrmVoucherList.aspx.cs" Inherits="FrmPaidFollowUp" EnableEventValidation="false" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script language="javascript" type="text/jscript">
//    <link href="/aspnet_client/System_Web/2_0_50727/CrystalReportWebFormViewer3/css/default.css"

    function nwOpen(mrsno,type,printyn)
        {
                        // debugger
        
                        var typ= type.toUpperCase();
                        if(typ == "JOURNAL")
                        {           
                            
                            window.open("Print/JournalVoucherView.aspx?voucherno=" + mrsno + "&printyn=N","es","menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=650,height=290,status=no,left=60,top=125");
                          //  ..,menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=387,height=220,status=no,left=220,top=70);
                        
                        }
                        else if(typ == "CASH PAYMENT" || typ == "BANK PAYMENT"  || typ == "BOTH PAYMENT" || typ == "HAPPAY" || typ == "WALLET PAYMENT")
                        {             
                           window.open("Print/DebitVoucherView.aspx?voucherno=" + mrsno + "&printyn=N","es","menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=650,height=290,status=no,left=60,top=125");
                           //,,menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=387,height=220,status=no,left=220,top=70);
                             
                        }
                        else if(typ == "CASH RECEIPT" || typ == "BANK RECEIPT"  || typ == "BOTH RECEIPT")
                        {                   
                      //  credit     
                           //window.open("Print/CreditVoucherView.aspx?voucherno=" + voucherId + "&printyn=N,"pbr","menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=387,height=220,status=no,left=220,top=70");
                           
                           window.open("Print/CreditVoucherView.aspx?voucherno=" + mrsno + "&printyn=N","es","menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=650,height=290,status=no,left=60,top=125");
                           //,,menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=387,height=220,status=no,left=220,top=70);
                             
                        }
                        else if(typ == "CONTRA")
                        {                        
                           window.open("Print/ContraView.aspx?voucherno=" + mrsno + "&printyn=N","es","menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=650,height=290,status=no,left=60,top=125");
                           //,menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=387,height=220,status=no,left=220,top=70);
                             
                        }
         
               //  window.open(" voucher_vew_print.aspx?vno="+mrsno+"&type="+type+"&printyn="+printyn,"pbr","menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=387,height=220,status=no,left=220,top=70");
               
        }
        
        function nwOpen1(mrsno,type,printyn)
        {
        
                var typ= type.toUpperCase();
                if(typ == "JOURNAL")
                {           
                    
                    window.open("Print/JournalVoucherView.aspx?voucherno=" + mrsno + "&printyn=Y","es","menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=650,height=290,status=no,left=60,top=125");
                
                }
                else if(typ == "CASH PAYMENT" || typ == "BANK PAYMENT" ||  typ == "HAPPAY")
                {            //debit            
                   window.open("Print/DebitVoucherView.aspx?voucherno=" + mrsno + "&printyn=Y","es","menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=650,height=290,status=no,left=60,top=125");
                     
                }
                else if(typ == "CASH RECEIPT" || typ == "BANK RECEIPT")
                {                   
              //  credit     
                   window.open("Print/CreditVoucherView.aspx?voucherno=" + mrsno + "&printyn=Y","es","menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=650,height=290,status=no,left=60,top=125");
                     
                }
                else if(typ == "CONTRA")
                {                        
                   window.open("Print/ContraView.aspx?voucherno=" + mrsno + "&printyn=Y","es","menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=650,height=290,status=no,left=60,top=125");
                     
                }
        }
    </script>

    <br />
    <br />
    <div align="left" style="width: 10in">
        <table style="width: 1008px">
            <tr>
                <td align="left">
                    <a><font class="blklnkund"><b>Module</b></font></a> <b>&gt; </b><font class="blklnkund">
                        <b>Account</b></font> <b>&gt; View & Print</b> <b>&gt; </b><font class="bluefnt"><b>
                            Voucher Register
                                Report</b></font>
                </td>
                <td align="right">
                    <a href="javascript:window.history.go(-1)" title="back">
                        <img src="../../../images/back.gif" border="0" alt="" /></a>
                </td>
            </tr>
        </table>
    </div>
    <br />
    <div align="left">
        <asp:Panel ID="p1" runat="server" Style="display: none">
            <table align="left" id="tbl1" runat="server" style="width: 362px" border="0" class="boxbg"
                cellspacing="1" cellpadding="5">
                <tr runat="server" id="tr0" class="bgbluegrey">
                    <td class="blackfnt" colspan="3" align="center">
                        Your Query Here
                    </td>
                </tr>
                <tr runat="server" id="tr1" bgcolor="white">
                    <td class="blackfnt" align="left">
                        Date Range
                    </td>
                    <td class="blackfnt" align="left">
                        <asp:Label ID="lblDateRange" CssClass="blackfnt" runat="server" Text="Label"></asp:Label>
                    </td>
                </tr>
                <tr runat="server" id="tr2" bgcolor="white">
                    <td class="blackfnt" align="left">
                        RO
                    </td>
                    <td class="blackfnt" align="left">
                        <asp:Label ID="lblRO" CssClass="blackfnt" runat="server" Text="Label"></asp:Label>
                    </td>
                </tr>
                <tr runat="server" id="tr3" bgcolor="white">
                    <td class="blackfnt" align="left">
                        Location</td>
                    <td class="blackfnt" align="left">
                        <asp:Label ID="lblLocation" CssClass="blackfnt" runat="server" Text="Label"></asp:Label>
                    </td>
                </tr>
                <tr runat="server" id="tr4" bgcolor="white">
                    <td class="blackfnt" align="left">
                        Voucher Type</td>
                    <td class="blackfnt" align="left">
                        <asp:Label ID="LblVoucherType" CssClass="blackfnt" runat="server" Text="Label"></asp:Label>
                    </td>
                </tr>
            </table>
            <br />
            <br />
            <br />
            <br />
        </asp:Panel>
    </div>
    <asp:Panel ID="p2" runat="server" Style="display: none">
        <table align="left" id="tbl2" runat="server" style="width: 362px" border="0" class="boxbg"
            cellspacing="1" cellpadding="5">
            <tr runat="server" id="Tr6" class="bgbluegrey">
                <td class="blackfnt" colspan="3" align="center">
                    Your Query Here
                </td>
            </tr>
            <tr runat="server" id="Tr11" bgcolor="white">
                <td class="blackfnt" align="left">
                    Voucher No.</td>
                <td class="blackfnt" align="left">
                    <asp:Label ID="lblvoucherno" CssClass="blackfnt" runat="server" Text="Label"></asp:Label>
                </td>
            </tr>
        </table>
    </asp:Panel>
    <br />
    <br />
    <br />
    <br />
    <br />
    <br />
    <div align="left">
        <asp:DataGrid ID="GrdPaidFollow" runat="server" PagerStyle-Mode="NumericPages" PagerStyle-Position="Bottom"
            PagerStyle-HorizontalAlign="Center" PagerStyle-CssClass="pageLinks" AllowPaging="True"
            HeaderStyle-CssClass="bgbluegrey" FooterStyle-CssClass="boxbg" AllowSorting="True"
            CssClass="boxbg" OnPageIndexChanged="PageIndexChanged_Click" OnSortCommand="SortCommand_Click"
            AutoGenerateColumns="False" PagerSettings-FirstPageText="[First]" Width="10in"
            BorderWidth="0" CellSpacing="1" CellPadding="5">
            <FooterStyle CssClass="boxbg" BackColor="white" />
            <PagerStyle CssClass="pageLinks" BackColor="white" Position="Bottom" HorizontalAlign="Center" />
            <HeaderStyle CssClass="bgbluegrey" HorizontalAlign="Center" />
            <Columns>
                <asp:TemplateColumn HeaderText="Sr.No">
                    <ItemStyle HorizontalAlign="Center" BackColor="white" />
                    <HeaderStyle CssClass="blackfnt" />
                    <ItemTemplate>
                        <asp:Label ID="lblId" Text='<%# Container.DataSetIndex + 1 %>' runat="server" CssClass="blackfnt"></asp:Label>
                    </ItemTemplate>
                </asp:TemplateColumn>
               
                <asp:TemplateColumn HeaderText="Voucher Number">
                    <HeaderStyle HorizontalAlign="center" Wrap="False" CssClass="blackfnt" />
                    <ItemStyle CssClass="blackfnt" BackColor="white" />
                    <ItemTemplate>
                        <%--<a class="bluefnt" href="JavaScript:nwOpen('<%#DataBinder.Eval(Container.DataItem, "Voucherno") %>','<%#DataBinder.Eval(Container.DataItem, "transtype") %>',0)">
                            <%#DataBinder.Eval(Container.DataItem, "Voucherno")%>
                        </a>--%>
                        <asp:Label ID="lblVoucherNo" Text='<%# DataBinder.Eval(Container, "DataItem.Voucherno") %>' runat="server" ></asp:Label>
                    </ItemTemplate>
                </asp:TemplateColumn>
                
                <asp:TemplateColumn HeaderText="Voucher Date">
                    <ItemStyle HorizontalAlign="Center" BackColor="white" />
                    <HeaderStyle CssClass="blackfnt" />
                    <ItemTemplate>
                        <asp:Label ID="lbllocation" CssClass="blackfnt" Text='<%# DataBinder.Eval(Container, "DataItem.transdate") %>'
                            runat="server"></asp:Label>
                    </ItemTemplate>
                </asp:TemplateColumn>
				<asp:TemplateColumn HeaderText="Module Type">
                    <ItemStyle HorizontalAlign="Center" BackColor="white" />
                    <HeaderStyle CssClass="blackfnt" />
                    <ItemTemplate>
                        <asp:Label ID="lblmoduletype" CssClass="blackfnt" Text='<%# DataBinder.Eval(Container, "DataItem.opertitle") %>'
                            runat="server"></asp:Label>
                    </ItemTemplate>
                </asp:TemplateColumn>
                <asp:TemplateColumn HeaderText="Voucher Type">
                    <ItemStyle HorizontalAlign="Center" BackColor="white" />
                    <HeaderStyle CssClass="blackfnt" />
                    <ItemTemplate>
                        <asp:Label ID="lblvouchertype" CssClass="blackfnt" Text='<%# DataBinder.Eval(Container, "DataItem.transtype") %>'
                            runat="server"></asp:Label>
                    </ItemTemplate>
                </asp:TemplateColumn>
                <asp:TemplateColumn HeaderText="Branch">
                    <ItemStyle HorizontalAlign="Center" BackColor="white" />
                    <HeaderStyle CssClass="blackfnt" />
                    <ItemTemplate>
                        <asp:Label ID="lblPaidDocket" CssClass="blackfnt" Text='<%# DataBinder.Eval(Container, "DataItem.location") %>'
                            runat="server"></asp:Label>
                    </ItemTemplate>
                </asp:TemplateColumn>
                <asp:TemplateColumn HeaderText="Employee Name">
                    <HeaderStyle CssClass="blackfnt" />
                    <ItemStyle HorizontalAlign="Center" BackColor="white" />
                    <ItemTemplate>
                        <asp:Label ID="lblArrivedDocket" CssClass="blackfnt" Text='<%# DataBinder.Eval(Container, "DataItem.Employee") %>'
                            runat="server"></asp:Label>
                    </ItemTemplate>
                </asp:TemplateColumn>
                <asp:TemplateColumn HeaderText="Total Accounted Amount">
                    <HeaderStyle CssClass="blackfnt" HorizontalAlign="Right" />
                    <ItemStyle HorizontalAlign="Right" BackColor="white" />
                    <ItemTemplate>
                        <asp:Label ID="lblMRGenerated" CssClass="blackfnt" Text='<%# DataBinder.Eval(Container, "DataItem.totcredit") %>'
                            runat="server"></asp:Label>
                    </ItemTemplate>
                </asp:TemplateColumn>
                 <asp:TemplateColumn HeaderText="Print">
                    <ItemStyle HorizontalAlign="Center" BackColor="White" Wrap="false" />
                    <HeaderStyle HorizontalAlign="Center" CssClass="blackfnt"  Wrap="false" />
                    <ItemTemplate>
                        <%--<asp:LinkButton ID="lblMROutstandingAmt" Font-Underline="true" CssClass="blackfnt"
                            Text='Print' runat="server"></asp:LinkButton>--%>
                        <a href="JavaScript:nwOpen('<%#DataBinder.Eval(Container.DataItem, "Voucherno") %>','<%#DataBinder.Eval(Container.DataItem, "transtype") %>',0)" style="text-decoration:underline">View</a>
                            | <a href="JavaScript:nwOpen1('<%#DataBinder.Eval(Container.DataItem, "Voucherno") %>','<%#DataBinder.Eval(Container.DataItem, "transtype") %>',0)" style="text-decoration:underline">Print</a>
                    </ItemTemplate>
                    
                </asp:TemplateColumn>
                
            </Columns>
        </asp:DataGrid>&nbsp;</div>
    <br />
    <div align="center" style="width: 10in">
        <%--<asp:Button ID="Button1" runat="server" BackColor="#C0C0FF" OnClick="Button1_Click" Text="Print" Width="54px" />--%>
        <asp:Button ID="cmdexcel" runat="server" OnClick="cmdexcel_Click" Text="Excel" Width="54px" />
    </div>
    <asp:TextBox ID="TxtDateRange" runat="server" Width="1px" ReadOnly="True" Visible="False"></asp:TextBox>
    <asp:TextBox ID="txtLocation" runat="server" Width="1px" ReadOnly="True" Visible="False"></asp:TextBox>
    <asp:TextBox ID="TxtRO" runat="server" Width="1px" ReadOnly="True" Visible="False"></asp:TextBox>
    <asp:TextBox ID="TxtFDt" runat="server" Visible="False" Width="1px"></asp:TextBox>
    <asp:TextBox ID="TxtTDt" runat="server" Visible="False" Width="11px"></asp:TextBox>
</asp:Content>
