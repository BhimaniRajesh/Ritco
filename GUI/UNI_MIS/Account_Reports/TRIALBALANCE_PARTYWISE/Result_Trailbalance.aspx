<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="Result_Trailbalance.aspx.cs" Inherits="GUI_UNI_MIS_Account_Reports_TRIALBALANCE_PARTYWISE_Result_Trailbalance"
    Title="Untitled Page" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <table width="100%" border="0" cellpadding="0" cellspacing="0">
        <tr>
            <td>
                &nbsp;
            </td>
        </tr>
        <tr>
            <td>
                <table width="95%" border="0" align="center" cellpadding="0" cellspacing="0">
                    <tr>
                        <td>
                            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                <tr>
                                    <td style="width: 39%; height: 762px;" valign="top">
                                        <%--Error messages are already handled in BillRegister.aspx.cs file--%>
                                        <%--Display error message table--%>
                                        <%--<table width="100%" border="0" cellspacing="0" cellpadding="0" id="tblErrorMessage" runat="server">
                                                                <tr>
                                                                    <td style="height: 300" valign="top">
                                                                        <br />
                                                                        <br />
                                                                        <br />
                                                                        
						                                                <table border="1" cellspacing="0" cellpadding="2" width="70%" 
						                                                    align="center" class="bglightblue">
   					                                                        <tr>
   							                                                    <td align="center" class="bgbluegrey">
   							                                                        <label class="blackfnt" style="color: red">
   							                                                            <b>Result</b>
   							                                                        </label>
   							                                                    </td>
   							                                                </tr>
						                                                    
						                                                    <tr>
						                                                        <td>
						                                                            <br />
					                                                                <p align="center">
					                                                                    <label id="lblErrorMessage" runat="server" class="blackfnt">    
					                                                                    </label>
					                                                                    
					                                                                    <br />
					                                                                    <br />
					                                                                    
					                                                                    <label class="blackfnt">
					                                                                        <a href="javascript:history.go(-1)">
					                                                                            <u>
					                                                                                Back
					                                                                            </u>
					                                                                        </a>
					                                                                    </label>
					                                                                    
					                                                                    <br />
					                                                                </p>    
					                                                            </td>
					                                                        </tr>
					                                                    </table>
                                                                    </td>
                                                                </tr>
                                                            </table>--%>
                                        <%--Display bill details table--%>
                                        <br />
                                        <p align="center">
                                            <label class="blackfnt">
                                                <b>You Selected </b>
                                            </label>
                                        </p>
                                        <%--<center>--%>
                                        <table border="0" cellpadding="3" width="565" cellspacing="1" align="center" class="boxbg">
                                            <tr style="background-color: #ffffff">
                                                <td class="blackfnt" style="height: 10px">
                                                    Date :</td>
                                                <td style="height: 10px">
                                                    &nbsp;
                                                    <asp:Label ID="lblseldet" runat="server" CssClass="blackfnt"></asp:Label></td>
                                            </tr>
                                            <tr style="background-color: #FFFFFF">
                                                <td style="width: 205; height: 15px;">
                                                    <label class="blackfnt">
                                                        Branch / Profit Center :</label></td>
                                                <td style="width: 343; height: 15px;">
                                                    &nbsp;
                                                    <asp:Label ID="lblro" runat="server" CssClass="blackfnt"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr style="background-color: #FFFFFF">
                                                <td style="width: 205">
                                                    <label class="blackfnt">
                                                        Account Head :</label></td>
                                                <td style="width: 343">
                                                    &nbsp;
                                                    <asp:Label ID="lblloc" runat="server" CssClass="blackfnt"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr id="lblcustRow" runat="server" visible="false" style="background-color: #FFFFFF">
                                                <td style="width: 205; height: 6px;">
                                                    <label class="blackfnt">
                                                        Customer Code :</label></td>
                                                <td style="width: 343; height: 6px;">
                                                    &nbsp;
                                                    <asp:Label ID="lblcust" runat="server" CssClass="blackfnt"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr id="lblVendRow" runat="server" visible="false" style="background-color: #ffffff">
                                                <td style="height: 6px">
                                                    <label class="blackfnt">
                                                        Vendor Code :</label>
                                                </td>
                                                <td style="width: 343; height: 6px;">
                                                    &nbsp;
                                                    <asp:Label ID="lblVend" runat="server" Visible="false" CssClass="blackfnt"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr id="lblempRow" runat="server" visible="false" style="background-color: #ffffff">
                                                <td style="height: 6px">
                                                    <label class="blackfnt">
                                                        Employee Code :</label>
                                                </td>
                                                <td style="width: 343; height: 6px;">
                                                    &nbsp;
                                                    <asp:Label ID="lblEmp" runat="server" CssClass="blackfnt"></asp:Label>
                                                </td>
                                            </tr>
                                        </table>
                                        <%--</center>--%>
                                        <br />
                                        <asp:GridView align="center" ID="GridView1" runat="server" BorderWidth="0" CellPadding="3"
                                            HeaderStyle-CssClass="bgbluegrey" AllowSorting="true" AllowPaging="true" PageSize="25"
                                            PagerStyle-HorizontalAlign="left" CellSpacing="1" CssClass="boxbg" Visible="false"
                                            FooterStyle-CssClass="boxbg" PagerSettings-Mode="NumericFirstLast" AutoGenerateColumns="false"
                                            PagerSettings-FirstPageText="[First]" PagerSettings-LastPageText="[Last]" PagerSettings-NextPageText="[Next]"
                                            PagerSettings-PreviousPageText="[Previous]" ShowFooter="true" OnRowDataBound="GridView1_OnRowDataBound"
                                            EmptyDataText="No Records Found..." OnPageIndexChanging="pgChange">
                                            <Columns>
                                                <asp:TemplateField HeaderText="SR.NO.">
                                                    <ItemTemplate>
                                                        <asp:Label CssClass="blackfnt" ID="lblsrnocomplainlist" Text="<%# Container.DataItemIndex+1 %>"
                                                            runat="server">
                                                        </asp:Label>
                                                    </ItemTemplate>
                                                    <HeaderStyle CssClass="blackfnt" />
                                                    <ItemStyle CssClass="blackfnt" BackColor="white" HorizontalAlign="center" />
                                                   
                                                </asp:TemplateField>
                                                <%--<asp:BoundField   DataField="report_loc" HeaderText="Consignee" > 
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                    <ItemStyle CssClass="blackfnt" />
                                </asp:BoundField>--%>
                                                <asp:TemplateField   HeaderText="Party Code" HeaderStyle-Width="120">
                                                    <ItemTemplate>
                                                        <%--<asp:LinkButton  ID="OCT_OS"  runat="server" Font-Underline="true"   PostBackUrl='<%#"~/GUI/UNI_MIS/creditcontrol/DetailFlow.aspx?loc=" + DataBinder.Eval(Container.DataItem, "loccode") + "&repdate="+Request.QueryString["DOCDate"].ToString()+"&custcd="+Request.QueryString["Cust"].ToString()+"&flow="+Request.QueryString["Flow"].ToString()+"&mode=14b"%>'  Text='<%#DataBinder.Eval(Container.DataItem, "OCT_TOBE_Coll_dkt") %>'></asp:LinkButton>--%>
                                                        <asp:Label ID="OCT_OS" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "pbov_code") +" : "+ DataBinder.Eval(Container.DataItem, "pbov_name") %>'></asp:Label>
                                                    </ItemTemplate>
                                                    <ItemStyle CssClass="blackfnt" Wrap="false" HorizontalAlign="center" BackColor="white" />
                                                    <HeaderStyle Width="100" HorizontalAlign="center" CssClass="blackfnt" />
                                                      <FooterTemplate>
                                                        <asp:Label ID="lblTOT" runat="server" Text="Total"></asp:Label>
                                                    </FooterTemplate>
                                                    <FooterStyle HorizontalAlign="right" CssClass="blackfnt" Font-Bold="true" />
                                                </asp:TemplateField>
                                                <%--  <asp:BoundField  DataField="pbov_code" HeaderText="Party Code " > 
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                    <ItemStyle CssClass="blackfnt" BackColor="white" HorizontalAlign="center" />
                                </asp:BoundField>
                                <asp:BoundField  DataField="pbov_name" HeaderText="Party Name " > 
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                    <ItemStyle CssClass="blackfnt" BackColor="white" HorizontalAlign="center" />
                                </asp:BoundField>
                                
                                --%>
                                                <asp:TemplateField HeaderStyle-Wrap="false" HeaderText="Opening Debit" HeaderStyle-Width="90">
                                                    <ItemTemplate>
                                                        <%--<asp:LinkButton  ID="OCT_OS"  runat="server" Font-Underline="true"   PostBackUrl='<%#"~/GUI/UNI_MIS/creditcontrol/DetailFlow.aspx?loc=" + DataBinder.Eval(Container.DataItem, "loccode") + "&repdate="+Request.QueryString["DOCDate"].ToString()+"&custcd="+Request.QueryString["Cust"].ToString()+"&flow="+Request.QueryString["Flow"].ToString()+"&mode=14b"%>'  Text='<%#DataBinder.Eval(Container.DataItem, "OCT_TOBE_Coll_dkt") %>'></asp:LinkButton>--%>
                                                        <asp:Label ID="lblopendebit" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "opendebit") %>'></asp:Label>
                                                    </ItemTemplate>
                                                    <ItemStyle CssClass="blackfnt" Wrap="false" HorizontalAlign="Right" BackColor="white" />
                                                    <HeaderStyle CssClass="blackfnt" />
                                                  
                                                    <FooterTemplate>
                                                        <asp:Label ID="lblTOTopendebit" runat="server"></asp:Label>
                                                    </FooterTemplate>
                                                    <FooterStyle HorizontalAlign="right" CssClass="blackfnt" Font-Bold="true" />
                                                </asp:TemplateField>
                                               <%-- <asp:BoundField DataField="opendebit" HeaderText="Opening Debit ">
                                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                                    <ItemStyle CssClass="blackfnt" BackColor="white" HorizontalAlign="right" />
                                                </asp:BoundField>--%>
                                                 <asp:TemplateField HeaderText="Opening Credit" HeaderStyle-Wrap="false" HeaderStyle-Width="90">
                                                    <ItemTemplate>
                                                        <%--<asp:LinkButton  ID="OCT_OS"  runat="server" Font-Underline="true"   PostBackUrl='<%#"~/GUI/UNI_MIS/creditcontrol/DetailFlow.aspx?loc=" + DataBinder.Eval(Container.DataItem, "loccode") + "&repdate="+Request.QueryString["DOCDate"].ToString()+"&custcd="+Request.QueryString["Cust"].ToString()+"&flow="+Request.QueryString["Flow"].ToString()+"&mode=14b"%>'  Text='<%#DataBinder.Eval(Container.DataItem, "OCT_TOBE_Coll_dkt") %>'></asp:LinkButton>--%>
                                                        <asp:Label ID="lblopencredit" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "opencredit") %>'></asp:Label>
                                                    </ItemTemplate>
                                                    <ItemStyle CssClass="blackfnt" Wrap="false" HorizontalAlign="Right" BackColor="white" />
                                                    <HeaderStyle CssClass="blackfnt" />
                                                  
                                                    <FooterTemplate>
                                                        <asp:Label ID="lblTOTopencredit" runat="server"></asp:Label>
                                                    </FooterTemplate>
                                                    <FooterStyle HorizontalAlign="right" CssClass="blackfnt" Font-Bold="true" />
                                                </asp:TemplateField>
                                               <%-- <asp:BoundField DataField="opencredit" HeaderText="Opening Credit ">
                                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                                    <ItemStyle CssClass="blackfnt" BackColor="white" HorizontalAlign="right" />
                                                </asp:BoundField>--%>
                                                <asp:TemplateField HeaderText="Current Debit" HeaderStyle-Wrap="false" HeaderStyle-Width="90">
                                                    <ItemTemplate>
                                                        <%--<asp:LinkButton  ID="OCT_OS"  runat="server" Font-Underline="true"   PostBackUrl='<%#"~/GUI/UNI_MIS/creditcontrol/DetailFlow.aspx?loc=" + DataBinder.Eval(Container.DataItem, "loccode") + "&repdate="+Request.QueryString["DOCDate"].ToString()+"&custcd="+Request.QueryString["Cust"].ToString()+"&flow="+Request.QueryString["Flow"].ToString()+"&mode=14b"%>'  Text='<%#DataBinder.Eval(Container.DataItem, "OCT_TOBE_Coll_dkt") %>'></asp:LinkButton>--%>
                                                        <asp:Label ID="lbltransdebit" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "transdebit") %>'></asp:Label>
                                                    </ItemTemplate>
                                                    <ItemStyle CssClass="blackfnt" Wrap="false" HorizontalAlign="Right" BackColor="white" />
                                                    <HeaderStyle CssClass="blackfnt" />
                                                  
                                                    <FooterTemplate>
                                                        <asp:Label ID="lblTOTtransdebit" runat="server"></asp:Label>
                                                    </FooterTemplate>
                                                    <FooterStyle HorizontalAlign="right" CssClass="blackfnt" Font-Bold="true" />
                                                </asp:TemplateField>
                                                <%--<asp:BoundField DataField="transdebit" HeaderText="Current Debit ">
                                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                                    <ItemStyle CssClass="blackfnt" BackColor="white" HorizontalAlign="right" />
                                                </asp:BoundField>--%>
                                                 <asp:TemplateField HeaderText="Current Credit" HeaderStyle-Wrap="false" HeaderStyle-Width="90">
                                                    <ItemTemplate>
                                                        <%--<asp:LinkButton  ID="OCT_OS"  runat="server" Font-Underline="true"   PostBackUrl='<%#"~/GUI/UNI_MIS/creditcontrol/DetailFlow.aspx?loc=" + DataBinder.Eval(Container.DataItem, "loccode") + "&repdate="+Request.QueryString["DOCDate"].ToString()+"&custcd="+Request.QueryString["Cust"].ToString()+"&flow="+Request.QueryString["Flow"].ToString()+"&mode=14b"%>'  Text='<%#DataBinder.Eval(Container.DataItem, "OCT_TOBE_Coll_dkt") %>'></asp:LinkButton>--%>
                                                        <asp:Label ID="lbltranscredit" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "transcredit") %>'></asp:Label>
                                                    </ItemTemplate>
                                                    <ItemStyle CssClass="blackfnt" Wrap="false" HorizontalAlign="Right" BackColor="white" />
                                                    <HeaderStyle CssClass="blackfnt" />
                                                  
                                                    <FooterTemplate>
                                                        <asp:Label ID="lblTOTtranscredit" runat="server"></asp:Label>
                                                    </FooterTemplate>
                                                    <FooterStyle HorizontalAlign="right" CssClass="blackfnt" Font-Bold="true" />
                                                </asp:TemplateField>
                                               <%-- <asp:BoundField DataField="transcredit" HeaderText="Current Credit ">
                                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                                    <ItemStyle CssClass="blackfnt" BackColor="white" HorizontalAlign="right" />
                                                </asp:BoundField>--%>
                                                 <asp:TemplateField HeaderText="Closing  Debit" HeaderStyle-Wrap="false" HeaderStyle-Width="90">
                                                    <ItemTemplate>
                                                        <%--<asp:LinkButton  ID="OCT_OS"  runat="server" Font-Underline="true"   PostBackUrl='<%#"~/GUI/UNI_MIS/creditcontrol/DetailFlow.aspx?loc=" + DataBinder.Eval(Container.DataItem, "loccode") + "&repdate="+Request.QueryString["DOCDate"].ToString()+"&custcd="+Request.QueryString["Cust"].ToString()+"&flow="+Request.QueryString["Flow"].ToString()+"&mode=14b"%>'  Text='<%#DataBinder.Eval(Container.DataItem, "OCT_TOBE_Coll_dkt") %>'></asp:LinkButton>--%>
                                                        <asp:Label ID="lblcloseDebit" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "closeDebit") %>'></asp:Label>
                                                    </ItemTemplate>
                                                    <ItemStyle CssClass="blackfnt" Wrap="false" HorizontalAlign="Right" BackColor="white" />
                                                    <HeaderStyle CssClass="blackfnt" />
                                                  
                                                    <FooterTemplate>
                                                        <asp:Label ID="lblTOTcloseDebit" runat="server"></asp:Label>
                                                    </FooterTemplate>
                                                    <FooterStyle HorizontalAlign="right" CssClass="blackfnt" Font-Bold="true" />
                                                </asp:TemplateField>
                                               <%-- 
                                                <asp:BoundField DataField="closeDebit" HeaderText="Closing  Debit ">
                                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                                    <ItemStyle CssClass="blackfnt" BackColor="white" HorizontalAlign="right" />
                                                </asp:BoundField>
                                                --%>
                                                 <asp:TemplateField HeaderText="Closing  Credit" HeaderStyle-Wrap="false" HeaderStyle-Width="90">
                                                    <ItemTemplate>
                                                        <%--<asp:LinkButton  ID="OCT_OS"  runat="server" Font-Underline="true"   PostBackUrl='<%#"~/GUI/UNI_MIS/creditcontrol/DetailFlow.aspx?loc=" + DataBinder.Eval(Container.DataItem, "loccode") + "&repdate="+Request.QueryString["DOCDate"].ToString()+"&custcd="+Request.QueryString["Cust"].ToString()+"&flow="+Request.QueryString["Flow"].ToString()+"&mode=14b"%>'  Text='<%#DataBinder.Eval(Container.DataItem, "OCT_TOBE_Coll_dkt") %>'></asp:LinkButton>--%>
                                                        <asp:Label ID="lblcloseCredit" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "closeCredit") %>'></asp:Label>
                                                    </ItemTemplate>
                                                    <ItemStyle CssClass="blackfnt" Wrap="false" HorizontalAlign="right" BackColor="white" />
                                                    <HeaderStyle CssClass="blackfnt" />
                                                  
                                                    <FooterTemplate>
                                                        <asp:Label ID="lblTOTcloseCredit" runat="server"></asp:Label>
                                                    </FooterTemplate>
                                                    <FooterStyle HorizontalAlign="right" CssClass="blackfnt" Font-Bold="true" />
                                                </asp:TemplateField>
                                                
                                                <%--<asp:BoundField DataField="closeCredit" HeaderText="Closing  Credit ">
                                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                                    <ItemStyle CssClass="blackfnt" BackColor="white" HorizontalAlign="right" />
                                                </asp:BoundField>--%>
                                                <%--<asp:TemplateField HeaderStyle-HorizontalAlign="Center">
                                                    
                                                    <ItemStyle BackColor="White" />
                                                    <ItemTemplate>
                                                        <center>
                                                            <asp:TextBox ID="txttotalweight" runat="server" CssClass="blackfnt" Style="text-align: right;"
                                                                onkeypress="javascript:return validFloat(event,this.getAttribute('id'));" onblur="javascript:return invoiceCalculation()"
                                                                MaxLength="8" ReadOnly="true" Enabled="false" Text="0" Width="70px" BorderStyle="Groove"></asp:TextBox>
                                                        </center>
                                                    </ItemTemplate>
                                                   
                                                </asp:TemplateField>--%>
                                            </Columns>
                                            <PagerStyle HorizontalAlign="Center" CssClass="bgbluegrey" />
                                            <HeaderStyle CssClass="bgbluegrey" />
                                            <FooterStyle CssClass="bgbluegrey" />
                                        </asp:GridView>
                                    </td>
                                </tr>
                            </table>
                            <br />
                            <br />
                            <%--<center>
                                <table width="25%" border="0" cellspacing="1" cellpadding="3" align="center" id="tblButtons"
                                    runat="server">
                                    <tr style="background-color: #ffffff">
                                        <td>
                                            <input type="button" class="btncolor" value="  Print  " runat="server" id="btnPrint"
                                                onclick="faction(1)" />
                                        </td>
                                        <td>
                                            <input type="button" class="btncolor" value="  XLS  " runat="server" id="btnXML"
                                                onclick="faction(2)" />
                                        </td>
                                        <td>
                                            <input type="button" class="btncolor" value="  Email " runat="server" id="btnEmail"
                                                onclick="faction(3)" />
                                        </td>
                                    </tr>
                                </table>
                            </center>--%>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
     <br />
        <table border="0" cellpadding="0" width="565" bgcolor="white" cellspacing="0" align="center">
            
           
            <tr bgcolor="white">
                <td colspan="2" align="center">
                    <asp:Button ID="btn_csv" Text="DownLoad XLS" runat="server" Width="170" OnClick="btn_csv_Click" />
                </td>
            </tr>
        </table>
   
</asp:Content>
