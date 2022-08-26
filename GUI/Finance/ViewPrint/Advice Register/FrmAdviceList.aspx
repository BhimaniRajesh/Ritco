<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master"
    CodeFile="FrmAdviceList.aspx.cs" Inherits="FrmPaidFollowUp" EnableEventValidation="false" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <script language="javascript" type="text/jscript">
    </script>
    <script language="javascript" type="text/javascript">
    
        function ViewPrint(arg1,arg2)
        {   
            window.open("AdvViewPrint.aspx?adviceno=" + arg1 + "&printyn=" + arg2 ,"es","menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=650,height=290,status=no,left=60,top=125");
        }
        
    </script>

   
    <br />
    <div align="left">
        <table style="width: 935px">
            <tr>
                <td align="left">
                    <a><font class="blklnkund"><b>Module</b></font></a> <b>&gt; </b><font class="blklnkund">
                        <b>Account</b></font> <b>&gt; View & Print</b> <b>&gt; </b><font class="bluefnt"><b>Advice Register</b></font>
                </td>
                <td align="right">
                    <a href="javascript:window.history.go(-1)" title="back">
                        <img src="../../../images/back.gif" border="0" alt="" /></a>
                </td>
            </tr>
        </table>
        <br />
        <br />
        <table cellpadding="5" cellspacing="1" style="width: 362px; height: 19px" border="0"
            class="boxbg">
            <tr class="bgbluegrey">
                <td class="blackfnt" align="center" colspan="3" style="height: 19px">
                    Your Query Here
                </td>
            </tr>
            <tr bgcolor="white">
                <td class="blackfnt" align="left">
                    Date Range
                </td>
                <td class="blackfnt" align="left">
                    <div align="left">
                        <asp:Label ID="lblDateRange" CssClass="blackfnt" runat="server" Text="Label" Width="233px"></asp:Label></div>
                </td>
            </tr>
            <tr bgcolor="white">
                <td class="blackfnt" align="left">
                    RO
                </td>
                <td class="blackfnt" align="left">
                    <div align="left">
                        <asp:Label ID="lblRO" CssClass="blackfnt" runat="server" Text="Label" Width="233px"></asp:Label></div>
                </td>
            </tr>
            <tr bgcolor="white">
                <td class="blackfnt" align="left">
                    Location</td>
                <td class="blackfnt" align="left">
                    <div align="left">
                        <asp:Label ID="lblLocation" CssClass="blackfnt" runat="server" Text="Label" Width="233px"></asp:Label></div>
                </td>
            </tr>
            <tr bgcolor="white">
                <td class="blackfnt" align="left">
                    Status</td>
                <td class="blackfnt" align="left">
                    <div align="left">
                        <asp:Label ID="Lblstatus" CssClass="blackfnt" runat="server" Text="Label" Width="233px"></asp:Label></div>
                </td>
            </tr>
            <tr bgcolor="white">
                <td class="blackfnt" align="left">
                    Advice No.</td>
                <td class="blackfnt" align="left">
                    <div align="left">
                        <asp:Label ID="LblAdviceNO" CssClass="blackfnt" runat="server" Text="Label" Width="233px"></asp:Label></div>
                </td>
            </tr>
        </table>
        <br />
        <asp:TextBox ID="TxtDateRange" runat="server" Width="237px" ReadOnly="True" Visible="False"
            Style="z-index: 102; left: 158px; position: absolute; top: 171px"></asp:TextBox>
        <asp:TextBox ID="TxtFDt" runat="server" Visible="False"></asp:TextBox>
        <asp:TextBox ID="TxtRO" runat="server" Width="168px" ReadOnly="True" Visible="False"
            Style="z-index: 102; left: 163px; position: absolute; top: 172px"></asp:TextBox>
        <asp:TextBox ID="TxtTDt" runat="server" Visible="False"></asp:TextBox><br />
        <asp:TextBox ID="txtLocation" runat="server" Width="168px" ReadOnly="True" Visible="False"
            Style="z-index: 102; left: 160px; position: absolute; top: 170px"></asp:TextBox>
        <asp:DataGrid ID="GrdPaidFollow" OnItemDataBound="eventhandler" runat="server" PagerStyle-Mode="NumericPages"
            PagerStyle-Position="Top" PagerStyle-HorizontalAlign="left" PagerStyle-CssClass="pageLinks"
            AllowPaging="False" HeaderStyle-CssClass="bgbluegrey" FooterStyle-CssClass="boxbg"
            AllowSorting="True" CssClass="boxbg" OnPageIndexChanged="PageIndexChanged_Click"
            CellPadding="5" CellSpacing="1" BorderWidth="0" OnSortCommand="SortCommand_Click"
            AutoGenerateColumns="False" PagerSettings-FirstPageText="[First]">
            <FooterStyle CssClass="boxbg" BackColor="White" />
            <PagerStyle CssClass="pageLinks" BackColor="White" HorizontalAlign="Center" Mode="NumericPages" />
            <HeaderStyle CssClass="bgbluegrey" />
            <Columns>
                <asp:TemplateColumn HeaderText="Sr.No">
                    <ItemStyle HorizontalAlign="Center" BackColor="White" />
                    <HeaderStyle CssClass="blackfnt" HorizontalAlign="Center" />
                    <ItemTemplate>
                        <asp:Label ID="lblId" Text="<%# Container.DataSetIndex+1 %>" runat="server" CssClass="blackfnt"></asp:Label>
                    </ItemTemplate>
                </asp:TemplateColumn>
                <asp:TemplateColumn HeaderText="Advice Number">
                    <ItemStyle HorizontalAlign="Center" BackColor="White" />
                    <HeaderStyle HorizontalAlign="Center" CssClass="blackfnt" />
                    <ItemTemplate>
                        <asp:Label ID="lblloccode" Text='<%# DataBinder.Eval(Container, "DataItem.Adviceno") %>' runat="server" CssClass="blackfnt"></asp:Label>
                    </ItemTemplate>
                </asp:TemplateColumn>
                <asp:TemplateColumn HeaderText="Advice Type">
                    <ItemStyle HorizontalAlign="Center" BackColor="White" />
                    <HeaderStyle HorizontalAlign="Center" CssClass="blackfnt" />
                    <ItemTemplate>
                        <asp:Label ID="lbllocation" CssClass="blackfnt" Text='<%# DataBinder.Eval(Container, "DataItem.Advtype") %>'
                            runat="server"></asp:Label>
                    </ItemTemplate>
                </asp:TemplateColumn>
                <asp:TemplateColumn HeaderText="Advice Transaction">
                    <ItemStyle HorizontalAlign="Center" BackColor="White" />
                    <HeaderStyle HorizontalAlign="Center" CssClass="blackfnt" />
                    <ItemTemplate>
                        <asp:Label ID="lblPaidDocket" CssClass="blackfnt" Text='<%# DataBinder.Eval(Container, "DataItem.credit_account") %>'
                            runat="server"></asp:Label>
                    </ItemTemplate>
                </asp:TemplateColumn>
                <asp:TemplateColumn HeaderText="Advice Status">
                    <ItemStyle HorizontalAlign="Center" BackColor="White" />
                    <HeaderStyle HorizontalAlign="Center" CssClass="blackfnt" />
                    <ItemTemplate>
                        <asp:Label ID="lblArrivedDocket" CssClass="blackfnt" Text='<%# DataBinder.Eval(Container, "DataItem.advicestatus") %>'
                            runat="server"></asp:Label>
                    </ItemTemplate>
                </asp:TemplateColumn>
                <asp:TemplateColumn HeaderText="Raised By">
                    <ItemStyle HorizontalAlign="Center" BackColor="White" Wrap="false" />
                    <HeaderStyle HorizontalAlign="Center" CssClass="blackfnt" Wrap="false" />
                    <ItemTemplate>
                        <asp:Label ID="lblMRGenerated" CssClass="blackfnt" Text='<%# DataBinder.Eval(Container, "DataItem.raisedbybranch") %>'
                            runat="server"></asp:Label>
                    </ItemTemplate>
                </asp:TemplateColumn>
                <asp:TemplateColumn HeaderText="Raised On">
                    <ItemStyle HorizontalAlign="Center" BackColor="White" />
                    <HeaderStyle HorizontalAlign="Center" CssClass="blackfnt" />
                    <ItemTemplate>
                        <asp:Label ID="lblMRGeneratedAmt" CssClass="blackfnt" Text='<%# DataBinder.Eval(Container, "DataItem.RaisedOnbranch") %>'
                            runat="server"></asp:Label>
                    </ItemTemplate>
                </asp:TemplateColumn>
                <asp:TemplateColumn HeaderText="Advice Amount">
                    <ItemStyle HorizontalAlign="Right" BackColor="White" />
                    <HeaderStyle HorizontalAlign="center" CssClass="blackfnt" />
                    <ItemTemplate>
                        <asp:Label ID="lblMRClosedMoney" CssClass="blackfnt" Text='<%# DataBinder.Eval(Container, "DataItem.advice_amount") %>'
                            runat="server"></asp:Label>
                    </ItemTemplate>
                </asp:TemplateColumn>
                <asp:TemplateColumn HeaderText="Cheque Detail">
                    <ItemStyle HorizontalAlign="center" BackColor="White" Wrap="false" />
                    <HeaderStyle HorizontalAlign="center" CssClass="blackfnt" Wrap="false" />
                    <ItemTemplate>
                        <asp:Label ID="lblChequedtl" CssClass="blackfnt" Text='<%# DataBinder.Eval(Container, "DataItem.chqdtl") %>'
                            runat="server"></asp:Label>
                    </ItemTemplate>
                </asp:TemplateColumn>
                <asp:BoundColumn DataField="AdviceDt" HeaderStyle-HorizontalAlign="Center" ItemStyle-Wrap="false" ItemStyle-BackColor="white"
                    ItemStyle-HorizontalAlign="Center" DataFormatString="{0:dd-MMM-yy}" ItemStyle-CssClass="blackfnt"
                    HeaderStyle-CssClass="blackfnt" HeaderText="Generation Date"></asp:BoundColumn>
                <asp:TemplateColumn HeaderText="Narration">
                    <ItemStyle HorizontalAlign="Left" BackColor="White" />
                    <HeaderStyle HorizontalAlign="center" CssClass="blackfnt" />
                    <ItemTemplate>
                        <asp:Label ID="lblNarration" CssClass="blackfnt" Text='<%# DataBinder.Eval(Container, "DataItem.Narration") %>'
                            runat="server"></asp:Label>
                    </ItemTemplate>
                </asp:TemplateColumn>
                <asp:BoundColumn DataField="AdvAccDt" HeaderStyle-HorizontalAlign="Center" ItemStyle-Wrap="false" ItemStyle-BackColor="white"
                    ItemStyle-HorizontalAlign="Center" DataFormatString="{0:dd-MMM-yy}" ItemStyle-CssClass="blackfnt"
                    HeaderStyle-CssClass="blackfnt" HeaderText="Accepted Date"></asp:BoundColumn>  
                <asp:TemplateColumn HeaderText="Print">
                    <ItemStyle HorizontalAlign="Center" BackColor="White" Wrap="false" />
                    <HeaderStyle HorizontalAlign="Center" CssClass="blackfnt"  Wrap="false" />
                    <ItemTemplate>
                        <a href="Javascript:ViewPrint('<%# DataBinder.Eval(Container, "DataItem.Adviceno") %>','N')" style="text-decoration:underline">View</a>
                            | <a href="Javascript:ViewPrint('<%# DataBinder.Eval(Container, "DataItem.Adviceno") %>','Y')" style="text-decoration:underline">Print</a>
                    </ItemTemplate>
                </asp:TemplateColumn>
                 <asp:TemplateColumn HeaderText="Raised By">
                    <ItemStyle HorizontalAlign="Center" BackColor="White" Wrap="false" />
                    <HeaderStyle HorizontalAlign="Center" CssClass="blackfnt" Wrap="false" />
                    <ItemTemplate>
                        <asp:Label ID="lblMRGenerated" CssClass="blackfnt" Text='<%# DataBinder.Eval(Container, "DataItem.raisedbybranch") %>'
                            runat="server"></asp:Label>
                    </ItemTemplate>
                </asp:TemplateColumn>
                 <asp:TemplateColumn HeaderText="Submitted By">
                    <ItemStyle HorizontalAlign="Center" BackColor="White" Wrap="false" />
                    <HeaderStyle HorizontalAlign="Center" CssClass="blackfnt" Wrap="false" />
                    <ItemTemplate>
                        <asp:Label ID="lblSubmittedBy" CssClass="blackfnt" Text='<%# DataBinder.Eval(Container, "DataItem.AdviceEntrySubmitedBy") %>'
                            runat="server"></asp:Label>
                    </ItemTemplate>
                </asp:TemplateColumn>
                 <asp:TemplateColumn HeaderText="Accepted By">
                    <ItemStyle HorizontalAlign="Center" BackColor="White" Wrap="false" />
                    <HeaderStyle HorizontalAlign="Center" CssClass="blackfnt" Wrap="false" />
                    <ItemTemplate>
                        <asp:Label ID="lblAcceptedBy" CssClass="blackfnt" Text='<%# DataBinder.Eval(Container, "DataItem.AdviceAcceptedBy") %>'
                            runat="server"></asp:Label>
                    </ItemTemplate>
                </asp:TemplateColumn>
                 <asp:TemplateColumn HeaderText="Cancelled By">
                    <ItemStyle HorizontalAlign="Center" BackColor="White" Wrap="false" />
                    <HeaderStyle HorizontalAlign="Center" CssClass="blackfnt" Wrap="false" />
                    <ItemTemplate>
                        <asp:Label ID="lblCancelledBy" CssClass="blackfnt" Text='<%# DataBinder.Eval(Container, "DataItem.AdviceCancelledBy") %>'
                            runat="server"></asp:Label>
                    </ItemTemplate>
                </asp:TemplateColumn>
                 <asp:TemplateColumn HeaderText="Cancelled Date">
                    <ItemStyle HorizontalAlign="Center" BackColor="White" Wrap="false" />
                    <HeaderStyle HorizontalAlign="Center" CssClass="blackfnt" Wrap="false" />
                    <ItemTemplate>
                        <asp:Label ID="lblCancelledDate" CssClass="blackfnt" Text='<%# DataBinder.Eval(Container, "DataItem.AdviceCancelledDate") %>'
                            runat="server"></asp:Label>
                    </ItemTemplate>
                </asp:TemplateColumn>
            </Columns>
        </asp:DataGrid>
        <br />
        <asp:DataGrid ID="DataXlsGrid" Visible="false" OnItemDataBound="eventhandler" runat="server" PagerStyle-Mode="NumericPages"
            PagerStyle-Position="Top" PagerStyle-HorizontalAlign="left" PagerStyle-CssClass="pageLinks"
            AllowPaging="False" HeaderStyle-CssClass="bgbluegrey" FooterStyle-CssClass="boxbg"
            AllowSorting="True" CssClass="boxbg" OnPageIndexChanged="PageIndexChanged_Click"
            CellPadding="5" CellSpacing="1" BorderWidth="0" OnSortCommand="SortCommand_Click"
            AutoGenerateColumns="False" PagerSettings-FirstPageText="[First]">
            <FooterStyle CssClass="boxbg" BackColor="White" />
            <PagerStyle CssClass="pageLinks" BackColor="White" HorizontalAlign="Center" Mode="NumericPages" />
            <HeaderStyle CssClass="bgbluegrey" />
            <Columns>
                <asp:TemplateColumn HeaderText="Sr.No">
                    <ItemStyle HorizontalAlign="Center" BackColor="White" />
                    <HeaderStyle CssClass="blackfnt" HorizontalAlign="Center" />
                    <ItemTemplate>
                        <asp:Label ID="lblId" Text="<%# Container.DataSetIndex+1 %>" runat="server" CssClass="blackfnt"></asp:Label>
                    </ItemTemplate>
                </asp:TemplateColumn>
                <asp:TemplateColumn HeaderText="Advice Number">
                    <ItemStyle HorizontalAlign="Center" BackColor="White" />
                    <HeaderStyle HorizontalAlign="Center" CssClass="blackfnt" />
                    <ItemTemplate>
                            <asp:Label ID="lblloccode" Text='<%# DataBinder.Eval(Container, "DataItem.Adviceno") %>' runat="server" CssClass="blackfnt"></asp:Label>
                    </ItemTemplate>
                </asp:TemplateColumn>
                <asp:TemplateColumn HeaderText="Advice Type">
                    <ItemStyle HorizontalAlign="Center" BackColor="White" />
                    <HeaderStyle HorizontalAlign="Center" CssClass="blackfnt" />
                    <ItemTemplate>
                        <asp:Label ID="lbllocation" CssClass="blackfnt" Text='<%# DataBinder.Eval(Container, "DataItem.Advtype") %>'
                            runat="server"></asp:Label>
                    </ItemTemplate>
                </asp:TemplateColumn>
                <asp:TemplateColumn HeaderText="Advice Transaction">
                    <ItemStyle HorizontalAlign="Center" BackColor="White" />
                    <HeaderStyle HorizontalAlign="Center" CssClass="blackfnt" />
                    <ItemTemplate>
                        <asp:Label ID="lblPaidDocket" CssClass="blackfnt" Text='<%# DataBinder.Eval(Container, "DataItem.credit_account") %>'
                            runat="server"></asp:Label>
                    </ItemTemplate>
                </asp:TemplateColumn>
                <asp:TemplateColumn HeaderText="Advice Status">
                    <ItemStyle HorizontalAlign="Center" BackColor="White" />
                    <HeaderStyle HorizontalAlign="Center" CssClass="blackfnt" />
                    <ItemTemplate>
                        <asp:Label ID="lblArrivedDocket" CssClass="blackfnt" Text='<%# DataBinder.Eval(Container, "DataItem.advicestatus") %>'
                            runat="server"></asp:Label>
                    </ItemTemplate>
                </asp:TemplateColumn>
                <asp:TemplateColumn HeaderText="Raised By">
                    <ItemStyle HorizontalAlign="Center" BackColor="White" />
                    <HeaderStyle HorizontalAlign="Center" CssClass="blackfnt" />
                    <ItemTemplate>
                        <asp:Label ID="lblMRGenerated" CssClass="blackfnt" Text='<%# DataBinder.Eval(Container, "DataItem.raisedbybranch") %>'
                            runat="server"></asp:Label>
                    </ItemTemplate>
                </asp:TemplateColumn>
                <asp:TemplateColumn HeaderText="Raised On">
                    <ItemStyle HorizontalAlign="Center" BackColor="White" />
                    <HeaderStyle HorizontalAlign="Center" CssClass="blackfnt" />
                    <ItemTemplate>
                        <asp:Label ID="lblMRGeneratedAmt" CssClass="blackfnt" Text='<%# DataBinder.Eval(Container, "DataItem.RaisedOnbranch") %>'
                            runat="server"></asp:Label>
                    </ItemTemplate>
                </asp:TemplateColumn>
                <asp:TemplateColumn HeaderText="Advice Amount">
                    <ItemStyle HorizontalAlign="Right" BackColor="White" />
                    <HeaderStyle HorizontalAlign="Right" CssClass="blackfnt" />
                    <ItemTemplate>
                        <asp:Label ID="lblMRClosedMoney" CssClass="blackfnt" Text='<%# DataBinder.Eval(Container, "DataItem.advice_amount") %>'
                            runat="server"></asp:Label>
                    </ItemTemplate>
                </asp:TemplateColumn>
                <asp:BoundColumn DataField="AdviceDt" HeaderStyle-HorizontalAlign="Center" ItemStyle-BackColor="white"
                    ItemStyle-HorizontalAlign="Center" DataFormatString="{0:dd-MMM-yy}" ItemStyle-CssClass="blackfnt"
                    HeaderStyle-CssClass="blackfnt" HeaderText="Generation Date"></asp:BoundColumn>
                <asp:TemplateColumn HeaderText="Narration">
                    <ItemStyle HorizontalAlign="Left" BackColor="White" />
                    <HeaderStyle HorizontalAlign="center" CssClass="blackfnt" />
                    <ItemTemplate>
                        <asp:Label ID="lblNarration" CssClass="blackfnt" Text='<%# DataBinder.Eval(Container, "DataItem.Narration") %>'
                            runat="server"></asp:Label>
                    </ItemTemplate>
                </asp:TemplateColumn>
                <asp:BoundColumn DataField="AdvAccDt" HeaderStyle-HorizontalAlign="Center" ItemStyle-BackColor="white"
                    ItemStyle-HorizontalAlign="Center" DataFormatString="{0:dd-MMM-yy}" ItemStyle-CssClass="blackfnt"
                    HeaderStyle-CssClass="blackfnt" HeaderText="Accepted Date">
                </asp:BoundColumn>
                   <asp:TemplateColumn HeaderText="Submitted By">
                    <ItemStyle HorizontalAlign="Center" BackColor="White" Wrap="false" />
                    <HeaderStyle HorizontalAlign="Center" CssClass="blackfnt" Wrap="false" />
                    <ItemTemplate>
                        <asp:Label ID="lblSubmittedBy" CssClass="blackfnt" Text='<%# DataBinder.Eval(Container, "DataItem.AdviceEntrySubmitedBy") %>'
                            runat="server"></asp:Label>
                    </ItemTemplate>
                </asp:TemplateColumn>
                 <asp:TemplateColumn HeaderText="Accepted By">
                    <ItemStyle HorizontalAlign="Center" BackColor="White" Wrap="false" />
                    <HeaderStyle HorizontalAlign="Center" CssClass="blackfnt" Wrap="false" />
                    <ItemTemplate>
                        <asp:Label ID="lblAcceptedBy" CssClass="blackfnt" Text='<%# DataBinder.Eval(Container, "DataItem.AdviceAcceptedBy") %>'
                            runat="server"></asp:Label>
                    </ItemTemplate>
                </asp:TemplateColumn>
                 <asp:TemplateColumn HeaderText="Cancelled By">
                    <ItemStyle HorizontalAlign="Center" BackColor="White" Wrap="false" />
                    <HeaderStyle HorizontalAlign="Center" CssClass="blackfnt" Wrap="false" />
                    <ItemTemplate>
                        <asp:Label ID="lblCancelledBy" CssClass="blackfnt" Text='<%# DataBinder.Eval(Container, "DataItem.AdviceCancelledBy") %>'
                            runat="server"></asp:Label>
                    </ItemTemplate>
                </asp:TemplateColumn>
                 <asp:TemplateColumn HeaderText="Cancelled Date">
                    <ItemStyle HorizontalAlign="Center" BackColor="White" Wrap="false" />
                    <HeaderStyle HorizontalAlign="Center" CssClass="blackfnt" Wrap="false" />
                    <ItemTemplate>
                        <asp:Label ID="lblCancelledDate" CssClass="blackfnt" Text='<%# DataBinder.Eval(Container, "DataItem.AdviceCancelledDate") %>'
                            runat="server"></asp:Label>
                    </ItemTemplate>
                </asp:TemplateColumn>
            </Columns>
        </asp:DataGrid>
        <%--<asp:LinkButton ID="LinkButton1" runat="server" Visible="false" Font-Bold="True"
            Font-Underline="True" ForeColor="Blue" OnClick="linkexcel" Style="z-index: 101;
            left: 391px; position: absolute; top: 1088px">Excel old</asp:LinkButton>--%>
        &nbsp;&nbsp;&nbsp;<br />
        <br />
        <div align="center" style="width: 11in">
            <asp:Button ID="cmdexcel" runat="server" OnClick="cmdexcel_Click" Text="Excel" Width="54px" />
        </div>
        <%--<asp:HyperLink ID="HyperLink1" Visible="false" runat="server" Font-Bold="True" Font-Underline="True"
            ForeColor="Blue" NavigateUrl="~/GUI/UNI_MIS/Advice Register/Excel1.csv" Style="z-index: 104;
            left: 461px; position: absolute; top: 1085px">Excel Hyp</asp:HyperLink>--%>
    </div>
</asp:Content>
