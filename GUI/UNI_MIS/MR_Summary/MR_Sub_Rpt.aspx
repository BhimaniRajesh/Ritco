<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master"
    CodeFile="MR_Sub_Rpt.aspx.cs" Inherits="GUI_UNI_MIS_MR_Summary_MR_Sub_Rpt" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script language="javascript" type="text/javascript">
        function OpenPopup(MR_Number) 
        { 
            window.open("../../Operation/Singlescreen_docketentry/DocketPrint/PaidMR/MR_Summ_Popup.aspx?mrsno=" + MR_Number,"es","menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=650,height=290,status=no,left=60,top=125");
        }
        
        function nwOpen(t,m)
        {
       // debugger
               if(t=="TBB")
               {
                window.open(" ../../Finance/MoneyRecipt/MR_Summ_Popup.aspx?mrsno="+m,"pbr","menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=387,height=220,status=no,left=220,top=70");
               }
               else
               {
                window.open(" ../../operation/singlescreen_docketentry/docketprint/paidmr/MR_Summ_Popup.aspx?mrsno="+m,"pbr","menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=387,height=220,status=no,left=220,top=70");
               }
        }
    </script>

    <br />
    <a href="javascript:window.history.go(-1)" title="back">
        <img id="IMG1" align="right" alt="" border="0" src="../../../GUI/images/back.gif" /></a>
    <asp:HyperLink ID="HyperLink1" runat="server" Font-Underline="True" NavigateUrl="~/GUI/UNI_MIS/rpt_finance.aspx">Fianance</asp:HyperLink>
    &gt;&nbsp;
    <asp:HyperLink ID="HyperLink2" runat="server" Font-Underline="True" NavigateUrl="~/GUI/UNI_MIS/MR_Summary/Query.aspx">MR Summary</asp:HyperLink><br />
    <br />
    <table align="center" border="0" cellpadding="3" cellspacing="1" class="boxbg" style="background-color: #808080">
        <tr style="background-color: #ffffff">
            <td style="width: 211px; height: 10px">
                <label class="blackfnt">
                    Date</label></td>
            <td style="height: 10px">
                <asp:Label ID="lblDtFrom" runat="server" CssClass="blackfnt"></asp:Label>
                -
                <asp:Label ID="lblDtTo" runat="server" CssClass="blackfnt"></asp:Label></td>
        </tr>
        <tr style="background-color: #ffffff">
            <td style="width: 211px; height: 15px">
                <label class="blackfnt">
                    MR RO</label></td>
            <td style="width: 343px; height: 15px">
                :</td>
        </tr>
        <tr style="background-color: #ffffff">
            <td style="width: 211px">
                <label class="blackfnt">
                    MR Branch</label></td>
            <td style="width: 343px">
                <asp:Label ID="lblBranch" runat="server" CssClass="blackfnt"></asp:Label>
                :
                <asp:Label ID="lblMRBranch" runat="server" CssClass="blackfnt"></asp:Label></td>
        </tr>
    </table>
    <br />
    <br />
    <table border="1" style="width: 98%; background-color: #808080" align="center" cellspacing="0"
        id="MR_Summary" runat="server" cellpadding="1" class="boxbg">
        <tr>
            <td>
                <tr class="bgbluegrey">
                    <td style="width: 5%; height: 25px;">
                        <label class="blackfnt">
                            Sr. No</label></td>
                    <td style="width: 5%; height: 25px;">
                        <label class="blackfnt">
                            MR Number</label></td>
                    <td style="width: 10%; height: 25px;">
                        <label class="blackfnt">
                            Docket No</label></td>
                    <td style="width: 7%; height: 25px;">
                        <label class="blackfnt">
                            MR Type</label></td>
                    <td style="width: 5%; height: 25px;">
                        <label class="blackfnt">
                            MR Date</label></td>
                    <td style="width: 22%; height: 25px;">
                        <label class="blackfnt">
                            MR Party</label></td>
                    <td style="width: 5%; height: 25px;">
                        <label class="blackfnt">
                            MR Branch</label></td>
                    <td style="width: 7%; height: 25px;">
                        <label class="blackfnt">
                            Payment Mode</label></td>
                    <td style="width: 10%; height: 25px;">
                        <label class="blackfnt">
                            Cheque No./Date</label></td>
                    <td style="width: 7%; height: 25px;">
                        <label class="blackfnt">
                            Cheque Amount</label></td>
                    <td style="width: 7%; height: 25px;">
                        <label class="blackfnt">
                            MR Status</label></td>
                    <td style="width: 7%; height: 25px;">
                        <label class="blackfnt">
                            Amount</label></td>
                    <td style="width: 7%; height: 25px;">
                        <label class="blackfnt">
                            Close Amount</label></td>
                    <td style="width: 7%; height: 25px;">
                        <label class="blackfnt">
                            MR Close Amount</label></td>
                    <td style="width: 7%; height: 25px;">
                        <label class="blackfnt">
                            Deduction</label></td>
                    <td style="width: 7%; height: 25px;">
                        <label class="blackfnt">
                            Addition</label></td>
                    <td style="width: 7%; height: 25px;">
                        <label class="blackfnt">
                            Remark</label></td>
                </tr>
                <asp:Repeater ID="rptBillDetails" runat="server">
                    <ItemTemplate>
                        <tr style="background-color: White">
                            <td style="width: 198px">
                                <center>
                                    <label class="blackfnt">
                                        <%#DataBinder.Eval(Container.DataItem, "RowCounter")%>
                                    </label>
                                </center>
                            </td>
                            <td>
                                <a class="bluefnt" href="JavaScript:nwOpen('<%#DataBinder.Eval(Container.DataItem, "MR_Type") %>','<%#DataBinder.Eval(Container.DataItem, "MR_Number") %>')">
                                    <%#DataBinder.Eval(Container.DataItem, "MR_Number")%>
                                </a>
                                <%-- <label class="blackfnt">
                                    <asp:HyperLink runat="server" Font-Underline="True" ForeColor="#003333" NavigateUrl='<%# DataBinder.Eval(Container.DataItem, "NavURL")%>'
                                        Text='<%#DataBinder.Eval(Container.DataItem, "MR_Number")%>' ID="Hyperlink1">
                                    </asp:HyperLink>
                                </label>--%>
                            </td>
                            <td>
                                <label class="blackfnt">
                                    <%#DataBinder.Eval(Container.DataItem, "DocNo")%>
                                </label>
                            </td>
                            <td>
                                <center>
                                    <label class="blackfnt">
                                        <%#DataBinder.Eval(Container.DataItem, "MR_Type")%>
                                    </label>
                                </center>
                            </td>
                            <td>
                                <center>
                                    <label class="blackfnt">
                                        <%#DataBinder.Eval(Container.DataItem, "MR_Date")%>
                                    </label>
                                </center>
                            </td>
                            <td>
                                <center>
                                    <label class="blackfnt">
                                        <%#DataBinder.Eval(Container.DataItem, "MR_Party")%>
                                    </label>
                                </center>
                            </td>
                            <td>
                                <center>
                                    <label class="blackfnt">
                                        <%#DataBinder.Eval(Container.DataItem, "MR_Branch")%>
                                    </label>
                                </center>
                            </td>
                            <td>
                                <center>
                                    <label class="blackfnt">
                                        <%#DataBinder.Eval(Container.DataItem, "Pay_Mode")%>
                                    </label>
                                </center>
                            </td>
                            <td>
                                <center>
                                    <label class="blackfnt">
                                        <%#DataBinder.Eval(Container.DataItem, "Chq_No")%>
                                    </label>
                                </center>
                            </td>
                            <td>
                                <center>
                                    <label class="blackfnt">
                                        <%#DataBinder.Eval(Container.DataItem, "Chq_Amt")%>
                                    </label>
                                </center>
                            </td>
                            <td>
                                <center>
                                    <label class="blackfnt">
                                        <%#DataBinder.Eval(Container.DataItem, "MR_Status")%>
                                    </label>
                                </center>
                            </td>
                            <td>
                                <center>
                                    <label class="blackfnt">
                                        <%#DataBinder.Eval(Container.DataItem, "Amt")%>
                                    </label>
                                </center>
                            </td>
                            <td>
                                <center>
                                    <label class="blackfnt">
                                        <%#DataBinder.Eval(Container.DataItem, "Cl_Amt")%>
                                    </label>
                                </center>
                            </td>
                            <td>
                                <center>
                                    <label class="blackfnt">
                                        <%#DataBinder.Eval(Container.DataItem, "MR_Close")%>
                                    </label>
                                </center>
                            </td>
                            <td>
                                <center>
                                    <label class="blackfnt">
                                        <%#DataBinder.Eval(Container.DataItem, "Dedu")%>
                                    </label>
                                </center>
                            </td>
                            <td>
                                <center>
                                    <label class="blackfnt">
                                        <%#DataBinder.Eval(Container.DataItem, "Add")%>
                                    </label>
                                </center>
                            </td>
                            <td>
                                <center>
                                    <label class="blackfnt">
                                        <%#DataBinder.Eval(Container.DataItem, "Remark")%>
                                    </label>
                                </center>
                            </td>
                        </tr>
                    </ItemTemplate>
                </asp:Repeater>
                <tr style="background-color: #FFFFFF" runat="server" id="trForTotalValues">
                    <td colspan="11" align="right">
                        <label class="blackfnt">
                            <b>Total : </b>
                        </label>
                    </td>
                    <td>
                        <center>
                            <asp:Label CssClass="blackfnt" ID="lblAmt" runat="server" Font-Bold="true">
                            </asp:Label></center>
                    </td>
                    <td>
                        <center>
                            <asp:Label CssClass="blackfnt" ID="lblClAmt" runat="server" Font-Bold="true">
                            </asp:Label></center>
                    </td>
                    <td>
                    </td>
                    <td>
                        <center>
                            <asp:Label CssClass="blackfnt" ID="lblDedu" runat="server" Font-Bold="true">
                            </asp:Label></center>
                    </td>
                    <td>
                        <center>
                            <asp:Label CssClass="blackfnt" ID="lblAdd" runat="server" Font-Bold="true">
                            </asp:Label></center>
                    </td>
                    <td>
                    </td>
                </tr>
            </td>
        </tr>
    </table>
    <table id="tblNoRecords" runat="server" border="0" style="width: 98%; background-color: #808080"
        align="center" cellspacing="1" cellpadding="2" class="boxbg" visible="false">
        <tr style="background-color: #ffffff">
            <td colspan="22" align="right" style="width: 892px; height: 23px;">
                <div align="center">
                    <label style="color: #FF0000;" class="blackfnt">
                        No Record Found
                    </label>
                </div>
            </td>
        </tr>
    </table>
    <br />
    <table border="0" align="center" cellpadding="0" cellspacing="4" id="tblPageNavigation"
        runat="server">
        <tr align="center">
            <td align="center">
                <label class="blackfnt">
                    Page&nbsp;
                    <asp:Label ID="CurrentPage" CssClass="blackfnt" runat="server" />
                    &nbsp;of&nbsp;
                    <asp:Label ID="TotalPages" CssClass="blackfnt" runat="server" />
                </label>
            </td>
        </tr>
        <tr align="center">
            <td align="center">
                <label class="blackfnt">
                    <asp:LinkButton runat="server" CssClass="blackfnt" ID="FirstPage" Text="[First Page]"
                        OnCommand="NavigationLink_Click" CommandName="First" />
                    <asp:LinkButton runat="server" CssClass="blackfnt" ID="PreviousPage" Text="[Previous Page]"
                        OnCommand="NavigationLink_Click" CommandName="Prev" />
                    <asp:LinkButton runat="server" CssClass="blackfnt" ID="NextPage" Text="[Next Page]"
                        OnCommand="NavigationLink_Click" CommandName="Next" />
                    <asp:LinkButton runat="server" CssClass="blackfnt" ID="LastPage" Text="[Last Page]"
                        OnCommand="NavigationLink_Click" CommandName="Last" />
                </label>
            </td>
        </tr>
        <tr align="center">
            <td align="center">
                <label class="blackfnt">
                </label>
                <select id="ddlPages" runat="server" class="blackfnt" onchange="PageSelectionChanged(this)"
                    visible="false">
                </select>
                <input type="hidden" id="HIDCurrentPageNo" runat="server" />
            </td>
        </tr>
    </table>
    <table width="25%" border="0" cellspacing="1" cellpadding="3" align="center" id="tblButtons"
        runat="server">
        <tr style="background-color: #ffffff">
            <td align="center">
                <asp:Button ID="btnXLS" runat="server" OnClick="btnXLS_Click1" Text="XLS" /></td>
        </tr>
    </table>
</asp:Content>
