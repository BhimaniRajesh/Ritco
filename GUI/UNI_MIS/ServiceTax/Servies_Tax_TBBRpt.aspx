<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master"  CodeFile="Servies_Tax_TBBRpt.aspx.cs" Inherits="GUI_UNI_MIS_ServiceTax_Servies_Tax_TBBRpt" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">
<script language="javascript" type="text/javascript">
        function OpenPopup(MR_Number) 
        { 
            window.open("Svc_TBB_Popup.aspx?MR_Number=" + MR_Number,"es","menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=650,height=290,status=no,left=60,top=125");
        }
        
        function OpenBillPopup(Bill_Number) 
        { 
            window.open("Svc_TBB_Bill_Popup.aspx?Bill_Number=" + Bill_Number,"es","menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=650,height=290,status=no,left=60,top=125");
        }
</script>

    <br />
    <a href="javascript:window.history.go(-1)" title="back">
        <img id="IMG1" align="right" alt="" border="0" src="../../../GUI/images/back.gif" /></a>
    <asp:HyperLink ID="HyperLink1" runat="server" Font-Underline="True" NavigateUrl="~/GUI/UNI_MIS/rpt_finance.aspx">Finance</asp:HyperLink>
    &gt;
    <asp:Label ID="Label1" runat="server" CssClass="blackfnt" Text="Service Tax"></asp:Label><br />
    <br />
    <table align="center" border="0" cellpadding="3" cellspacing="1" class="boxbg" style="background-color: #808080">
        <tr style="background-color: #ffffff">
            <td style="width: 211px; height: 10px">
                <label class="blackfnt">
                    MR Date</label></td>
            <td style="height: 10px">
                <asp:Label ID="lblDtFrom" runat="server" CssClass="blackfnt"></asp:Label>
                -
                <asp:Label ID="lblDtTo" runat="server" CssClass="blackfnt"></asp:Label></td>
        </tr>
        <tr style="background-color: #ffffff">
            <td style="width: 211px; height: 15px">
                <label class="blackfnt">
                    MR Party</label></td>
            <td style="width: 343px; height: 15px">
                <asp:Label ID="lblParty" runat="server" CssClass="blackfnt"></asp:Label></td>
        </tr>
        <tr style="background-color: #ffffff">
            <td style="width: 211px">
                <label class="blackfnt">
                    MR Type</label></td>
            <td style="width: 343px">
                <asp:Label ID="lblType" runat="server" CssClass="blackfnt"></asp:Label></td>
        </tr>
        <tr style="background-color: #ffffff">
            <td class="blackfnt" style="width: 211px">
                MR RO</td>
            <td style="width: 343px">
                <asp:Label ID="lblRO" runat="server" CssClass="blackfnt"></asp:Label></td>
        </tr>
        <tr style="background-color: #ffffff">
            <td class="blackfnt" style="width: 211px">
                MR Branch</td>
            <td style="width: 343px">
                <asp:Label ID="lblBranch" runat="server" CssClass="blackfnt"></asp:Label></td>
        </tr>
        <tr style="background-color: #ffffff">
            <td class="blackfnt" style="width: 211px">
                Amount Greater Than</td>
            <td style="width: 343px">
                <asp:Label ID="lblAmount" runat="server" CssClass="blackfnt"></asp:Label></td>
        </tr>
    </table>
    <br />
    <br />
    <table align="center" border="0" cellpadding="2" cellspacing="1" class="boxbg" style="width: 98%;
        background-color: #808080">
        <tr class="bgbluegrey">
            <td style="width: 5%;" align="center" rowspan="2">
                <label class="blackfnt">
                    Sr. No</label></td>
            <td align="center" rowspan="2">
                <label class="blackfnt">
                    MR Number</label></td>
            <td align="center" rowspan="2">
                <label class="blackfnt">
                    MR Date</label></td>
            <td align="center" rowspan="2">
                <label class="blackfnt">
                    Bill No</label></td>
            <td align="center" rowspan="2">
                <label class="blackfnt">
                    Bill Date</label></td>
            <td align="center" rowspan="2">
                <label class="blackfnt">
                    Party</label></td>
            <td align="center" rowspan="2">
                <label class="blackfnt">
                    Bill Branch</label></td>
            <td align="center" rowspan="2">
                <label class="blackfnt">
                    Bill Amount</label></td>
            <td align="center" rowspan="2">
                <label class="blackfnt">
                    Service Tax Rate</label></td>
            <td align="center" rowspan="2">
                <label class="blackfnt">
                    Cess Rate</label></td>
            <td align="center" colspan="3">
                <label class="blackfnt">
                    Bill</label></td>
            <td align="center" colspan="3">
                <label class="blackfnt">
                    Other Deduction</label></td>
            <td align="center" colspan="3" >
                <label class="blackfnt">
                    Received</label></td>
            <td align="center" rowspan="2">
                <label class="blackfnt">
                    TDS Deduction</label></td>
            <td align="center" rowspan="2">
                <label class="blackfnt">
                    Claim Deduction</label></td>
            <td align="center" colspan="3">
                <label class="blackfnt">
                    Balance</label></td>
           <td align="center" rowspan="2">
                <label class="blackfnt">
                    Net Balance</label></td>                    
          
        </tr>
        
        
           <tr class="bgbluegrey">
            <td align="center" class="blackfnt">
                Freight</td>
            <td align="center" class="blackfnt">
                Service Tax</td>
            <td align="center" class="blackfnt">
                Cess</td>
            <td align="center" class="blackfnt">
                Freight</td>
            <td align="center" class="blackfnt">
                Service Tax</td>
            <td align="center" class="blackfnt">
                Cess</td>
            <td align="center" class="blackfnt">
                Freight</td>
            <td align="center" class="blackfnt">
                Service Tax</td>
            <td align="center" class="blackfnt">
                Cess</td>
            <td align="center" class="blackfnt">
                Freight</td>
            <td align="center" class="blackfnt">
                Service Tax</td>
            <td align="center" class="blackfnt">
                Cess</td>
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
                    <td align="center"> 
                        <label class="blackfnt">
                           <asp:HyperLink Runat="server"  Font-Underline="True"  ForeColor="#000099" NavigateUrl='<%# DataBinder.Eval(Container.DataItem, "NavURL")%>' Text='<%#DataBinder.Eval(Container.DataItem, "MR_Number")%>' ID="Hyperlink1">
                                </asp:HyperLink>     
                        </label>
                    </td>
                    <td align="center">
                        <label class="blackfnt">
                            <%#DataBinder.Eval(Container.DataItem, "MR_Date")%>
                        </label>
                    </td>
                    <td align="center">
                        <label class="blackfnt">
                           <asp:HyperLink Runat="server"  Font-Underline="True"  ForeColor="#000099" NavigateUrl='<%# DataBinder.Eval(Container.DataItem, "NavURL1")%>' Text='<%#DataBinder.Eval(Container.DataItem, "Bill_No")%>' ID="Hyperlink2">
                                </asp:HyperLink>   
                            
                        </label>
                    </td>
                    <td align="center"> 
                        <label class="blackfnt">
                            <%#DataBinder.Eval(Container.DataItem, "Bill_Date")%>
                        </label>
                    </td>
                    <td align="center">
                        <label class="blackfnt">
                            <%#DataBinder.Eval(Container.DataItem, "Party")%>
                        </label>
                    </td>
                    <td align="center">
                        <label class="blackfnt">
                            <%#DataBinder.Eval(Container.DataItem, "Bill_Branch")%>
                        </label>
                    </td>
                    <td align="center">
                        <label class="blackfnt">
                            <%#DataBinder.Eval(Container.DataItem, "Bill_Amt")%>
                        </label>
                    </td>
                    <td align="center">
                        <label class="blackfnt">
                            <%#DataBinder.Eval(Container.DataItem, "Svc_Tax")%>
                        </label>
                    </td>
                    <td align="center">
                        <label class="blackfnt">
                            <%#DataBinder.Eval(Container.DataItem, "Cess_Rate")%>
                        </label>
                    </td>
                    <td align="center">
                        <label class="blackfnt">
                            <%#DataBinder.Eval(Container.DataItem, "Bill_Fre")%>
                        </label>
                    </td>
                    <td align="center">
                        <label class="blackfnt">
                            <%#DataBinder.Eval(Container.DataItem, "Bill_Svc")%>
                        </label>
                    </td>
                    <td align="center">
                        <label class="blackfnt">
                            <%#DataBinder.Eval(Container.DataItem, "Bill_Cess")%>
                        </label>
                    </td>
                    <td align="center">
                        <label class="blackfnt">
                            <%#DataBinder.Eval(Container.DataItem, "Dedu_Fre")%>
                        </label>
                    </td>
                    <td align="center">
                        <label class="blackfnt">
                            <%#DataBinder.Eval(Container.DataItem, "Dedu_Svc")%>
                        </label>
                    </td>
                    <td align="center">
                        <label class="blackfnt">
                            <%#DataBinder.Eval(Container.DataItem, "Dedu_Cess")%>
                        </label>
                    </td>
                    <td align="center">
                        <label class="blackfnt">
                            <%#DataBinder.Eval(Container.DataItem, "Rec_Fre")%>
                        </label>
                    </td>
                    <td align="center">
                        <label class="blackfnt">
                            <%#DataBinder.Eval(Container.DataItem, "Rec_Svc")%>
                        </label>
                    </td>
                    <td align="center">
                        <label class="blackfnt">
                            <%#DataBinder.Eval(Container.DataItem, "Rec_Cess")%>
                        </label>
                    </td>
                    <td align="center">
                        <label class="blackfnt">
                            <%#DataBinder.Eval(Container.DataItem, "TDS")%>
                        </label>
                    </td>
                    <td align="center">
                        <label class="blackfnt">
                            <%#DataBinder.Eval(Container.DataItem, "Dedu")%>
                        </label>
                    </td>
                    <td align="center">
                        <label class="blackfnt">
                            <%#DataBinder.Eval(Container.DataItem, "Bal_Fre")%>
                        </label>
                    </td>
                    <td align="center">
                        <label class="blackfnt">
                            <%#DataBinder.Eval(Container.DataItem, "Bal_Svc")%>
                        </label>
                    </td>
                    <td align="center">
                        <label class="blackfnt">
                            <%#DataBinder.Eval(Container.DataItem, "Bal_Cess")%>
                        </label>
                    </td>
                    <td align="center">
                        <label class="blackfnt">
                            <%#DataBinder.Eval(Container.DataItem, "Net_Amt")%>
                        </label>
                    </td>
                </tr>
            </ItemTemplate>
        </asp:Repeater>
     
        <tr id="trForTotalValues" runat="server" style="background-color: #ffffff">
            <td align="center" colspan="7">
                <label class="blackfnt">
                    <b>Total : </b>
                </label>
            </td>
            <td align="center">
                <center>
                    <asp:Label ID="lblBillAmt" runat="server" CssClass="blackfnt" Font-Bold="true">
                                                                            </asp:Label></center>
            </td>
            <td align="center">
            </td>
            <td align="center">
            </td>
            <td align="center">
                <center>
                    <asp:Label ID="lblBillFre" runat="server" CssClass="blackfnt" Font-Bold="true">
                                                                            </asp:Label></center>
            </td>
            <td align="center">
                <center>
                    <asp:Label ID="lblBillSer" runat="server" CssClass="blackfnt" Font-Bold="true">
                                                                            </asp:Label></center>
            </td>
            <td align="center">
                <center>
                    <asp:Label ID="lblBillCess" runat="server" CssClass="blackfnt" Font-Bold="true">
                                                                            </asp:Label></center>
            </td>
            <td align="center">
                <center>
                    <asp:Label ID="lblDeduFre" runat="server" CssClass="blackfnt" Font-Bold="true">
                                                                            </asp:Label></center>
            </td>
            <td align="center">
                <center>
                    <asp:Label ID="lblDeduSer" runat="server" CssClass="blackfnt" Font-Bold="true">
                                                                            </asp:Label></center>
            </td>
            <td align="center">
                <center>
                    <asp:Label ID="lblDeduCess" runat="server" CssClass="blackfnt" Font-Bold="true">
                                                                            </asp:Label></center>
            </td>
            <td align="center">
                <center>
                    <asp:Label ID="lblRecFre" runat="server" CssClass="blackfnt" Font-Bold="true">
                                                                            </asp:Label></center>
            </td>
            <td align="center">
                <center>
                    <asp:Label ID="lblRecSer" runat="server" CssClass="blackfnt" Font-Bold="true">
                                                                            </asp:Label></center>
            </td>
            <td align="center">
                <center>
                    <asp:Label ID="lblRecCess" runat="server" CssClass="blackfnt" Font-Bold="true">
                                                                            </asp:Label></center>
            </td>
            <td align="center">
                <center>
                    <asp:Label ID="lblTDS" runat="server" CssClass="blackfnt" Font-Bold="true">
                                                                            </asp:Label></center>
            </td>
            <td align="center">
                <center>
                    <asp:Label ID="lblCalim" runat="server" CssClass="blackfnt" Font-Bold="true">
                                                                            </asp:Label></center>
            </td>
            <td align="center">
                <center>
                    <asp:Label ID="lblBalFre" runat="server" CssClass="blackfnt" Font-Bold="true"></asp:Label></center>
            </td>
            <td align="center">
                <center>
                    <asp:Label ID="lblBalSer" runat="server" CssClass="blackfnt" Font-Bold="true"></asp:Label></center>
            </td>
            <td align="center">
            <center>
                    <asp:Label ID="lblBalCess" runat="server" CssClass="blackfnt" Font-Bold="true"></asp:Label></center></td>
            <td align="center">
                <center>
                    <asp:Label ID="lblNetAmt" runat="server" CssClass="blackfnt" Font-Bold="true">
                                                                            </asp:Label></center>
            </td>
        </tr>
    </table>
    <table id="tblNoRecords" runat="server" align="center" border="0" cellpadding="2"
        cellspacing="1" class="boxbg" style="width: 98%; background-color: #808080" visible="false">
        <tr style="background-color: #ffffff">
            <td align="right" colspan="22" style="width: 892px; height: 23px">
                <div align="center">
                    <label class="blackfnt" style="color: #ff0000">
                        No Record Found
                    </label>
                </div>
            </td>
        </tr>
    </table>
    <br />
    <table id="tblPageNavigation" runat="server" align="center" border="0" cellpadding="0"
        cellspacing="4">
        <tr align="center">
            <td align="center">
                <label class="blackfnt">
                    Page&nbsp;
                    <asp:Label ID="CurrentPage" runat="server" CssClass="blackfnt"></asp:Label>
                    &nbsp;of&nbsp;
                    <asp:Label ID="TotalPages" runat="server" CssClass="blackfnt"></asp:Label>
                </label>
            </td>
        </tr>
        <tr align="center">
            <td align="center">
                <label class="blackfnt">
                    <asp:LinkButton ID="FirstPage" runat="server" CommandName="First" CssClass="blackfnt"
                        OnCommand="NavigationLink_Click" Text="[First Page]"></asp:LinkButton>
                    <asp:LinkButton ID="PreviousPage" runat="server" CommandName="Prev" CssClass="blackfnt"
                        OnCommand="NavigationLink_Click" Text="[Previous Page]"></asp:LinkButton>
                    <asp:LinkButton ID="NextPage" runat="server" CommandName="Next" CssClass="blackfnt"
                        OnCommand="NavigationLink_Click" Text="[Next Page]"></asp:LinkButton>
                    <asp:LinkButton ID="LastPage" runat="server" CommandName="Last" CssClass="blackfnt"
                        OnCommand="NavigationLink_Click" Text="[Last Page]"></asp:LinkButton>
                </label>
            </td>
        </tr>
        <tr align="center">
                                                        <td align="center">
                                                            <label class="blackfnt">
                                                            </label>
                                                            <select id="ddlPages" runat="server" class="blackfnt" onchange="PageSelectionChanged(this)" visible="false">
                                                            </select>
                                                            <input type="hidden" id="HIDCurrentPageNo" runat="server"/>
                                                        </td>
                                                    </tr>
    </table>
    <table id="tblButtons" runat="server" align="center" border="0" cellpadding="3" cellspacing="1"
        width="25%">
        <tr style="background-color: #ffffff">
            <td align="center">
                <asp:Button ID="btnXLS" runat="server" OnClick="btnXLS_Click" Text="XLS" /></td>
        </tr>
    </table>
</asp:Content>
