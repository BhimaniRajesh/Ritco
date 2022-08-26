<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master"
    CodeFile="Bill_Summ_Rpt.aspx.cs" Inherits="GUI_UNI_MIS_Bill_Summary_Bill_Summ_Rpt" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    &nbsp;<a href="javascript:window.history.go(-1)" title="back"><img id="IMG1" align="right"
        alt="" border="0" src="../../../GUI/images/back.gif" /></a><br />
    &nbsp;<asp:HyperLink ID="HyperLink1" runat="server" Font-Underline="True" NavigateUrl="~/GUI/UNI_MIS/rpt_finance.aspx">Finance</asp:HyperLink>
    &gt;&nbsp;
    <asp:HyperLink ID="HyperLink2" runat="server" Font-Strikeout="False" Font-Underline="True"
        NavigateUrl="~/GUI/UNI_MIS/Bill_Summary/Query.aspx">Bill Summary</asp:HyperLink><br />
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
                    Ro</label></td>
            <td style="width: 343px; height: 15px">
                <asp:Label ID="lblRo" runat="server" CssClass="blackfnt"></asp:Label></td>
        </tr>
        <tr style="background-color: #ffffff">
            <td style="width: 211px">
                <label class="blackfnt">
                    Location</label></td>
            <td style="width: 343px">
                <asp:Label ID="lblLoc" runat="server" CssClass="blackfnt"></asp:Label></td>
        </tr>
        <tr style="background-color: #ffffff">
            <td style="width: 211px" class="blackfnt">
                Submission</td>
            <td style="width: 343px">
                <asp:Label ID="lblSub" runat="server" CssClass="blackfnt"></asp:Label></td>
        </tr>
        <tr style="background-color: #ffffff">
            <td style="width: 211px" class="blackfnt">
                Collection Location</td>
            <td style="width: 343px">
                <asp:Label ID="lblCollLoc" runat="server" CssClass="blackfnt"></asp:Label></td>
        </tr>
        <tr style="background-color: #ffffff">
            <td style="width: 211px" class="blackfnt">
                Customer Code</td>
            <td style="width: 343px">
                <asp:Label ID="lblCustCode" runat="server" CssClass="blackfnt"></asp:Label></td>
        </tr>
        <tr style="background-color: #ffffff">
            <td style="width: 211px" class="blackfnt">
                Bill Type</td>
            <td style="width: 343px">
                <asp:Label ID="lblBillType" runat="server" CssClass="blackfnt"></asp:Label></td>
        </tr>
        <tr style="background-color: #ffffff">
            <td style="width: 211px" class="blackfnt">
                Bill Amount</td>
            <td style="width: 343px">
                <asp:Label ID="lblBillAmt" runat="server" CssClass="blackfnt"></asp:Label></td>
        </tr>
        <tr style="background-color: #ffffff">
            <td style="width: 211px" class="blackfnt">
                Listing</td>
            <td style="width: 343px">
                <asp:Label ID="lblList" runat="server" CssClass="blackfnt"></asp:Label></td>
        </tr>
        <tr style="background-color: #ffffff">
            <td style="width: 211px" class="blackfnt">
                Report Date</td>
            <td style="width: 343px">
                <asp:Label ID="lblRptDate" runat="server" CssClass="blackfnt"></asp:Label></td>
        </tr>
    </table>
    <br />
    <br />
    <table border="1" style="width: 98%; background-color: #808080" align="center" cellspacing="0"
        cellpadding="1" class="boxbg" id="Bill_Summary" runat="server">
        <tr>
            <td>
                <tr class="bgbluegrey">
                    <td style="width: 5%;" rowspan="2">
                        <label class="blackfnt">
                            Sr. No</label></td>
                    <td style="width: 20%;" rowspan="2">
                        <label class="blackfnt">
                            LocCode.LocName</label></td>
                    <td style="height: 25px;" colspan="2">
                        <label class="blackfnt">
                            Bill Generated
                        </label>
                    </td>
                    <td style="height: 25px;" colspan="2">
                        <label class="blackfnt">
                            Submitted-Due</label></td>
                    <td style="height: 25px;" colspan="2">
                        <label class="blackfnt">
                            Submitted-Not Due</label></td>
                    <td style="height: 25px;" colspan="2">
                        <label class="blackfnt">
                            Un-submitted Due</label></td>
                    <td style="height: 25px;" colspan="2">
                        <label class="blackfnt">
                            Un-submitted Not due</label></td>
                    <td style="height: 25px;" colspan="2">
                        <label class="blackfnt">
                            Collected NO</label></td>
                </tr>
                <tr class="bgbluegrey">
                    <td style="width: 7%; height: 25px" class="blackfnt">
                        No</td>
                    <td style="width: 7%; height: 25px" class="blackfnt">
                        Amount</td>
                    <td style="width: 7%; height: 25px" class="blackfnt">
                        No</td>
                    <td style="width: 7%; height: 25px" class="blackfnt">
                        Amount</td>
                    <td style="width: 7%; height: 25px" class="blackfnt">
                        No</td>
                    <td style="width: 7%; height: 25px" class="blackfnt">
                        Amount</td>
                    <td style="width: 7%; height: 25px" class="blackfnt">
                        No</td>
                    <td style="width: 7%; height: 25px" class="blackfnt">
                        Amount</td>
                    <td style="width: 7%; height: 25px" class="blackfnt">
                        No</td>
                    <td style="width: 7%; height: 25px" class="blackfnt">
                        Amount</td>
                    <td style="width: 7%; height: 25px" class="blackfnt">
                        No</td>
                    <td style="width: 7%; height: 25px" class="blackfnt">
                        Amount</td>
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
                                <label class="blackfnt">
                                    <%#DataBinder.Eval(Container.DataItem, "loccode")%>
                                </label>
                            </td>
                            <td>
                                <center>
                                    <label class="blackfnt">
                                        <asp:HyperLink runat="server" Font-Underline="True" ForeColor="#003333" NavigateUrl='<%#"Bil_Summ_SubRpt.aspx?Code=" + DataBinder.Eval(Container.DataItem, "Code") +" &LocCode="+ "ALL" + "&BillTyped=" + "BIllgenerated" + "&Ro=" + Request.QueryString["Ro"].ToString() + "&Loc=" + Request.QueryString["Loc"].ToString() + "&Sub=" + Request.QueryString["SubLoc"].ToString() + "&CollLoc=" + Request.QueryString["ColLoc"].ToString() +"&CustCode=" + Request.QueryString["Cust"].ToString() +"&BillType=" +Request.QueryString["BillType"].ToString()+ "&BillAmt=" +Request.QueryString["BillAmt"].ToString()+ "&List=" + Request.QueryString["CustWise"].ToString() +"&RDate=" + Request.QueryString["RptDate"].ToString()+ "&dateFrom=" + Request.QueryString["dateFrom"].ToString() + "&dateTo=" + Request.QueryString["dateTo"].ToString()%>'
                                            Text='<%#DataBinder.Eval(Container.DataItem, "Bill_No")%>' ID="Hyperlink6" />
                                    </label>
                                </center>
                            </td>
                            <td>
                                <center>
                                    <label class="blackfnt">
                                        <%#DataBinder.Eval(Container.DataItem, "Bill_Amt")%>
                                    </label>
                                </center>
                            </td>
                            <td>
                                <center>
                                    <asp:HyperLink runat="server" Font-Underline="True" ForeColor="#003333" NavigateUrl='<%#"Bil_Summ_SubRpt.aspx?Code=" + DataBinder.Eval(Container.DataItem, "Code") +" &LocCode="+ "ALL" + "&BillTyped=" + "Billsubmited" + "&Ro=" + Request.QueryString["Ro"].ToString() + "&Loc=" + Request.QueryString["Loc"].ToString() + "&Sub=" + Request.QueryString["SubLoc"].ToString() + "&CollLoc=" + Request.QueryString["ColLoc"].ToString() +"&CustCode=" + Request.QueryString["Cust"].ToString() +"&BillType=" +Request.QueryString["BillType"].ToString()+ "&BillAmt=" +Request.QueryString["BillAmt"].ToString()+ "&List=" + Request.QueryString["CustWise"].ToString() +"&RDate=" + Request.QueryString["RptDate"].ToString()+ "&dateFrom=" + Request.QueryString["dateFrom"].ToString() + "&dateTo=" + Request.QueryString["dateTo"].ToString()%>'
                                        Text='<%#DataBinder.Eval(Container.DataItem, "Sub_No")%>' ID="Hyperlink2" Visible='<%#DataBinder.Eval(Container.DataItem, "LinkVisible")%>' />
                                    <label class="blackfnt" id="Label1" runat="server" visible='<%#DataBinder.Eval(Container.DataItem, "LabelVisible")%>'>
                                        <%#DataBinder.Eval(Container.DataItem, "Sub_No")%>
                                    </label>
                                </center>
                            </td>
                            <td>
                                <center>
                                    <label class="blackfnt">
                                        <%#DataBinder.Eval(Container.DataItem, "Sub_Amt")%>
                                    </label>
                                </center>
                            </td>
                            <td>
                                <center>
                                    <asp:HyperLink runat="server" Font-Underline="True" ForeColor="#003333" NavigateUrl='<%#"Bil_Summ_SubRpt.aspx?Code=" + DataBinder.Eval(Container.DataItem, "Code") +" &LocCode="+ "ALL" + "&BillTyped=" + "Billsubmited_Not_Due" + "&Ro=" + Request.QueryString["Ro"].ToString() + "&Loc=" + Request.QueryString["Loc"].ToString() + "&Sub=" + Request.QueryString["SubLoc"].ToString() + "&CollLoc=" + Request.QueryString["ColLoc"].ToString() +"&CustCode=" + Request.QueryString["Cust"].ToString() +"&BillType=" +Request.QueryString["BillType"].ToString()+ "&BillAmt=" +Request.QueryString["BillAmt"].ToString()+ "&List=" + Request.QueryString["CustWise"].ToString() +"&RDate=" + Request.QueryString["RptDate"].ToString()+ "&dateFrom=" + Request.QueryString["dateFrom"].ToString() + "&dateTo=" + Request.QueryString["dateTo"].ToString()%>'
                                        Text='<%#DataBinder.Eval(Container.DataItem, "Sub_Due_No")%>' ID="Hyperlink3"
                                        Visible='<%#DataBinder.Eval(Container.DataItem, "LinkVisible1")%>' />
                                    <label class="blackfnt" id="lblTotalDockets" runat="server" visible='<%#DataBinder.Eval(Container.DataItem, "LabelVisible1")%>'>
                                        <%#DataBinder.Eval(Container.DataItem, "Sub_Due_No")%>
                                    </label>
                                </center>
                            </td>
                            <td>
                                <center>
                                    <label class="blackfnt">
                                        <%#DataBinder.Eval(Container.DataItem, "Sub_Due_Amt")%>
                                    </label>
                                </center>
                            </td>
                            <td>
                                <center>
                                    <asp:HyperLink runat="server" Font-Underline="True" ForeColor="#003333" NavigateUrl='<%#"Bil_Summ_SubRpt.aspx?Code=" + DataBinder.Eval(Container.DataItem, "Code") +" &LocCode="+ "ALL" + "&BillTyped=" + "Billunsubmited" + "&Ro=" + Request.QueryString["Ro"].ToString() + "&Loc=" + Request.QueryString["Loc"].ToString() + "&Sub=" + Request.QueryString["SubLoc"].ToString() + "&CollLoc=" + Request.QueryString["ColLoc"].ToString() +"&CustCode=" + Request.QueryString["Cust"].ToString() +"&BillType=" +Request.QueryString["BillType"].ToString()+ "&BillAmt=" +Request.QueryString["BillAmt"].ToString()+ "&List=" + Request.QueryString["CustWise"].ToString() +"&RDate=" + Request.QueryString["RptDate"].ToString()+ "&dateFrom=" + Request.QueryString["dateFrom"].ToString() + "&dateTo=" + Request.QueryString["dateTo"].ToString()%>'
                                        Text='<%#DataBinder.Eval(Container.DataItem, "UnSub_No")%>' ID="Hyperlink4" Visible='<%#DataBinder.Eval(Container.DataItem, "LinkVisible2")%>' />
                                    <label class="blackfnt" id="Label2" runat="server" visible='<%#DataBinder.Eval(Container.DataItem, "LabelVisible2")%>'>
                                        <%#DataBinder.Eval(Container.DataItem, "UnSub_No")%>
                                    </label>
                                </center>
                            </td>
                            <td>
                                <center>
                                    <label class="blackfnt">
                                        <%#DataBinder.Eval(Container.DataItem, "UnSub_Amt")%>
                                    </label>
                                </center>
                            </td>
                            <td>
                                <center>
                                    <asp:HyperLink runat="server" Font-Underline="True" ForeColor="#003333" NavigateUrl='<%#"Bil_Summ_SubRpt.aspx?Code=" + DataBinder.Eval(Container.DataItem, "Code") +" &LocCode="+ "ALL" + "&BillTyped=" + "Billunsubmited_Not_Due" + "&Ro=" + Request.QueryString["Ro"].ToString() + "&Loc=" + Request.QueryString["Loc"].ToString() + "&Sub=" + Request.QueryString["SubLoc"].ToString() + "&CollLoc=" + Request.QueryString["ColLoc"].ToString() +"&CustCode=" + Request.QueryString["Cust"].ToString() +"&BillType=" +Request.QueryString["BillType"].ToString()+ "&BillAmt=" +Request.QueryString["BillAmt"].ToString()+ "&List=" + Request.QueryString["CustWise"].ToString() +"&RDate=" + Request.QueryString["RptDate"].ToString()+ "&dateFrom=" + Request.QueryString["dateFrom"].ToString() + "&dateTo=" + Request.QueryString["dateTo"].ToString()%>'
                                        Text='<%#DataBinder.Eval(Container.DataItem, "UnSub_Due_No")%>' ID="Hyperlink5"
                                        Visible='<%#DataBinder.Eval(Container.DataItem, "LinkVisible3")%>' />
                                    <label class="blackfnt" id="Label3" runat="server" visible='<%#DataBinder.Eval(Container.DataItem, "LabelVisible3")%>'>
                                        <%#DataBinder.Eval(Container.DataItem, "UnSub_Due_No")%>
                                    </label>
                                </center>
                            </td>
                            <td>
                                <center>
                                    <label class="blackfnt">
                                        <%#DataBinder.Eval(Container.DataItem, "UnSub_Due_Amt")%>
                                    </label>
                                </center>
                            </td>
                            <td>
                                <center>
                                    <asp:HyperLink runat="server" Font-Underline="True" ForeColor="#003333" NavigateUrl='<%#"Bil_Summ_SubRpt.aspx?Code=" + DataBinder.Eval(Container.DataItem, "Code") +" &LocCode="+ "ALL" + "&BillTyped=" + "Collected" + "&Ro=" + Request.QueryString["Ro"].ToString() + "&Loc=" + Request.QueryString["Loc"].ToString() + "&Sub=" + Request.QueryString["SubLoc"].ToString() + "&CollLoc=" + Request.QueryString["ColLoc"].ToString() +"&CustCode=" + Request.QueryString["Cust"].ToString() +"&BillType=" +Request.QueryString["BillType"].ToString()+ "&BillAmt=" +Request.QueryString["BillAmt"].ToString()+ "&List=" + Request.QueryString["CustWise"].ToString() +"&RDate=" + Request.QueryString["RptDate"].ToString()+ "&dateFrom=" + Request.QueryString["dateFrom"].ToString() + "&dateTo=" + Request.QueryString["dateTo"].ToString()%>'
                                        Text='<%#DataBinder.Eval(Container.DataItem, "Coll_No")%>' ID="Hyperlink1" Visible='<%#DataBinder.Eval(Container.DataItem, "LinkVisible4")%>' />
                                    <label class="blackfnt" id="Label4" runat="server" visible='<%#DataBinder.Eval(Container.DataItem, "LabelVisible4")%>'>
                                        <%#DataBinder.Eval(Container.DataItem, "Coll_No")%>
                                    </label>
                                </center>
                            </td>
                            <td>
                                <center>
                                    <label class="blackfnt">
                                        <%#DataBinder.Eval(Container.DataItem, "Coll_Amt")%>
                                    </label>
                                </center>
                            </td>
                        </tr>
                    </ItemTemplate>
                </asp:Repeater>
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
                <asp:Button ID="btnXLS" runat="server" OnClick="btnXLS_Click" Text="XLS" /></td>
        </tr>
    </table>
</asp:Content>
